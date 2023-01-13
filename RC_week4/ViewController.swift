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
    
    let duration: Double = 60 // duration in seconds
    var timer: Timer?
    var progressView: UIProgressView!
    var timeElapsed: Double = 0
    var score: Int = 0
    let screenSize: CGRect = UIScreen.main.bounds
    
    var submitCnt: Int = 0
    let totalCnt: Int = 7
    
    let roastTime = 3.0
    let overcookTime = 5.0
    
    var objects: [Meat] = []
    let frame =  CGRect(x: 100, y: 100, width: 100, height: 50)
    
    let location: [CGPoint] = [CGPoint(x: 67.0, y: 80.0), CGPoint(x:73.0, y:114), CGPoint(x:171, y:90), CGPoint(x:117, y:50), CGPoint(x:168, y:64), CGPoint(x:195, y:120), CGPoint(x: 112, y: 136)]
    
    
    var endView: UIView = {
        let screenSize: CGRect = UIScreen.main.bounds
        var endview = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        endview.backgroundColor = .white.withAlphaComponent(0.7)
        
        let restartButton = UIButton(frame: CGRect(x: screenSize.width/2 - 40, y: screenSize.height/2 - 50, width: 80, height: 60))
        //restartButton.setTitle("재시작", for: .normal)
        restartButton.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 40.0)
//        restartButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let symbolConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 32, weight: .bold))
        restartButton.setImage(UIImage(systemName: "gobackward", withConfiguration: symbolConfig), for: .normal)
        restartButton.backgroundColor = UIColor(named: "pointColor")
        restartButton.tintColor = .white
//        restartButton.backgroundColor = UIColor(named: "backgroundColor")
        restartButton.layer.cornerRadius = 10

        restartButton.addTarget(self, action: #selector(restartTimer), for: .touchUpInside)
        endview.addSubview(restartButton)
        
        return endview
    }()
    
    
    
    // ------------------------
    // MARK : View Load
    override func viewDidLoad() {
        score = 0
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
        
        // remove objects if remains
        for subview in self.view.subviews {
            if String(describing: type(of: subview)) == "Meat"{
                subview.removeFromSuperview()
            }     
        }
        
        for i in 0..<totalCnt{
            let object = Meat()
            object.backgroundColor = .clear
            object.frame.origin = location[i]
            object.frame.size = CGSize(width: frame.width, height: frame.height)
//            object.frame = CGRect(x: CGFloat(80 + (i*20)), y:  CGFloat(80 + (i*20)), width: frame.width, height: frame.height)
            object.image = UIImage(named: "meat1_front")
            self.view.addSubview(object)
            self.view.bringSubviewToFront(object)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            object.addGestureRecognizer(panGestureRecognizer)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
            object.addGestureRecognizer(tapGesture)
            object.isUserInteractionEnabled = true
            object.tag = i
            
            objects.append(object)
        }
        
        
        scoreView(view: scoreBox)
        scoreLabel.text = "\(score)"
        timeElapsed = 0
        
        // time
        timeProgress()
    }
    
    func timeProgress(){
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame = CGRect(x: 50, y: 20, width: screenSize.width - 100, height: 40)
        progressView.progress = 0
        progressView.tintColor = UIColor(named: "pointColor")
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
        
        // score label
//        CGRect(x: screenSize.width/2 - 40, y: screenSize.height/2 - 50, width: 80, height: 60)
        let finalScoreLabel = UILabel(frame: CGRect(x: screenSize.width/2 , y: screenSize.height/2, width: 100, height: 100))
        finalScoreLabel.center = CGPoint(x: (view.center.x), y: view.center.y - CGFloat(30.0))
        finalScoreLabel.text = "\(score) 점"
        finalScoreLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        //finalScoreLabel.backgroundColor = .yellow
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
            //print("\(sender.view?.frame.origin)")
            
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
                    tappedView.finalScore()
                    self.score += tappedView.meatScore
                    //print("score: \(tappedView.meatScore)")
                }
                sender.view?.removeFromSuperview()
                scoreLabel.text = "\(score)"
                submitCnt += 1
                if submitCnt == totalCnt {
                    timer?.invalidate()
                    timerEnded()
                }
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
            print("\(tappedView.frame.origin)")
            if tappedView.isFront { // Flip to Back side
                tappedView.pauseBackTimer()
                if tappedView.backElapsedTime < roastTime{ // under cook
                    tappedView.image = UIImage(named: "meat1_back")
                }else if tappedView.backElapsedTime < overcookTime{
                    tappedView.image = UIImage(named: "meat1_back_gril")
                }else{
                    tappedView.image = UIImage(named: "meat1_back_over")
                }
                
                if sender.view!.frame.intersects(grilImageView.frame){
                    tappedView.startFrontTimer()
                }
                
                print("index: \(tappedView.tag) - backElapsed : \(tappedView.backElapsedTime)")
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
                
                if sender.view!.frame.intersects(grilImageView.frame){
                    tappedView.startBackTimer()
                }
                print("index: \(tappedView.tag) - frontElapsed : \(tappedView.frontElapsedTime)")
            }
            
            tappedView.isFront = !tappedView.isFront
        }
    }
    
}
