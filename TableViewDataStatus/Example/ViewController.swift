//
//  ViewController.swift
//  TableViewDataStatus
//
//  Created by Gabriel Massana on 27/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    //MARK: - Accessors

    var arrayWithNoData: Array<String> {
       
        let arrayWithNoData: Array = Array<String>()
        
        return arrayWithNoData
    }
    
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
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        fakeAPICallAndComplition()
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWithNoData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCellIdentifier", forIndexPath: indexPath)
        
        return cell
    }
    
    //MARK: - FakeAPICallAndComplition
    
    func fakeAPICallAndComplition() {
        
        tableView.willLoadContent()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5.0 * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            self.tableView.didFinishLoadingContent(false)
        }
    }
}

