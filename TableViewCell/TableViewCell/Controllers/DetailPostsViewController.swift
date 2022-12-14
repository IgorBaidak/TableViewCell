//
//  DetailPostsViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 4.09.22.
//

import UIKit

class DetailPostsViewController: UIViewController {
    var user: User?
    var posts: Post?
    
    @IBOutlet weak var postsDetailText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }
    
    private func setupUI() {
        title = posts?.title
        postsDetailText.text = posts?.body
    }

    @IBAction func commentsButton() {
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommentsTableViewController") as! CommentsTableViewController
        vc.posts = posts
        navigationController?.pushViewController(vc, animated: true)
    }
}
