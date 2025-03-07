//
//  CalendarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import SwiftUI
//import Combine
import RealmSwift

struct CalendarView: View {
    @State var month: Date // 현재 표시 되는 달
    @State var offset: CGSize = CGSize() // 제스처 인식을 위한 변수, 뷰 이동 상태를 저장
    @Binding var selectedDate: Date?
    @State var publicHolidays: Set<Date> = Set() // 공휴일을 담을 변수
    @Binding var isPopupVisible: Bool
    @Binding var isalertVisible: Bool
    
    @State var isShowingAlert: Bool = false // Alert 표시 여부
    @State var navigateToDiary: Bool = false // 일기 화면으로 전환
    @State var navigateToMemo: Bool = false // 메모 화면으로 전환
    
    @State var selectedDiary: TimeDiaryModel?
    @State var selectedMemo: TimeDiaryMemo?
    
    @State var isShowingDiaryDetail: Bool = false
    @State var isShowingMemoDetail: Bool = false
    
    @State var savedDates: Set<Date> = Set()
    
    @State private var isToastVisible: Bool = false // 토스트 메시지 표시 여부
    @State private var toastMessage: String = "" // 토스트 메시지 내용
    
    
    @StateObject var viewModel = PopupViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()
    
    let repository = DiaryTableRepository()
    
    
    
    var body: some View {
        VStack {
            headerView
                .padding(.bottom, 20)
            
            calendarGridView
                .frame(maxHeight: 500)
        }
        .overlay(
            
            popupView
                .opacity(isPopupVisible ? 1 : 0)
                .animation(.easeInOut, value: isPopupVisible),
            alignment: .center
        )
        
        .overlay(
            Group {
                if isToastVisible {
                    CustomToastView(message: toastMessage)
                        .transition(.opacity)
                        .zIndex(1)
                        .offset(y: 50)
                }
            },
            alignment: .top
        )
        
        
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
                DiaryDetailView(diary: diary)
            }
        }
        .navigationDestination(isPresented: $isShowingMemoDetail) {
            if let memo = selectedMemo {
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
        .task {
            fetchHolidays()
            fetchSavedDates()
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
                        .background(RoundedRectangle(cornerRadius: 10).fill(Diary.color.timeTravelDarkGrayColor))
                        .shadow(radius: 10)
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 350)
                        .onAppear {
                            viewModel.fetchDiaryAndMemo(for: dateString)
                        }
                        .actionSheet(isPresented: $isShowingAlert) {
                            ActionSheet(title: Text(""), buttons: [
                                .default(Text("diary")) {
                                    navigateToDiary = true
                                },
                                .default(Text("memo")) {
                                    navigateToMemo = true
                                },
                                .cancel(Text("cancel"))
                            ])
                        }
                    }
                }
                .offset(x: 0, y: 80)
                .zIndex(1) // 팝업 뷰는 이미지보다 앞에 위치
                
                // 달 이미지 추가 - 팝업 상단에 자연스럽게 겹치도록
                //                Image("달")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: 100, height: 100) // 적절한 크기로 설정
                //                    .offset(x: 100, y: -100)
                //                    .zIndex(2) // 팝업 뷰와 달이 겹치게 이미지가 앞에 오도록 우선순위 설정
            }
            
        }
    }
    
    private func popupHeader(for selectedDate: Date) -> some View {
        Text(Self.popupFormatter(selectedDate))
            .font(.system(size: 20))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.top, 10)
            .padding(.leading, 10)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func popupContent(for dateString: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if !viewModel.diaries.isEmpty {
                ForEach(viewModel.diaries, id: \.self) { diaryTitle in
                    if let diary = repository.fetchTitleDiary(for: diaryTitle) {
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 8, height: 8)
                                Text("일기")
                                    .font(.system(size: 15))
                                    .padding(.leading, 5)
                                    .foregroundColor(.white)
                                
                                if let diaryDate = CalendarView.dateFormatter.date(from: diary.date), diaryDate <= Date() {
                                    Image(systemName: "lock.open.fill")
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.red)
                                }
                                Spacer()
                            }
                            
                            Text(diaryTitle)
                                .font(.system(size: 15))
                                .padding(.leading, 20)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    if let diaryDate = CalendarView.dateFormatter.date(from: diary.date), diaryDate <= Date() {
                                        DispatchQueue.main.async {
                                            selectedDiary = diary
                                            isPopupVisible = false
                                            isShowingDiaryDetail = true
                                            isalertVisible = false
                                        }
                                    } else {
                                        isalertVisible = true
                                        //                                        showToast(message: "지금은 우주를 항해하며 미래에 도착할 준비 중이에요. \n 지정한 날짜가 오기 전까지는 일기를 열 수 없답니다!")
                                        showToast(message: NSLocalizedString("space", comment: ""))
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
                                Text("memo")
                                    .font(.system(size: 15))
                                    .padding(.leading, 5)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            Text(memoContents)
                                .font(.system(size: 18))
                                .padding(.leading, 14)
                                .foregroundColor(.white)
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
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .padding(.bottom, 10)
        }
    }
    
    private func showToast(message: String) {
        toastMessage = message
        isToastVisible = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isToastVisible = false
        }
    }
    
    
//    private func fetchDiary(for tittle: String) -> TimeDiary? {
//        let realm = try! Realm()
//        return realm.objects(TimeDiary.self).filter("title == %@", tittle).first
//    }
    
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
        VStack(spacing: 10) {
            HStack {
                HStack {
                    Text(month, formatter: Self.monthformatter)
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        Text(month, formatter: Self.yearformatter)
                            .font(.system(size: 23))
                            .foregroundColor(.white)
                        Text(Self.enYearformatter(for: month))
                            .font(.system(size: 23))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                
                HStack {
                    Button {
                        changeMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                            .padding()
                            .foregroundColor(.white) // 버튼 색상 설정
                    }
                    
                    Button {
                        let today = Date()
                        month = today
                        selectedDate = today
                    } label: {
                        Text("today")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    
                    Button {
                        changeMonth(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                            .padding()
                            .foregroundColor(.white) // 버튼 색상 설정
                    }
                }
            }
            .padding(.bottom, 30)
            .padding(.horizontal, 10) // 양쪽에 여백 추가
            
            
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
                        Spacer()
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
            return .white
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
    
    static let calendarFormatter: DateFormatter = {
        let formatter = DateFormatter()
        //        formatter.dateFormat = "M월"
        formatter.dateFormat = "yyyy.MM"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let monthformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter
    }()
    
    static let yearformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static func enYearformatter(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    
    static func popupFormatter(_ target: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM.dd(E)"
        
        let converted = formatter.string(from: target)
        return converted
    }
    
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
