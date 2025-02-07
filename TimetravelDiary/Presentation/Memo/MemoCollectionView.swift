//
//  MemoCollectionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/28/24.
//

import SwiftUI
import RealmSwift

struct MemoCollectionView: View {
    
    @ObservedResults(TimeDiaryMemo.self) var memo // TimeDiaryMemo 모델에 대한 관찰
    
    var body: some View {
        
        let groupedMemos = Dictionary(grouping: memo) { memos -> String in
            let date = CalendarView.calendarFormatter.date(from: memos.date) ?? Date()
            return CalendarView.calendarFormatter.string(from: date) // yyyy.MM 형식으로 반환
        }
        
        // 정렬된 섹션 키 생성
        let sortedKeys = groupedMemos.keys.sorted(by: { $0 > $1 }) // 최신 월부터 정렬
        
        VStack(alignment: .leading) {
            ForEach(sortedKeys, id: \.self) { month in
                Section(header: Text(month)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()) {
                    
                    // 각 월에 해당하는 메모들
                    let memosForMonth = groupedMemos[month] ?? []
                    ForEach(memosForMonth, id: \.id) { memo in
                        NavigationLink(destination: MemoDetailView(memo: memo)) {
                            Text(memo.memo)
                                .font(.callout)
                                .lineLimit(1)
                                .truncationMode(.tail) // 줄임표 설정
                                .padding()
                                .frame(width: 350, alignment: .leading)
                                .background(Color.gray.opacity(0.3))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 5)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 0)
        .padding(.bottom)
        .listStyle(GroupedListStyle()) // 리스트 스타일 설정
    }
}

#Preview {
    MemoCollectionView()
}
