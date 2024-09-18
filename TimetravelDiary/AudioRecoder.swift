//
//  AudioRecoder.swift
//  TimetravelDiary
//
//  Created by 최민경 on 9/18/24.
//

import SwiftUI
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder!
    @Published var isRecording = false
    
    override init() {
        super.init()
        setupRecorder()
    }
    
    func setupRecorder() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            session.requestRecordPermission { allowed in
                if !allowed {
                    print("Permission to record not granted")
                }
            }
        } catch {
            print("Failed to setup session: \(error)")
        }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentsPath.appendingPathComponent("recording.m4a")
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.prepareToRecord()
        } catch {
            print("Failed to setup recorder: \(error)")
        }
    }
    
    func startRecording() {
        audioRecorder.record()
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder.stop()
        isRecording = false
    }
}

//
//#Preview {
//    AudioRecorder()
//}
