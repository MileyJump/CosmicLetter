//
//  WirteMemoView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/15/24.
//

import SwiftUI

struct WriteMemoView: View {
    @StateObject private var viewModel = WriteMemoViewModel() // ViewModel 생성

    var body: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.contentText.isEmpty {
                Text("메모")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .regular))
                    .padding(.top, 23)
                    .padding(.leading, 15)
            }
            TextEditor(text: $viewModel.contentText) // ViewModel의 contentText를 바인딩
                .padding()
                .background(Color.clear)
                .foregroundColor(.black)
                .scrollContentBackground(.hidden)
        }
        .background(Color.clear)
        .padding()
        .navigationTitle("2024.09.22")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장") {
                    viewModel.saveDiary() // ViewModel의 saveDiary 호출
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    WriteMemoView()
}
