//
//  GASpeech.swift
//  YYFramework
//
//  Created by houjianan on 2020/3/13.
//  Copyright © 2020 houjianan. All rights reserved.
//  语音识别

import Foundation
import Speech

protocol GASpeechDelegate: class {
    func ga_speechRecognizer(available: Bool)
    func ga_speechRecognition(text: String)
}

@available(iOS 10.0, *)
class GASpeech: NSObject {
    
    weak var delegate: GASpeechDelegate?
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh-CN"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    func authorization(finishedHandler: @escaping (_: Bool) -> ()) {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            @unknown default:
                break
            }

            OperationQueue.main.addOperation() {
                finishedHandler(isButtonEnabled)
            }
        }
    }
    
    func start() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            startRecording()
        }
    }
    
    func stop() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }
    }
    
    func startRecording() {
        delegate?.ga_speechRecognizer(available: false)
        print("开始说话")
        if recognitionTask != nil {  // 1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  // 2
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  // 3
        
        let inputNode = audioEngine.inputNode// 4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } // 5
        
        recognitionRequest.shouldReportPartialResults = true  // 6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { [weak self]
            result, error in  // 7
            guard let weakSelf = self else {
                return
            }
            var isFinal = false  // 8
            
            if result != nil {
                print("识别结果：")
                let text = result?.bestTranscription.formattedString
                print(text ?? "识别错误...")
                weakSelf.delegate?.ga_speechRecognition(text: text ?? "识别错误...")
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  // 10
                weakSelf.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                weakSelf.recognitionRequest = nil
                weakSelf.recognitionTask = nil
                
                weakSelf.delegate?.ga_speechRecognizer(available: true)
                print("识别完成")
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  // 11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            [weak self] buffer, when in
            guard let weakSelf = self else {
                return
            }
            weakSelf.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  // 12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        print("正在说话.......")
    }
    
}

@available(iOS 10.0, *)
extension GASpeech: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        delegate?.ga_speechRecognizer(available: available)
    }
}
