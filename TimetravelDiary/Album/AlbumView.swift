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
                            ForEach(viewModel.images, id: \.id) { diary in
                                NavigationLink(destination: DiaryDetailView(diary: diary)) {
                                    if let firstPhotoName = diary.photos.first?.photoName,
                                       let firstImage = viewModel.loadImageFromDocument(filename: firstPhotoName) {
                                        Image(uiImage: firstImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                                            .clipped()
                                    } 
//                                    else {
//                                        Rectangle()
//                                            .fill(Color.gray)
//                                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
//                                    }
                                }
                            }
                        }
                    }
                }
                 
            }
            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 100)
            .onAppear {
                viewModel.fetchImageFromDiaryAlbum()
            }
            
        }
    }
}

#Preview {
    AlbumView()
}
