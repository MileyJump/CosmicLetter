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
    
    let realm = try! Realm()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(diaries, id: \.id) { diary in
                    NavigationLink(destination: DiaryDetailView(diary: diary)) {
                        Text(diary.title)  // 데이터의 title 속성 표시
                    }
                }
                
                .onDelete(perform: $diaries.remove)  // 항목 삭제
            }
            .onAppear {
                print(realm.configuration.fileURL)
            }
        }
    }
}


#Preview {
    DiaryCollectionView()
}
