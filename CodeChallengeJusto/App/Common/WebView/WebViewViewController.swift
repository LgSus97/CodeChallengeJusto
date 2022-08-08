//
//  WebViewViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, Storyboarded, LoaderPresentable {
  
  @IBOutlet weak var webView: WKWebView!
  
  var url : String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.uiDelegate = self
    webView.navigationDelegate = self
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.presentLoader {
      self.processURL(urlLoad: self.url )
    }
  }
  
  func setup(url: String){
    self.url = url
  }
  
  
}

extension WebViewViewController: WKNavigationDelegate, WKUIDelegate{
  func processURL(urlLoad:String?){
    self.dismissLoader { [self] in
      if let strUrl = urlLoad {
        let url = URL(string: strUrl)!
        let request = URLRequest(url: url)
        webView.load(request)
      } else {
        showMessage(body: "Fail to load url", title: "Error")
      }
    }
  }
  
}
