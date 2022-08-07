//
//  LoaderViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

class LoaderViewController: UIViewController {
  
  @IBOutlet weak var containerView : UIView!
  
  var titleLoading:String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.addAnimation()
    // Do any additional setup after loading the view.
  }
  
  init() {
    super.init(nibName: "Loader", bundle: nil)
    self.modalPresentationStyle = .overCurrentContext
    self.modalTransitionStyle = .crossDissolve
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func addAnimation(){
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.titleLoading
    label.textAlignment = .center
    self.view.addSubview(label)
    
    let animationView : UIImageView = UIImageView()
    animationView.loadGif(name: "loading")
    animationView.image = animationView.image?.withRenderingMode(.alwaysTemplate)
    animationView.tintColor = .white
    self.view.addSubview(animationView)
    
    animationView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(animationView)
    
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lottie(100)]-10-[label]", options: [], metrics: nil, views: ["lottie":animationView, "label":label]) )
    
    
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[lottie(100)]", options: [], metrics: nil, views: ["lottie":animationView]))
    self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[label]-20-|", options: [], metrics: nil, views: ["label":label]))
    
    self.view.addConstraint(NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
    
    self.view.addConstraint(NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
  }
  
}
