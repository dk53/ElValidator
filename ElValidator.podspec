#
# Be sure to run `pod lib lint ElValidator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ElValidator"
  s.version          = "2.0"
  s.summary          = "A simple plugin to help you validate textfield entries"

  s.description      = <<-DESC
  			ElValidator Helps you controle yours UITextField user entries
			 by validating them.
			 You can add multiples validators to a UITextfield :
			- Date Validator
			- Lenght Validator
			- Regex
			- ...
                       DESC

  s.homepage         = "https://github.com/dk53/ElValidator"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Victor Carmouze" => "victor.carmouze@gmail.com" }
  s.source           = { :git => "https://github.com/dk53/ElValidator.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  
end
