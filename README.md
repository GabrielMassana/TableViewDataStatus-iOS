# TableViewDataStatus-iOS

[![Version](https://img.shields.io/cocoapods/v/TableViewDataStatus.svg?style=flat-square)](http://cocoapods.org/pods/TableViewDataStatus)
[![License](https://img.shields.io/cocoapods/l/TableViewDataStatus.svg?style=flat-square)](http://cocoapods.org/pods/TableViewDataStatus)
[![Platform](https://img.shields.io/cocoapods/p/TableViewDataStatus.svg?style=flat-square)](http://cocoapods.org/pods/TableViewDataStatus)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/TableViewDataStatus.svg?style=flat-square)](http://cocoapods.org/pods/TableViewDataStatus)
[![Build Status](https://img.shields.io/travis/GabrielMassana/TableViewDataStatus-iOS/master.svg?style=flat-square)](https://travis-ci.org/GabrielMassana/TableViewDataStatus-iOS)

##   What is it?

Table View to control Data Status. 

 - Allows to add a loading view as subview.
 - Allows to add an empty view as subview.

The table view automatically controls the visibility of the views.

## Installation

#### Podfile

```ruby
platform :ios, '8.0'
use_frameworks!

pod 'TableViewDataStatus', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

#### Old school

Drag into your project the folder `/TableViewDataStatus-iOS`. That's all.

## Example Swift

On the example the empty view is a simple UIView with orangeColor() background. 
The loading view is the same but with greenColor() background.

On production they can be any UIView subview with any elements.

```swift
     /**
     Empty View to be shown when no data in the Table View.
     */
    lazy var emptyView: UIView = {
        
        let emptyView: UIView = UIView(frame: CGRect.init(x: 0.0, y: 0.0, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds)))
        
        emptyView.backgroundColor = UIColor.orangeColor()
        
        return emptyView
    }()
    
    /**
     Empty View to be shown when no data in the Table View.
     */
    lazy var loadingView: UIView = {
        
        let loadingView: UIView = UIView(frame: CGRect.init(x: 0.0, y: 0.0, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds)))
        
        loadingView.backgroundColor = UIColor.greenColor()
        
        return loadingView
    }()
    
    /**
     Table view to display data.
     */
    lazy var tableView: TableViewDataStatus = {
        
        let tableView: TableViewDataStatus = TableViewDataStatus.init(frame: UIScreen.mainScreen().bounds, style: .Plain)
        
        tableView.emptyView = self.emptyView
        tableView.loadingView = self.loadingView
        
        return tableView
    }()
    
    /**
     Fake API call method. 
     At the begining of the method willLoadContent() is called to update the loadingView visibility.
     At the end of the APi call didFinishLoadingContent() is called to update again the views visibilities.
     */
    func fakeAPICallAndComplition() {
        
        // Call this method before the API call.
        tableView.willLoadContent()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5.0 * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            // Call this method on finish the API call.
            self.tableView.didFinishLoadingContent(false)
        }
    }    
    

```

## Example Objective-C

```objc
#import "TableViewDataStatus-Swift.h"


```

## License

TableViewDataStatus-iOS is released under the MIT license. Please see the file called LICENSE.

## Versions

```bash
$ git tag -a 1.0.0 -m 'Version 1.0.0'

$ git push --tags
```

## Author

Gabriel Massana

##Found an issue?

Please open a [new Issue here](https://github.com/GabrielMassana/TableViewDataStatus-iOS/issues/new) if you run into a problem specific to TableViewDataStatus-iOS, have a feature request, or want to share a comment.
