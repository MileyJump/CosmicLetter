//
//  AlbumViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/27/24.
//

import SwiftUI
import RealmSwift

class AlbumViewModel: ObservableObject {
    @Published var images: [TimeDiary] = []
    
    init() {
        fetchImageFromDiaryAlbum()
    }
    //
    func fetchImageFromDiaryAlbum() {
        let timeDiaries = ImageService.shared.realm.objects(TimeDiary.self)
        self.images = Array(timeDiaries)
    }
    
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

func getDocumentsDirectory() -> URL? {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("document에서 파일을 찾을 수 없음")
        return nil
    }
    return url
}

