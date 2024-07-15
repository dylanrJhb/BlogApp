//
//  BlogModel.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation

struct BlogModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
