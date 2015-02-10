Pod::Spec.new do |s|

  s.name         = "IDTwitterAccountChooserViewController"
  s.version      = "1.0.0"
  s.summary      = "Twitter Account Chooser view controller for iOS 6+"

  s.description  = <<-DESC
                   Twitter Account Chooser view controller for iOS 6+. Uses a block-based completion handler or a classic protocol-based delegate method.
		   DESC

  s.homepage     = "https://github.com/idevsoftware/IDTwitterAccountChooserViewController"
  s.screenshots  = "https://raw.githubusercontent.com/idevsoftware/IDTwitterAccountChooserViewController/master/screenshot.png"

  s.license      = { :type => "MIT", :text => "Licensed under the MIT license\n\nCopyright by @iDevSoftware 2012" }

  s.author    	 = "iDev Software"

  s.platform     = :ios, "6.0"

  s.source       = { 
	:git => "https://github.com/idevsoftware/IDTwitterAccountChooserViewController.git",
	:commit => "2f8b1b04fc7db5c0a2cc57c2d9ae60bd62663487",
	:tag => s.version.to_s }

  s.source_files = "IDTwitterAccountChooserViewController.{h,m}"

  s.public_header_files = "IDTwitterAccountChooserViewController.h"

  s.weak_frameworks = "UIKit", "Accounts", "Social"

end