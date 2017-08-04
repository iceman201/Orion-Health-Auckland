//
//  ContactDetailsTableViewCell.swift
//  OrionHealth
//
//  Created by Liguo Jiao on 24/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.text = ""
        detailTitle.text = ""
        detailTitle.numberOfLines = 0
        self.selectionStyle = .none
    }
}
