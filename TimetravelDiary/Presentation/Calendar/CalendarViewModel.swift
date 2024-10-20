//
//  CalendarViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 10/1/24.
//

import Foundation
import RealmSwift

class CalendarViewModel: ObservableObject {
    
    
     func fetchMemo(for memo: String) -> TimeDiaryMemo? {
        let realm = try! Realm()
        return realm.objects(TimeDiaryMemo.self).filter("memo == %@", memo).first
    }
    
}
