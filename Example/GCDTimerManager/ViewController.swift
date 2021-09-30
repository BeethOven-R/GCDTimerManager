//
//  ViewController.swift
//  GCDTimerManager
//
//  Created by wjr723@126.com on 09/30/2021.
//  Copyright (c) 2021 wjr723@126.com. All rights reserved.
//

import UIKit
import GCDTimerManager

class ViewController: UIViewController {
    
    private let timerIdentifier: String = "com.timer.gcd"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let totalTimes = 60
        var leftTimes = totalTimes
        
        GCDTimerManager.shared.scheduleDispatchTimer(interval: DispatchTimeInterval.milliseconds(1000), identifier: timerIdentifier, repeats: true, leeway: DispatchTimeInterval.milliseconds(100), queue: .global()) { _ in
            leftTimes = leftTimes-1
            if leftTimes == 0 {
                GCDTimerManager.shared.cancelTimer(identifier: self.timerIdentifier)
            }
            debugPrint("\(leftTimes)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        GCDTimerManager.shared.suspendTimer(identifier: timerIdentifier)
    }

}

