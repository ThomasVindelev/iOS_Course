//
//  ViewController.swift
//  MyNoteBook
//
//  Created by Thomas Vindelev on 14/02/2020.
//  Copyright © 2020 Thomas Vindelev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var theText = "";
    
    var index = 0;
    
    var currentlyEditing = false
    
    var textArray = [String]() // we initialize an empty String array
    
    var preload = ["mynamejeff", "heydude"]
    
    let file = "hehe.txt"
        
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    func saveFile(str:String, fileName:String) {
        let filePath = getDocumentDirectory().appendingPathComponent(fileName)
        do {
            try str.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
            print("success writing \(str)")
        } catch {
            print("error writing \(str)")
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDirectory().appendingPathComponent(fileName)
        do {
            let string = try String(contentsOf: filePath, encoding: .utf8)
            return string
        } catch {
            print("error while reading file " + fileName)
        }
        return "empty";
    }
    
    @IBAction func deleteIndex(_ sender: UIButton) {
        if currentlyEditing {
            textArray.remove(at: index)
            currentlyEditing = false
            textView.text = ""
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for e in preload {
            textArray.append(e)
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func savePressed(_ sender: UIButton) {
        theText = textView.text
        textView.text = "";
        if currentlyEditing {
            textArray[index] = theText
            currentlyEditing = false
            
        } else {
            textArray.append(theText)
        }
        tableView.reloadData()
        saveFile(str: theText, fileName: file)
        print(readStringFromFile(fileName: file))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") {
            cell.textLabel?.text = textArray[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentlyEditing = true
        textView.text = textArray[indexPath.row]
        index = indexPath.row
    }
    
}

