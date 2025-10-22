require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "LiquidGlass"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported, :osx => '12.0' }
  s.source       = { :git => "https://github.com/callstack/liquid-glass.git", :tag => "#{s.version}" }

  s.ios.source_files = "ios/**/*.{h,m,mm,cpp,swift}"
  s.ios.private_header_files = "ios/**/*.h"

  s.osx.source_files = "macos/**/*.{h,m,mm,cpp,swift}"
  s.osx.private_header_files = "macos/**/*.h"

  install_modules_dependencies(s)
end
