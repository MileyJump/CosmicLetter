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
    
//    func loadImageFromDocument(filename: String) -> UIImage? {
//        if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let fileURL = documentsURL.appendingPathComponent(filename)
//            return UIImage(contentsOfFile: fileURL.path)
//        }
//        return nil
//    }
//}

//class ImageService {
//    
//    static let shared = ImageService()
//    
//    let realm = try! Realm()
//    
//    private init () { }
//    
//    
//    func saveImageToDocument(image: UIImage, filename: String) -> String? {
//        if let data = image.jpegData(compressionQuality: 1.0) {
//            if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let uniqueFileName = "\(UUID().uuidString)"
//                let fileURL = documentsURL.appendingPathComponent("\(filename)_\(uniqueFileName)")
//                
//                // 이미지 파일 저장
//                do {
//                    try data.write(to: fileURL)
//                    print("Image saved at path: \(uniqueFileName)") // 경로를 출력하여 확인
//                    return fileURL.path
//                    
//                } catch {
//                    print("이미지 저장 에러")
//                    return nil
//                }
//            }
//        }
//        return nil
//    }
//    
//    // 이미지에 저장하고, 해당 경로를 Realm에 저장
    func saveDiaryWithImages(images: [UIImage], title: String, contents: String, voice: Data, favorite: Bool) {
        let timeDiary = TimeDiary()
        let fileManager = FileManager.default
        
        for (index, image) in images.enumerated() {
            
            if let filePath = saveImageToDocument(image: image, filename: "image_\(index).jpg") {
                timeDiary.photos.append(Photos(photoName: filePath))
                print("===============")
                print(filePath)
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
//    
//    // 저장된 이미지 경로에서 이미지를 불러오는 메서드
//        func loadImageFromDocument(filename: String) -> UIImage? {
//            if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let fileURL = documentsURL.appendingPathComponent(filename)
//                if FileManager.default.fileExists(atPath: fileURL.path) {
//                    return UIImage(contentsOfFile: fileURL.path)
//                } else {
////                    print("파일이 존재하지 않음: \(fileURL.path)")
//                    return nil
//                }
//            }
//            return nil
//        }
    
    // 저장된 전체 경로에서 이미지를 불러오는 메서드
    func loadImageFromDocument(filename: String) -> UIImage? {
        if FileManager.default.fileExists(atPath: filename) {
            return UIImage(contentsOfFile: filename)
        } else {
            print("파일이 존재하지 않음: \(filename)")
            return nil
        }
    }
//
//    func getImagesFromDiary() -> [String] {
//        let timeDiaries = realm.objects(TimeDiary.self)
//        var imagePaths: [String] = []
//        
//        for diary in timeDiaries {
//            if let firstImage = diary.photos.first {
//                imagePaths.append(firstImage.photoName)
//            }
//        }
//        return imagePaths
//    }
//    
//    func getFirstImageFromDiary() -> String? {
//        let timeDiaries = realm.objects(TimeDiary.self)
//        return timeDiaries.first?.photos.first?.photoName
//    }
//    
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
