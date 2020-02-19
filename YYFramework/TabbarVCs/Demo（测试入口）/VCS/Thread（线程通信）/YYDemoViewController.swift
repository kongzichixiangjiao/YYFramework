//
//  YYDemoViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/17.
//  Copyright © 2018年 houjianan. All rights reserved.
//  线程间通信

import UIKit

class YYDemoViewController: UIViewController, NSMachPortDelegate {

    var handelEventMachPort: NSMachPort!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMachPortToMainRunLoop()

    }
    
    func addMachPortToMainRunLoop() {
        self.handelEventMachPort = NSMachPort()
        self.handelEventMachPort.setDelegate(self)
        RunLoop.current.add(self.handelEventMachPort, forMode: RunLoop.Mode.common)
    }

    func handleMachMessage(_ msg: UnsafeMutableRawPointer) {
        print("handleMatchMessage: \(Thread.current)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        DispatchQueue.global().async {
            guard let sendEventPort = self.handelEventMachPort else {
                return
            }
            Thread.current.name = "MySubThread"
            print("send event sub thread: \(Thread.current)")
            
            sendEventPort.send(before: Date(), msgid: 100, components: nil, from: nil, reserved: 0)
        }
    }
    
}

