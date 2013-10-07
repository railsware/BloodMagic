Pod::Spec.new do |podspec|
  podspec.name = 'Dynamics'
  podspec.version = '0.0.1'
  podspec.platform = :ios, '5.0'
  podspec.summary = 'Hello'
  podspec.homepage = 'http://okolodev.org'
  podspec.author = 'AlexDenisov'
  podspec.source = { :git => 'git@git.okolodev.org:AlexDenisov/dynamics.git', :branch => 'master' }
  podspec.requires_arc = true

  podspec.subspec 'Core' do |core|
    core.source_files = 'Dynamics/Sources/Modules/Core/**/*.{h,m,mm}'
  end

  podspec.subspec 'Initializers' do |initializers|
    initializers.source_files = 'Dynamics/Sources/Modules/Initializers/**/*.{h,m,mm}'
    initializers.dependency 'Dynamics/Core'
  end

  podspec.subspec 'Lazy' do |lazy|
    lazy.source_files = 'Dynamics/Sources/Modules/Lazy/**/*.{h,m,mm}'
    lazy.dependency 'Dynamics/Core'
    lazy.dependency 'Dynamics/Initializers'
  end

  podspec.xcconfig = {
    'OTHER_LDFLAGS' => '-lstdc++'
  }

end

