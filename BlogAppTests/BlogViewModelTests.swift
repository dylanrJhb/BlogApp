//
//  BlogViewModelTests.swift
//  BlogAppTests
//
//  Created by Reid, Dylan D on 2024/09/17.
//
import XCTest
@testable import BlogApp

class BlogViewModelTests: XCTestCase {

    var viewModel: BlogViewModel!
    var apiConnectionStub: APIConnectionStub!

    override func setUp() {
        super.setUp()

        apiConnectionStub = APIConnectionStub()
        
        viewModel = BlogViewModel(blogTitle: "Test Title", blogBody: "Test Body", blogId: 1, apiConnection: apiConnectionStub)
    }

    override func tearDown() {
        apiConnectionStub = nil
        viewModel = nil
        super.tearDown()
    }

    // Test fetchComments success scenario
//    func testFetchCommentsSuccess() {
//        apiConnectionStub.comments = [
//        CommentsModel(postId: 1, id: 1, name: "User 1", email: "user1@email.com", body: "Body 1"),
//        CommentsModel(postId: 2, id: 2, name: "User 2", email: "user2@email.com", body: "Body 2")
//        ]
//
//        let expectation = XCTestExpectation(description: "Fetch comments")
//        viewModel.fetchComments {
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1.0)
//
//        //Verify that the comments are fetched correctly
//        XCTAssertEqual(viewModel.comments.count, 2)
//        XCTAssertEqual(viewModel.comments.first?.body, "Body 1")
//        XCTAssertEqual(viewModel.comments.last?.body, "Body 2")
//    }

    // Test fetchComments failure scenario
    func testFetchCommentsFailure() {
        apiConnectionStub.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Fetch comments")
        viewModel.fetchComments {
            expectation.fulfill()
        }        

        XCTAssertEqual(viewModel.comments.count, 0)
    }

    // Test numberOfComments
    func testNumberOfComments() {
        viewModel.comments = [
            CommentsModel(postId: 1, id: 1, name: "Test 1", email: "Email 1", body: "Body 1"),
            CommentsModel(postId: 2, id: 2, name: "Test 2", email: "Email 2", body: "Body 2")
        ]

        let count = viewModel.numberOfComments()
        
        XCTAssertEqual(count, 2)
    }


    func testCommentAtIndex() {
        let comment1 = CommentsModel(postId: 1, id: 1, name: "Test 1", email: "Email 1", body: "Body 1")
        let comment2 = CommentsModel(postId: 2, id: 2, name: "Test 2", email: "Email 2", body: "Body 2")
        viewModel.comments = [comment1, comment2]

        let comment = viewModel.comment(at: 1)

        XCTAssertEqual(comment?.body, "Body 2")
    }

    // Test comment returns nil for out of bounds index
    func testCommentAtInvalidIndex() {
        viewModel.comments = [CommentsModel(postId: 1, id: 1, name: "Test 1", email: "Email 1", body: "Body 1")]

        let comment = viewModel.comment(at: 10)

        XCTAssertNil(comment)
    }
}
