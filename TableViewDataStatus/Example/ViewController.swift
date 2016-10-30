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
        
        let emptyView: UIView = UIView(frame: CGRect.init(x: 0.0,
                                                          y: 0.0,
                                                          width: UIScreen.main.bounds.width,
                                                          height: UIScreen.main.bounds.height))
        
        emptyView.backgroundColor = UIColor.orange
        
        return emptyView
    }()
    
    /**
     Empty View to be shown when no data in the Table View.
     */
    lazy var loadingView: UIView = {
        
        let loadingView: UIView = UIView(frame: CGRect.init(x: 0.0,
                                                            y: 0.0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: UIScreen.main.bounds.height))
        
        loadingView.backgroundColor = UIColor.green
        
        return loadingView
    }()
    
    /**
     Table view to display data.
     */
    lazy var tableView: TableViewDataStatus = {
        
        let tableView: TableViewDataStatus = TableViewDataStatus.init(frame: UIScreen.main.bounds,
                                                                      style: .plain)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWithNoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
        
        return cell
    }
    
    //MARK: - FakeAPICallAndComplition
    
    /**
     Fake API call method. 
     At the begining of the method willLoadContent() is called to update the loadingView visibility.
     At the end of the APi call didFinishLoadingContent() is called to update again the views visibilities.
     */
    func fakeAPICallAndComplition() {
        
        // Call this method before the API call.
        tableView.willLoadContent()
        
        let delayTime = DispatchTime.now() + Double(Int64(5.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            
            // Call this method on finish the API call.
            self.tableView.didFinishLoadingContent(false)
        }
    }
}

