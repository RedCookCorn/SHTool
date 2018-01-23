#
#  Be sure to run `pod spec lint SHTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "SHTool"
  s.version      = "0.0.3.3"
  s.summary      = "base tool for developer"
  s.homepage     = "https://github.com/zhenghaodd01/SHTool"
  s.license      = "MIT"
  s.author             = { "zhenghaodd01" => "haozheng@hk01.com" }
  s.platform     = :ios
  # s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/zhenghaodd01/SHTool.git", :tag => "#{s.version}" }
  s.source_files  = "SHTool/SHBase/*","SHTool/SHBase/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  s.resources = "SHTool/SHBase/Resource/*"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
