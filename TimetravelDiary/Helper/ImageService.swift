//
//  ImageService.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/25/24.
//

import UIKit
import RealmSwift

class ImageService {
    
    static let shared = ImageService()
    
    let realm = try! Realm()
    
    private init () { }
    
    func saveImageToDocument(image: UIImage, filename: String) -> String? {
        
        if let data = image.jpegData(compressionQuality: 1.0) {
            if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsURL.appendingPathComponent(filename)
                
                do {
                    try data.write(to: fileURL)
                    return fileURL.path
                } catch {
                    print("이미지 저장 에러")
                    return nil
                }
            }
        }
        
        return nil
    }
    
    // 이미지에 저장하고, 해당 경로를 Realm에 저장
    func saveDiaryWithImages(images: [UIImage], title: String, contents: String, voice: Data, favorite: Bool) {
        let timeDiary = TimeDiary()
        let fileManager = FileManager.default
        
        for (index, image) in images.enumerated() {
            if let filePath = saveImageToDocument(image: image, filename: "image_\(index).jpg") {
                timeDiary.photos.append(Photos(photoName: filePath))
            }
        }
        
        timeDiary.title = title
        timeDiary.contents = contents
        timeDiary.voice = voice
        timeDiary.favorite = favorite
//        timeDiary.memo = memo
        
        try! realm.write {
            realm.add(timeDiary)
        }
    }
    
    
    
        //    }
        //
        //        // 앱의 문서 디렉토리 URL을 가져오기
        //        guard let documentDirectory = FileManager.default.urls(
        //            for: .documentDirectory,
        //            in: .userDomainMask).first else { return }
        //
        //        // 이미지를 저장할 경로(파일명) 지정
        //        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        //
        //        // 이미지를 JPEG 형식으로 압축
        //        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        //
        //        // 이미지 파일 저장
        //        do {
        //            try data.write(to: fileURL)
        //            print("File saved successfully at: \(fileURL.path)")
        //        } catch {
        //            print("File save error:", error)
        //        }
        //    }
        //
        //}
    
}
