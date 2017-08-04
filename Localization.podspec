Pod::Spec.new do |s|
  s.name             = "Localization"
  s.version          = "1.0.2"
  s.summary          = "A Localization Manager written in Swift."
  s.homepage         = "https://github.com/Meniny/Localization"
  s.license          = 'MIT'
  s.author           = { "Elias Abel" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/Localization.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Localization/*.*'
  s.module_name = 'Localization'
  s.public_header_files = 'Localization/*.h'
  s.frameworks = 'Foundation'
end
