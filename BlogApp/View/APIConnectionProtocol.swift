//
//  APIConnectionProtocol.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/09/18.
//

import Foundation

protocol APIConnectionProtocol {
    func fetchComments( completion: @escaping (Result<[CommentsModel], Error>) -> Void)
}

class APIConnectionStub: APIConnectionProtocol {
    
    var shouldReturnError = false
    
    var blogs: [BlogModel] = []
    var comments: [CommentsModel] = []
    
    func fetchBlogs(completion: @escaping (Result<[BlogModel], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
        } else {
            completion(.success(blogs))
        }
    }
    
    func fetchComments(completion: @escaping (Result<[CommentsModel], any Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
        } else {
            completion(.success(comments))
        }
    }
}
