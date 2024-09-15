//
//  PublicHolidayModel.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/14/24.
//

import Foundation

struct PublicHolidayModel: Decodable {
    let date: String
    let localName: String
    let name: String
    let countryCode: String
}
