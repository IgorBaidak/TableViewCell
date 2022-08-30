//
//  ImageViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 30.08.22.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    private let imageUrl = "https://cdn.wallpapersafari.com/76/81/56baIz.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImageData()
        // Do any additional setup after loading the view.
    }
    
    // метод преобразующий стринговый URL адрес в URL
    private func fetchImageData() {
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
    // создаем замыкание и отправляем все данные в главный поток (для отбражения картинки)
            DispatchQueue.main.async {
                if let error = error {
                    print (error)
                }
                if let response = response {
                    print (response)
                }
                if let data = data {
                    print (data)
                    self?.imageView.image = UIImage(data: data)
                    self?.activityIndicator.stopAnimating()
                }
            }
        } .resume()
    }
}
