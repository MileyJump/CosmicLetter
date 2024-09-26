//
//  CustomtabBar.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/24/24.
//
import SwiftUI


struct CustomTabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Main content
                VStack {
                    if selectedTab == 0 {
                        InfoView()
                    } else if selectedTab == 1 {
                        HomeCalendarView()
                    } else {
                        Text("Settings View")
                    }
                    Spacer()
                }
                
                // Custom Tab Bar
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // Tab Button 1
                        Button(action: {
                            selectedTab = 0
                        }) {
                            VStack {
                                Image(systemName: "moon.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Features")
                                    .font(.caption)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 0 ? .white : .gray)
                        }
                        .background(Circle()
                            .fill(selectedTab == 0 ? Diary.color.timeTravelNavyColor.opacity(0.9) : Color.clear)
                            .frame(width: 70, height: 70)
                        )
                        
                        Spacer()
                        
                        // Tab Button 2 (Center Button, slightly raised)
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack {
                                Image(systemName: "calendar.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.top, -15) // To make it appear raised
                                Text("캘린더")
                                    .font(.caption)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 1 ? .white : .gray)
                        }
                        .background(Circle()
                            .fill(selectedTab == 1 ? Diary.color.timeTravelNavyColor.opacity(0.9) : Color.clear)
                            .frame(width: 90, height: 90) // Slightly larger for the center button
                        )
                        
                        Spacer()
                        
                        // Tab Button 3
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack {
                                Image(systemName: "gearshape.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Settings")
                                    .font(.caption)
                            }
                            .padding()
                            .foregroundColor(selectedTab == 2 ? .white : .gray)
                        }
                        .background(Circle()
                            .fill(selectedTab == 2 ? Diary.color.timeTravelNavyColor : Color.clear)
                            .frame(width: 70, height: 70)
                        )
                        
                        Spacer()
                    }
                    .frame(height: 80) // Tab bar height
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black.opacity(0.4))
                            .shadow(radius: 10)
                    )
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
      
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}
