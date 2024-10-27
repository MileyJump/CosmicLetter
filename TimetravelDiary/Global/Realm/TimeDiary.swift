//
//  TimeDiary.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/24/24.
//

import Foundation
import RealmSwift

// 'TimeDiary' 클래스 정의
final class TimeDiary: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: String
    @Persisted var title: String
    @Persisted var photos: List<Photos>
    @Persisted var contents: String
    @Persisted var voice: Data
    @Persisted var favorite: Bool
    
    // List<Photos>를 받는 생성자
    convenience init(date: String, title: String, photos: List<Photos>, contents: String, voice: Data, favorite: Bool) {
        self.init()
        self.date = date
        self.title = title
        self.photos = photos
        self.contents = contents
        self.voice = voice
        self.favorite = favorite
    }
}

// 'Photos' 클래스 정의
final class Photos: Object, ObjectKeyIdentifiable {
    @Persisted var photoName: String
    
    // Photos의 초기화 구문
    convenience init(photoName: String) {
        self.init()
        self.photoName = photoName
    }
}


final class TimeDiaryMemo: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: String
    @Persisted var memo: String
    @Persisted var favorite: Bool
    
    convenience init(date: String, favorite: Bool, memo: String) {
        self.init()
        self.date = date
        self.favorite = favorite
        self.memo = memo
    }
}
