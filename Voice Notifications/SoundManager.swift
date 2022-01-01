//
//  SoundManager.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 1/1/22.
//

import Foundation
import AVFAudio

class SoundManager {
    // audio session to manage recording
    // audio recorder to handle reading and saving of data
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    let audioFileName = "voice_memo_recording.m4a"
    var audioFileURL: URL {
        SoundManager.getSoundFolder().appendingPathComponent(audioFileName)
    }
    
    init() {
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
}

extension SoundManager {
    static let shared = SoundManager()
}
