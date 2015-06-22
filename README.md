# PSUserDefaultsMonitor

Simple Httpserver for NSUserDefaults and objects and coredatas.

![example](https://raw.githubusercontent.com/hmuronaka/PSUserDefaultsMonitor/master/docs/example01.png)

[Japanese](http://qiita.com/hmuronaka/items/2e78cda82d1c9640a113)

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
@property(nonatomic, strong) NSDictionary* configuration;

// AppDelegate.m

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  configuration = @{"MyValue": @(10)};

  PSUserDefaultsMonitor* monitor = [PSUserDefaultsMonitor defaultMonitor];
  
  [monitor setObject:configuration key:@"configuration"]; // for show objects.
  monitor.managedObjectContext = self.managedObjectContext; // for show CoreData.
  [monitor startMonitorWithPort:5050]; // 5050 is http server listen port.
}
```

## stop

```objc
[monitor stop];
```

## show 

## show NSUserDefaults from your browser.

http://{your iphone's ipaddress}:{http server's port}/U/

examples
- http://192.168.0.4:5050/U/
- http://192.168.0.4:5050/U/NSLanguages

![example](https://raw.githubusercontent.com/hmuronaka/PSUserDefaultsMonitor/master/docs/example03.png)

## show Objects

http://{your iphone's ipaddress}:{http server's port}/O/

examples
- http://192.168.0.4:5050/O/

![example](https://raw.githubusercontent.com/hmuronaka/PSUserDefaultsMonitor/master/docs/example02.png)

## show CoreDatas

http://{your iphone's ipaddress}:{http server's port}/C/{TableName}

examples
- http://192.168.0.4.:5050/C/Person

![example](https://raw.githubusercontent.com/hmuronaka/PSUserDefaultsMonitor/master/docs/example04.png)
