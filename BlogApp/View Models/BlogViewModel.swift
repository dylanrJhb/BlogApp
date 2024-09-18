//
//  BlogViewModel.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import Alamofire

class BlogViewModel {
    
    var comments: [CommentsModel] = []
    var blogTitle: String
    var blogBody: String
    var blogId: Int
    var apiConnection: APIConnectionProtocol
    
    init(blogTitle: String, blogBody: String, blogId: Int, apiConnection: APIConnectionProtocol = APIConnection()) {
        self.blogTitle = blogTitle
        self.blogBody = blogBody
        self.blogId = blogId
        self.apiConnection = apiConnection
    }
    
//MARK: Fetch Data from API using Alamofire
    var onCommentsUpdated: (() -> Void)?

    func fetchComments(completion: @escaping () -> Void) {
        
        APIConnection.fetchComments(forPostId: blogId) { result in
            switch result {
            case .success(let commentsData):
                self.comments = commentsData
                completion()
                
            case .failure(let error):
                print("Error fetching comments: \(error)")
                self.comments = []
                completion()
            }
        }
    }
    
    func numberOfComments() -> Int {
        return comments.count
    }
    
    func comment(at index: Int) -> CommentsModel? {
        guard index >= 0 && index < comments.count else { return nil }
        return comments[index]
    }
}

