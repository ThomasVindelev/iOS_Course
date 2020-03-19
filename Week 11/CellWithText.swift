//
//  CellWithText.swift
//  FirebaseHelloWorld
//
//  Created by Thomas Vindelev on 13/03/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit

class CellWithText: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
