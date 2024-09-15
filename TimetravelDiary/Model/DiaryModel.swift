//
//  DiaryModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import SwiftUI
import SwiftData

@Model
class DiaryModel {
    var date: Date
    var content: String
    
    init(date: Date, content: String) {
        self.date = date
        self.content = content
    }
}
