Pod::Spec.new do |podspec|
  podspec.name = 'BloodMagic'
  podspec.version = '0.0.1'
  podspec.platform = :ios, '5.0'
  podspec.summary = 'BloodMagic'
  podspec.homepage = 'http://railsware.com'
  podspec.author = 'AlexDenisov'
  podspec.source = { :git => 'git@git.okolodev.org:AlexDenisov/dynamics.git', :branch => 'master' }
  podspec.requires_arc = true

  podspec.subspec 'Core' do |core|
    core.source_files = 'BloodMagic/Sources/Modules/Core/**/*.{h,m,mm}'
  end

  podspec.subspec 'Initializers' do |initializers|
    initializers.source_files = 'BloodMagic/Sources/Modules/Initializers/**/*.{h,m,mm}'
    initializers.dependency 'BloodMagic/Core'
  end

  podspec.subspec 'Lazy' do |lazy|
    lazy.source_files = 'BloodMagic/Sources/Modules/Lazy/**/*.{h,m,mm}'
    lazy.dependency 'BloodMagic/Initializers'
  end

  podspec.xcconfig = {
    'OTHER_LDFLAGS' => '-lstdc++',
    'CLANG_CXX_LIBRARY' => 'libstdc++'
  }

end

