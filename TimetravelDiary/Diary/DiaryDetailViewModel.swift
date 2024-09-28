//
//  DiaryDetailViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

class DiaryDetailViewModel: ObservableObject {
    @Published var diary: TimeDiary?
    
    func loadDiary(id: ObjectId) {
        let realm = try! Realm()
        if let loadedDiary = realm.object(ofType: TimeDiary.self, forPrimaryKey: id) {
            self.diary = loadedDiary
        }
    }
}

