//
//  view2TableViewCell.swift
//  swiftyapp
//
//  Created by Alexandra RIBEIRO on 10/26/17.
//  Copyright © 2017 Alexandra RIBEIRO. All rights reserved.
//

import UIKit

class view2TableViewCell: UITableViewCell {

    @IBOutlet weak var name_slugLabel: UILabel!
    
    @IBOutlet weak var notationLabel: UILabel!
    
    @IBOutlet weak var validateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        name_slugLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    
}
