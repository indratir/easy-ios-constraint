Pod::Spec.new do |s|
    s.name             = 'easy-ios-constraint'
    s.version          = '1.0.0'
    s.summary          = 'Easy iOS constraint programmatically'
    s.homepage         = 'https://github.com/indratir/easy-ios-constraint'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'indratir' => 'tirta777@gmail.com' }
    s.source           = { :git => 'https://github.com/indratir/easy-ios-constraint.git', :tag => s.version.to_s }
    s.ios.deployment_target = '11.0'
    s.swift_version = '5.4'
    s.source_files = 'Sources/easy-ios-constraint/**/*'
  end

