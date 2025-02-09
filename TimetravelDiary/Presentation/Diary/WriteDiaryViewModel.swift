//
//  WriteDiaryViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

//import SwiftUI
//import PhotosUI
//import RealmSwift
//
//class WriteDiaryViewModel: ObservableObject {
//    
//    @Published var titleText: String = ""
//    @Published var contentText: String = ""
//    @Published var selectedPhotos: [PhotosPickerItem] = []
//    @Published var images: [UIImage] = []
//    @Published var date: String = ""
//    @Published var errorMessage: String?
//    
//    @Published var showImagePicker = false
//    @Published var showRecordingModal = false
//    @Published var isRecording = false
//    
//    private let audioRecorderManager = AudioRecorderManager()
//    
//    // 저장을 위한 메서드
//    func saveDiary() {
//        guard !titleText.isEmpty && !contentText.isEmpty else {
//            errorMessage = "titleAndContents"
//            return
//        }
//       
//        // 오디오 데이터 생성
//        let audioData = Data()
//        
//        // ImageService를 통해 Diary 저장
//        ImageService.shared.saveDiaryWithImages(date: date, images: images, title: titleText, contents: contentText, voice: audioData, favorite: false)
//        
//        // 저장 후 상태 초기화
//        titleText = ""
//        contentText = ""
//        images.removeAll()
//    }
//    
//    // 이미지 선택 시 이미지 로드
//    func loadSelectedPhotos() {
//        images.removeAll()
//        errorMessage = nil
//        
//        Task {
//            await withTaskGroup(of: (UIImage?, Error?).self) { taskGroup in
//                for photoItem in selectedPhotos {
//                    taskGroup.addTask {
//                        do {
//                            if let imageData = try await photoItem.loadTransferable(type: Data.self),
//                               let image = UIImage(data: imageData) {
//                                return (image, nil)
//                            }
//                            return (nil, nil)
//                        } catch {
//                            return (nil, error)
//                        }
//                    }
//                }
//                
//                for await result in taskGroup {
//                    if let error = result.1 {
//                        errorMessage = "Failed to load one or more images."
//                        break
//                    } else if let image = result.0 {
//                        images.append(image)
//                    }
//                }
//            }
//        }
//    }
//    
//    // 오디오 레벨 업데이트
//    func updateAudioLevels() {
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            if self.audioRecorderManager.isRecording {
//                self.audioRecorderManager.updateAudioLevels()
//            } else {
//                timer.invalidate()
//            }
//        }
//    }
//    
//    // 녹음 시작 및 중지
//    func toggleRecording() {
//        if isRecording {
//            audioRecorderManager.stopRecording()
//        } else {
//            audioRecorderManager.startRecording()
//            updateAudioLevels()
//        }
//        isRecording.toggle()
//    }
//    
//}
