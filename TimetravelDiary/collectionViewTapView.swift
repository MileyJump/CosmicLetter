//
//  collectionViewTapView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI

enum tapInfo : String, CaseIterable {
    case info = "앨범"
    case size = "일기"
    case review = "메모"
    case call = "문의"
}

struct InfoView: View {

    @State private var selectedPicker: tapInfo = .info
    @Namespace private var animation
    
    var body: some View {
        VStack {
            animate()
            testView(tests: selectedPicker)
        }
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(tapInfo.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.title3)
                        .frame(maxWidth: .infinity/4, minHeight: 50)
                        .foregroundColor(selectedPicker == item ? .black : .gray)

                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "info", in: animation)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
    }
}

struct testView : View {
    
    var tests : tapInfo
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            switch tests {
            case .info:
                CollectPhotosView()
//                ForEach(0..<5) { _ in
//                    Text("블랙컬러")
//                        .padding()
//                    Image("shoes")
//                        .resizable()
//                        .frame(maxWidth: 350, minHeight: 500)
//                }
            case .size:
               DiaryMemoView()
//                    .padding()
            case .review:
                ScrollView(.horizontal, showsIndicators: false) {
                    ForEach(0..<10) { _ in
                        LazyHStack {
                            ForEach(0..<2) { _ in
                                NavigationLink(destination: WriteMemoView()){
                                    VStack(spacing: 5) {
                                        Image("shoes")
                                            .resizable()
                                            .frame(width: 160, height: 200, alignment: .center)
                                        Text("실착용 솔직 한달 후기 입니다")
                                            .font(.system(size: 15, weight: .bold, design: .monospaced))
                                            .frame(width: 160, height: 20, alignment: .leading)
                                            .foregroundColor(.black)
                                        Text("Sky Blue")
                                            .font(.system(size: 13, weight: .medium, design: .monospaced))
                                            .frame(width: 160, height: 20, alignment: .leading)
                                            .foregroundColor(.black)
                                        Text("평발인데 너무편해요 공간도 넉넉해서 걸을때 불편하지 않아요 최고입니다 ㅋㅋ 재구매의사 100%")
                                            .font(.system(size: 13, weight: .medium, design: .default))
                                            .frame(width: 160, height: 50, alignment: .leading)
                                            .foregroundColor(.black)
                                    }
                                    .padding(15)
                                }
                            }
                        }
                    }
                }
            case .call:
                VStack {
                    Text("별도의 커뮤니티를 운영하지 않습니다.")
                    Text("자세한 문의는 여기로 부탁드립니다")
                    Text("02-xxx-xxxx")
                        .padding()
                }.padding()
            }
        }
    }
}



#Preview {
    InfoView()
}


//struct TapView: View {
//    
//    var tests : tapInfo
//    
//    var body: some View {
//        switch tests {
//        case .album :
//            DiaryMemoView()
//        case .diary:
//            WriteDiaryView()
//        case .memo:
//            WriteMemoView()
//        }
//    }
//}
