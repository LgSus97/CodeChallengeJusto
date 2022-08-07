//
//  UIColor+Definition.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

extension UIColor {
  static var whiteGray : UIColor {    // #F8F8F8
    return UIColor(named: "WhiteGray") ?? .whiteGray
  }

}

extension UIColor {
  struct font {
    static var whiteGray : UIColor { return UIColor.whiteGray }
  }
    
}
