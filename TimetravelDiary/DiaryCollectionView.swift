//
//  DiaryCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI

struct DiaryCollectionView: View {
    var body: some View {
        ZStack {
            // 그라데이션 배경
            Color.clear
//                .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 460)
//            GradientBackgroundView(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
                .ignoresSafeArea()

            List {
                Text("안녕하세요")
                Text("오늘은 약과를 먹었다.")
                Text("오늘 카페에서 공부했다. 근데 세녹이 아니었음..ㅠㅠ")
            }
            .scrollContentBackground(.hidden) // 기본 List 배경 숨기기
            .background(Color.clear) // List의 배경을 투명하게 설정
        }
    }
}

#Preview {
    DiaryCollectionView()
}
