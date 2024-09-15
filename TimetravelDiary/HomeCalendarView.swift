//
//  HomeCalendarView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI
import SwiftData

struct HomeCalendarView: View {
    
//    @Query var diaryModels: [DiaryModel]
    
    var body: some View {
        ZStack {
            // 캘린더와 배경을 묶어서 뒤쪽에 배치
            VStack {
                ZStack {
                    Image("물감배경")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 400)
                        .offset(x: 30, y: -20)
//                        .shadow(radius: 6)
                    
                    CalendarView(month: Date())
                        .frame(width: 380, height: 200)
                        .offset(y: -80)  // 캘린더 뷰 위치 조정
                }
                
            }
            
            // 이미지를 앞으로 배치하고 위치 조정
            Image("둥실우주비행사")
                .resizable()
                .frame(width: 250, height: 250)
                .offset(x: -100, y: -280) // 이미지 위치 조정
            
            VStack {
                Spacer()
                HStack {
//                    Spacer()
                    Button(action: {
                        // 버튼이 클릭되었을 때의 액션
                    }) {
                        Image("보라우주선")
                            .resizable()  // 이미지 크기 조정 가능
                            .scaledToFit()  // 비율 유지
                            .frame(width: 60, height: 60)  // 버튼의 크기 설정
                            .padding()
//                            .background(Diary.color.timeTravelDarkNavyColor)  // 버튼의 배경 색상
                            .background(.black)  // 버튼의 배경 색상
                            .clipShape(Circle())  // 버튼을 원형으로
                            .shadow(radius: 10)  // 버튼에 그림자 추가
                            .rotationEffect(.degrees(50))  // 이미지 -50도로 기울이기
                    }
                    .padding(.leading, 250)
                    .padding(.bottom, 100)
                }
            }
        }
//        .gradientBackground(startColor: Diary.color.timeTravelPurpleColor, endColor: Diary.color.timeTravelNavyColor, starCount: 120)
        .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 120)
    }
}

#Preview {
    HomeCalendarView()
}

