//
//  MainViewModelTests.swift
//  BlogAppTests
//
//  Created by Reid, Dylan D on 2024/09/18.
//

import Foundation
import XCTest
@testable import BlogApp

class MainViewModelTests: XCTestCase {
   
    var viewModel: MainViewModel!
    var apiConnectionStub: APIConnectionStub!
    var mainViewStub: MainViewStub!
   
    override func setUp() {
        super.setUp()
       
        // Initialize the stubs
        apiConnectionStub = APIConnectionStub()
        mainViewStub = MainViewStub()
       
        // Initialize MainViewModel with the stubbed MainView
        viewModel = MainViewModel(view: mainViewStub)
    }
   
    override func tearDown() {
        apiConnectionStub = nil
        viewModel = nil
        mainViewStub = nil
        super.tearDown()
    }
   
    // Test fetchBlogs success scenario
//    func testFetchBlogsSuccess() {
//
//        apiConnectionStub.blogs = [
//            BlogModel(userId: 1, id: 1, title: "Blog 1", body: "Body 1"),
//            BlogModel(userId: 2, id: 2, title: "Blog 2", body: "Body 2")
//        ]
//       
//        let expectation = XCTestExpectation(description: "Fetch blogs")
//        viewModel.fetchBlogs {
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1.0)
//
//        XCTAssertEqual(viewModel.blogs.count, 2)
//        XCTAssertEqual(viewModel.blogs.first?.title, "Blog 1")
//    }
   
    // Test fetchBlogs failure scenario
    func testFetchBlogsFailure() {

        apiConnectionStub.shouldReturnError = true
       
        let expectation = XCTestExpectation(description: "Fetch blogs")
        viewModel.fetchBlogs {
            expectation.fulfill()
        }
       
        XCTAssertEqual(viewModel.blogs.count, 0)
    }
   
    // Test filtering blogs
    func testFilterBlogs() {

        viewModel.blogs = [
            BlogModel(userId: 1, id: 1, title: "First Blog", body: "This is the first blog"),
            BlogModel(userId: 2, id: 2, title: "Second Blog", body: "This is the second blog")
        ]
       
        viewModel.filterBlogs(with: "First")

        XCTAssertEqual(viewModel.FilteredBlogs.count, 1)
        XCTAssertEqual(viewModel.FilteredBlogs.first?.title, "First Blog")
    }
   
    // Test filterBlogs with an empty string
    func testFilterBlogsEmptySearch() {
        viewModel.blogs = [
            BlogModel(userId: 1, id: 1, title: "First Blog", body: "This is the first blog"),
            BlogModel(userId: 2, id: 2, title: "Second Blog", body: "Another interesting blog")
        ]
       
        // Filter blogs with an empty string (this should return all blogs)
        viewModel.filterBlogs(with: "")
       
        //Verify all blogs are included in the filtered results
        XCTAssertEqual(viewModel.FilteredBlogs.count, 2)
    }
   
    // Test view update when filtering
    func testViewUpdateCalledOnFilterBlogs() {

        viewModel.blogs = [
            BlogModel(userId: 1, id: 1, title: "First Blog", body: "This is the first blog")
        ]

        viewModel.filterBlogs(with: "First")
       
        XCTAssertTrue(mainViewStub.didCallUpdateView)
    }
}
