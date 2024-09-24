//
//  AlbumView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI

struct AlbumView: View {
    
//    let photos: [UIImage]
    let photos: [String] = ["미용해피", "턱시도해피"]

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(photos.indices, id: \.self) { index in
//                    Image(uiImage: photos[index])
//                    Image(systemName: photos[index])
                    Image( photos[index])
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .clipped() // 이미지가 1:1 비율에 맞춰 잘리도록 설정
                        .background(.blue)
                }
            }
            .padding(10)
            
        }
        .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 460)
    }
}
    

        
//        GradientBackgroundView(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
//      .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 460)
    

//
#Preview {
    AlbumView()
}




