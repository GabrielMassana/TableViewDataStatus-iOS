//
//  TableViewDataStatus.swift
//  TableViewDataStatus
//
//  Created by Gabriel Massana on 27/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

public class TableViewDataStatus: UITableView {
    
    //MARK: - Accessors
    
    /**
    View to display when the Data Source View is empty.
    */
    public var emptyView: UIView?
    
    /**
     View to display when the Data Source View is loading.
     */
    public var loadingView: UIView?
    
    /**
     Indicates that loading actions have finished
     */
    public var didFinishLoadingContentActions: Bool = true
    
    //MARK - Init
    
    /**
     Initializes and returns a table view object having the given frame and style.
     
     - parameter frame: A rectangle specifying the initial location and size of the table view in its superview’s coordinates. The frame of the table view changes as table cells are added and deleted.
     - parameter style: A constant that specifies the style of the table view. See Table View Style for descriptions of valid constants.
     
     - returns: Returns an initialized UITableView object, or nil if the object could not be successfully initialized.
     */
    override init(frame: CGRect, style: UITableViewStyle) {
        
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
    
    //MARK - ReloadData
    
    /**
     Reloads the rows and sections of the table view.
     */
    override public func reloadData() {
        
        super.reloadData()
        
        if (loadingView != nil) {
            
            updateLoadingView()
        }
        else
        {
            updateEmptyView()
        }
    }
    
    //MARK - LayoutSubviews
    
    /**
     Lays out subviews.
     */
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        if (loadingView != nil) {
            
            if (((loadingView!.superview) != nil)) {
                
                updateLoadingView()
            }
            
            self.bringSubviewToFront(loadingView!)
        }
        else
        {
            if (((emptyView!.superview) != nil)) {
                
                updateEmptyView()
            }
            
            self.bringSubviewToFront(emptyView!)
        }
    }
    
    //MARK - EndUpdates
    
    /**
     Concludes a series of method calls that insert, delete, select, or reload rows and sections of the table view.
     */
    override public func endUpdates() {
        
        super.endUpdates()
        
        if (loadingView != nil) {
            
            updateLoadingView()
        }
        
        updateEmptyView()
    }
    
    //MARK - UpdateEmptyView
    
    /**
    Updates the visibility of the empty view depending on the table view data.
    */
    public func updateEmptyView() {
        
        if (emptyView != nil) {
            
            if (hasData()) {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
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
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.emptyView!.alpha = 1.0
                })
            }
        }
    }
    
    //MARK - UpdateLoadingView

    /**
     Updates the visibility of the empty view depending on the table view data.
     */
    public func updateLoadingView() {

        if (loadingView != nil) {
            
            if (hasData() ||
                didFinishLoadingContentActions) {
                
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        
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
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.loadingView!.alpha = 1.0
                })
            }
        }
    }
    
    //MARK - HasData
    
    /**
     Checks if the table view has data or not.
     
     - returns: true if the tableview has Data. No otherwise.
    */
    private func hasData() -> Bool {
        
        var hasData = false
        
        let numberOfRowsInSectionZero = numberOfRowsInSection(0)
        
        if (numberOfRowsInSectionZero > 0) {
            
            hasData = true
        }
        
        return hasData
    }
    
    /**
     Notify the tableView that the loading is starting.
     */
    public func willLoadContent() {
        
        didFinishLoadingContentActions = false
    }
    
    /**
    Notify the tableView that the loading has finished.
    
    - parameter hasData : YES if there is data in the tableView, NO otherwise.
    */
    public func didFinishLoadingContent(hasData: Bool) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            if (self.loadingView?.superview != nil) {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
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
