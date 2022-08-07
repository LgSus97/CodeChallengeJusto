//
//  Extensions.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit


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

