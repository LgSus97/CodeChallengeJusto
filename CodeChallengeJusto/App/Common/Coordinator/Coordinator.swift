//
//  Coordinator.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()
  func childDidFinish(_ child: Coordinator?)
  
  func returnToBegin(classToReturn:AnyClass)
  func returnToPreviousController()
}

extension Coordinator {
  func childDidFinish(_ child: Coordinator?) {
    
  }
}

extension Coordinator {
  
  func returnToBegin(classToReturn:AnyClass) {
    for controller in self.navigationController.viewControllers as Array {
      if controller.isKind(of: classToReturn.self ) {
        self.navigationController.popToViewController(controller, animated: true)
        break
      }
    }
  }
  
  func returnToPreviousController() {
    self.navigationController.popViewController(animated: true)
  }
}
