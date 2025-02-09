//
//  DiaryTableRepository.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/7/25.
//

import SwiftUI
import RealmSwift

final class DiaryTableRepository {
    private let realm = try! Realm()
    
    func fetchAllDiaries() -> [TimeDiary] {
        let diary = realm.objects(TimeDiary.self).sorted(byKeyPath: "date", ascending: false)
        return Array(diary)
    }
    
    func fetchDiary(id: String) -> TimeDiary? {
        return realm.object(ofType: TimeDiary.self, forPrimaryKey: id)
    }
    
    func fetchTitleDiary(for tittle: String) -> TimeDiaryModel? {
        let realm = try! Realm()
        let timeDiaries = realm.objects(TimeDiary.self).filter("title == %@", tittle).first
        return timeDiaries.map { $0.toTimeDiaryModel() }
    }
    
    
    func deleteDiary(_ diaryModel: TimeDiaryModel) {
            // DTO 모델을 Realm 모델로 변환
            if let diaryToDelete = realm.objects(TimeDiary.self).filter("id == %@", diaryModel.id).first {
                try? realm.write {
                    realm.delete(diaryToDelete)
                }
            }
        }
    
    func addDiary(_ diary: TimeDiary) {
        try? realm.write {
            realm.add(diary)
        }
    }
    
    func updateDiary(id: ObjectId, newTitle: String, newContents: String, newPhotos: [Photos], newVoice: String, newFavorite: Bool) {
        guard let realm = try? Realm() else { return }
        
        
        if let diary = realm.object(ofType: TimeDiary.self, forPrimaryKey: id) {
            try? realm.write {
                diary.title = newTitle
                diary.contents = newContents
                diary.voice = newVoice
                diary.favorite = newFavorite
                
                diary.photos.removeAll()
                diary.photos.append(objectsIn: newPhotos)
            }
        }
    }
}


