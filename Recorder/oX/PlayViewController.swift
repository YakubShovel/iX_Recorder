//
//  PlayViewController.swift
//  oX
//
//  Created by Jacob Shavel on 6/28/17.
//  Copyright © 2017 Jacob Shavel. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var soundFileURL: URL?
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var PlayBTN: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let URLpath:String = soundFileURL!.path
        print("PVC URL path: ", URLpath)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSound(_ sender: Any) {
        PlayBTN.isEnabled = false
            
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL!)

            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("Played the sound")
        }
        catch let error as NSError {
                print(error.description)
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
