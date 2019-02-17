//
//  ViewController.swift
//  pressure
//
//  Created by murph on 2/15/19.
//  Copyright © 2019 k9doghouse. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController
{

    @IBAction func refreshButton(_ sender: UIButton) {getSensorData()}
    @IBOutlet weak var pressureLabel: UILabel!

    var rawPressure = 999.99
    var intervalTimer: Timer!

    let hour = 3600.00
    let altimeter = CMAltimeter()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        getSensorData()
        intervalTimer3600()
    }


    func intervalTimer3600()
    {
        intervalTimer = Timer.scheduledTimer(timeInterval: hour,
                                             target: self,
                                             selector: #selector(getSensorData),
                                             userInfo: nil,
                                             repeats: true)
    }


    @objc func getSensorData()
    {
        if CMAltimeter.isRelativeAltitudeAvailable()
        {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main)
            {
                (data, error) in
                if !(error != nil)
                {
                    self.rawPressure = Double(truncating: (data?.pressure)!) * 10.00
                    self.pressureLabel.text = String(format: "%.0f", self.rawPressure)+" mb"
                    print("timer is working: \(String(describing: self.pressureLabel.text))")
                    self.altimeter.stopRelativeAltitudeUpdates()
                } else {
                    self.pressureLabel.text = " Oops! 😕 1 "
                }
            }
        }  else {
            self.pressureLabel.text = " Oops! 😕 2 "
        }
    }

}
