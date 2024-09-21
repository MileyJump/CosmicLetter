//
//  TestTopTapView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/21/24.
//

import SwiftUI

struct TestTopTapView: View {
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.yellow)
            Text("SecondView")
        }
    }
}

#Preview {
    TestTopTapView()
}
