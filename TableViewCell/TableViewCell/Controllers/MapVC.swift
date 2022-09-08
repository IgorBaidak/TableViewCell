//
//  MapVC.swift
//  TableViewCell
//
//  Created by Igor Baidak on 8.09.22.
//

import UIKit
import MapKit


class MapVC: UIViewController {

    var user: User?
    
    @IBOutlet weak var userMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        guard let user = user,
              let address = user.address,
                let geo = address.geo,
                let lat = geo.lat,
                let lan = geo.lng,
                let latDbl = Double(lat),
                let lanDbl = Double(lan) else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = latDbl
        annotation.coordinate.longitude = lanDbl
        userMap.addAnnotation(annotation)
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
