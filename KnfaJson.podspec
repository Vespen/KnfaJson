Pod::Spec.new do |s|
  s.name = 'KnfaJson'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Simple JSON handling in Swift'
  s.homepage = 'https://github.com/Vespen/KnfaJson'
  s.authors = { 'Anton Lagutin' => 'a.lagutin@white-soft.ru' }
  s.source = { :git => 'https://github.com/Vespen/KnfaJson.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Sources/**/*.swift'
end