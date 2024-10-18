//
//  PopupViewModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/30/24.
//

import Foundation
import RealmSwift
import Combine

class PopupViewModel: ObservableObject {
    @Published var diaryTitle: String = ""
    @Published var memoText: String = ""
//    @Published var hasDiary: Bool = false
//    @Published var hasMemo: Bool = false
    @Published var diaryDates: Set<String> = [] // 일기가 있는 날짜를 저장하는 Set
    @Published var memoDates:  Set<String> = [] // 메모가 있는 날짜를 저장하는 Set
    
    @Published var diaries: [String] = []
    @Published var memos: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    // 월간 일기 및 메모 정보를 가져옴
    func fetchDiaryAndMemoForMonth(startDate: Date, endDate: Date) {
        let realm = try! Realm()
        
        // 해당 월의 모든 일기 가져오기
        let diaries = realm.objects(TimeDiary.self).filter("date >= %@ AND date <= %@", startDate, endDate)
        let diaryDates = diaries.map { $0.date }
        
        // 해당 월의 모든 메모 가져오기
        let memos = realm.objects(TimeDiaryMemo.self).filter("date >= %@ AND date <= %@", startDate, endDate)
        let memoDates = memos.map { $0.date }
        
        // 날짜 정보를 String Set으로 저장
        self.diaryDates = Set(diaryDates)
        self.memoDates = Set(memoDates)
    }
    

        
        func fetchDiaryAndMemo(for dateString: String) {
            let realm = try! Realm()
            
            // 선택된 날짜에 해당하는 일기와 메모를 모두 불러옴
            let diaryObjects = realm.objects(TimeDiary.self).filter("date == %@", dateString)
            let memoObjects = realm.objects(TimeDiaryMemo.self).filter("date == %@", dateString)
            
            // 일기와 메모를 각각 배열에 저장
            self.diaries = diaryObjects.map { $0.title }
            self.memos = memoObjects.map { $0.memo }
        }
        
        var hasDiary: Bool {
            return !diaries.isEmpty
        }
        
        var hasMemo: Bool {
            return !memos.isEmpty
        }
    }
    

