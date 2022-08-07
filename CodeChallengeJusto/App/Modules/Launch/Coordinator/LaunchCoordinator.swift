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

}

