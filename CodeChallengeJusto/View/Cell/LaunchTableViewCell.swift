//
//  LaunchTableViewCell.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
  
  @IBOutlet weak var missinNameLabel : UILabel!
  @IBOutlet weak var siteNameLabel : UILabel!
  @IBOutlet weak var rocketNameLabel : UILabel!
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func configCell(item: LaunchesQuery.Data.Launch){
    missinNameLabel.text = item.missionName
    siteNameLabel.text = item.launchSite?.siteName
    rocketNameLabel.text = item.rocket?.rocketName
  }
}
