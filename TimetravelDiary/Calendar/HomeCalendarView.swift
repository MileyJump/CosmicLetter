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
    @State private var selectedDate: Date? = Date()
    @State private var isPopupVisible: Bool = false
    
    
    var body: some View {
        // 얘를 없애면 일기작성 화면에서 갤러리 버튼 클릭시 뒤로감 ㅠ
        NavigationView {
            ZStack {

                // 이 부분 우너래 없었어
                if isPopupVisible {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isPopupVisible = false
                        }
                    //                    PopupView(selectedDate: $selectedDate, isPopupVisible: $isPopupVisible).transition(.scale)
                    
                }
                
//                VStack {
                    CalendarView(month: Date(), selectedDate: $selectedDate, isPopupVisible: $isPopupVisible)
                    //                CalendarView(month: Date(), selectedDate: $selectedDate, isPopupVisible: $isPopupVisible)
                        .frame(width: 380, height: 200)
                        .offset(y: -80)  // 캘린더 뷰 위치 조정
                    
                    FloatingMenu(selectedDate: $selectedDate)
                        .padding(.bottom, 100)
                        .padding(.leading, 260)
//                }
            }
            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, mediumColor:  Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 100)
            
            

        }
    }
}

#Preview {
    HomeCalendarView()
}


// PopupView를 별도의 구조체로 분리
//struct PopupView: View {
//    @Binding var selectedDate: Date?
//    @Binding var isPopupVisible: Bool
//    @StateObject var viewModel = PopupViewModel()
//
//    var body: some View {
//        VStack {
//            
//            if let selectedDate = selectedDate {
//                let dateString = CalendarView.dateFormatter.string(from: selectedDate)
//                
//                VStack(spacing: 10) {
//                    Text(CalendarView.popupFormatter(selectedDate))
//                        .font(.system(size: 20))
//                        .fontWeight(.regular)
//                        .padding(.top, 10)
//                        .padding(.leading, 10)
//                        .padding(.bottom, 20)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    VStack(alignment: .leading, spacing: 8) {
//                        HStack {
//                            Circle()
//                                .fill(Color.purple)
//                                .frame(width: 8, height: 8)
//                            Text("일기")
//                                .font(.system(size: 15))
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        Text(viewModel.diaryTitle)
//                            .font(.system(size: 18))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 14)
//                        
//                        HStack {
//                            Circle()
//                                .fill(Color.purple)
//                                .frame(width: 8, height: 8)
//                            Text("메모")
//                                .font(.system(size: 15))
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        Text(viewModel.memoText)
//                            .font(.system(size: 18))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 14)
//                        
//                        HStack {
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 8, height: 8)
//                            Text("일기")
//                                .font(.system(size: 15))
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        Text(viewModel.memoText)
//                            .font(.system(size: 18))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 14)
//                    }
//                    .padding(.horizontal, 16)
//                    
//                    Button(action: {
//                        // 작성 버튼 액션
//                    }) {
//                        Image(systemName: "plus.circle")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .padding(.bottom, 10)
//                    }
//                }
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//                .shadow(radius: 10)
//                .frame(width: UIScreen.main.bounds.width * 0.7, height: 600)
//                .onAppear {
//                    viewModel.fetchDiaryAndMemo(for: dateString)
//                }
//            }
//        }
//    }
//}

