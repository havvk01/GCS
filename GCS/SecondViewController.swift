//
//  SecondViewController.swift
//  GCS
//
//  Created by Slava Havvk on 14.09.2022.
//

import UIKit

class SecondViewController:UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            fetchImage()
        delay(3) {
            self.loginAlert()
        }
            

    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Registration", message: "Push login and password", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "cancel", style: .default)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Login"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Password"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://www.dailyartmagazine.com/wp-content/uploads/2020/08/Henriette_ronner-knip_cat_nap-scaled-e1652946286135-1536x971.jpeg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
            
        }
        
        

        }
}
