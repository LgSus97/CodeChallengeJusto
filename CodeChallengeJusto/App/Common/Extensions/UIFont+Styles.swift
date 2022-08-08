//
//  UIFont+Styles.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

extension UIFont {
  
  struct sizes {
    static let bigTitle : CGFloat = 24
    static let title : CGFloat = 20
    static let subTitle : CGFloat = 15
    static let normal : CGFloat = 14
    static let small : CGFloat = 12
  }
  
  static func getBold(size: CGFloat) -> UIFont{
    let font = UIFont.systemFont(ofSize: size, weight: .bold)
    return font
  }
  
  static func getSemiBold(size: CGFloat) -> UIFont{
    let font = UIFont.systemFont(ofSize: size, weight: .semibold)
    return font
  }
  
  static func getMedium(size: CGFloat) -> UIFont{
    let font = UIFont.systemFont(ofSize: size, weight: .medium)
    return font
  }
  
  static func getRegular(size: CGFloat) -> UIFont{
    let font = UIFont.systemFont(ofSize: size)
    return font
  }
}
