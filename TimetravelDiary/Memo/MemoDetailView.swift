//
//  MemoDetailView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

struct MemoDetailView: View {
    let memo: TimeDiaryMemo // 전달받은 다이어리 데이터
    
    var body: some View {
        ZStack(alignment: .top) {
            // 제목과 내용
            VStack(alignment: .leading, spacing: 10) {
                Text(memo.memo)
                    .font(.body)
                    .padding(.horizontal)
                    .foregroundColor(.white)
            }
            //                .navigationBarTitleDisplayMode(.inline)
            .background(Color.clear) // 기본 배경색을 투명으로 설정
        }
        .onAppear {
            print("되고 있냐")
            // 네비게이션 바의 배경색 설정
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground() // 투명 배경으로 설정
            appearance.backgroundColor = UIColor(Color.red) // 원하는 배경색으로 설정
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 제목 텍스트 색상 설정
            
            // 네비게이션 바에 appearance 적용
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 100)
    }
    //            .padding(.top, 10) // VStack의 상단 패딩 제거
    //            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 100)
}


