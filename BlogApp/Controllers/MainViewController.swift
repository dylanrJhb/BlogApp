//
//  MainViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var blogs = [BlogModel]()
    var filteredBlogs: [BlogModel] = []
    var refreshControl = UIRefreshControl()
//    let searchController = UISearchController()
    private let vm = MainViewModel()
                   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        vm.fetchBlogs()
//        tableView.reloadData()    
        activityIndicatorView()
        
        ApiConnection.sharedInstance.fetchAPIData{ apiData in
            self.blogs = apiData

           DispatchQueue.main.async {
            self.tableView.reloadData()
           }
        }
                
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        searchBar.delegate = self
        
//        filteredBlogs = blogs
    }
    
   @objc func refresh(send: UIRefreshControl) {
       ApiConnection.sharedInstance.fetchAPIData{ apiData in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

//TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let blogTable = blogs[indexPath.row]
        cell.textLabel?.text = blogTable.title.capitalized
        cell.detailTextLabel?.text = blogTable.body.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BlogViewController {
            destination.blog = blogs[tableView.indexPathForSelectedRow!.row]
        }
    }
}

//Search Bar
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredBlogs = []
           
        if searchText.isEmpty{
                    filteredBlogs = blogs
                    print("searchText is empty")
                }
                else {
                    print("searchText is not empty -- \(searchText)")
//                    
//                    filteredBlogs = blogs.filter { $0.title.lowercased().contains(searchText.lowercased())}
//                    
//                    print(filteredBlogs)
                    
                    for blog in blogs {
                        if blog.title.lowercased().contains(searchText.lowercased()) {
                            filteredBlogs.append(blog)
                            print("Blog -- \(filteredBlogs)")
                        }
                    }
                }
        tableView.reloadData()
        }
    }

//Loading indicator
extension MainViewController {
    
    fileprivate func activityIndicatorView() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: .blue, padding: 0)
        loading.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 50),
            loading.heightAnchor.constraint(equalToConstant: 50),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loading.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            loading.stopAnimating()
        }
    }
}
