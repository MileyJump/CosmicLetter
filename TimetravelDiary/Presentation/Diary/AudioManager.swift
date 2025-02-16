//
//  AudioManager.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/16/25.
//

import Foundation
import AVFoundation

class AudioManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    @Published var audioPlayer: AVAudioPlayer?
    @Published var progress:CGFloat = 0.0
    @Published private var playing = false
    @Published var duration: Double = 0.0
    @Published var formattedDurtaion: String = "00:00"
    @Published var formattedProgress: String = "00:00"
    @Published private var timer: Timer?
    
    func setupAudioPlayer(_ fileName: String?) {
        guard let fileName = fileName else {
            print("오디오 파일 이름이 없습니다!")
            return
        }
        print("파일 매니저 ~~~~~~ == \(fileName) == ~~~~!!")
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let audioUrl = documentPath.appendingPathComponent(fileName)
        
        print("오디오 파일 경로: \(audioUrl.path)")
        
        guard FileManager.default.fileExists(atPath: audioUrl.path) else {
            print("파일이 존재하지 않습니다: \(audioUrl.path)")
            
            return
        }
        
        do {
            // 오디오 세션 설정
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            
            print("audioUrl: \(audioUrl)")
            // 오디오 플레이어 초기화
            self.audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            print("ㅂ꺠꺆ㅎ")
            //            audioPlayer?.prepareToPlay()
//            audioPlayer?.delegate = self
            print("빠빠ㅎ")
            audioPlayer?.play()
            
            print("아하하하핳ㅎ")
            // 재생 시간 포맷팅
            if let player = audioPlayer {
                print("야야야야야야")
                duration = player.duration
                formattedDurtaion = formatTime(duration)
            }
            
            // 타이머 설정 - 프로그레스 바 업데이트용
            setupProgressTimer()
        }
        
        catch {
            print("Error setting up audio player: \(error.localizedDescription)")
        }
    }
    
    func playPauseAction() {
        guard let player = audioPlayer else { return }
        
        if player.isPlaying {
            playing = false
            player.pause()
        } else {
            playing = true
            player.play()
        }
    }
    
    func skipBackward() {
        guard let player = audioPlayer else { return }
        
        let decrease = player.currentTime - 15
        if decrease < 0.0 {
            player.currentTime = 0.0
        } else {
            player.currentTime -= 15
        }
    }
    
    func skipForward() {
        guard let player = audioPlayer else { return }
        
        let increase = player.currentTime + 15
        if increase < player.duration {
            player.currentTime = increase
        } else {
            player.currentTime = duration
        }
    }
    
    func setupProgressTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let player = self.audioPlayer {
                self.progress = CGFloat(player.currentTime / player.duration)
                self.formattedProgress = self.formatTime(player.currentTime)
            }
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
