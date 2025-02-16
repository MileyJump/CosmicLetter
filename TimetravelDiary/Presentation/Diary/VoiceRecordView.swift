//
//  VoiceRecordView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/8/25.
//

import SwiftUI
import AVKit
import RealmSwift

struct VoiceRecordView: View {
    
    let audioFileName: String?
    
    @State var audioPlayer: AVAudioPlayer?
    @State var progress:CGFloat = 0.0
    @State private var playing = false
    @State var duration: Double = 0.0
    @State var formattedDurtaion: String = "00:00"
    @State var formattedProgress: String = "00:00"
    @State private var timer: Timer?
    
    @StateObject private var audioManager = AudioManager()
    
    init(audioFileName: String?) {
        
        self.audioFileName = audioFileName
    }
    
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.6)
            Spacer()
            HStack{
                Text(formattedProgress).font(.caption.monospacedDigit())
                    .foregroundStyle(.white)
                GeometryReader{ gr in
                    Capsule()
                        .stroke(Color.blue, lineWidth: 2)
                        .background(
                            Capsule()
                                .foregroundColor(Color.white)
                                .frame(width: gr.size.width * progress, height: 8), alignment: .leading)
                }.frame( height: 8)
                
                Text(formattedDurtaion).font(.caption.monospacedDigit()).foregroundStyle(.white)
            }
            .padding()
            HStack {
                Spacer()
                Button(action: audioManager.skipBackward) {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                        .imageScale(.medium)
                }
                Spacer()
                Button(action: audioManager.playPauseAction) {
                    Image(systemName: playing ? "pause.circle.fill" : "play.circle.fill")
                        .font(.title)
                        .imageScale(.medium)
                }
                Spacer()
                Button(action: audioManager.skipForward) {
                    Image(systemName: "goforward.15")
                        .font(.title)
                        .imageScale(.medium)
                }
                Spacer()
                
            }
            Spacer()
        }
        .onAppear {
            audioManager.setupAudioPlayer(audioFileName)
        }
        .onDisappear {
            timer?.invalidate()
            audioPlayer?.stop()
        }
        .gradientBackground(startColor: Diary.color.timeTravelBlackColor, mediumColor: Diary.color.timeTravelLightBlackColor, endColor: Diary.color.timeTravelDarkNavyBlackColor, starCount: 200)
    }
}


