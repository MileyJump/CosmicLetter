//
//  DiaryCollectionViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

class DiaryCollectionViewModel: ObservableObject {
    @Published var diaries: [TimeDiary] = []
    
    init() {
        fetchDiaries()
    }
    
    func fetchDiaries() {
        let realm = try! Realm()
        let timeDiaries = realm.objects(TimeDiary.self)
        self.diaries = Array(timeDiaries)
    }
    
    func deleteDiary(at offsets: IndexSet) {
        let realm = try! Realm()
        offsets.forEach { index in
            if let diary = realm.object(ofType: TimeDiary.self, forPrimaryKey: diaries[index].id) {
                try? realm.write {
                    realm.delete(diary)
                }
            }
        }
        fetchDiaries()
    }
}
