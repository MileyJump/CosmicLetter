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
    @State var selectedImage: UIImage? // 선택된 이미지를 저장할 상태 변수.
    @State var showImagePicker = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
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
                    
                    // 선택된 이미지가 있으면 이미지 표시
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 200)
                            .padding()
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
                        }, label: {
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                        })
                       Spacer()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .gradientBackground(startColor: Diary.color.timeTravelNavyColor, endColor: Diary.color.timeTravelPurpleColor, starCount: 0)
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


// 이미지 선택을 위한 PHPicker 구현
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            provider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}
