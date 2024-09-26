//
//  TimeDiaryTableRepository.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/24/24.
//

import Foundation
import RealmSwift

class TimeDiaryTableRepository {
    
    private let realm = try! Realm()
    
    func fetchItem(id: ObjectId) -> [TimeDiary] {
        let value = realm.objects(TimeDiary.self)
        return Array(value)
    }
    
    func createItem(item: TimeDiary) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm append Error")
        }
    }
     
    func updateItem(_ completionHandler: () -> Void) {
        do {
            try realm.write {
                completionHandler()
            }
        } catch {
            print("Realm Update Failed")
        }
    }
    
    func deleteItem(item: TimeDiary) {
        let item = fetchItem(id: item.id)
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Realm Delete Succeed")
        }
    }
    
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
                print("All Realm Data deleted Succeed")
            }
        } catch {
            print("Realm Error: \(error)")
        }
    }
  
    
     
//     static func editMemo(memo: TimeDiary, title: String, text: String) {
//         try! realm.write {
//             memo.title = title
//             memo.text = text
//             memo.postedDate = Date.now
//         }
//     }
    
}
