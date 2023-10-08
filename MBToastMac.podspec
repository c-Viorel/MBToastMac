#
# Be sure to run `pod lib lint MBToastMac.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MBToastMac'
  s.version          = '1.0.0'
  s.summary          = 'MBToastMac: Simple. Efficient. Toasts for macOS. Crafted with Swift. Enhance user interactions. No frills. Just performance.'
  s.swift_versions   = '5.0'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
 MBToastMac: Toasts for macOS. Crafted in Swift.

 In the world of macOS development, clarity and brevity are often the keys to effective user interaction. MBToastMac was forged with this philosophy in mind.

 We understand that every interaction, no matter how brief, is a touchpoint between the user and the software. It’s a chance to inform, to guide, to reassure. That’s why we developed a toast system that's not just about fleeting messages but about enriching those small moments of communication.

 Why choose MBToastMac?

 Simplicity: Our library integrates seamlessly into your macOS projects, allowing you to implement toasts without the weight of unnecessary features.

 Efficiency: Built with Swift, it's optimized for performance, ensuring your app remains agile and responsive.

 Customizability: While we value minimalism, we also understand the importance of adaptability. Customize to fit your application's aesthetics, ensuring consistency in design.

 Reliability: Every toast delivered is a result of rigorous testing and refinement, ensuring reliability in varied use-cases.

 Dive into MBToastMac – where minimalism meets function. Elevate your user feedback and make every message count.

                      DESC


  s.homepage         = 'https://github.com/c-Viorel/MBToastMac'
  s.screenshots     = 'https://github.com/c-Viorel/MBToastMac/blob/main/Example/MBToast_sample.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Viorel P' => 'viorelporumbescu@outlook.com' }
  s.source           = { :git => 'https://github.com/c-Viorel/MBToastMac.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :osx
  s.osx.deployment_target = "10.13"

  s.source_files = 'MBToastMac/Classes/**/*'

  # s.resource_bundles = {
  #   'MBToastMac' => ['MBToastMac/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Cocoa'
  # s.dependency 'AFNetworking', '~> 2.3'
end
