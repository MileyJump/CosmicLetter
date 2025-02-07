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
    @Environment(\.dismiss) private var dismiss
    let diary: TimeDiaryModel // 전달받은 다이어리 데이터
    let repository = DiaryTableRepository()
    
    @StateObject private var viewModel = DiaryDetailViewModel()
    
    @State var currentPage: Int = 0
    @State private var showing = false
    @State private var isEditLinkActive = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    if !diary.photos.isEmpty {
                        ShuffleDeck(Array(diary.photos.enumerated()), initialIndex: 0) { index, photo in
                            if let image = viewModel.loadImageFromDocument(filename: photo) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill() // 이미지 비율 유지
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 300)
                                    .cornerRadius(16)
                                    .clipped()
                                
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 300)
                        //                    .padding(.horizontal, 20) // 슬라이드 카드의 간격 조정
                        .padding(.bottom)
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
                    Spacer()
                }
                
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .onAppear {
                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithTransparentBackground()
                    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                    
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                }
                .toolbar {
                    Menu {
                        Button("편집") {
                            print("편집 버튼 클릭 됨!!😊😊")
                        }
                        Button("삭제", role: .destructive) {
                            repository.deleteDiary(diary)
                            dismiss()
                        }
                    } label : {
                        Label("", systemImage: "ellipsis")
                    }
                }
             
            }
            .gradientBackground(startColor: Diary.color.timeTravelBlackColor, mediumColor: Diary.color.timeTravelLightBlackColor, endColor: Diary.color.timeTravelDarkNavyBlackColor, starCount: 120)
        }
    }
}

