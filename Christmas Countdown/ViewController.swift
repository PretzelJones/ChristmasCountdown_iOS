//
//  ViewController.swift
//  Christmas Countdown
//
//  Created by Sean Patterson on 10/1/19.
//  Copyright © 2019 Sean Patterson. All rights reserved.
//

//
//  ViewController.swift
//  ChristmasCountdown
//
//  Created by Sean Patterson on 10/1/19.
//  Copyright © 2019 Sean Patterson. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var daysLabel: UILabel!
    
    var audioPlayer: AVAudioPlayer?
    
    var ChristmasDay: Date
    {
        let userCalendar = Calendar.current
        var components = DateComponents()
        components.year = 2019
        components.day = 25
        components.month = 12
        
        return userCalendar.date(from: components)!
    }
    
    var today: Date
    {
        let now = Date()
        let userCalendar = Calendar.current
        var components = DateComponents()
        components.year = userCalendar.component(.year, from: now)
        components.day = userCalendar.component(.day, from: now)
        components.month = userCalendar.component(.month, from: now)
        
        return userCalendar.date(from: components)!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!))
            audioPlayer?.prepareToPlay()
        }
        catch {
            print(error)
        }
        
        audioPlayer?.numberOfLoops = -1
        self.audioPlayer?.play()
        
        //set snowflake background image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        //snowflake animation settings
        let flakeEmitterCell = CAEmitterCell()
        flakeEmitterCell.contents = UIImage(named: "snowFlake")?.cgImage
        flakeEmitterCell.scale = 0.06
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 40
        flakeEmitterCell.velocity = -30
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 30
        flakeEmitterCell.xAcceleration = 5
        flakeEmitterCell.spin = -0.5
        flakeEmitterCell.spinRange = 1.0
        
        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        
        view.layer.addSublayer(snowEmitterLayer)
        
        let daysTillChristmas = daysBetweenDates(startDate: today, endDate: ChristmasDay)
        daysLabel.text = "\(daysTillChristmas)"
        
        UIApplication.shared.applicationIconBadgeNumber = daysTillChristmas
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }
}

