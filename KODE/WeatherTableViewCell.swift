//
//  WeatherTableViewCell.swift
//  KODE
//
//  Created by mac on 07.02.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var maximumLabel: UILabel!
    
    @IBOutlet weak var minimumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
