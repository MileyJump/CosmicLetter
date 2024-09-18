//
//  WriteDiaryView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI
import AVFoundation

struct WriteDiaryView: View {
    
    @State var titleText = ""
    @State var contentPlaceholderText: String = "여행 꿀팁을 입력해주세요"
    @State var contentText: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                // Title TextField
                TextField("", text: $titleText)
                    .placeholder(when: titleText.isEmpty) {
                        Text("제목을 입력해주세요")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(.white)
                
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
            }
            .padding()
        }
        .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
    }
}

#Preview {
    WriteDiaryView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
