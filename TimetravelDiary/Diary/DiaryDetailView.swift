//
//  DiaryDetailView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/25/24.
//
//

import SwiftUI
import RealmSwift
import ShuffleDeck

struct DiaryDetailView: View {
    let diary: TimeDiary // 전달받은 다이어리 데이터
    @StateObject private var viewModel = DiaryDetailViewModel()
    
    @State var currentPage: Int = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                // 사진 슬라이드 뷰 (ShuffleDeck)
                if !diary.photos.isEmpty {
                    ShuffleDeck(Array(diary.photos.enumerated()), initialIndex: 0) { index, photo in
                        if let image = viewModel.loadImageFromDocument(filename: photo.photoName) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill() // 이미지 비율 유지
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 300)
                                .cornerRadius(16)
                                .padding(.horizontal) // 양쪽에 패딩 추가하여 중앙에 배치
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 300)
                    .padding(.horizontal, 20) // 슬라이드 카드의 간격 조정
                }
                
                // 제목과 내용
                VStack(alignment: .leading, spacing: 10) {
                    Text(diary.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .padding(.bottom, 10) // 제목과 내용 간격 조정
                    Text(diary.contents)
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }

                .background(Color.clear) // 기본 배경색을 투명으로 설정
            }
            .onAppear {
                print("되고 있냐")
                // 네비게이션 바의 배경색 설정
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground() // 투명 배경으로 설정
                appearance.backgroundColor = UIColor(Color.red) // 원하는 배경색으로 설정
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 제목 텍스트 색상 설정
                
                // 네비게이션 바에 appearance 적용
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }

            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, mediumColor:  Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 100)
            
        }
    }
}

