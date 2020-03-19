//
//  Post.swift
//  FirebaseHelloWorld
//
//  Created by Thomas Vindelev on 13/03/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation

class Post {
    
    var text:String = ""
    
    var image:String = ""
    
    init(txt:String, img:String) {
        text = txt
        image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0 // returns true if there is some imagename string
    }
}
