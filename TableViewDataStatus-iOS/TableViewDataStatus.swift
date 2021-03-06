//
//  TableViewDataStatus.swift
//  TableViewDataStatus
//
//  Created by Gabriel Massana on 27/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

/// Table View to control Data Status. The table view automatically controls the visibility of the views.
open class TableViewDataStatus: UITableView {
    
    //MARK: - Accessors
    
    /// View to display when the Data Source View is empty.
    open var emptyView: UIView?
    
    /// View to display when the Data Source View is loading.
    open var loadingView: UIView?
    
    /// Indicates that loading actions have finished
    open var didFinishLoadingContentActions: Bool = true
    
    //MARK: - Init
    
    /**
     Initializes and returns a table view object having the given frame and style.
     
     - parameter frame: A rectangle specifying the initial location and size of the table view in its superview’s coordinates. The frame of the table view changes as table cells are added and deleted.
     - parameter style: A constant that specifies the style of the table view. See Table View Style for descriptions of valid constants.
     
     - returns: Returns an initialized UITableView object, or nil if the object could not be successfully initialized.
     */
    override public init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
    }
    
    /**
     Returns an object initialized from data in a given unarchiver.
     
     - parameter aDecoder: An unarchiver object.

     - returns: Returns an initialized UITableView object, or nil if the object could not be successfully initialized.
     */
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    //MARK: - ReloadData
    
    /**
     Reloads the rows and sections of the table view.
     */
    override open func reloadData() {
        
        super.reloadData()
        
        if (loadingView != nil) {
            
            updateLoadingView()
        }
        else
        {
            updateEmptyView()
        }
    }
    
    //MARK: - LayoutSubviews
    
    /**
     Lays out subviews.
     */
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        if (loadingView != nil) {
            
            if (((loadingView!.superview) != nil)) {
                
                updateLoadingView()
            }
            
            self.bringSubview(toFront: loadingView!)
        }
        else
        {
            if (((emptyView!.superview) != nil)) {
                
                updateEmptyView()
            }
            
            self.bringSubview(toFront: emptyView!)
        }
    }
    
    //MARK: - EndUpdates
    
    /**
     Concludes a series of method calls that insert, delete, select, or reload rows and sections of the table view.
     */
    override open func endUpdates() {
        
        super.endUpdates()
        
        if (loadingView != nil) {
            
            updateLoadingView()
        }
        
        updateEmptyView()
    }
    
    //MARK: - UpdateEmptyView
    
    /**
    Updates the visibility of the empty view depending on the table view data.
    */
    fileprivate func updateEmptyView() {
        
        if (emptyView != nil) {
            
            if (hasData()) {
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.emptyView!.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.emptyView?.removeFromSuperview()
                })
            }
            else
            {
                emptyView!.alpha = 0.0
                addSubview(emptyView!)
                emptyView!.updateConstraints()
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.emptyView!.alpha = 1.0
                })
            }
        }
    }
    
    //MARK: - UpdateLoadingView

    /**
     Updates the visibility of the empty view depending on the table view data.
     */
    fileprivate func updateLoadingView() {

        if (loadingView != nil) {
            
            if (hasData() ||
                didFinishLoadingContentActions) {
                
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        
                        self.loadingView!.alpha = 0.0
                        
                        }, completion: { (Bool) -> Void in
                            
                            self.loadingView?.removeFromSuperview()
                    })
            }
            else
            {
                loadingView!.alpha = 0.0
                addSubview(loadingView!)
                loadingView!.updateConstraints()
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.loadingView!.alpha = 1.0
                })
            }
        }
    }
    
    //MARK: - HasData
    
    /**
     Checks if the table view has data or not.
     
     - returns: true if the tableview has Data. No otherwise.
    */
    open func hasData() -> Bool {
        
        var hasData = false
        
        let numberOfRowsInSectionZero = numberOfRows(inSection: 0)
        
        if (numberOfRowsInSectionZero > 0) {
            
            hasData = true
        }
        
        return hasData
    }
    
    //MARK: - LoadingContent

    /**
     Notify the tableView that the loading is starting.
     */
    open func willLoadContent() {
        
        didFinishLoadingContentActions = false
    }
    
    /**
    Notify the tableView that the loading has finished.
    
    - parameter hasData : YES if there is data in the tableView, NO otherwise.
    */
    open func didFinishLoadingContent(_ hasData: Bool) {
        
        DispatchQueue.main.async {
            
            if (self.loadingView?.superview != nil) {
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.loadingView!.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.loadingView?.removeFromSuperview()
                })
            }
            
            self.updateEmptyView()
            
            self.didFinishLoadingContentActions = true
        }
    }
}
