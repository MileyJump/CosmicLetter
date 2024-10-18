//
//  CustomPopupView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 10/18/24.
//
import SwiftUI

struct CustomPopupView: View {
    var message: String
    @Binding var isVisible: Bool
    
    var body: some View {
        
        if isVisible {
            ZStack {
                Color.black.opacity(0.4) // 배경 어둡게
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text(message)
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        isVisible = false // 버튼 클릭 시 팝업 닫기
                    }) {
                        Text("지금은 우주를 항해하며 미래에 도착할 준비 중이에요. 지정한 날짜가 오기 전까지는 일기를 열 수 없답니다!")
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(radius: 10)
                .frame(width: 300, height: 150) // 팝업의 크기 조정
            }
        }
    }
}
