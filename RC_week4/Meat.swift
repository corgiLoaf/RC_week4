//
//  Meat.swift
//  RC_week4
//
//  Created by 예은 on 2023/01/11.
//

import Foundation
import UIKit

class Meat: UIImageView{
    var meatScore = 0
    var frontTimer = Timer()
    var backTimer = Timer()
    var isRunning = false
    var isFront = true
    var roastTime = 5.0
    var overcookTime = 7.0
    var frontElapsedTime = 0.0
    var backElapsedTime = 0.0
    
    var imageName = "meat1_front"
    
    
    func setImage(imageName: String){
        self.image = UIImage(named: imageName)
    }
    
    func startFrontTimer() {
        DispatchQueue.global().async {
            self.frontTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateFrontTime), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
    }
    
    func startBackTimer() {
        DispatchQueue.global().async {
            self.backTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateBackTime), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
    }
    
    func pauseFrontTimer(){
        frontTimer.invalidate()
    }
    
    func pauseBackTimer(){
        backTimer.invalidate()
    }
    
    @objc func updateFrontTime() {
        frontElapsedTime += 0.1
        
    }
    
    @objc func updateBackTime() {
        backElapsedTime += 0.1
        
    }
    
    func finalScore(){
        if (self.frontElapsedTime >= 3) && (self.frontElapsedTime < 5){
            if (self.backElapsedTime >= 3) && (self.backElapsedTime < 5){
                self.meatScore = 20
            }
        }else{
            self.meatScore = 0
        }
    }
    

    
    
}


