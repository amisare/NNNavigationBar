platform :ios, '8.0'

use_frameworks!

workspace 'NNNavigationBar.xcworkspace'

def all_pods
    pod 'NNNavigationBar', :path => 'NNNavigationBar.podspec'
end

target :NNNavigationBarDemo do
    project './NNNavigationBarDemo/NNNavigationBarDemo'
    all_pods
end
