//
//  CommentViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class CommentViewController: UIViewController {
    
    var comment = [CommentsModel]()
       
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var emailTextView: UITextView!
    @IBOutlet var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                   
            downloadJSON {
                print("Data successfully fetched from comments API")
            }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error == nil {
                do {
                    self.comment = try JSONDecoder().decode([CommentsModel].self, from: data!)
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
