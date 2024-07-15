//
//  CommentsModel.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation

struct CommentsModel: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
