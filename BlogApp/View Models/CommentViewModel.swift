//
//  CommentViewModel.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation

class CommentViewModel {
    private(set) var comments: [CommentsModel] = []
    
    let comment: CommentsModel
    
    init(comment: CommentsModel) {
        self.comment = comment
    }
    
    //Strings
    var commentPostId: Int {
        var postId = comment.postId
        postId = 1
        return postId
    }
    
    var commentName: String {
        
        var commentName = comment.name
        commentName = "This is a comment"
        return commentName
        //return self.comment.name
    }
    
    var commentEmail: String {
        var commentEmail = comment.email
        commentEmail = "This is a comment"
        return commentEmail
        //return self.comment.email
    }
    
    var commentBody: String {
        var commentBody = comment.body
        commentBody = "This is a comment"
        return commentBody
//        return self.comment.body
    }
    
}
