//
//  Extensions.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

extension UILabel{
  
  func setStyleBold(size: CGFloat, color: UIColor){
    self.font = UIFont.getBold(size: size)
    self.textColor = color
  }
  
  func setStyleSemiBold(size: CGFloat, color: UIColor){
    self.font = UIFont.getSemiBold(size: size)
    self.textColor = color
  }
  
  func setStyleMedium(size: CGFloat, color: UIColor){
    self.font = UIFont.getMedium(size: size)
    self.textColor = color
  }
  
  func setStyleRegular(size: CGFloat, color: UIColor){
    self.font = UIFont.getRegular(size: size)
    self.textColor = color
  }
  
  func darkTitleBold(){
    self.setStyleBold(size: UIFont.sizes.title , color: UIColor.font.dark)
  }
  
  func darkTitleSemiBold(){
    self.setStyleSemiBold(size: UIFont.sizes.title , color: UIColor.font.dark)
  }
  
  func graySubTitle(){
    self.setStyleRegular(size: UIFont.sizes.subTitle, color: UIColor.font.grayGranite)
  }
  
  func darkNormal(){
    self.setStyleMedium(size: UIFont.sizes.normal, color: UIColor.font.dark)
  }
  
}

extension UIButton{
  func solid(radius:CGFloat? = 20){
    self.clipsToBounds = true
    self.setBackgroundColor(color: UIColor(named: "ApolloAzure") ?? .blue, forState: .normal)
    self.setBackgroundColor(color: UIColor(named: "GrayGranite") ?? .lightGray, forState: .disabled)
    self.setTitleColor(.white, for: .normal)
    self.setTitleColor(.darkGray, for: .disabled)
    self.tintColor = .white
    self.setDefaultHeight()
    self.layer.cornerRadius = radius ?? 20;
  }
  
  func setBackgroundColor(color: UIColor, forState: UIControl.State){
    self.clipsToBounds = true
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    if let context = UIGraphicsGetCurrentContext(){
      context.setFillColor(color.cgColor)
      context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
      let colorImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      self.setBackgroundImage(colorImage, for: forState)
    }
  }
  
  func setDefaultHeight(){
    let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
    self.addConstraint(heightConstraint)
  }
}
extension String{
  var youtubeID: String? {
      let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

      let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
      let range = NSRange(location: 0, length: count)

      guard let result = regex?.firstMatch(in: self, range: range) else {
          return nil
      }

      return (self as NSString).substring(with: result.range)
  }
  
}


extension UINavigationController{
  
  func whitheStyle(){
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(named: "WhiteGray") ?? .whiteGray
    
    appearance.titleTextAttributes  = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    appearance.shadowColor = .clear
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationBar.setValue(true, forKey: "hidesShadow")
    self.navigationBar.isTranslucent = false
    
    // Customizing our navigation bar
    navigationBar.tintColor = .darkGray
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
  }
}

extension UIView{
  func cardShadow(){
    self.layer.cornerRadius = 5
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.layer.shadowRadius = 3.0
    self.layer.shadowOpacity = 0.7
  }
}

extension UIViewController {
  
  func showMessage(body:String, title:String){
    let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
  static func swizzle() {
    let originalSelector1 = #selector(viewDidLoad)
    let swizzledSelector1 = #selector(swizzled_viewDidLoad)
    swizzling(UIViewController.self, originalSelector1, swizzledSelector1)
  }
  
  @objc open func swizzled_viewDidLoad() {
    if let _ = navigationController {
      if #available(iOS 14.0, *) {
        navigationItem.backButtonDisplayMode = .minimal
      } else {
        // Fallback on earlier versions
        navigationItem.backButtonTitle = ""
      }
    }
    swizzled_viewDidLoad()
  }
}

private let swizzling: (UIViewController.Type, Selector, Selector) -> Void = { forClass, originalSelector, swizzledSelector in
  if let originalMethod = class_getInstanceMethod(forClass, originalSelector), let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
    let didAddMethod = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    if didAddMethod {
      class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
}

