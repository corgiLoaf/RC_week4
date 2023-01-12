//
//  Object.swift
//  RC_week4
//
//  Created by 예은 on 2023/01/12.
//

import UIKit
class TimerView: UIView {
  var timer = Timer()
  var timeLabel = UILabel()
  var isRunning = false
  var elapsedTime = 0.0

  func startTimer() {
    if !isRunning {
      timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
      isRunning = true
    }
  }

  func pauseTimer() {
    if isRunning {
      timer.invalidate()
      isRunning = false
    }
  }

  @objc func updateTime() {
    elapsedTime += 0.1
    timeLabel.text = String(format: "%.1f", elapsedTime)
  }
  
  func addLabel(frame:CGRect) {
    timeLabel.frame = frame
    timeLabel.textColor = .black
    timeLabel.textAlignment = .center
    self.addSubview(timeLabel)
  }
}

