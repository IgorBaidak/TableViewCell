//
//  NewPostViewController.swift
//  TableViewCell
//
//  Created by Igor Baidak on 6.09.22.
//

import UIKit
import SwiftyJSON
import Alamofire


class NewPostViewController: UIViewController {

    var user: User?
    var posts: [Post] = []
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postURLSession() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsPathURL
        {
            // создаем новую URL
            var request = URLRequest(url: url)
            
            // заполняем свойства HEADER
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Создаем тело запроса BODY
            let post: [String: Any] = ["userId": userId,
                                       "title": title,
                                       "body": body]
            
            // преобразуем наш пост в формат Data
            guard let httpBody = try? JSONSerialization.data(withJSONObject: post, options: []) else { return }
                    request.httpBody = httpBody
                    
            // Создаем DataTask
                    URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                        print (response ?? "")
                        if let data = data {
                            print(data)
                            let json = JSON(data)
                            print(json)
                            let userId = json["userId"].int
                            let title = json["title"].string
                            let body = json["body"].string
                            
                            DispatchQueue.main.async {
                                self?.navigationController?.popViewController(animated: true)
                            }
                        } else if let error = error {
                            print(error)
                        }
                    }.resume()
        }
    }
    
    
    @IBAction func postAlamofire() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsPathURL
        {
            let parameter: Parameters = ["userId": userId,
                                         "title": title,
                                         "body": body]
            
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
                .responseJSON { response in
                    
                    debugPrint(response)
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)

                    switch response.result {
                    case .success(let data):
                        print(data)
                        print(JSON(data))
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
    
    
}
