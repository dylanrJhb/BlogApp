//
//  BlogViewController.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/07/15.
//

import Foundation
import UIKit

class BlogViewController: UIViewController {
    
    @IBOutlet var headerTextView: UITextView!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var commentTableView: UITableView!
       
    private var viewModel: BlogViewModel?
    
    let loadingIndicator = LoadingIndicator()
    
    var blogTitle: String?
    var blogBody: String?
    var blogId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
        
        loadingIndicator.showLoadingIndicator(view: self.view)
        fetchComments()
    }
}

//MARK: Setup
extension BlogViewController {
  
    private func setupView() {
        headerTextView.text = blogTitle
        bodyTextView.text = blogBody
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CommentCell")
    }
    
    private func setupViewModel() {
        viewModel?.onCommentsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.hideLoadingIndicator()
                
                self?.commentTableView.reloadData()
            }
        }
    }
    
    func fetchComments() {
        if let blogTitle = blogTitle, let blogBody = blogBody, let blogId = blogId {
            viewModel = BlogViewModel(blogTitle: blogTitle, blogBody: blogBody, blogId: blogId)
            
            viewModel?.fetchComments {
                DispatchQueue.main.async {
                    self.loadingIndicator.hideLoadingIndicator()
                    self.commentTableView.reloadData()
                }
            }
        }
    }
}

//MARK: Table View
extension BlogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfComments() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        if let comment = viewModel?.comment(at: indexPath.row) {
            cell.textLabel?.text = comment.name.capitalized
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if let comment = viewModel?.comment(at: indexPath.row) {
            let commentVC = CommentDetailViewController(nibName: "CommentsView", bundle: nil)
            commentVC.title = "Comments"
            commentVC.comment = comment
            navigationController?.pushViewController(commentVC, animated: true)
        }
    }
}
