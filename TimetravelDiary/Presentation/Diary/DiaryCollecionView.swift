//
//  DiaryCollecionView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/7/25.
//

import SwiftUI
import RealmSwift

struct DiaryCollecionView: View {
    
    let repository = DiaryTableRepository()
    
    var body: some View {
        VStack(alignment: .leading) {
            let diary = repository.fetchAllDiaries()
            ForEach(diary, id: \.id) { diary in
                
                    
                
            }
            
        }
    }
}

#Preview {
    DiaryCollecionView()
}
