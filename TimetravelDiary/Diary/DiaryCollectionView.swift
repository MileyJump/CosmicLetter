//
//  DiaryCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI
import RealmSwift

struct DiaryCollectionView: View {
    
    @ObservedResults(TimeDiary.self) var diaries
    
    var body: some View {
        List {
            ForEach(diaries, id: \.id) { diary in
                NavigationLink(destination: DiaryDetailView(diary: diary)) {
                    Text(diary.title)
                }
            }
        }
    }
}

#Preview {
    DiaryCollectionView()
}
