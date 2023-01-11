//
//  tap.swift
//  RC_week4
//
//  Created by 예은 on 2023/01/11.
//

import Foundation
import UIKit

class DragDraft: UIViewController {
    
    let redSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        return view
    }()
    
    let yellowSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.frame = CGRect(x: 150, y: 400, width: 100, height: 100)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(redSquare)
        self.view.bringSubviewToFront(redSquare)
        self.view.addSubview(yellowSquare)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        redSquare.addGestureRecognizer(panGestureRecognizer)
        redSquare.isUserInteractionEnabled = true
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            
            if redSquare.frame.intersects(yellowSquare.frame) {
                print("Here")
            }
        }
        
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        
    }
}
