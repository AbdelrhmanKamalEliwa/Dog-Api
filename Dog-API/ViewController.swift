//
//  ViewController.swift
//  Dog-API
//
//  Created by Abdelrhman Eliwa on 4/6/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var dogImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSwiftImage()
    }
    
    @IBAction func loadDogImageButtonTapped(_ sender: Any) {
        loadDogImage()
    }
    
    
    func loadSwiftImage() {
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/40px-Swift_logo.svg.png")
        let task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error != nil {
                print("error")
            }
            if let safeData = data {
                DispatchQueue.main.async {
                    self.logoImageView.image = UIImage(data: safeData)
                }
            }
        }
        task.resume()
    }
    
    func loadDogImage() {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")
        let task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error != nil {
                print("error")
            }
            if let safeData = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: safeData, options: []) as? [String:String] {
                        if let image = json["message"] {
                            let task = URLSession.shared.dataTask(with: URL(string: image)!) { (data, urlResponse, error) in
                                if error != nil {
                                    print("error")
                                }
                                if let safeData = data {
                                    DispatchQueue.main.async {
                                        self.dogImageView.image = UIImage(data: safeData)
                                    }
                                }
                            }
                            task.resume()
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }


}

