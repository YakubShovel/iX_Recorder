//
//  ViewController.swift
//  oX
//
//  Created by Jacob Shavel on 6/26/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?

    
    @IBOutlet weak var RecordBTN: UIButton!
    @IBOutlet weak var StopBTN: UIButton!
    @IBOutlet weak var PlayBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        }
        catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        }
        catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func RecordFunc(_ sender: AnyObject) {
        if audioRecorder?.isRecording == false {
            PlayBTN.isEnabled = false
            StopBTN.isEnabled = true
            audioRecorder?.record()
        }
    }
    @IBAction func StopFunc(_ sender: AnyObject) {
        StopBTN.isEnabled = false
        PlayBTN.isEnabled = true
        RecordBTN.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        }
        else {
            audioPlayer?.stop()
        }
    }
    
    @IBAction func PlayFunc(_ sender: AnyObject) {
        if audioRecorder?.isRecording == false {
            StopBTN.isEnabled = true
            RecordBTN.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            }
            catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        RecordBTN.isEnabled = true
        StopBTN.isEnabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
   
}



