//
//  VoiceRecordView.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/8/25.
//

import SwiftUI
import AVKit

struct VoiceRecordView: View {
    
    let audioFileName: String?
    
    @State var audioPlayer: AVAudioPlayer?
    @State var progress:CGFloat = 0.0
    @State private var playing = false
    @State var duration: Double = 0.0
    @State var formattedDurtaion: String = "20:00"
    @State var formattedProgress: String = "00:00"
    @State private var timer: Timer?
    
    init(audioFileName: String?) {
           self.audioFileName = audioFileName
       }
       
       private func setupAudioPlayer() {
           guard let fileName = audioFileName else { return }
           
           // 도큐먼트 디렉토리에서 파일 URL 가져오기
           let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
           let audioUrl = documentPath.appendingPathComponent(fileName)
           
           do {
               // 오디오 세션 설정
               try AVAudioSession.sharedInstance().setCategory(.playback)
               try AVAudioSession.sharedInstance().setActive(true)
               
               // 오디오 플레이어 초기화
               audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
               audioPlayer?.prepareToPlay()
               
               // 재생 시간 포맷팅
               if let player = audioPlayer {
                   duration = player.duration
                   formattedDurtaion = formatTime(duration)
               }
               
               
               // 타이머 설정 - 프로그레스 바 업데이트용
               setupProgressTimer()
           } catch {
               print("Error setting up audio player: \(error.localizedDescription)")
           }
       }
    
    private func playPauseAction() {
          guard let player = audioPlayer else { return }
          
          if player.isPlaying {
              playing = false
              player.pause()
          } else {
              playing = true
              player.play()
          }
      }
       
    private func skipBackward() {
         guard let player = audioPlayer else { return }
         
         let decrease = player.currentTime - 15
         if decrease < 0.0 {
             player.currentTime = 0.0
         } else {
             player.currentTime -= 15
         }
     }
     
     private func skipForward() {
         guard let player = audioPlayer else { return }
         
         let increase = player.currentTime + 15
         if increase < player.duration {
             player.currentTime = increase
         } else {
             player.currentTime = duration
         }
     }
    
    private func setupProgressTimer() {
          timer?.invalidate()
          timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
              if let player = audioPlayer {
                  progress = CGFloat(player.currentTime / player.duration)
                  formattedProgress = formatTime(player.currentTime)
              }
          }
      }
      
      private func formatTime(_ time: Double) -> String {
          let minutes = Int(time) / 60
          let seconds = Int(time) % 60
          return String(format: "%02d:%02d", minutes, seconds)
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
            Button(action: skipBackward) {
                Image(systemName: "gobackward.15")
                    .font(.title)
                    .imageScale(.medium)
            }
            Spacer()
            Button(action: playPauseAction) {
                Image(systemName: playing ? "pause.circle.fill" : "play.circle.fill")
                    .font(.title)
                    .imageScale(.medium)
            }
            Spacer()
            Button(action: skipForward) {
                Image(systemName: "goforward.15")
                    .font(.title)
                    .imageScale(.medium)
            }
            Spacer()

        }
        Spacer()
    }
    .onAppear {
        setupAudioPlayer()
    }
    .onDisappear {
        timer?.invalidate()
        audioPlayer?.stop()
    }
    .gradientBackground(startColor: Diary.color.timeTravelBlackColor, mediumColor: Diary.color.timeTravelLightBlackColor, endColor: Diary.color.timeTravelDarkNavyBlackColor, starCount: 200)
}



}


