//
//  GradientBackgroundView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import SwiftUI

struct GradientBackgroundView: ViewModifier {
    
    var startColor: Color
    var mediumColor: Color
    var optionColor: Color?
    var endColor: Color
    var starCount: Int
    let starSizeRange: ClosedRange<CGFloat> = 1...2
    
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: optionColor != nil ? [.black, startColor, mediumColor, optionColor!, endColor] : [.black, startColor, mediumColor, endColor]),
                                startPoint: .top,
                                endPoint: .bottom)
//                gradient: Gradient(colors: [.black, startColor, mediumColor, endColor]), startPoint: .top, endPoint: .bottom )
                   .ignoresSafeArea() // 안전 영역 무시하여 전체 화면에 적용
            
            ForEach(0..<starCount, id: \.self) { _ in
                           Circle()
                               .fill(Color.white.opacity(Double.random(in: 0.5...1))) // 투명도 랜덤
                               .frame(width: CGFloat.random(in: starSizeRange), height: CGFloat.random(in: starSizeRange)) // 크기 랜덤
                               .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                         y: CGFloat.random(in: 0...UIScreen.main.bounds.height)) // 위치 랜덤
                       }
                   
                   content // 그라데이션 위에 내용 표시
               }
           }
    
}


extension View {
    func gradientBackground(startColor: Color, mediumColor: Color,  optionColor: Color? = nil, endColor: Color, starCount: Int) -> some View {
        self.modifier(GradientBackgroundView(startColor: startColor, mediumColor: mediumColor, optionColor: optionColor, endColor: endColor, starCount: starCount))
    }
}

