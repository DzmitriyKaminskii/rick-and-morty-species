source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '15.0'
inhibit_all_warnings!
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end

target 'RickAndMortySpecies' do
  # Pods for RickAndMortySpecies
  pod "Action"
  pod "RxSwift"
  pod "RxCocoa"
  pod "Moya/RxSwift"
  pod "RxSwiftExt"

  pod "AlamofireImage"
  pod "SwiftLint"

  pod 'MaterialComponents', :subspecs => ['Snackbar']
  pod 'SnapKit'
  pod 'Swinject'

  target 'RickAndMortySpeciesTests' do
    inherit! :search_paths
    # Pods for testing
    pod "RxBlocking"
    pod "RxTest"
  end

end
