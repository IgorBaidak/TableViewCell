//
//  AlbumsTableViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 4.09.22.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var user: User?
    var albums: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbums()
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albums = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsCell", for: indexPath)
        cell.textLabel?.text = albums.title
        cell.detailTextLabel?.text = albums.url

        return cell
    }
    
    // MARK: Func's
    
    private func fetchAlbums() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.albumsPath)?userId=\(userId)"
        
        guard let url = URL(string: pathUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.albums = try JSONDecoder().decode([Photo].self, from: data) //
            } catch {
                print (self.albums)
            }
            // отправляем данные в главный поток
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } .resume()
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
