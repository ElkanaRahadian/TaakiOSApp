//
//  DailyGoalsCell.swift
//  TaakiOSApp
//
//  Created by Vivian Angela on 06/04/21.
//

import UIKit

class DailyGoalsCell: UITableViewCell {

    
    @IBOutlet weak var setDailyGoalButton: UIButton!

    @IBOutlet weak var dailyGoalDetail: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
