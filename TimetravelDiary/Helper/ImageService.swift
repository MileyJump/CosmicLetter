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
    
    private init() { }
    
    func saveImageToDocument(image: UIImage, filename: String) -> String? {
        if let data = image.jpegData(compressionQuality: 1.0) {
            if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let uniqueFileName = "\(UUID().uuidString)_\(filename)"
                let fileURL = documentsURL.appendingPathComponent(uniqueFileName)
                do {
                    try data.write(to: fileURL)
                    //                    return fileURL.path
                    return uniqueFileName
                } catch {
                    return nil
                }
            }
        }
        return nil
    }
    
    //    // 이미지에 저장하고, 해당 경로를 Realm에 저장
    func saveDiaryWithImages(date: String, images: [UIImage], title: String, contents: String, voice: Data, favorite: Bool) {
        let timeDiary = TimeDiary()
        let fileManager = FileManager.default
        
        for (index, image) in images.enumerated() {
            
            if let filePath = saveImageToDocument(image: image, filename: "image_\(index).jpg") {
                timeDiary.photos.append(Photos(photoName: filePath))
                print("===============")
                print(filePath)
            }
        }
        
        timeDiary.date = date
        timeDiary.title = title
        timeDiary.contents = contents
        timeDiary.voice = voice
        timeDiary.favorite = favorite
        //        timeDiary.memo = memo
        
        try! realm.write {
            realm.add(timeDiary)
        }
    }
    
    
    
    
    
    // 저장된 전체 경로에서 이미지를 불러오는 메서드
    func loadImageFromDocument(filename: String) -> UIImage? {
        if FileManager.default.fileExists(atPath: filename) {
            return UIImage(contentsOfFile: filename)
        } else {
            print("파일이 존재하지 않음: \(filename)")
            return nil
        }
    }
    
}
