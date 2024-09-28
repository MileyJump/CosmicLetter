//
//  DiaryDetailView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/25/24.
//
//
//import SwiftUI
//import RealmSwift
//
//struct DiaryDetailView: View {
//    let diary: TimeDiary // 전달받은 다이어리 데이터
//    
//    var body: some View {
//        VStack {
//            Text(diary.title)
//                .font(.largeTitle)
//                .padding()
//            
//            Text(diary.contents)
//                .padding()
//            
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(diary.photos, id: \.self) { photo in
//                        if let image = ImageService.shared.loadImageFromDocument(filename: photo.photoName) {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                        }
//                    }
//                }
//            }
//            .padding()
//            
//            Text("Voice memo: \(diary.voice.count) bytes")
//            Text("Favorite: \(diary.favorite ? "Yes" : "No")")
//            Text("Memo: \(diary.memo)")
//        }
//        .navigationTitle("Diary Detail")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}


import SwiftUI
import RealmSwift

struct DiaryDetailView: View {
    let diary: TimeDiary // 전달받은 다이어리 데이터
    @StateObject private var viewModel = DiaryDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 상단 날짜와 완료 버튼
            HStack {
                Text(diary.date)
                    .font(.headline)
                    .padding(.leading)
                Spacer()
                Button("완료") {
                    // 완료 버튼 액션
                }
                .padding(.trailing)
            }
            .padding(.top)
            
            // 사진 뷰 (가로 스크롤 가능)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(diary.photos, id: \.self) { photo in
//                        if let image = ImageService.shared.loadImageFromDocument(filename: photo.photoName) {
                        
                        if let image = viewModel.loadImageFromDocument(filename: photo.photoName) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 200) // 이미지 크기 조정
                                .cornerRadius(15)
                                .clipped() // 이미지를 넘지 않도록 자르기
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // 제목과 내용
            VStack(alignment: .leading, spacing: 10) {
                Text(diary.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text(diary.contents)
                    .font(.body)
                    .padding(.horizontal)
            }
            
            Spacer() // 하단 여백 확보
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
