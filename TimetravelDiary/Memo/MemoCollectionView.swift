//
//  MemoCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

struct MemoCollectionView: View {

    @ObservedResults(TimeDiaryMemo.self) var memo // TimeDiaryMemo 모델에 대한 관찰

    var body: some View {
        List {
            ForEach(memo, id: \.id) { diary in
                NavigationLink(destination: MemoDetailView(memo: diary)) {
                    Text(diary.memo) // 메모의 내용 표시
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
        }
        .gradientBackground(
            startColor: Diary.color.timeTravelDarkNavyColor,
            mediumColor: Diary.color.timeTravelDarkNavyColor,
            optionColor: Diary.color.timeTravelNavyColor,
            endColor: Diary.color.timeTravelBlueColor,
            starCount: 40
        )
        .navigationTitle("Memo Collection")
    }

}

#Preview {
    DiaryCollectionView()
}
