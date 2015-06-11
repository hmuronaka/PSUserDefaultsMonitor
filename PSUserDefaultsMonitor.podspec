Pod::Spec.new do |s|
  s.name        = "PSUserDefaultsMonitor"
  s.version     = "0.1.0"
  s.summary     = "PSUserDefaultsMonitor is simle HTTPServer for NSUserDefaults"
  s.homepage    = "https://github.com/hmuronaka/PSUserDefaultsMonitor"
  s.license     = { :type => "MIT" }
  s.authors     = { "hmuronaka" => "capriccio27@gmail.com" }

  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "7.0"
  s.source   = { :git => "https://github.com/hmuronaka/PSUserDefaultsMonitor.git" }
  s.source_files = "PSUserDefaultsMonitor/Classes/*.swift"
#  s.dependency = 'GCDWebServer', "~> 3.0"
end
