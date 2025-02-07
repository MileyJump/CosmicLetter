//
//  DiaryCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/7/25.
//

import SwiftUI
import RealmSwift

struct DiaryCollectionView: View {
    
    let repository = DiaryTableRepository()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                let diaries = repository.fetchAllDiaries()
                ForEach(diaries, id: \.id) { diary in
                    
                    let isToday = Calendar.current.isDateInToday(CalendarView.dateFormatter.date(from: diary.date) ?? Date())
                    
                    Section(header: Text(isToday ? "오늘" : diary.date)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom, 0)
                    )  {
                        if let diary = CalendarView.dateFormatter.date(from: diary.date), diary > Date() {
                            Image(systemName: "lock.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 80)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10) // 둥글게 처리
                            //                                    .padding(.horizontal, 5) // 양쪽 여백 설정
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // 그림자 추가
                                .foregroundColor(.gray)
                        } else {
                            let diaryModel = diary.toTimeDiaryModel()
                            VStack {
                                if let firstPhotoName = diaryModel.photos.first,
                                   let image = ImageService.shared.loadImageFromDocument(filename: firstPhotoName) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 350, height: UIScreen.main.bounds.width / 3)
                                        .clipped()
                                }
                                Text(diaryModel.title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding()
                                    .frame(width: 350, alignment: .leading)
                                    .foregroundColor(.white)
                                    .font(.callout)
                            }
                            .background(Color.gray.opacity(0.3))
                            .frame(width: 350)
                            .cornerRadius(10)
                        }
                    }
                    
                }
                
            }
        }
        .padding(.top, 0)
        .padding(.bottom)
    }
}

#Preview {
    DiaryCollectionView()
}
