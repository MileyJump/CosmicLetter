//
//  TimeDiaryTableRepository.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/24/24.
//

import Foundation
import RealmSwift

class TimeDiaryTableRepository {
    
    private static var realm = try! Realm()
     
     // realm객체가 타입 프로퍼티이기에 메서드도 타입 메서드로 선언
     // realm객체에 담긴 모든 값을 Results<Memo>의 형태로 조회
     static func findAll() -> Results<TimeDiary> {
         realm.objects(TimeDiary.self)
     }
     
     // realm객체에 값을 추가
     static func addMemo(_ memo: TimeDiary) {
         try! realm.write {
             realm.add(memo)
         }
     }
     
     // realm객체의 값을 삭제
     static func delMemo(_ memo: TimeDiary) {
         try! realm.write {
             realm.delete(memo)
         }
     }
     
     // realm객체의 값을 업데이트
     static func editMemo(memo: TimeDiary, title: String, text: String) {
         try! realm.write {
             memo.title = title
             memo.text = text
             memo.postedDate = Date.now
         }
     }
    
}
