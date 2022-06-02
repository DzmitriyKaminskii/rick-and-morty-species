// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Apply
  public static let applyButtonTitle = Strings.tr("Localizable", "apply_button_title")
  /// Characters
  public static let characterListTitle = Strings.tr("Localizable", "character_list_title")
  /// Close
  public static let closeButton = Strings.tr("Localizable", "close_button")
  /// From:
  public static let dateFromTitle = Strings.tr("Localizable", "date_from_title")
  /// To:
  public static let dateToTitle = Strings.tr("Localizable", "date_to_title")
  /// Female
  public static let genderFemale = Strings.tr("Localizable", "gender_female")
  /// Genderless
  public static let genderGenderless = Strings.tr("Localizable", "gender_genderless")
  /// Male
  public static let genderMale = Strings.tr("Localizable", "gender_male")
  /// Gender:
  public static let genderTitle = Strings.tr("Localizable", "gender_title")
  /// Dimension:
  public static let locationDimension = Strings.tr("Localizable", "location_dimension")
  /// Location:
  public static let locationTitle = Strings.tr("Localizable", "location_title")
  /// Type:
  public static let locationType = Strings.tr("Localizable", "location_type")
  /// Species:
  public static let speciesTitle = Strings.tr("Localizable", "species_title")
  /// Alive
  public static let statusAlive = Strings.tr("Localizable", "status_alive")
  /// Dead
  public static let statusDead = Strings.tr("Localizable", "status_dead")
  /// Unknown
  public static let unknowStatus = Strings.tr("Localizable", "unknow_status")
  /// Unknown
  public static let unknownGender = Strings.tr("Localizable", "unknown_gender")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
