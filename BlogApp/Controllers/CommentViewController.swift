//
//  CommentViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class CommentViewController: UIViewController {
    
    var comment: CommentsModel?
    
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var emailTextView: UITextView!
    @IBOutlet var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
