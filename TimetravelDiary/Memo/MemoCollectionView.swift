//
//  MemoCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

struct MemoCollectionView: View {
    
    @ObservedResults(TimeDiary.self) var diaries
    
    var body: some View {
//        NavigationView {
            List {
                ForEach(diaries, id: \.id) { diary in
                    NavigationLink(destination: DiaryDetailView(diary: diary)) {
                        Text(diary.title)
                    }
                }
                .onDelete(perform: $diaries.remove)
            }
            
//        }
    }
}

#Preview {
    DiaryCollectionView()
}
