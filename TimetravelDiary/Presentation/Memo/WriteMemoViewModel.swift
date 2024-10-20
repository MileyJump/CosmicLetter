//
//  WriteMemoViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

class WriteMemoViewModel: ObservableObject {
    @Published var contentText: String = ""
    

    private var realm: Realm {
        return try! Realm() // Realm 인스턴스 가져오기
    }

    func saveDiary(selectedDate: String) {
        guard !contentText.isEmpty else {
            // 제목이나 내용이 비어 있을 경우의 처리
            return
        }

        // 메모 객체 생성
        let newMemo = TimeDiaryMemo(date: selectedDate, favorite: false, memo: contentText)

        // Realm에 저장
        do {
            try realm.write {
                realm.add(newMemo)
                print("memo 저장 \(newMemo)")
            }
        } catch {
            print("저장 오류: \(error)")
        }

        // 저장 후 필드 초기화
        contentText = ""
    }
}
