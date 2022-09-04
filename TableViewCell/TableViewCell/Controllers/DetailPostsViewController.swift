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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
