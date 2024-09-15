//
//  CalendarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import SwiftUI
import Combine

struct CalendarView: View {
    @State var month: Date // 현재 표시 되는 달
    @State var offset: CGSize = CGSize() // 제스처 인식을 위한 변수, 뷰 이동 상태를 저장
    @State var selectedDate: Date? = nil // 선택한 날짜를 저장하는 변수
    @State var publicHolidays: Set<Date> = Set() // 공휴일을 담을 변수
    @State private var cancellables: Set<AnyCancellable> = []
    
    var holidayService = NetworkManager()
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
        .task {
            fetchHolidays()
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
                }
//                Spacer()
                Text(month, formatter: Self.monthOnlyFormatter)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.bottom, 90)
                    .padding(.trailing, 60)
                    .foregroundColor(.white)
            }
            
            Button {
                changeMonth(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .padding()
            }

            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white) // 요일 텍스트의 색상을 흰색으로 설정
                }
            }
            .padding(.bottom, 10)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 20) { // 셀 간격 조정
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        
                        CellView(day: day, cellDate: date, isSelected: date == selectedDate, isToday: date.isSameDate(date: Date()), publicHolidays: publicHolidays)
                            .onTapGesture {
                                selectedDate = date // 새로운 날짜 선택
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
    
    var body: some View {
        ZStack {
            // 선택된 날짜 배경
            if isSelected {
                Circle()
                    .foregroundColor(.blue)
                    .opacity(0.3)
                    .frame(width: 35, height: 35)
            }
            
            // 날짜 텍스트
            Text(String(day))
                .font(.system(size: 20))
                .foregroundColor(textColor)
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
    static let monthOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
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
