//
//  TableViewDataStatus.swift
//  TableViewDataStatus
//
//  Created by Gabriel Massana on 27/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import UIKit

class TableViewDataStatus: UITableView {
    
    //MARK: - Accessors
    
    var emptyView: UIView?
    
    //MARK - Init
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    //MARK - ReloadData
    
    override func reloadData() {
        
        super.reloadData()
        
        if (emptyView != nil) {
            
            updateEmptyView()
        }
    }
    
    //MARK - LayoutSubviews
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if (emptyView != nil) {
            
            if (((emptyView!.superview) != nil)) {
                
                updateEmptyView()
            }
            
            self.bringSubviewToFront(emptyView!)
        }
    }
    
    //MARK - EndUpdates
    
    override func endUpdates() {
        
        super.endUpdates()
        
        updateEmptyView()
    }
    
    //MARK - UpdateEmptyView
    
    /**
    Updates the visibility of the empty view depending on the table view data.
    */
    func updateEmptyView() {
        
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
    
    //MARK - HasData
    
    /**
    Checks if the table view has data or not.
    */
    func hasData() -> Bool {
        
        var hasData = false
        
        let numberOfRowsInSectionZero = numberOfRowsInSection(0)
        
        if (numberOfRowsInSectionZero > 0) {
            
            hasData = true
        }
        
        return hasData
    }
}
