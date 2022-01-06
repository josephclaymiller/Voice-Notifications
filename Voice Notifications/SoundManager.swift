//
//  SoundManager.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 1/1/22.
//

import Foundation
import AVFAudio

class SoundManager: NSObject, AVAudioRecorderDelegate {
    // audio session to manage recording
    // audio recorder to handle reading and saving of data
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    let audioFileName = "voice_memo_recording.m4a"
    var audioFileURL: URL {
        SoundManager.getSoundFolder().appendingPathComponent(audioFileName)
    }
    
    override init() {
        super.init()
        // need to request permission from the user to use the microphone for audio recording
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            // failed to record!
            print("Failed to set up recording session")
        }
        
    }
    
    static func getSoundFolder() -> URL {
        let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent("Sounds", isDirectory: true)
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
        return url
    }
    
    // MARK: - Record Audio
    // sound file can not be longer than 30 seconds
    func startRecording() {
        print(audioFileURL)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            // TODO: set record button to say "stop"
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func setUpAudioPlayer() {
        audioPlayer = nil
        print(audioFileURL)
        do {
            try audioPlayer = AVAudioPlayer.init(contentsOf: audioFileURL)
            audioPlayer.prepareToPlay()
        } catch {
            print("Failed to create an audio player")
            return
        }
    }
    
    func finishRecording(success: Bool) {
        if audioRecorder != nil {
            audioRecorder.stop()
        }
        audioRecorder = nil
        
        setUpAudioPlayer()
        
        if success {
            // TODO: recordButton.setTitle("Re-record", for: .normal)
        } else {
            // TODO: recordButton.setTitle("Record", for: .normal)
            // recording failed :(
        }
    }
    
    func toggleRecording() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    // iOS might stop recording such as if a phone call comes in
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }

    func playRecording() {
        //print("play recording")
        print(audioFileURL)
        audioPlayer.play()
    }
}

extension SoundManager {
    static let shared = SoundManager()
}
