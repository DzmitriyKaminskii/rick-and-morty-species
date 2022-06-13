//
//  RickAndMortyMoyaProvider.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Foundation

import Moya
import RxMoya
import RxSwift

class RickAndMortyMoyaProvider<Target> where Target: TargetType {

  private let provider: MoyaProvider<Target>
  private let stubResponseDataFactory: ((Target) -> Data?)?

  init(stubResponseDataFactory: ((Target) -> Data?)? = nil) {
    let errorHandlerPlugin = ResponseErrorProcessingPlugin()
    self.stubResponseDataFactory = stubResponseDataFactory

    provider = MoyaProvider(endpointClosure: MoyaProvider<Target>.defaultEndpointMapping,
                            requestClosure: MoyaProvider<Target>.defaultRequestMapping,
                            stubClosure: stubResponseDataFactory == nil ? { _ in .never } : { _ in .immediate },
                            callbackQueue: .global(qos: .background),
                            session: MoyaProvider<Target>.defaultAlamofireSession(),
                            plugins: [errorHandlerPlugin],
                            trackInflights: false)
  }

  func request<Response: Decodable>(_ target: Target, responseType: Response.Type) -> Single<Response> {
    guard let stub = stubResponseDataFactory else { return provider.rx.request(target).map(responseType) }
    guard let data = stub(target) else { return .error(RickAndMortyAPIError.response(message: "Incorrect decode")) }

    if let object = try? JSONDecoder().decode(responseType, from: data) {
      return .just(object)
    }

    guard let jsonResponse = try? JSONSerialization.jsonObject(with: data) else {
      return .error(RickAndMortyAPIError.response(message: "Unknown error"))
    }

    if let responseDictionary = jsonResponse as? [String: Any],
       let message = responseDictionary["error"] as? String {
      return .error(MoyaError.underlying(RickAndMortyAPIError.response(message: message), nil))
    }

    return .error(RickAndMortyAPIError.response(message: "Unknown error"))
  }

}
