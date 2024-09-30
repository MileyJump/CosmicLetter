//
//  collectionViewTapView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI

enum TapInfo: String, CaseIterable {
    case album = "앨범"
    case diary = "일기"
    case memo = "메모"
}

// 탭 선택과 선택된 탭에 맞는 내용을 표시하는 메인 뷰입니다.
struct InfoView: View {
    @State private var selectedPicker: TapInfo = .album
    
    // matchedGeometryEffect의 in:에 들어간 같은 @namespace들끼리 같은 애니메이션을 만든다.
    @Namespace private var animation
    
    var body: some View {
        VStack {
            animate()
                .background(Color.clear)
            testView(tests: selectedPicker)
        }
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(TapInfo.allCases, id: \.self) { item in
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }) {
                    VStack {
                        Text(item.rawValue)
                            .font(.title3)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundColor(selectedPicker == item ? .black : .gray)
                            .background(Color.clear) // 배경을 클리어로 설정
                            .clipShape(Capsule()) // 캡슐형 버튼으로 만들기
                            .shadow(color: selectedPicker == item ? Color.black.opacity(0.5) : Color.clear, radius: 4, x: 0, y: 2)
                    }
                }
            }
        }
        .padding(.top) // 상단 여백 추가
    }
}

struct TestView: View {
    var tests: TapInfo
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            switch tests {
            case .album:
                AlbumView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            case .diary:
                DiaryCollectionView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            case .memo:
                MemoCollectionView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            }
        }
    }
}

#Preview {
    InfoView()
}

//struct TestView: View {
//    var tests: TapInfo
//    
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            switch tests {
//            case .album:
//                AlbumView()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
//            case .diary:
//                DiaryCollectionView()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
//            case .memo:
//                MemoCollectionView()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
//            }
//        }
//    }
//}
//
//#Preview {
//    InfoView()
//}


//import SwiftUI
//
//enum TapInfo : String, CaseIterable {
//    case album = "앨범"
//    case diary = "일기"
//    case memo = "메모"
//}
//
//// 탭 선택과 선택된 탭에 맞는 내용을 표시하는 메인 뷰입니다.
//struct InfoView: View {
//
//    @State private var selectedPicker: tapInfo = .album
//    
//    // matchedGeometryEffect의 in:에 들어간 같은 @namespace들끼리 같은 애니메이션을 만든다.
//    @Namespace private var animation
//    
//    var body: some View {
//        VStack {
//            animate()
//            testView(tests: selectedPicker)
//        }
//    }
//    
//    @ViewBuilder
//    private func animate() -> some View {
//        HStack {
//            ForEach(tapInfo.allCases, id: \.self) { item in
//                VStack {
//                    Text(item.rawValue)
//                        .font(.title3)
//                        .frame(maxWidth: .infinity/4, minHeight: 50)
//                        .foregroundColor(selectedPicker == item ? .black : .gray)
//
//                    if selectedPicker == item {
//                        Capsule()
//                            .foregroundColor(.black)
//                            .frame(height: 3)
//                            .matchedGeometryEffect(id: "info", in: animation)
//                    }
//                    
//                }
//                .onTapGesture {
//                    withAnimation(.easeInOut) { // 이 애니메이션이 화면이 닫히는 느낌임
//                        self.selectedPicker = item
//                    }
//                }
//                
//            }
//        }
//    }
//}
//
struct testView : View {
    
    var tests: TapInfo
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            switch tests {
            case .album:
                AlbumView()
//                TestTopTapView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                   // .frame(width: UIScreen.main.bounds.width,  height: UIScreen.main.bounds.height - 500, alignment: .center)
                            
                
//                ForEach(0..<5) { _ in
//                    Text("블랙컬러")
//                        .padding()
//                    Image("shoes")
//                        .resizable()
//                        .frame(maxWidth: 350, minHeight: 500)
//                }
            case .diary:
               DiaryCollectionView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                
//                    .padding()
            case .memo:
                MemoCollectionView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            }
        }
    }
}



#Preview {
    InfoView()
}
