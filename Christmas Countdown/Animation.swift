//
//  Animation.swift
//  Christmas Countdown
//
//  Created by Sean Patterson on 7/8/20.
//  Copyright © 2020 Sean Patterson. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIButton {
    
    @IBAction func pulsate(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.080,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.97, y: 0.96)
                            self.showsTouchWhenHighlighted = false
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.080, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
        
    }
    
}
