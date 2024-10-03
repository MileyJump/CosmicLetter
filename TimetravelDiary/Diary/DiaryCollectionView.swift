//
//  DiaryCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//
//


//import SwiftUI
//import RealmSwift
//
//struct DiaryCollectionView: View {
//    
//    @ObservedResults(TimeDiary.self) var diaries
//    
//    var body: some View {
//        List {
//            ForEach(diaries, id: \.id) { diary in
//                NavigationLink(destination: DiaryDetailView(diary: diary)) {
//                    Text(diary.title)
//                }
////                .listRowInsets()
////                .listRowInsets(EdgeInsets()) // 기본 리스트 인셋 제거
//            }
//        }
//    }
//}
//
//#Preview {
//    DiaryCollectionView()
//}

import SwiftUI
import RealmSwift

struct DiaryCollectionView: View {
    
    @ObservedResults(TimeDiary.self) var diaries
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // 수직 스택으로 변경
            ForEach(diaries, id: \.id) { diary in
                NavigationLink(destination: DiaryDetailView(diary: diary)) {
                    Text(diary.title)
                        .lineLimit(1) // 줄 수를 1로 제한
                        .truncationMode(.tail) // 줄임표 설정
                        .padding() // 텍스트에 패딩 추가
                        .frame(width: 300, alignment: .leading) // 고정 폭 설정
                        .background(Color.gray.opacity(0.3)) // 배경색 설정
                        .foregroundColor(.white)
//                        .background(Color.white) // 배경색 설정
                        .cornerRadius(10) // 둥글게 처리
                        .padding(.horizontal, 10) // 양쪽 여백 설정
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // 그림자 추가
                }
            }
        }
        .padding(.top, 0) // VStack의 상단 여백 제거
        .padding(.bottom) // 하단 여백 추가 (필요한 경우 조정 가능)
    }
}

#Preview {
    DiaryCollectionView()
}
