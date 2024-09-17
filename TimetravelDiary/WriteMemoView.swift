//
//  WirteMemoView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI

struct WriteMemoView: View {
    
    @State var contentText = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if contentText.isEmpty {
                Text("하고 싶은 말이 있나요?")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .regular))
                    .padding(.top, 23)
                    .padding(.leading, 15)
            }
            TextEditor(text: $contentText)
                .padding()
                .background(Color.clear)
                .foregroundColor(.white)
                .scrollContentBackground(.hidden)
        }
        .background(Color.clear)
        
        .padding()
        
        .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
        
    }
    
}

#Preview {
    WriteMemoView()
}
