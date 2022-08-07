//
//  ApolloNetworkHelper.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 06/08/22.
//

import Foundation
import Apollo

enum GraphQLType : String{
  case launchList
  case userList
}

final class ApolloNetworkHelper {
  static let shared = ApolloNetworkHelper()
  var graphQLType : GraphQLType = .userList
  
  private(set) lazy var apolloClient : ApolloClient = {
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)
    let authPayLoads = ["Authorization": "Bearer <Token>"]
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = authPayLoads
    
    let client = URLSessionClient(sessionConfiguration: configuration,
                                  callbackQueue: nil)
    let provider = NetworkInterceptorProvider(client: client,
                                              shouldInvalidateClientOnDeinit: true,
                                              store: store)
    let url = URL(string: getGraphQLURL(type: graphQLType))!
    let requestChainTransort = RequestChainNetworkTransport(interceptorProvider: provider,
                                                            endpointURL: url)
    return ApolloClient(networkTransport: requestChainTransort,
                        store: store)
  }()
  
  private func getGraphQLURL(type: GraphQLType) -> String {
    switch type {
    case .launchList:
      return "https://api.spacex.land/graphql/"
    case .userList:
      return "https://api.spacex.land/graphql/userList"
    }
  }
}

class NetworkInterceptorProvider : DefaultInterceptorProvider {
  override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
    return super.interceptors(for: operation)
  }
}
