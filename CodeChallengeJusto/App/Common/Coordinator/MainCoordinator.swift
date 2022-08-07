//
//  MainCoordinator.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
  
  
  
  static var shared = MainCoordinator()
  
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController = UINavigationController()
  
  private var window: UIWindow?
  
  private override init() {}
  
  func setup(window: UIWindow?) {
    self.window = window
  }
  
  func start() {
    childCoordinators.removeAll()
    
    let launchViewController = LaunchViewController.instantiate(fromStoryboard: "Launch")
    let launchCoordinator = LaunchCoordinator(navigationController: navigationController)
    launchViewController.setup(coordinator: launchCoordinator)
    childCoordinators.append(launchCoordinator)
    navigationController.pushViewController(launchViewController, animated: true)
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    navigationController.whitheStyle()
    
  }
  
  
  func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === child {
        childCoordinators.remove(at: index)
        break
      }
    }
  }
  
  func popToLaucher(){
    self.navigationController.popViewController(animated: true)
    self.childCoordinators.removeLast()
  }
  
  
  /// Method to update root view controller of app window with  received view.
  /// - Parameter view: The new root module.
  func updateRoot(with view: UIViewController) {
    window?.rootViewController = view
  }
}
