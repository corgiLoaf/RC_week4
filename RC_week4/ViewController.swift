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
    
    let duration: Double = 100 // duration in seconds
    var timer: Timer?
    var progressView: UIProgressView!
    var timeElapsed: Double = 0
    var score: Int = 100
    let screenSize: CGRect = UIScreen.main.bounds
    
    let roastTime = 3.0
    let overcookTime = 5.0
    
    var objects: [Meat] = []
    let frame =  CGRect(x: 100, y: 100, width: 100, height: 50)
    
//    let object1: Meat = {
//
//        let view = Meat()
//        view.backgroundColor = .clear
//        view.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
//        view.image = UIImage(named: "meat1_front")
//
//        //view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
//
//        return view
//    }()
//
    
    
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
        score = 0
        for i in 0..<3{
            let object = Meat()
            object.backgroundColor = .clear
            object.frame = CGRect(x: CGFloat(80 + (i*20)), y:  CGFloat(80 + (i*20)), width: frame.width, height: frame.height)
            object.image = UIImage(named: "meat1_front")
            self.view.addSubview(object)
            self.view.bringSubviewToFront(object)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            object.addGestureRecognizer(panGestureRecognizer)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            object.addGestureRecognizer(tapGesture)
            object.isUserInteractionEnabled = true
            objects.append(object)
        }
//        self.view.addSubview(object1)
//        self.view.bringSubviewToFront(object1)
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        object1.addGestureRecognizer(panGestureRecognizer)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//        object1.addGestureRecognizer(tapGesture)
//        object1.isUserInteractionEnabled = true
        
        
        scoreView(view: scoreBox)
        scoreLabel.text = "\(score)"
        timeElapsed = 0
        
        // time
        timeProgress()
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
        reset()
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            
            if sender.view!.frame.intersects(grilImageView.frame) {
                //print("here")
                if let tappedView = sender.view as? Meat {
                    if tappedView.isFront{
                        tappedView.startBackTimer()
                    }else{
                        tappedView.startFrontTimer()
                    }
                }
            }else if sender.view!.frame.intersects(submitZone.frame) {
                if let tappedView = sender.view as? Meat{
                    //tappedView.finalScore()
                    self.score += tappedView.meatScore
                }
                sender.view?.removeFromSuperview()
                scoreLabel.text = "\(score)"
            }

        }
        
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        if let tappedView = sender.view as? Meat {
            if tappedView.isFront { // Flip to Back side
                tappedView.pauseBackTimer()
                if tappedView.backElapsedTime < roastTime{ // under cook
                    tappedView.image = UIImage(named: "meat1_back")
                }else if tappedView.backElapsedTime < overcookTime{
                    tappedView.image = UIImage(named: "meat1_back_gril")
                }else{
                    tappedView.image = UIImage(named: "meat1_back_over")
                }
                tappedView.startFrontTimer()
                print("backElapsed : \(tappedView.backElapsedTime)")
            }
            else {
                tappedView.pauseFrontTimer()
                if tappedView.frontElapsedTime < roastTime{ // under cook
                    tappedView.image = UIImage(named: "meat1_front")
                }else if tappedView.frontElapsedTime < overcookTime{
                    tappedView.image = UIImage(named: "meat1_front_gril")
                }else{
                    tappedView.image = UIImage(named: "meat1_front_over")
                }
                tappedView.startBackTimer()
                print("frontElapsed : \(tappedView.frontElapsedTime)")
            }
            
            tappedView.isFront = !tappedView.isFront
        }
    }
    
}
