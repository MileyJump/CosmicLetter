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


struct TimeDiaryModel: Codable {
    let id: ObjectId
    let date: String
    let title: String
    let photos: [String]
    let contents: String
    let voice: Data
    let favorite: Bool
}

struct PhotosModel: Codable {
    let photoName: String
}

struct TimeDiaryMemoModel: Codable {
    let id: String
    let date: String
    let memo: String
    let favorite: Bool
}


extension TimeDiary {
    
    func toTimeDiaryModel() -> TimeDiaryModel {
        .init(id: id , date: date, title: title, photos: photos.map { $0.photoName } , contents: contents, voice: voice, favorite: favorite)
    }
}
