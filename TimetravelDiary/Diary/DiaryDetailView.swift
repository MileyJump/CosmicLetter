//
//  DiaryDetailView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/25/24.
//

import SwiftUI
import RealmSwift

struct DiaryDetailView: View {
    let diary: TimeDiary // 전달받은 다이어리 데이터
    
    var body: some View {
        VStack {
            Text(diary.title)
                .font(.largeTitle)
                .padding()
            
            Text(diary.contents)
                .padding()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(diary.photos, id: \.self) { photo in
                        if let image = ImageService.shared.loadImageFromDocument(filename: photo.photoName) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .padding()
            
            Text("Voice memo: \(diary.voice.count) bytes")
            Text("Favorite: \(diary.favorite ? "Yes" : "No")")
            Text("Memo: \(diary.memo)")
        }
        .navigationTitle("Diary Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
