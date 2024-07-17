//
//  MainViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UITableView!
    
    var blogs = [BlogModel]()
    var filteredData: [BlogModel]!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
            print("Data successfully fetched from API")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        filteredData = blogs
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        downloadJSON {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let blogTable = filteredData[indexPath.row]
        cell.textLabel?.text = blogTable.title.capitalized
        cell.detailTextLabel?.text = blogTable.body.capitalized

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = blogs
        }
        else {
            for blog in blogs {
                if blog.title.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(blog)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BlogViewController {
            destination.blog = filteredData[tableView.indexPathForSelectedRow!.row]
        }
    }
        
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error == nil {
                do {
                    self.filteredData = try JSONDecoder().decode([BlogModel].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
}

