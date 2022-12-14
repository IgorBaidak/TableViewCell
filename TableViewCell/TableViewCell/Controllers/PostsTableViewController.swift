//
//  PostsTableViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 3.09.22.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var user: User?
    var posts: [Post] = []
    var comment: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath)
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }

    // MARK: Func's
    
    private func fetchPosts() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"
        
        guard let url = URL(string: pathUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data) //
            } catch {
                print (self.posts)
            }
            // отправляем данные в главный поток
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } .resume()
    }

    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let posts = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "PostAndComments", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailPostsViewController") as! DetailPostsViewController
        vc.posts = posts
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            let _ = posts[indexPath.section]
            tableView.insertRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
