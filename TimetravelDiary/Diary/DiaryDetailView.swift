//
//  DiaryDetailView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/25/24.
//

import SwiftUI
import RealmSwift

struct DiaryDetailView: View {
    
    @ObservedRealmObject var diary: TimeDiary
    
    var body: some View {
        VStack {
            Text(diary.title)
            Text(diary.contents)
        }
           
    }
}

