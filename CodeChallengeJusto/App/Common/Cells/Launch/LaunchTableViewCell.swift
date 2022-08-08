//
//  LaunchTableViewCell.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import UIKit
import AlamofireImage

class LaunchTableViewCell: UITableViewCell {
  
  @IBOutlet weak var missionNameLabel : UILabel!
  @IBOutlet weak var siteNameLabel : UILabel!
  @IBOutlet weak var dateLabel : UILabel!
  @IBOutlet weak var missionImageView : UIImageView!
  @IBOutlet weak var mainView: UIView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setTextStyles()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    missionNameLabel.text = String()
    siteNameLabel.text = String()
    dateLabel.text = String()
    missionImageView.image = UIImage()
  }
  
  private func setTextStyles(){
    missionNameLabel.darkTitleBold()
    siteNameLabel.graySubTitle()
    dateLabel.graySubTitle()
    mainView.cardShadow()
  }
  
  func configCell(item: LaunchesQuery.Data.Launch){
    missionNameLabel.text = item.missionName
    siteNameLabel.text = item.launchSite?.siteName
    dateLabel.text = Date().changeDateFormat(dateString: item.launchDateLocal ?? "", fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ" , toFormat: "EEEE, MMM d, yyyy")
    
    let urlImg = URL(string: item.links?.missionPatchSmall ?? "") ?? URL(fileURLWithPath: "")
    let placeholderImage = UIImage(named: "rocket")!
    let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
      size: missionImageView.frame.size,
      radius: 20.0
    )
    
    missionImageView.af.setImage(
      withURL: urlImg,
      placeholderImage: placeholderImage,
      filter: filter,
      imageTransition: .crossDissolve(0.2))
  }
  

}
