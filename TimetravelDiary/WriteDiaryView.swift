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
    //    @State var selectedImage: UIImage? // 선택된 이미지를 저장할 상태 변수.
    @State private var selectedPhotos: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []
    @State private var errorMessage: String?
    @State private var showImagePicker = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        //                        photoPickerSection
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
                        }, label: {
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                }
            }
            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
            
            // isPresented가 사진 선택 창(PhotosPicker) 가 화면에 표시 될지 여부를 나타냄
            .photosPicker(isPresented: $showImagePicker, selection: $selectedPhotos, maxSelectionCount: 3, matching: .images)
            .onChange(of: selectedPhotos) { _ in
                loadSelectedPhotos()
            }
        }
    }
    
    //    private var photoPickerSection: some View {
    //        Section {
    //            PhotosPicker(selection: $selectedPhotos,
    //                         maxSelectionCount: 3,
    //                         matching: .images) {
    //                Label("Select a photo", systemImage: "photo")
    //            }
    //                         .onChange(of: selectedPhotos) { _ in
    //                             loadSelectedPhotos()
    //                         }
    //        }
    //    }
    
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

