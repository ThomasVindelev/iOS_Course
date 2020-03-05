//
//  ViewController2.swift
//  FirebaseHelloWorld
//
//  Created by Thomas Vindelev on 28/02/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    
    @IBOutlet weak var headline: UITextView!
    
    
    @IBOutlet weak var body: UITextView!
    
    @IBAction func btnClicked(_ sender: UIButton) {
        CloudStorage.createNote(head: headline.text, body: body.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
