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
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    
    var keyboardIsShow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    func keyboardWillShow(notification:NSNotification) {
        
        //Nếu keyboard đã mơ rồi thì không thực hiện đẩy nữa
        if !keyboardIsShow {
            adjustingHeight(show: true, notification: notification)
            keyboardIsShow = true
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        if keyboardIsShow {
            adjustingHeight(show: false, notification: notification)
            keyboardIsShow = false
        }
        
    }
    
    // Thay đổi thông số của constrant bottomConstraint để nó nằm trên bàn phím ảo
    func adjustingHeight(show:Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let changeInHeight = (keyboardFrame.height) * (show ? 1 : -1)
        
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.btmConstraint.constant += changeInHeight
        })
    }
}

