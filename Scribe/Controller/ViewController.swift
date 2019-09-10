//
//  ViewController.swift
//  Scribe
//
//  Created by Molnár Csaba on 2019. 09. 10..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.hidesWhenStopped = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
    }
    
    func requestSpeechAuth(){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        debugPrint("hiba")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            debugPrint("There was an error \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                            print(result?.bestTranscription.formattedString)
                        }
                    }
                }
            }
        }
    }

    @IBAction func playBtnWasPressed(_ sender: Any) {
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
}

