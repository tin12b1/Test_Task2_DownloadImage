//
//  ViewController.swift
//  Test_Task2_DownloadImage
//
//  Created by cntt17 on 7/5/17.
//  Copyright © 2017 cntt17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var urlTextField1: UITextField!
    @IBOutlet weak var urlTextField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func downloadButtonClick(_ sender: Any) {
        if (urlTextField1?.text == "" || urlTextField2?.text == "") {
            let alert = UIAlertController(title: "Error", message: "You must input url", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else {
        let url1 = urlTextField1?.text
        let url2 = urlTextField2?.text
        fetchImage(url1!, url2!)
        }
    }
    
    func fetchImage(_ url1: String,_ url2: String) {
        let url1 = URL(string: url1)
        (URLSession(configuration: .default)).dataTask(with: url1!, completionHandler: {(dataImage, response, error) in
            if let data = dataImage {
                DispatchQueue.main.async() { () -> Void in
                    self.imageView1?.image = UIImage(data: data)
                }
                
            }
        }).resume()
        
        let url2 = URL(string: url2)
        (URLSession(configuration: .default)).dataTask(with: url2!, completionHandler: {(dataImage, response, error) in
            if let data = dataImage {
                DispatchQueue.main.async() { () -> Void in
                    self.imageView2?.image = UIImage(data: data)
                }
                
            }
        }).resume()
        
    }
}

