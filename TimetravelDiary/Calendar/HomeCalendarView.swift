//
//  HomeCalendarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI
import SwiftData

struct HomeCalendarView: View {
    
    @State private var selectedDate: Date? = Date()
    @State private var isPopupVisible: Bool = false
    @State private var isalertVisible: Bool = false
    
    var body: some View {
        // 얘를 없애면 일기작성 화면에서 갤러리 버튼 클릭시 뒤로감 ㅠ
        NavigationView {
            ZStack {

                if isPopupVisible {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isPopupVisible = false
                        }
                }
                
                CalendarView(month: Date(), selectedDate: $selectedDate, isPopupVisible: $isPopupVisible, isalertVisible: $isalertVisible)
                    .frame(width: 380, height: 200)
                    .offset(y: -60)  // 캘린더 뷰 위치 조정
                
                FloatingMenu(selectedDate: $selectedDate)
                    .padding(.bottom, 50)
                    .padding(.leading, 300)
            }

            .gradientBackground(startColor: Diary.color.timeTravelBlackColor, mediumColor: Diary.color.timeTravelLightBlackColor, endColor: Diary.color.timeTravelDarkNavyBlackColor, starCount: 120)
        }
    }
}

#Preview {
    HomeCalendarView()
}
