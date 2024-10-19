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
                        Text("확인")
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
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 팝업의 크기 조정
            }
        }
    }
}
