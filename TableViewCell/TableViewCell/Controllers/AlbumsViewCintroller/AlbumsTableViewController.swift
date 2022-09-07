//
//  AlbumsTableViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 7.09.22.
//

import UIKit
import SwiftyJSON
import Alamofire



class AlbumsTableViewController: UITableViewController {

    var user: User!
    var alboms: [JSON] = []

    override func viewDidLoad() {
        getData()
    }

    private func getData() {

        guard let userId = user?.id else { return }
        
        guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }

        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                self.alboms = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alboms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "PhotoCell")
        cell.textLabel?.text = (alboms[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = alboms[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = alboms[indexPath.row]
        performSegue(withIdentifier: "goToCollectionSegue", sender: albom)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCollectionSegue",
            let photosCollectionVC = segue.destination as? AlbumsCollectionCVC,
            let album = sender as? JSON {
            photosCollectionVC.user = user
            photosCollectionVC.album = album
        }
    }

}

