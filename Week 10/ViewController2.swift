//
//  ViewController2.swift
//  FirebaseHelloWorld
//
//  Created by Thomas Vindelev on 28/02/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var headline: UITextView!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var imageText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var rowNumber = 0
    
    @IBAction func btnClicked(_ sender: UIButton) {
        CloudStorage.createNote(head: headline.text, body: body.text, image: imageText.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // use rowNumber to get the right note object
        let note = CloudStorage.getNoteAt(index: rowNumber)
        headline.text = note.head
        body.text = note.body
        if note.image != "empty" {
            imageText.text = note.image; CloudStorage.downloadImage(name: note.image, image: imageView)
        } else {
            print("image is empty")
        }
        // Do any additional setup after loading the view.
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    }
    
    //
    @IBAction func photoAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    // function is called when to picker controller has picked an image from the camera roll
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else {
            return
        }
        print(image.size)
        dismiss(animated: true)
        CloudStorage.uploadImage(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
