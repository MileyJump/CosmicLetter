//
//  WriteDiaryView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct WriteDiaryView: View {
    
    @State var titleText = ""
    @State var contentText: String = ""
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []
    @State private var errorMessage: String?
    @State private var showImagePicker = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    VStack {
                        Form {
                            imagesSection
                        }
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    VStack {
                        // Title TextField
                        TextField("", text: $titleText)
                            .placeholder(when: titleText.isEmpty) {
                                Text("제목을 입력해주세요")
                                    .foregroundColor(.gray)
                                    .font(.title)
                            }
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(.white)
                        
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
                                .foregroundColor(.white)
                                .scrollContentBackground(.hidden)
                        }
                        .background(Color.clear)
                    }
                    .padding()
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                print("포토 툴바 버튼 탭드")
                                showImagePicker = true
                                print("showImagePicker: \(showImagePicker)")
                            }, label: {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                            })
                            Spacer()
                        }
                    }
                }
                .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
            }
            
            // isPresented는 NavigationView 밖에서 처리
            .photosPicker(isPresented: $showImagePicker, selection: $selectedPhotos, maxSelectionCount: 3, matching: .images)
            .onChange(of: selectedPhotos) { _ in
                loadSelectedPhotos()
            }
        }
    }
    
    private var imagesSection: some View {
        Section {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .padding(.vertical, 10)
            }
        }
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

