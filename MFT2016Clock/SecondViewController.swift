//
//  SecondViewController.swift
//  MFT2016Clock
//
//  Created by KajiharaYuma on 2016/07/19.
//  Copyright © 2016年 KajiharaYuma. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var alertTime: UIDatePicker!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var musicSelector: UIPickerView!
    
    private var tempTime: String = "00:00"
    private var setTime: String = "00:00"
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    let fileName: String? = "music1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func alertTimer(sender: AnyObject) {
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        tempTime = format.stringFromDate(alertTime.date)
    }
    
    
    @IBAction func decideAlertTime(sender: AnyObject) {
        setTime = tempTime
        print(setTime)
        ud.setObject(setTime, forKey: "alertTime")
    }
    
    
    @IBAction func changeVolume(sender: AnyObject) {
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

    
}

