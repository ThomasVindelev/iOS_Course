//
//  ViewController.swift
//  SensorApp
//
//  Created by Thomas Vindelev on 28/04/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneView: UIView!
    
    @IBOutlet weak var doneDistance: UILabel!
    
    @IBOutlet weak var doneSteps: UILabel!
        
    @IBOutlet weak var comment: UITextField!
    
    let pedometer = CMPedometer()
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var stepsLabel: UILabel!
    
    @IBOutlet weak var paceLabel: UILabel!
        
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comment.delegate = self
        doneView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        startBtn.setTitle("Tracking", for: .normal)
        pedometer.startUpdates(from: Date()) {
            (data, error) in
            DispatchQueue.main.async {
                if (error == nil) {
                    var isDecimal = false
                    var toDisplay = ""
                    var temp = data?.distance?.stringValue
                    for index in 0...temp!.count {
                        if (temp![index] == ".") {
                            isDecimal = true
                            for number in 0...index+2 {
                                toDisplay.append(temp![number])
                            }
                            self.distanceLabel.text = toDisplay
                            break
                        }
                    }
                    
                    print()
                    self.stepsLabel.text = data?.numberOfSteps.stringValue
                    self.paceLabel.text = data?.currentPace?.stringValue
                }
            }
        }
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        pedometer.stopUpdates()
        doneView.isHidden = false
        doneDistance.text = distanceLabel.text
        doneSteps.text = stepsLabel.text
    }
    

    @IBAction func comfirmBtnPressed(_ sender: Any) {
        FirebaseRepository.add(distance: doneDistance.text ?? "0", steps: doneSteps.text ?? "0", comment: comment.text ?? "")
        distanceLabel.text = "0"
        stepsLabel.text = "0"
        paceLabel.text = "0"
        doneView.isHidden = true
    }
    
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
