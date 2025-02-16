//
//  AudioRecorderManager.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/22/24.
//

import Foundation
import AVFoundation

class AudioRecorderManager: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    private var countTimer: Timer?
    @Published var countSec: Int = 0
    @Published var timerString: String = ""
    
    // 오디오 레벨을 저장하는 배열
    @Published var audioLevels: [CGFloat] = Array(repeating: 0.0, count: 10)
    
    // 녹음 상태 표시를 위한 프로퍼티
    @Published var isRecording: Bool = false
    
    @Published var currentRecordingURL: URL? // 현재 녹음 중인 파일의 URL
//    @Published var savedRecordingURL: URL? // 저장된 녹음 파일의 URL

    func startRecording() {
        // AVAudioSession의 싱글턴 인스턴스를 가져옴
        let session = AVAudioSession.sharedInstance()
        do {
            
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            // 오디오 세션을 활성화
            try session.setActive(true)
        } catch {
            // 세션 설정에 실패한 경우 에러 메세지 출력!!
            print("Failed to set up recording session")
            return
        }
        
        let fileName = "\(Date().timeIntervalSince1970).m4a"
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일의 전체 경로를 생성
        let fileURL = documentPath.appendingPathComponent(fileName)
        currentRecordingURL = fileURL
        
        // 녹음 설정을 정의. AAC 포맷, 샘플 레이트 12000 Hz, 단일 채널, 높은 오디오 품질로 설정
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            // AVAudioRecorder 인스턴스를 생성하고 초기화, 위에서 정의된 설정과 경로를 사용
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            // 미터링을 활성화하여 녹음 중 오디오 레벨을 측정할 수 있게 함.
//            audioRecorder.isMeteringEnabled = true
            // 녹음 준비
//            audioRecorder.prepareToRecord()
            // 녹음 시작!
            audioRecorder.record()
            
            isRecording = true // 녹음 시작 시 상태 업데이트
            countSec = 0 // 타이머 초기화
            
            // 녹음 시간을 계산하기 위한 타이머 시작, 1초마다 콜백이 실행
            countTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.countSec += 1
                self.timerString = self.convertSecToMinAndHour(seconds: self.countSec)
            }
            
            
        } catch {
            print("Recording failed to start")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false // 녹음 중지 시 상태 업데이트
        countTimer?.invalidate() // 타이머 중지
    }
    
    func saveRecording() -> URL? {
        guard let currentURL = currentRecordingURL else { return nil }
        currentRecordingURL = currentURL
        return currentURL
    }
    
    func resetRecording() {
        stopRecording()
        if let url = currentRecordingURL {
            try? FileManager.default.removeItem(at: url)
        }
        currentRecordingURL = nil
        countSec = 0
        timerString = ""
    }
    
    func updateAudioLevels() {
        audioRecorder?.updateMeters()
        
        if let averagePower = audioRecorder?.averagePower(forChannel: 0) {
            let baseLevel = CGFloat(max(0.2, pow(10.0, averagePower / 20)))
            
            audioLevels = audioLevels.enumerated().map { index, previousLevel in
                let randomVariance = CGFloat.random(in: 0.5...1.5)
                let targetLevel = baseLevel * randomVariance
                return previousLevel * 0.5 + targetLevel * 0.8
            }
        }
    }
    
    private func convertSecToMinAndHour(seconds: Int) -> String {
        let minutes = seconds / 60
        let hours = minutes / 60
        return String(format: "%02d:%02d:%02d", hours, minutes % 60, seconds % 60)
    }
    
    private func convertSecToMinAndHour(seconds: Int, showHours: Bool = false) -> String {
        let minutes = seconds / 60
        let hours = minutes / 60
        return showHours ?
            String(format: "%02d:%02d:%02d", hours, minutes % 60, seconds % 60) :
            String(format: "%02d:%02d", minutes, seconds % 60)
    }
    
    func startPlaying(url: URL) {
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        } catch {
            print("Playing Failed")
        }
    }
}
