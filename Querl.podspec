#
# Be sure to run `pod lib lint Querl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Querl'
  s.version          = '0.1.2'
  s.summary          = 'A minimal GraphQL client library.'
  s.swift_versions   = ['5.0']

  s.description      = <<-DESC
Querl is a minimal GraphQL client library. It aims to be agnostic as to the architecture and technology choices of your app. It can be used with any networking stack, and makes no assumptions about how your models are defined. In addition, it is as Swift-y as possible: protocol-oriented, type-safe, and chock full of generics. It has no dependencies, and comprises less than 200 lines of easily auditable code.
                       DESC

  s.homepage         = 'https://github.com/joinhandshake/Querl'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Handshake' => 'open-source@joinhandshake.com' }
  s.source           = { :git => 'https://github.com/joinhandshake/Querl.git', :tag => s.version.to_s }
   s.social_media_url = 'https://mastodon.social/@foon'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/Querl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Querl' => ['Querl/Assets/*.png']
  # }

  s.frameworks = 'Foundation'
end
