//
//  FirstViewController.swift
//  MFT2016Clock
//
//  Created by KajiharaYuma on 2016/07/19.
//  Copyright © 2016年 KajiharaYuma. All rights reserved.
//

import UIKit
import VideoSplashKit
import AVFoundation

class FirstViewController: VideoSplashViewController, AVAudioPlayerDelegate {

    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var alermSwitch: UISwitch!
    private var setTime: String = "00:00"
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    
    private var isAlerted: Bool = false
    var audioPlayer: AVAudioPlayer?
    let fileName: String? = "music1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupVideo()
        nowTime()
        isAlerted = false
        _ = NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: #selector(FirstViewController.update), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func alermSwitcher(sender: AnyObject) {
        if(alermSwitch.on){
            var udId : AnyObject! = ud.objectForKey("alertTime")
            print(udId)
        }
    }
    
    
    
    private func setupVideo() {
        if let path = NSBundle.mainBundle().pathForResource("sample", ofType: "mp4") {
            let url = NSURL.fileURLWithPath(path)
            videoFrame = view.frame
            fillMode = .ResizeAspectFill
            alwaysRepeat = true
            restartForeground = true
            sound = true
            startTime = 0.0
            duration = 0.0
            alpha = 0.6
            backgroundColor = UIColor.blackColor()
            contentURL = url
        }
    }
    
    
    
    func nowTime() {
        let myDate: NSDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let string = formatter.stringFromDate(myDate)
        hourLabel.text = string
    }
    
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // 成形する
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.stringFromDate(nowTime)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    }
    
    
    
    func update() {
        // 現在時刻を取得
        let udId : AnyObject! = ud.objectForKey("alertTime")
        setTime = udId as! String
        nowTime()
        let str = getNowTime()
        if str == setTime {
            if !isAlerted {
                myAlarm(str)
            }
        } else {
            if isAlerted {
                isAlerted = false
            }
        }
    }
    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        if str == setTime{
            alert()
        }
    }
    
    
    
    func alert() {
        let myAlert = UIAlertController(title: "Yuma Kajihara's App", message: "It's time to wake up!", preferredStyle: .Alert)
        let myAction = UIAlertAction(title: "wakeup", style: .Default, handler: {
            (action: UIAlertAction!) -> Void in
            self.audioPlayer?.stop();
        })
        playsound();
        isAlerted = true
        myAlert.addAction(myAction)
        presentViewController(myAlert, animated: true, completion: nil)
    }
    
    
    func playsound(){
        let fileType:String? = "mp3"
        if let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: fileType) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: url)
                audioPlayer!.play()
            } catch {
                // プレイヤー作成失敗
                // その場合は、プレイヤーをnilとする
                audioPlayer = nil
            }
        } else {
            fatalError("Url is nil.")
        }
        
        
    }
    
}

