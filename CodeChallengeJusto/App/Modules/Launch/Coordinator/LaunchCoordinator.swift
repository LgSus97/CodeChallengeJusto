//
//  LaunchCoordinator.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

class LaunchCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator]
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    childCoordinators = []
    self.navigationController = navigationController
    self.navigationController.whitheStyle()
    
  }
  
  func start() {
    
  }
  
  func presentDetailLaunch(item: LaunchesQuery.Data.Launch){
    let DetailLaunchViewController = DetailLaunchViewController.instantiate(fromStoryboard: "Launch")
    DetailLaunchViewController.setup(coordinator: self, item: item)
    navigationController.pushViewController(DetailLaunchViewController, animated: true)
  }
  
  func presentYTPlayer(urlVideo:String){
    let ytVideoPlayerViewController = YTVideoPlayerViewController.instantiate(fromStoryboard: "YTVideo")
    ytVideoPlayerViewController.setup(urlVideo: urlVideo)
    navigationController.pushViewController(ytVideoPlayerViewController, animated: true)
  }
  
  func presentWebView(urlInfo:String){
    let webViewViewController = WebViewViewController.instantiate(fromStoryboard: "WebView")
    webViewViewController.setup(url: urlInfo)
    navigationController.pushViewController(webViewViewController, animated: true)
  }

  
}

