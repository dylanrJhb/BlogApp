//
//  BlogViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class BlogViewController: UIViewController {
    
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var headerTextView: UITextView!
    @IBOutlet var commentButton: UIButton!
    
    var blog: BlogModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTextView.isScrollEnabled = false
        headerTextView.isScrollEnabled = false

        headerTextView.text = blog?.title
        bodyTextView.text = blog?.body
        commentButton.tintColor = .systemGray
        
        headerTextView.sizeToFit()
        bodyTextView.sizeToFit()

    }
    
    func commentButtonTapped() {
        performSegue(withIdentifier: "commentView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationScreen = segue.destination as? CommentViewController {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
