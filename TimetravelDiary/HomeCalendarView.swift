//
//  HomeCalendarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI
import SwiftData

struct HomeCalendarView: View {
    
    @Query var diaryModels: [DiaryModel]
    
    var body: some View {
        NavigationStack { // 네비게이션 스택 추가
            ZStack {
                    CalendarView(month: Date())
                        .frame(width: 380, height: 200)
                        .offset(y: -80)  // 캘린더 뷰 위치 조정
                    
                    FloatingMenu()
                        .padding(.bottom, 100)
                        .padding(.leading, 260)
                }
                .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 200)
//            }
        }
    }
}

#Preview {
    HomeCalendarView()
}
