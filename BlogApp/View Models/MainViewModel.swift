//
//  MainViewModel.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation

class MainViewModel {
    
    private(set) var blogs: [BlogModel] = []
    
    let blog: BlogModel
    
    init(blog: BlogModel) {
        self.blog = blog
    }
    
    //Strings
    var blogEntryTitle: String {
        return self.blog.title
    }
    
    var blogEntryBody: String {
        return self.blog.body
    }
}
