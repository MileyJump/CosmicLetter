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
    
    // 그리드 아이템 설정 (3개의 열을 고정)
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        VStack {
            if viewModel.images.isEmpty {
                Text("No images available")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill) // 1:1 비율 맞추기
                                .frame(width: 100, height: 100) // 고정 크기
                                .clipped() // 이미지 크기 초과 시 자르기
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.fetchImageFromDiaryAlbum() // 뷰가 나타날 때 이미지 데이터 불러오기
        }
    }
}

#Preview {
    AlbumView()
}
