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
    @Published var titleText: String = "" // 제목 추가
    @Published var images: [UIImage] = [] // 이미지 배열 추가
    var audioData: Data? // 음성 데이터 추가 (필요시)

    private var realm: Realm {
        return try! Realm() // Realm 인스턴스 가져오기
    }

    func saveDiary() {
        guard !contentText.isEmpty else {
            // 제목이나 내용이 비어 있을 경우의 처리
            return
        }

        // 메모 객체 생성
        let newMemo = TimeDiaryMemo(date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none),
                                     favorite: false,
                                     memo: contentText)

        // Realm에 저장
        do {
            try realm.write {
                realm.add(newMemo)
            }
        } catch {
            print("저장 오류: \(error)")
        }

        // 저장 후 필드 초기화
        titleText = ""
        contentText = ""
        images.removeAll()
    }
}
