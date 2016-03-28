//
//  TableViewDataStatusTests.swift
//  TableViewDataStatusTests
//
//  Created by Gabriel Massana on 28/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import XCTest

@testable import TableViewDataStatus

class TableViewDataStatusTests: XCTestCase {
    
    var tableView: TableViewDataStatus?
    
    override func setUp() {
        
        super.setUp()
        
        tableView = TableViewDataStatus.init(frame: CGRectZero, style: .Plain)
    }
    
    override func tearDown() {

        
        super.tearDown()
    }
    

    func test () {
        
        // https://www.raywenderlich.com/101306/unit-testing-tutorial-mocking-objects
        
        // http://blog.eliperkins.me/mocks-in-swift-via-protocols
        // http://masilotti.com/better-swift-unit-testing/
        // http://clean-swift.com/to-mock-or-not-to-mock/
        // https://christiantietze.de/posts/2015/06/mocks-swift/
    }
}
