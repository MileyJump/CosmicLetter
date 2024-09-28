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
    
//    func loadDiary(id: ObjectId) {
//        let realm = try! Realm()
//        if let loadedDiary = realm.object(ofType: TimeDiary.self, forPrimaryKey: id) {
//            self.diary = loadedDiary
//        }
//    }
    
    // 파일매니저에서 이미지를 불러오는 메서드
        func loadImageFromDocument(filename: String) -> UIImage? {
            if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsURL.appendingPathComponent(filename)
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    return UIImage(contentsOfFile: fileURL.path)
                } else {
                    print("파일이 존재하지 않음: \(fileURL.path)")
                    return nil
                }
            }
            return nil
        }
    
}

