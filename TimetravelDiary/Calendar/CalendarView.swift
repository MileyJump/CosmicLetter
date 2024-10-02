//
//  CalendarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import SwiftUI
import Combine
import RealmSwift

struct CalendarView: View {
    @State var month: Date // 현재 표시 되는 달
    @State var offset: CGSize = CGSize() // 제스처 인식을 위한 변수, 뷰 이동 상태를 저장
    @Binding var selectedDate: Date?
    @State var publicHolidays: Set<Date> = Set() // 공휴일을 담을 변수
//    @State var isPopupVisible: Bool = false
    @Binding var isPopupVisible: Bool
    @State var isShowingAlert: Bool = false // Alert 표시 여부
    @State var navigateToDiary: Bool = false // 일기 화면으로 전환
    @State var navigateToMemo: Bool = false // 메모 화면으로 전환
    
    @State var selectedDiary: TimeDiary?
    @State var selectedMemo: TimeDiaryMemo?
    
    @State var isShowingDiaryDetail: Bool = false
    @State var isShowingMemoDetail: Bool = false
    
    
    @State var savedDates: Set<Date> = Set()
    
    @StateObject var viewModel = PopupViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()
    
    var holidayService = NetworkManager()
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
        .overlay(
            popupView
                .opacity(isPopupVisible ? 1 : 0)
                .animation(.easeInOut, value: isPopupVisible),
            alignment: .center
        )
        .task {
            fetchHolidays()
            fetchSavedDates()
            
        }
        .gesture( // 스와이프 인식
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width < -100 {
                        changeMonth(by: 1)
                    } else if gesture.translation.width > 100 {
                        changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )

        
        .navigationDestination(isPresented: $isShowingDiaryDetail) {
            if let diary = selectedDiary {
                let _ = print("---\(diary)")
                DiaryDetailView(diary: diary)
            }
        }
        
        .navigationDestination(isPresented: $isShowingMemoDetail) {
            if let memo = selectedMemo {
                let _ = print("---\(memo)")
                MemoDetailView(memo: memo)
            }
        }
        
        .navigationDestination(isPresented: $navigateToDiary) {
            if let selectedDate = selectedDate {
                WriteDiaryView(seletedDate: CalendarView.dateFormatter.string(from: selectedDate))
            }
        }
        .navigationDestination(isPresented: $navigateToMemo) {
            if let selectedDate = selectedDate {
                WriteMemoView(selectedDate: CalendarView.dateFormatter.string(from: selectedDate))
            }
        }
    }
    
    private var popupView: some View {
        ZStack {
            if isPopupVisible {
                VStack {
                    if let selectedDate = selectedDate {
                        let dateString = CalendarView.dateFormatter.string(from: selectedDate)
                        
                        VStack(spacing: 10) {
                            popupHeader(for: selectedDate)
                            
                            ScrollView {
                                popupContent(for: dateString)
                            }
                            
                            popupFooter
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(radius: 10)
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 300)
                        .onAppear {
                            viewModel.fetchDiaryAndMemo(for: dateString)
                        }
                        .onTapGesture {}
                        .actionSheet(isPresented: $isShowingAlert) {
                            ActionSheet(title: Text(""), buttons: [
                                .default(Text("일기")) {
                                    navigateToDiary = true
                                },
                                .default(Text("메모")) {
                                    navigateToMemo = true
                                },
                                .cancel(Text("취소"))
                            ])
                        }
                    }
                }
                .padding()
            }
        }
    }

    private func popupHeader(for selectedDate: Date) -> some View {
        Text(Self.popupFormatter(selectedDate))
            .font(.system(size: 20))
            .fontWeight(.regular)
            .padding(.top, 10)
            .padding(.leading, 10)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func popupContent(for dateString: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if !viewModel.diaries.isEmpty {
                ForEach(viewModel.diaries, id: \.self) { diaryTitle in
                    if let diary = fetchDiary(for: diaryTitle) {
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 8, height: 8)
                                Text("일기")
                                    .font(.system(size: 15))
                                    .padding(.leading, 5)
                                Spacer()
                            }
                            
                            Text(diaryTitle)
                                .font(.system(size: 15))
                                .padding(.leading, 14)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        selectedDiary = diary
                                        isPopupVisible = false
                                        isShowingDiaryDetail = true
                                    }
                                }
                        }
                        .padding(.bottom, 10)
                    }
                }
            }
            
            if !viewModel.memos.isEmpty {
                ForEach(viewModel.memos, id: \.self) { memoContents in
                    if let memo = calendarViewModel.fetchMemo(for: memoContents) {
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 8, height: 8)
                                Text("메모")
                                    .font(.system(size: 15))
                                    .padding(.leading, 5)
                                Spacer()
                            }
                            
                            Text(memoContents)
                                .font(.system(size: 18))
                                .padding(.leading, 14)
                                .onTapGesture {
                                    selectedMemo = memo
                                    isPopupVisible = false
                                    isShowingMemoDetail = true
                                }
                        }
                        .padding(.bottom, 10)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }

    private var popupFooter: some View {
        Button(action: {
            isShowingAlert = true
        }) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.bottom, 10)
        }
    }
    
    
//    private var popupView: some View {
//        ZStack {
//            if isPopupVisible {
//                VStack {
//                    if let selectedDate = selectedDate {
//                        let dateString = CalendarView.dateFormatter.string(from: selectedDate)
//                        
//                        VStack(spacing: 10) {
//                            // 날짜
////                            Text(selectedDate, formatter: Self.popupFormatter)
//                            Text(Self.popupFormatter(selectedDate))
//                                .font(.system(size: 20))
//                                .fontWeight(.regular)
//                                .padding(.top, 10)
//                                .padding(.leading, 10)
//                                .padding(.bottom, 20)
//                                .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬 추가
//                            
//                            // 샘플 메모 내용
//                            ScrollView {
//                                VStack(alignment: .leading, spacing: 8) {
//                                    if !viewModel.diaries.isEmpty {
//                                        ForEach(viewModel.diaries, id: \.self) { diaryTitle in
//                                            if let diary = fetchDiary(for: diaryTitle) {
//                                                
////                                                NavigationLink(destination: DiaryDetailView(diary: diary)) {
//                                                    VStack(alignment: .leading) {
//                                                        HStack {
//                                                            Circle()
//                                                                .fill(Color.purple)
//                                                                .frame(width: 8, height: 8)
//                                                            Text("일기")
//                                                                .font(.system(size: 15))
//                                                                .padding(.leading, 5)
//                                                            
//                                                            Spacer()
//                                                        }
//                                                        
//                                                        Text(diaryTitle)
//                                                            .font(.system(size: 15))
//                                                            .padding(.leading, 14)
//                                                    
//                                                            .onTapGesture {
//                                                                print("==")
//                                                                DispatchQueue.main.async {
//                                                                    if let diary = fetchDiary(for: diaryTitle) {
//                                                                        selectedDiary = diary
//                                                                        print("Selected diary: \(diary)")
//                                                                        isPopupVisible = false
//                                                                        isShowingDiaryDetail = true
//                                                                        print("isShowingDiaryDetail: \(isShowingDiaryDetail)")
//                                                                    }
//                                                                }
//                                                            }
//                                                    }
//                                                    .padding(.bottom, 10)
////                                                }
//                                            }
//                                        }
//                                    }
//                                    
//                                    if !viewModel.memos.isEmpty {
//                                        ForEach(viewModel.memos, id: \.self) { memoContents in
//                                            if let memo = calendarViewModel.fetchMemo(for: memoContents) {
//                                                
//                                                VStack(alignment: .leading) {
//                                                    HStack {
//                                                        Circle()
//                                                            .fill(Color.purple)
//                                                            .frame(width: 8, height: 8)
//                                                        Text("메모")
//                                                            .font(.system(size: 15))
//                                                            .padding(.leading, 5)
//                                                        
//                                                        Spacer()
//                                                    }
//                                                    Text(memoContents)
//                                                        .font(.system(size: 18))
//                                                        .padding(.leading, 14)
//                                                    
//                                                        .onTapGesture {
//                                                            if let memo = calendarViewModel.fetchMemo(for: memoContents) {
//                                                                selectedMemo = memo
//                                                                isPopupVisible = false
//                                                                isShowingMemoDetail = true
//                                                            }
//                                                        }
//                                                }
//                                                
//                                                
//                                            }
//                                            .padding(.bottom, 10)
//                                        }
//                                    }
//                                }
//                        
//                        
//                                .padding(.horizontal, 16)
//                            }
//                            
//                            
//                            // + 버튼
//                            Button(action: {
//                                isShowingAlert = true
//                            }) {
//                                Image(systemName: "plus.circle")
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                                    .padding(.bottom, 10)
//                            }
//                        }
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//                        .shadow(radius: 10)
//                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 300)
//                        .onAppear {
//                            
//                            viewModel.fetchDiaryAndMemo(for: dateString)
//                        }
//                        .onTapGesture {
//                            // 팝업창 닫는 기능을 원하지 않는 경우 이 부분을 주석처리
//                        }
//                        .actionSheet(isPresented: $isShowingAlert) {
//                            ActionSheet(title: Text(""), buttons: [
//                                .default(Text("일기")) {
//                                    navigateToDiary = true
//                                },
//                                .default(Text("메모")) {
//                                    navigateToMemo = true
//                                },
//                                .cancel(Text("취소"))
//                            ])
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//    }
    
    private func fetchDiary(for tittle: String) -> TimeDiary? {
        let realm = try! Realm()
        return realm.objects(TimeDiary.self).filter("title == %@", tittle).first
    }
    
    
    
    private func fetchSavedDates() {
        // Realm에서 저장된 TimeDiary와 TimeDiaryMemo 객체들의 날짜를 불러와 savedDates에 저장
        let realm = try! Realm()
        let diaries = realm.objects(TimeDiary.self)
        let memos = realm.objects(TimeDiaryMemo.self)
        
        // 날짜를 Set에 저장하여 중복 방지
        savedDates = Set(diaries.compactMap { CalendarView.dateFormatter.date(from: $0.date) })
        savedDates.formUnion(memos.compactMap { CalendarView.dateFormatter.date(from: $0.date) })
        
        print("저장된 날짜 \(savedDates)")
    }
    
    private func fetchDiaryAndMemo(for dateString: String) {
        viewModel.fetchDiaryAndMemo(for: dateString)
        // 만약 일기와 메모가 없으면 팝업을 숨김
        if !viewModel.hasDiary && !viewModel.hasMemo {
            isPopupVisible = false
        } else {
            isPopupVisible = true
        }
    }
    
  

    
    private func fetchHolidays() {
        let currentYear = Calendar.current.component(.year, from: month)
        NetworkManager.shared.fetchHolidays(for: currentYear, countryCode: "KR") { result in
            switch result {
            case .success(let holidays):
                self.publicHolidays = holidays
            case .failure(let error):
                print("공휴일을 가져오는 중 오류 발생: \(error)")
            }
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .padding()
                        .foregroundColor(.white) // 버튼 색상 설정
                }
                
                Text(month, formatter: Self.monthOnlyFormatter)
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .padding()
                        .foregroundColor(.white) // 버튼 색상 설정
                }
            }
            .padding(.bottom, 60)
            .padding(.horizontal, 20) // 양쪽에 여백 추가
            
            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white) // 요일 텍스트의 색상을 흰색으로 설정
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 35) { // 셀 간격 조정
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        
                        let hasSavedData = savedDates.contains(date)
                        
                        CellView(day: day, cellDate: date, isSelected: date == selectedDate, isToday: date.isSameDate(date: Date()), publicHolidays: publicHolidays, hasSavedData: hasSavedData)

                            .onTapGesture {
                                selectedDate = date
                                fetchDiaryAndMemo(for: CalendarView.dateFormatter.string(from: date))
                            }
                        
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    var day: Int
    var cellDate: Date
    var isSelected: Bool
    var isToday: Bool
    var publicHolidays: Set<Date>
//    var hasDiary: Bool
//    var hasMemo: Bool
    
    var hasSavedData: Bool
    
    
    var body: some View {
        ZStack {
            // 선택된 날짜 배경
            if isSelected {
                Circle()
                    .foregroundColor(.blue)
                    .opacity(0.3)
                    .frame(width: 35, height: 35)
            }
            
            // 오늘 날짜 배경
            if isToday {
                Circle()
                    .foregroundColor(Diary.color.timeTravelgray) // 오늘 날짜 배경 색상
                    .opacity(0.3)
                    .frame(width: 35, height: 35)
            }
            
            // 날짜 텍스트
            Text(String(day))
                .font(.system(size: 20))
                .foregroundColor(textColor)
            
                
            
//            if hasDiary || hasMemo {
            if hasSavedData {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 12))
                    .offset(x: 0, y: 15)
                    .padding(.top, 25)
            }
        }
        .frame(width: 40, height: 40)
        //        .scaledToFit()
    }
    
    private var textColor: Color {
        if Calendar.current.isDateInWeekend(cellDate) {
            if Calendar.current.component(.weekday, from: cellDate) == 1 || publicHolidays.contains(cellDate) {
                return .red // 일요일 또는 공휴일은 빨간색
            } else {
                return .blue // 토요일은 파란색
            }
        } else if publicHolidays.contains(cellDate) {
            return .red // 공휴일은 빨간색
        } else {
            return isToday ? .red : .white // 오늘 날짜는 빨간색
        }
    }
}

// MARK: - 내부 메서드
private extension CalendarView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
            self.selectedDate = nil // 월 변경 시 선택된 날짜 초기화
        }
    }
}

// MARK: - Static 프로퍼티
extension CalendarView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    static let monthOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        //        formatter.dateFormat = "M월"
        formatter.dateFormat = "yyyy.MM"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static func popupFormatter(_ target: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM.dd(E)"
        
        let converted = formatter.string(from: target)
        return converted
    }
//    static let popupFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "MM.dd(E)" // 요일 이름을 짧게 표시
//        
//        return formatter
//    }()
    
    
    static let weekdaySymbols: [String] = ["일", "월", "화", "수", "목", "금", "토"]
}

extension Date {
    private func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func isSameDate(date: Date) -> Bool {
        self.startOfDay() == date.startOfDay()
    }
}
