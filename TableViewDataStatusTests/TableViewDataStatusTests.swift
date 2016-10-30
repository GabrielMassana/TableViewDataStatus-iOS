//
//  TableViewDataStatusTests.swift
//  TableViewDataStatusTests
//
//  Created by Gabriel Massana on 28/3/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

import XCTest

@testable import TableViewDataStatus


class MockDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class MockDataSourceNoRows: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class TableViewDataStatusTests: XCTestCase {
    
    var tableView: TableViewDataStatus?
    
    var mockDataSource: MockDataSource?
    var mockDataSourceNoRows: MockDataSourceNoRows?
    
    var loadingView: UIView?
    var emptyView: UIView?

    override func setUp() {
        
        super.setUp()
        
        tableView = TableViewDataStatus.init(frame: CGRect.zero, style: .plain)
        
        mockDataSource = MockDataSource()
        mockDataSourceNoRows = MockDataSourceNoRows()
        
        loadingView = UIView()
        emptyView = UIView()
    }
    
    override func tearDown() {
        
        tableView = nil
        
        mockDataSource = nil
        mockDataSourceNoRows = nil
        
        loadingView = nil
        emptyView = nil
        
        super.tearDown()
    }

    // MARK: - HasData

    func test_hasData_withData () {
        
        tableView!.dataSource = mockDataSource
        
        XCTAssertTrue(tableView!.hasData(), "hasData should be true")
    }
    
    func test_hasData_WithoutData () {
        
        tableView!.dataSource = mockDataSourceNoRows

        XCTAssertFalse(tableView!.hasData(), "hasData should be false")
    }
    
    func test_hasData_NoDataSource () {
        
        XCTAssertFalse(tableView!.hasData(), "hasData should be false because no DataSource")
    }
    
    // MARK: - DidFinishLoadingContentActions

    func test_didFinishLoadingContentActions_initToTrue () {
        
        XCTAssertTrue(tableView!.didFinishLoadingContentActions, "didFinishLoadingContentActions is init to true")
    }
    
    // MARK: - LoadingView

    func test_loadingView_nilIfNotSet () {
        
        XCTAssertNil(tableView!.loadingView, "loadingView should be nil if not set")
    }
    
    // MARK: - EmptyView

    func test_emptyView_nilIfNotSet () {
        
        XCTAssertNil(tableView!.emptyView, "emptyView should be nil if not set")
    }
    
    // MARK: - WillLoadContent

    func test_willLoadContent_loadingViewVisibleWithData () {
        
        tableView!.dataSource = mockDataSource
        tableView!.loadingView = loadingView!
        
        tableView!.willLoadContent()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.loadingView!.alpha) as Float), NSNumber(value: 1.0 as Float), "loadingView should be visible")
    }
    
    func test_willLoadContent_didFinishLoadingContentActions () {
        
        tableView!.dataSource = mockDataSource
        
        tableView!.willLoadContent()
        
        XCTAssertFalse(tableView!.didFinishLoadingContentActions, "didFinishLoadingContentActions should be false after willLoadContent()")
    }
    
    // MARK: - ReloadData
    
    func test_reloadData_emptyViewNotVisibleWithData () {
        
        tableView!.dataSource = mockDataSource
        tableView!.emptyView = emptyView!
        
        tableView!.reloadData()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.emptyView!.alpha) as Float), NSNumber(value: 0.0 as Float), "emptyView shouldn't be visible")
    }
    
    func test_reloadData_emptyViewVisibleWithoutData () {
        
        tableView!.dataSource = mockDataSourceNoRows
        tableView!.emptyView = emptyView!
        
        tableView!.reloadData()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.emptyView!.alpha) as Float), NSNumber(value: 1.0 as Float), "emptyView should be visible")
    }
    
    // MARK: - LayoutSubviews
    
    func test_layoutSubviews_emptyViewNotVisibleWithData () {
        
        tableView!.dataSource = mockDataSource
        tableView!.emptyView = emptyView!
        
        tableView!.layoutSubviews()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.emptyView!.alpha) as Float), NSNumber(value: 0.0 as Float), "emptyView shouldn't be visible")
    }
    
    func test_layoutSubviews_emptyViewVisibleWithoutData () {
        
        tableView!.dataSource = mockDataSourceNoRows
        tableView!.emptyView = emptyView!
        
        tableView!.layoutSubviews()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.emptyView!.alpha) as Float), NSNumber(value: 1.0 as Float), "emptyView should be visible")
    }
    
    // MARK: - EndUpdates
    
    func test_endUpdates_emptyViewNotVisibleWithData () {
        
        tableView!.dataSource = mockDataSource
        tableView!.emptyView = emptyView!
        
        tableView!.endUpdates()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.emptyView!.alpha) as Float), NSNumber(value: 0.0 as Float), "emptyView shouldn't be visible")
    }
    
    func test_endUpdates_emptyViewVisibleWithoutData () {
        
        tableView!.dataSource = mockDataSourceNoRows
        tableView!.emptyView = emptyView!
        
        tableView!.endUpdates()
        
        XCTAssertEqual(NSNumber(value: Float(tableView!.emptyView!.alpha) as Float), NSNumber(value: 1.0 as Float), "emptyView should be visible")
    }
}
