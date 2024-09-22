//
//  WriteDiaryView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI
import PhotosUI

struct WriteDiaryView: View {
    
    @State var titleText = ""
    @State var contentText: String = ""
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []
    @State private var errorMessage: String?
    @State private var showImagePicker = false
    
    @StateObject private var audioRecorderManager = AudioRecorderManager()
    
    var body: some View {
        ZStack {
            VStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Title TextField
                TextField("", text: $titleText)
                    .placeholder(when: titleText.isEmpty) {
                        Text("제목을 입력해주세요")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                    }
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(.black)
                
                // 선택된 이미지가 있을 때 이미지 그리드 섹션을 표시
                if !images.isEmpty {
                    imagesGridSection
                }
                
                ZStack(alignment: .topLeading) {
                    if contentText.isEmpty {
                        Text("하고 싶은 말이 있나요?")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .padding(.top, 23)
                            .padding(.leading, 15)
                    }
                    TextEditor(text: $contentText)
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .scrollContentBackground(.hidden)
                }
                .background(Color.clear)
                
                // RecordingView 통합
                RecordingView(audioRecorderManager: audioRecorderManager)
                
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Image(systemName: "photo")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
            .navigationTitle("2024.09.22")
            .navigationBarTitleDisplayMode(.inline)
        }
        .photosPicker(isPresented: $showImagePicker, selection: $selectedPhotos, maxSelectionCount: 3, matching: .images)
        .onChange(of: selectedPhotos) { _ in
            loadSelectedPhotos()
        }
    }
    
    // 이미지들을 3개씩 한 행에 나란히 배치
    private var imagesGridSection: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .clipped()
            }
        }
        .padding(.bottom, 10)
    }
    
    private func loadSelectedPhotos() {
        images.removeAll()
        errorMessage = nil
        
        Task {
            await withTaskGroup(of: (UIImage?, Error?).self) { taskGroup in
                for photoItem in selectedPhotos {
                    taskGroup.addTask {
                        do {
                            if let imageData = try await photoItem.loadTransferable(type: Data.self),
                               let image = UIImage(data: imageData) {
                                return (image, nil)
                            }
                            return (nil, nil)
                        } catch {
                            return (nil, error)
                        }
                    }
                }
                
                for await result in taskGroup {
                    if let error = result.1 {
                        errorMessage = "Failed to load one or more images."
                        break
                    } else if let image = result.0 {
                        images.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    WriteDiaryView()
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

// 수정된 RecordingView
struct RecordingView: View {
    
    @ObservedObject var audioRecorderManager: AudioRecorderManager
    @State private var audioLevels: [CGFloat] = [0, 0, 0] // 초기 오디오 레벨
    
    var body: some View {
        VStack {
            Text(audioRecorderManager.timerString)
                .font(.largeTitle)
                .padding()

            Button(action: {
                if audioRecorderManager.isRecording {
                    audioRecorderManager.stopRecording()
                } else {
                    audioRecorderManager.startRecording()
                    updateAudioLevels() // 녹음 시작 시 오디오 레벨 업데이트 시작
                }
            }) {
                Text(audioRecorderManager.isRecording ? "Stop Recording" : "Start Recording")
                    .font(.title)
                    .padding()
                    .background(audioRecorderManager.isRecording ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // 녹음 중일 때 상태 표시
            if audioRecorderManager.isRecording {
                Text("녹음 중...")
                    .foregroundColor(.red)
                    .font(.headline)

                // 오디오 레벨 그래프 표시
                AudioLevelGraph(audioLevels: audioLevels)
                    .frame(height: 100) // 그래프 높이 조절
            }
        }
        .padding()
        .onChange(of: audioRecorderManager.isRecording) { isRecording in
            if !isRecording {
                audioLevels = [0, 0, 0] // 녹음 중지 시 오디오 레벨 초기화
            }
        }
    }
    
    private func updateAudioLevels() {
        // 타이머를 설정하여 주기적으로 오디오 레벨 업데이트
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if audioRecorderManager.isRecording {
                audioRecorderManager.updateAudioLevels()
                audioLevels = audioRecorderManager.audioLevels // 오디오 레벨 업데이트
            } else {
                timer.invalidate() // 녹음이 중지되면 타이머 중지
            }
        }
    }
}

struct AudioLevelGraph: View {
    var audioLevels: [CGFloat]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(audioLevels, id: \.self) { level in
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 5, height: CGFloat(level) * 200) // 높이를 오디오 레벨에 따라 조절
            }
        }
        .padding(.horizontal)
    }
}
