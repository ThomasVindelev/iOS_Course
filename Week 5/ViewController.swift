//
//  ViewController.swift
//  HelloWorld
//
//  Created by Thomas Vindelev on 07/02/2020.
//  Copyright © 2020 Thomas Vindelev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var text: UITextField!
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if let name = text.text {
            var initText : String!
            initText = "Hello \(name)"
            print(initText)
        }
    }
}

