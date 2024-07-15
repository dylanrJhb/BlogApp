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
    var commentName: String {
        return self.comment.name
    }
    
    var commentEmail: String {
        return self.comment.email
    }
    
    var commentBody: String {
        return self.comment.body
    }
    
}
