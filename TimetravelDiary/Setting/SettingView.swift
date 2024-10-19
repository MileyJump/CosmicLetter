//
//  SettingView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 10/2/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section(header: Text("정보")
                        .font(.headline)
                        .foregroundColor(.gray))  {
                        Link(destination: URL(string: "https://magnificent-plantain-b4f.notion.site/6189dd4b6c4649968db0f6f59892bf10?pvs=4")!) {
                            HStack {
                                Image(systemName: "exclamationmark.circle")
                                    .foregroundStyle(.black)
                                Text("개인정보처리 방침")
                                    .font(.body)
                                    .foregroundStyle(.black)
                            }
                        }
                        Link(destination: URL(string: "mailto:choialsrud2002@gmail.com")!) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundStyle(.black)
                                Text("문의")
                                    .font(.body)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("버전 정보")
                                .foregroundStyle(.black)
                            Spacer()
                            Text("1.0")
                                .foregroundStyle(.black)
                        }
                    }
                }
//                .listStyle(PlainListStyle()) // 리스트 스타일을 플레인으로 설정
                .navigationTitle("Settings")
//                .navigationBarTitleDisplayMode(.inline) // 타이틀 표시 모드 설정
                .foregroundColor(.white) // 타이틀 색상 변경
//                .padding(.top, 20)
            }
        }
    }
}

#Preview {
    SettingView()
}
