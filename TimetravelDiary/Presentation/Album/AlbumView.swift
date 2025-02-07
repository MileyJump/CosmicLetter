//
//  AlbumView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI
import RealmSwift

struct AlbumView: View {
    @StateObject private var viewModel = AlbumViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.images.isEmpty {
                    Text("No images available")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            // ForEach에서 id를 명시적으로 지정
                            ForEach(viewModel.images, id: \.id) { diary in
                                if let diaryDate = CalendarView.dateFormatter.date(from: diary.date), diaryDate > Date() {
                                    // 자물쇠 이미지 표시
                                    Image(systemName: "lock.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                    
                                } else {
                                    // 네비게이션 링크
                                    NavigationLink(destination: DiaryDetailView(diary: diary)) {
                                        
                                        if let firstPhotoName = diary.photos.first,
                                           let firstImage = viewModel.loadImageFromDocument(filename: firstPhotoName) {
                                            Image(uiImage: firstImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                                                .clipped()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .background(.clear)
            .onAppear {
                viewModel.fetchImageFromDiaryAlbum()
            }
        }
    }
}

#Preview {
    AlbumView()
}
