//
//  LaunchViewModel.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import Foundation
import Apollo

protocol LaunchViewModelDelegate : AnyObject {
  func didReceiveData()
  func didFail(errorMessage: String)
}

class LaunchViewModel {
  var launchList = [LaunchesQuery.Data.LaunchesPastResult] ()
  weak var delegate : LaunchViewModelDelegate?
  
  func fetchLaunchList() {
    launchList.removeAll()
    let apolloNetworkHelper = ApolloNetworkHelper.shared
    apolloNetworkHelper.graphQLType = .launchList
    apolloNetworkHelper.apolloClient.fetch(query: LaunchesQuery()){ [weak self] result in
      switch result {
      case .success(let graphQLResult):
        debugPrint("graphQLResult: \(graphQLResult)")
        if let errors = graphQLResult.errors {
          let message = errors.map { $0.localizedDescription }.joined(separator: "\n")
          self?.delegate?.didFail(errorMessage: message)
        }
        if let launchConnection = graphQLResult.data?.launchesPastResult{
          self?.launchList.append(contentsOf: launchConnection.compactMap { $0 })
        }
        self?.delegate?.didReceiveData()
      case .failure(let error):
        debugPrint("Failure Error: \(error)")
        self?.delegate?.didFail(errorMessage: error.localizedDescription)
      }
      
    }
  }
}
