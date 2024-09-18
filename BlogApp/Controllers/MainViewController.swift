//
//  MainViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var blogs: [BlogModel] = []
    var filteredBlogs: [BlogModel] = []
    
    private lazy var viewModel = MainViewModel(view: self)
    
    let loadingIndicator = LoadingIndicator()
    
    var refreshControl = UIRefreshControl()
    private var searchController: UISearchController
    
    static func loadFromNib() -> MainViewController {
        return MainViewController()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.showLoadingIndicator(view: self.view)
                
        fetchBlogs()
        configureTableView()
        configureSearchController()
        configureRefreshControl()
    }
                       
    func fetchBlogs() {
        viewModel.fetchBlogs{
            self.loadingIndicator.hideLoadingIndicator()
            
            self.blogs = self.viewModel.blogs
            self.filteredBlogs = self.viewModel.blogs
            self.tableView.reloadData()
        }
    }
        
    public init() {
        searchController = UISearchController(searchResultsController: nil)
        
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFilteringBranches ? filteredBlogs.count : blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let blog = isFilteringBranches ? filteredBlogs[indexPath.row] : blogs[indexPath.row]
        cell.textLabel?.text = blog.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let selectedBlog = isFilteringBranches ? filteredBlogs[indexPath.row] : blogs[indexPath.row]
        
        let blogVC = BlogViewController(nibName: "BlogDetailsView", bundle: nil)
        blogVC.title = "Blog Post"
        blogVC.blogTitle = selectedBlog.title
        blogVC.blogBody = selectedBlog.body
        blogVC.blogId = selectedBlog.id
        
        navigationController?.pushViewController(blogVC, animated: true)
    }
}

//MARK: Search Bar
extension MainViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    private func configureSearchController() {
        tableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Blogs"
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFilteringBranches: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        filterBlogs(searchText: searchText)
    }
    
    private func filterBlogs(searchText: String) {
        if searchText.isEmpty {
            filteredBlogs = blogs
        } else {
            filteredBlogs = blogs.filter { blog in
                return blog.title.lowercased().contains(searchText.lowercased()) || blog.body.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

//MARK: Refresh controller
extension MainViewController {
    
    func configureRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(refreshBlogPosts(_:)), for: .valueChanged)//vm code
    }
    
    @objc private func refreshBlogPosts(_ sender: Any) {
        viewModel.fetchBlogs {
            DispatchQueue.main.async {
                self.blogs = self.viewModel.blogs
                self.filteredBlogs = self.blogs
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

//MARK: Protocol
extension MainViewController: MainView {
    
    func configureTitle(with title: String) {
        self.title = title
    }
    
    func updateView() {
        tableView.reloadData()
    }
}
