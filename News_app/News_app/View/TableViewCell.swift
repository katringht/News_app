//
//  TableViewCell.swift
//  News_app
//
//  Created by Ekaterina Tarasova on 16.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
