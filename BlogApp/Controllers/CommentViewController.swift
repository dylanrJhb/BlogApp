//
//  CommentViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var emailTextView: UITextView!
    @IBOutlet var commentTextView: UITextView!
    
    var comment = [CommentsModel]()
    var linkComment: [CommentsModel]!
    var viewModel: CommentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                   
            downloadJSON {
                self.nameTextView.text = self.linkComment[1].name
                self.emailTextView.text = self.linkComment[1].email
                self.commentTextView.text = self.linkComment[1].body
                print("Data successfully fetched from comments API")
            }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(1)/comments")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error == nil {
                do {
                    self.linkComment = try JSONDecoder().decode([CommentsModel].self, from: data!)
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
