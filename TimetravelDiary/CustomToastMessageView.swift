//
//  CustomToastMessageView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 10/19/24.
//

import SwiftUI

struct CustomToastView: View {
    var message: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.white)
        }
        .padding(20)  // 배경과의 여백 5 설정
        .background(Diary.color.timeTravelPopUpColor.opacity(0.8))
        .cornerRadius(8)
        .shadow(radius: 10)
    }
}
