//
//  AlbumView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI

struct AlbumView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let colors: [Color] = [.white, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
    
    var body: some View {
      LazyVGrid(columns: columns) {
        ForEach(colors, id: \.self) { color in
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 150, height: 100)
            .foregroundColor(color)
        }
      }
        
      .padding()
        
      .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 460)
    }
}

#Preview {
    AlbumView()
}




