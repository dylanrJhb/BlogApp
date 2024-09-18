//
//  ApiConnection.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/08/27.
//

import Foundation
import Alamofire

class APIConnection: APIConnectionProtocol{
    func fetchComments(completion: @escaping (Result<[CommentsModel], any Error>) -> Void) {}
   
    // Function to fetch blog posts
    static func fetchBlogs(completion: @escaping (Result<[BlogModel], Error>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
       
        AF.request(url).responseDecodable(of: [BlogModel].self) { response in
            switch response.result {
            case .success(let blogsData):
                completion(.success(blogsData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
    // Function to fetch comments for a specific post
    static func fetchComments(forPostId postId: Int, completion: @escaping (Result<[CommentsModel], Error>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts/\(postId)/comments"
       
        AF.request(url).responseDecodable(of: [CommentsModel].self) { response in
            switch response.result {
            case .success(let commentsData):
                completion(.success(commentsData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
