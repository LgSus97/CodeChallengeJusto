//
//  CarrouselCollectionViewCell.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit
import AlamofireImage

class CarrouselCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var carouselImage: UIImageView!
  
  public var flickrImage: String = String() {
    didSet {
      setCell()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func prepareForReuse() {
      super.prepareForReuse()
      //hide or reset anything you want hereafter, for example
    carouselImage.image = UIImage()
  }
  
  func setCell(){
    print(" - - - - -")
    print(flickrImage)
    
    let urlImg = URL(string: flickrImage) ?? URL(fileURLWithPath: "")
    let placeholderImage = UIImage(named: "rocket")!
    let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
      size: carouselImage.frame.size,
      radius: 20.0
    )
    
    carouselImage.af.setImage(
      withURL: urlImg,
      placeholderImage: placeholderImage,
      filter: filter)
    
    
  }
  
}
