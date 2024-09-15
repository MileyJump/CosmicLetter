//
//  BubbleView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import SwiftUI

struct BubbleView: View {
    var body: some View {
//        Circle() // 동그란 뷰를 만들기 위해 Circle 사용
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white.opacity(0.5)) // 불투명한 흰색
            .frame(width: 200, height: 200) // 크기 설정
            .blur(radius: 10) // 살짝 흐릿하게
            .overlay(
//                Circle()
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white.opacity(0.8), lineWidth: 2) // 윤곽선을 강조
                    .blur(radius: 1)
            )
            .shadow(color: Color.white.opacity(0.6), radius: 10, x: 0, y: 0) // 빛나는 효과 추가
    }
}
