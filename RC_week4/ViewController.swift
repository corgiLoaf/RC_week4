//
//  ViewController.swift
//  RC_week4
//
//  Created by 예은 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var grilImageView: UIImageView!
    @IBOutlet weak var submitZone: UIView!
    
    @IBOutlet weak var right: UIView!
    @IBOutlet weak var scoreBox: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var meat1: UIImageView!
    
    let duration: Double = 5 // duration in seconds
    var timer: Timer?
    var progressView: UIProgressView!
    var timeElapsed: Double = 0
    var score: Int = 100
    let screenSize: CGRect = UIScreen.main.bounds
    
    let object: UIView = {
        let imageView = UIImageView(image: UIImage(named: "meat1"))
        imageView.frame =  CGRect(x: 100, y: 100, width: 100, height: 200)
        
        let view = UIView()
        //view.addSubview(imageView)
        view.backgroundColor = .red
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        //view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        return view
    }()
    
    var endView: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        var endview = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        endview.backgroundColor = .white.withAlphaComponent(0.5)
        
        let restartButton = UIButton(frame: CGRect(x: screenSize.width/2 - 100, y: screenSize.height/2 - 50, width: 150, height: 50))
        restartButton.setTitle("재시작", for: .normal)
        restartButton.backgroundColor = .blue
//        restartButton.backgroundColor = UIColor(named: "backgroundColor")
        restartButton.layer.cornerRadius = 10

        restartButton.addTarget(self, action: #selector(restartTimer), for: .touchUpInside)
        endview.addSubview(restartButton)
        
        return endview
    }()
    
    
    
    // ------------------------
    // MARK : View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        //self.view.addSubview(timerProgressView)
    }
    
    
    func scoreView(view : UIView){
        //        image.layer.cornerRadius = image.frame.width / 2
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(named: "subColor")?.cgColor
        view.layer.borderWidth = 2
        view.clipsToBounds = true
        
    }
    
    func reset(){
        score = 50
        self.view.addSubview(object)
        self.view.bringSubviewToFront(object)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        object.addGestureRecognizer(panGestureRecognizer)
        object.isUserInteractionEnabled = true
        scoreView(view: scoreBox)
        scoreLabel.text = "\(score)"
        timeElapsed = 0
        
        // time
        timeProgress()
        //score = 0
        
        //meats()
    }
    
    func timeProgress(){
        progressView = UIProgressView(progressViewStyle: .default)
//        progressView.frame = CGRect(x: view.frame.maxX - 40, y: 20, width: view.frame.height - 40, height: 10)
//        progressView.frame = CGRect(x: view.frame.maxX - 50, y: 50, width: view.frame.height - 50, height: 10)
//        progressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        progressView.frame = CGRect(x: 50, y: 50, width: view.frame.width - 100, height: 10)
        progressView.progress = 0
        //progressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        self.view.addSubview(progressView)

        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)

    }
    
    
    @objc func timerFired() {
        timeElapsed += 0.01
        let progress = Float(timeElapsed / duration)
        progressView.progress = progress
        
        if timeElapsed >= duration {
            timer?.invalidate()
            timerEnded()
        }
    }
    
    func timerEnded() {
        // Timer has ended, do something here
        // Show the restart button
        print("Ended")
        
        // score label
        let finalScoreLabel = UILabel(frame: CGRect(x: screenSize.width/2 - 100, y: screenSize.height/2 - 100, width: 150, height: 50))
        finalScoreLabel.text = "\(score)"
        finalScoreLabel.textAlignment = .center
        endView.addSubview(finalScoreLabel)
        self.view.addSubview(endView)
        //view.addSubview(restartButton)
    }

    @objc func restartTimer() {
        // Restart the timer
        endView.removeFromSuperview()
        timer?.invalidate()
        timeElapsed = 0
        progressView.progress = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        //reset()
    }
    
    @objc func tmp(){
        print("button clicked!")
    }
    
    
    
    func meats(){
        self.view.addSubview(object)
        self.view.bringSubviewToFront(object)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        object.addGestureRecognizer(panGestureRecognizer)
        object.isUserInteractionEnabled = true
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            
            if sender.view!.frame.intersects(grilImageView.frame) {
                DispatchQueue.global(qos: .userInitiated).async {
                    var myTimer: Timer?
                    //myTimer.
                }
            }else if sender.view!.frame.intersects(submitZone.frame) {
                print("Arrive")
                sender.view?.removeFromSuperview()
            }
            //            else if sender.view!.frame.intersects(submitZone.frame) {
            //                print("Arrive")
            //                sender.view?.removeFromSuperview()
            //            }
        }
        
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
}
