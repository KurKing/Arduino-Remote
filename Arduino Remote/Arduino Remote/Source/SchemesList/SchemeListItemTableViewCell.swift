//
//  SchemeListItemTableViewCell.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit

class SchemeListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(with title: String) {
        
        nameLabel.text = title
    }
}
