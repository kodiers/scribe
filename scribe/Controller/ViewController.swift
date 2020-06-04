//
//  ViewController.swift
//  scribe
//
//  Created by Viktor Yamchinov on 04.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == .authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("Recognition error: \(error)")
                        } else {
                            print(result?.bestTranscription.formattedString ?? "")
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }

    @IBAction func playBtnPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
        
    }
}

