//
//  Color+.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/13/24.
//

import Foundation
import UIKit
import SwiftUI

enum Diary { }

extension Diary {
    enum color {
//        static let timeTravelPinkColor = Color(UIColor(hexCode: "CB80AB"))
//        static let timeTravelPinkColor = Color(UIColor(hexCode: "E3A5C7"))
//        static let timeTravelPinkColor = Color(UIColor(hexCode: "D95F59"))
//        static let timeTravelPinkColor = Color(UIColor(hexCode: "FF8A8A"))
        static let timeTravelPinkColor = Color(UIColor(hexCode: "102C57"))
        
        static let timeTravelNavyColor = Color(UIColor(hexCode: "17153B"))
        
        static let timeTravelDarkNavyColor = Color(UIColor(hexCode: "0E0C23"))
        static let timeTravelMediumCNavyClor = Color(UIColor(hexCode: "03346E"))
        
        
//        static let timeTravelPurpleColor = Color(UIColor(hexCode: "624E88"))
//        static let timeTravelPurpleColor = Color(UIColor(hexCode: "4F1787"))
        static let timeTravelPurpleColor = Color(UIColor(hexCode: "2E073F"))
        static let timeTravelBlueColor = Color(UIColor(hexCode: "3795BD"))
        
        static let timeTravelgray = Color(UIColor(hexCode: "E6DAD1"))
        static let timeTravelpeachColor = Color(UIColor(hexCode: "FF8A8A"))
        
    }
}



extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
