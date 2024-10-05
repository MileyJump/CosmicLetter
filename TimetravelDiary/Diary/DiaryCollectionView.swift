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
        // 월별로 그룹화된 일기 데이터를 생성
        
        let groupedDiaries = Dictionary(grouping: diaries) { diary -> String in
            // monthOnlyFormatter를 사용하여 날짜를 월로 변환
            let date = CalendarView.calendarFormatter.date(from: diary.date) ?? Date()
            return CalendarView.calendarFormatter.string(from: date) // yyyy.MM 형식으로 반환
        }
//        let groupedDiaries = Dictionary(grouping: diaries) { diary -> String in
//            // DateFormatter를 사용하여 날짜를 월로 변환
//            // 🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀🍀
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM"
//            let date = dateFormatter.date(from: diary.date) ?? Date()
//            dateFormatter.dateFormat = "yyyy년 MM월"
//            return dateFormatter.string(from: date)
//        }
//        
        // 정렬된 섹션 키 생성
        let sortedKeys = groupedDiaries.keys.sorted(by: { $0 > $1 }) // 최신 월부터 정렬
        
        VStack(alignment: .leading) {
            ForEach(sortedKeys, id: \.self) { month in
                Section(header: Text(month)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding() ) {
//                    .background(Color.gray.opacity(0.1))) {
                    ForEach(groupedDiaries[month] ?? [], id: \.id) { diary in
                        NavigationLink(destination: DiaryDetailView(diary: diary)) {
                            Text(diary.title)
                                .lineLimit(1) // 줄 수를 1로 제한
                                .truncationMode(.tail) // 줄임표 설정
                                .padding() // 텍스트에 패딩 추가
                                .frame(width: 300, alignment: .leading) // 고정 폭 설정
                                .background(Color.gray.opacity(0.3)) // 배경색 설정
                                .foregroundColor(.white)
                                .cornerRadius(10) // 둥글게 처리
                                .padding(.horizontal, 5) // 양쪽 여백 설정
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // 그림자 추가
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 0) // VStack의 상단 여백 제거
        .padding(.bottom) // 하단 여백 추가 (필요한 경우 조정 가능)
        .listStyle(GroupedListStyle()) // 리스트 스타일 설정
    }
}

#Preview {
    DiaryCollectionView()
}
