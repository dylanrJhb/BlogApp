//
//  MainViewModel.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation

class MainViewModel {
    
    private weak var view: MainView?
    
    var blogs = [BlogModel]()
    var FilteredBlogs: [BlogModel] = []

    init(view: MainView) {
        self.view = view
    }
       
//MARK: Call fetched data from API using Alamofire
    func fetchBlogs(completion: @escaping () -> Void){
        APIConnection.fetchBlogs { result in
            switch result {
            case .success(let blogsData):
                self.blogs = blogsData
                completion()
                
            case .failure(let error):
                print("Error fetching blogs: \(error)")
                self.blogs = []
                completion()
            }
        }
    }

    func filterBlogs(with searchText: String) {
        if searchText.isEmpty {
            FilteredBlogs = blogs
        } else {
            FilteredBlogs = blogs.filter { blogs in
                blogs.title.lowercased().contains(searchText.lowercased()) || blogs.body.lowercased().contains(searchText.lowercased())
            }
            view?.updateView()
        }
        view?.updateView()
    }
}

struct MainModel {
    
    let blog: BlogModel
    
    init(blog: BlogModel) {
        self.blog = blog
    }
    
    //Strings
    var blogEntryTitle: String {
        blog.title
    }
    
    var blogEntryBody: String {
        blog.body
    }
}

