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

  s.source_files = "apple/**/*.{h,m,mm,cpp,swift}"
  s.private_header_files = "apple/**/*.h"

  install_modules_dependencies(s)
end
