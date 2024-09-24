//
//  TimeDiary.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/24/24.
//

import Foundation
import SwiftUI
import RealmSwift

final class TimeDiary: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: String
    @Persisted var title: String
    @Persisted var photos: String
    @Persisted var contents: String
    @Persisted var voice: Data
    @Persisted var favorite: Bool
    @Persisted var memo: String
    
    convenience init(date: String, title: String, photos: String, contents: String, voice: Data, favorite: Bool, memo: String) {
        self.init()
        self.date = date
        self.title = title
        self.photos = photos
        self.contents = contents
        self.voice = voice
        self.favorite = favorite
        self.memo = memo
    }
}

