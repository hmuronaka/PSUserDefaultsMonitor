# PSUserDefaultsMonitor

Simple Httpserver for NSUserDefaults.

![example](https://raw.githubusercontent.com/hmuronaka/PSUserDefaultsMonitor/master/example.png)

# Install

```ruby
// Podfile

pod 'PSUserDefaultsMonitor', git: 'https://github.com/hmuronaka/PSUserDefaultsMonitor.git'
use_frameworks! # for swift.

```

# Usage example

## start monitor
```Objc

// AppDelegate.h
@property(nonatomic, strong) PSUserDefaultsMonitor* monitor;

// AppDelegate.m

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  monitor = [PSUserDefaultsMonitor new];
  [monitor startMonitorWithPort:5050]; // 5050 is http server listen port.
}
```

## stop

```objc
[monitor stop];
```

## show 

show datas from your browser.

URL: http://{your iphone's ipaddress}:{http server's port}/{NSUserDefaults key(only Dictionary or Array}/

example: http://192.168.0.4:5050/
example: http://192.168.0.4:5050/AppleKeyboards/
