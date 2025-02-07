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
        ZStack(alignment: .topLeading) { // ZStack의 alignment를 .topLeading으로 설정
            
            ScrollView { // ScrollView로 감싸기
                VStack(alignment: .leading, spacing: 10) {
                    Text(memo.memo)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.top, 20) // 상단 여백 설정
                        .padding(.leading, 15) // 왼쪽 여백 설정
                        .frame(maxWidth: .infinity, alignment: .leading) // 너비를 최대한으로 설정하고 왼쪽 정렬
                        .multilineTextAlignment(.leading) // 여러 줄일 경우 왼쪽 정렬 유지
                    Spacer() // VStack 내에서 상단에 붙게 만듦
                }
                .background(Color.clear) // 기본 배경색을 투명으로 설정
                .navigationTitle(memo.date)
            }
        }
        .gradientBackground(startColor: Diary.color.timeTravelBlackColor, mediumColor: Diary.color.timeTravelLightBlackColor, endColor: Diary.color.timeTravelDarkNavyBlackColor, starCount: 120)
    }
}
