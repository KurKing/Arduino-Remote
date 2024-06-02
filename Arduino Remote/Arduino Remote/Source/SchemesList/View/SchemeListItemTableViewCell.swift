//
//  SchemeListItemTableViewCell.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit

class SchemeListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: SchemesListItem?
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        item = nil
        nameLabel.text = ""
        accessibilityIdentifier = "scheme-list-item-none"
    }
    
    func setup(with item: SchemesListItem) {
        
        self.item = item
        nameLabel.text = item.title
    }
}
