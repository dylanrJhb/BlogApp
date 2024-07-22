//
//  CommentDetailViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/22.
//

import Foundation
import UIKit

class CommentDetailViewController: UIViewController {
    
    @IBOutlet var commentName: UITextView!
    @IBOutlet var commentEmail: UITextView!
    @IBOutlet var commentBodyText: UITextView!
    
    var comment: CommentsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentName.text = comment?.name
        commentEmail.text = comment?.email
        commentBodyText.text = comment?.body
        
        commentName.sizeToFit()
        commentEmail.sizeToFit()
        commentBodyText.sizeToFit()
    }
}
