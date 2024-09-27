//
//  AlbumViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/27/24.
//

import SwiftUI
import RealmSwift

class AlbumViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    
    init() {
        fetchImageFromDiaryAlbum()
    }
    func getDocumentsDirectory() -> URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("document에서 파일을 찾을 수 없음")
            return nil
        }
//        print("Documents Directory: \(url.path)") // 경로를 출력하여 확인
        return url
    }

    func fetchImageFromDiaryAlbum() {
        let timeDiaries = ImageService.shared.realm.objects(TimeDiary.self)
        var loadedImages: [UIImage] = []

        for diary in timeDiaries {
            if let firstImage = diary.photos.first {
                // 전체 경로가 아니라 파일 이름만 가져와야 함
                let fileName = (firstImage.photoName as NSString).lastPathComponent

                if let documentsDirectory = getDocumentsDirectory() {
                    let filePath = documentsDirectory.appendingPathComponent(fileName).path

                    // 이 경로에 실제로 파일이 존재하는 지 확인
                    if FileManager.default.fileExists(atPath: filePath) {
                        if let image = UIImage(contentsOfFile: filePath) {
                            loadedImages.append(image)
                            print("Image loaded successfully from: \(filePath)")
                        } else {
                            print("Error: Failed to load image at path: \(filePath)")
                        }
                    } else {
                        print("Error: File does not exist at path: \(filePath)")
                    }
                }
            }
        }

        DispatchQueue.main.async {
            self.images = loadedImages
        }
    }
}
