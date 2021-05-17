//
//  MovieListViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 15/05/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let parameters: [String: String] = [:]
//        parameters["language"] = "en-US"
//        parameters["page"] = "1"
//        parameters["api_key"] = API_KEY
        let request = RequestModel(url: .movieList, httpBody: parameters)
        NetworkManager.request(request, MovieListResponse.self) { result in
            switch result {
            case .success(let list):
                print(list)
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
// end of class
