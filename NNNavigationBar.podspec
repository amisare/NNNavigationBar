Pod::Spec.new do |s|

  s.name          = "NNNavigationBar"
  s.version       = "2.7.2"
  s.summary       = "NNNavigationBar: make UINavigationBar background transition smoothly."

  s.description   = <<-DESC
                   NNNavigationBar is A library that makes the UINavigationBar background to smoothly transition between different colors or images.
                   DESC

  s.homepage      = "https://github.com/amisare/NNNavigationBar"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Haijun Gu" => "243297288@qq.com" }
  s.social_media_url        = "https://www.jianshu.com/u/9df9f28ff266"

  s.source        = { :git => "https://github.com/amisare/NNNavigationBar.git", :tag => s.version.to_s }
  s.ios.deployment_target   = '8.0'
  s.requires_arc  = true

  s.source_files        = 'NNNavigationBar/NNNavigationBar/*.{h,m}'
  s.public_header_files = 'NNNavigationBar/NNNavigationBar/NNNavigationBar.h'
  
  s.subspec 'Core' do |ss|
    ss.source_files    = 'NNNavigationBar/NNNavigationBar/Core/*.{h,m,mm}'
    ss.private_header_files    = 'NNNavigationBar/NNNavigationBar/Core/*.{h}'
  end

  s.subspec 'Utils' do |ss|
    ss.source_files    = 'NNNavigationBar/NNNavigationBar/Utils/*.{h,m}'
    ss.private_header_files    = 'NNNavigationBar/NNNavigationBar/Utils/*.{h}'
  end

  s.subspec 'Background' do |ss|
    ss.dependency        'NNNavigationBar/Core'
    ss.dependency        'NNNavigationBar/Utils'
    ss.source_files    = 'NNNavigationBar/NNNavigationBar/Background/**/*.{h,m}'
    ss.private_header_files    = 'NNNavigationBar/NNNavigationBar/Background/Source/*.{h}', 'NNNavigationBar/NNNavigationBar/Background/Delegate/*.{h}', 'NNNavigationBar/NNNavigationBar/Background/Transition/*.{h}'
  end

  s.subspec 'TintColor' do |ss|
    ss.dependency        'NNNavigationBar/Core'
    ss.dependency        'NNNavigationBar/Utils'
    ss.source_files    = 'NNNavigationBar/NNNavigationBar/TintColor/**/*.{h,m}'
    ss.private_header_files    = 'NNNavigationBar/NNNavigationBar/TintColor/Delegate/*.{h}', 'NNNavigationBar/NNNavigationBar/TintColor/Transition/*.{h}'
  end

end
