//
//  LoaderPresentable.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit

typealias LoaderClosure = () -> Void

/// Protocol Definition to implement generic loader.
protocol LoaderPresentable {
  
  /// Method to present the LoaderViewController.
  ///
  /// - Parameter completion: Escaping closure executed after presentation.
  func presentLoader(title:String, completion: @escaping LoaderClosure)
  
  /// Method to dismiss the LoaderViewController.
  ///
  /// - Parameter completion: Escaping closure executed after dismiss.
  func dismissLoader(completion: @escaping LoaderClosure)
  
}

// MARK: - Methods Implementation
extension LoaderPresentable where Self: UIViewController {
  
  
  func presentLoader(title:String = "", completion: @escaping LoaderClosure) {
    // Avoid multiple presentations
    guard !(self.presentedViewController is LoaderViewController) else { return }
    // Present
    DispatchQueue.main.async { [weak self] in
      let loaderView = LoaderViewController()
      loaderView.titleLoading = title
      if let subviews = self?.view.superview?.subviews {
        for _view in subviews {
          if !(_view === LoaderViewController.self) {
            self?.view.superview?.sendSubviewToBack(_view)
          }
        }
      }
      self?.present(loaderView, animated: true, completion: completion)
    }
  }
  
  func dismissLoader(completion: @escaping LoaderClosure) {
    guard let loaderView = self.presentedViewController as? LoaderViewController else { return }
    DispatchQueue.main.async {
      loaderView.dismiss(animated: true, completion: completion)
    }
  }
  
  
}
