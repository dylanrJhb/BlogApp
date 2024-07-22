//
//  CommentViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var commentTableView: UITableView!
    
    var comment = [CommentsModel]()
    var viewModel: CommentViewModel!
    
    var comments: CommentsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                   
            downloadJSON {
                self.commentTableView.reloadData()
                print("Data successfully fetched from comments API")
            }
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let commentTable = comment[indexPath.row]
        cell.textLabel?.text = commentTable.name.capitalized
        cell.textLabel?.text = commentTable.email.capitalized
        cell.detailTextLabel?.text = commentTable.body.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CommentDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationScreen = segue.destination as? CommentDetailViewController {
            destinationScreen.comment = comment[(commentTableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(1)/comments")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error == nil {
                do {
                    self.comment = try JSONDecoder().decode([CommentsModel].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from comments api")
                }
            }
        }.resume()
    }
    
}
