//
//  DiaryDetailView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/25/24.
//
//

import SwiftUI
import RealmSwift
//import ShuffleDeck
import ShuffleIt

struct DiaryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let diary: TimeDiaryModel // 전달받은 다이어리 데이터
    let repository = DiaryTableRepository()
    
    @StateObject private var viewModel = DiaryDetailViewModel()
    
    @State private var showing = false
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(diary.title)
                        .font(.title3)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .padding(.vertical, 10) // 제목과 내용 간격 조정
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    if !diary.photos.isEmpty {
                        CarouselStack(Array(diary.photos.enumerated()), initialIndex: 0) { index, photo in
                            if let image = viewModel.loadImageFromDocument(filename: photo) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill() // 이미지 비율 유지
                                
                                    .frame(height: 200)
                                    .cornerRadius(16)
                                    .clipped()
                                
                            }
                        }
                        .padding(.bottom)
                    }
                    Text(diary.contents)
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
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
                    // 음성 아이콘 버튼 추가
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                showing = true
                            }) {
                                Image(systemName: "mic.fill")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                            .sheet(isPresented: $showing) {
                                VoiceRecordView()
                                    .presentationDetents([.medium])
//                                    
                                    .presentationDragIndicator(.visible)
                            }
                            Spacer()
                        }
                    }
                }
                
            }
            .navigationTitle("일기 날짜")
            .navigationBarTitleDisplayMode(.inline)
            .gradientBackground(startColor: Diary.color.timeTravelBlackColor, mediumColor: Diary.color.timeTravelLightBlackColor, endColor: Diary.color.timeTravelDarkNavyBlackColor, starCount: 120)
        }
        .tint(.white)
    }
}


