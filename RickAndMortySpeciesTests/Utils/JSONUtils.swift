// swiftlint:disable convenience_type
//
//  JSONUtils.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/22/22.
//

import Foundation

public enum JSONUtils {

  public static func dataFromJson(named resourceName: String, bundle: Bundle? = nil) -> Data {
    dataFromResource(resourceName: resourceName, bundle: bundle) ?? Data()
  }

  public static func decodeJson<T: Decodable>(named resourceName: String, bundle: Bundle? = nil) -> T? {
    let data = dataFromResource(resourceName: resourceName, bundle: bundle) ?? Data()
    return try? JSONDecoder().decode(T.self, from: data)
  }

  private static func dataFromResource(resourceName: String, bundle: Bundle?) -> Data? {
    let bundle = bundle ?? BundleDetector.currentBundle
    guard let path = bundle.path(forResource: resourceName, ofType: "json") else {
      return nil
    }
    return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
  }

}

private class BundleDetector {
  static var currentBundle = Bundle(for: BundleDetector.self)
}
