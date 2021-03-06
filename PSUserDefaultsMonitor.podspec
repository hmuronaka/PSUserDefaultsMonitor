Pod::Spec.new do |s|
  s.name        = "PSUserDefaultsMonitor"
  s.version     = "0.5.0"
  s.summary     = "PSUserDefaultsMonitor is simle HTTPServer for NSUserDefaults, objects, and Coredatas"
  s.homepage    = "https://github.com/hmuronaka/PSUserDefaultsMonitor"
  s.license     = { :type => "MIT" }
  s.authors     = { "hmuronaka" => "capriccio27@gmail.com" }

  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "7.0"
  s.source   = { :git => "https://github.com/hmuronaka/PSUserDefaultsMonitor.git", tag: s.version }
  s.source_files = ["PSUserDefaultsMonitor/Classes/*.{swift,h,m}", "PSUserDefaultsMonitor/PSUserDefaultsMonitor-Bridging-Header.h"]
  s.dependency 'GCDWebServer', "~> 3.0"
end
