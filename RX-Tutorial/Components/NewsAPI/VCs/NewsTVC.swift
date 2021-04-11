//
//  NewsTVC.swift
//  RX-Tutorial
//
//  Created by David Adel on 07/04/2021.
//

import UIKit

class NewsTVC: UITableViewCell {

    static let identifier = "NewsTVC"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
