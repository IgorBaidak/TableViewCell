//
//  DetailCommentsViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 4.09.22.
//

import UIKit
import SwiftyJSON

class DetailCommentsViewController: UIViewController {

    var comments: Comment?
    var user: User?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func mapButton() {
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        title = comments?.email
        name.text = comments?.name
        email.text = comments?.email
        comment.text = comments?.body
        }
    }

