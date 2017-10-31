//
//  ViewController.swift
//  swiftyapp
//
//  Created by Alexandra RIBEIRO on 10/19/17.
//  Copyright © 2017 Alexandra RIBEIRO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let instanceGetUser : GetUser = GetUser()

    @IBOutlet weak var errorLabel: UILabel!

    @IBOutlet weak var textField: UITextField!

    @IBAction func searchButton(_ sender: UIButton) {
    
        _ = GetAccessToken.init()
        
        let disableMyButton = sender
        disableMyButton.isEnabled = false
        
        Constants.login = textField.text!
        if Constants.login == "" {
            errorLabel.text = "error : empty field"
            disableMyButton.isEnabled = true
            return
        }
       
        instanceGetUser.getUserRequest { (result) in
            if result == true {
                self.performSegue(withIdentifier: "segueView", sender: self)
                disableMyButton.isEnabled = true
            } else {
                self.errorLabel.text = "error : not a valid login"
                disableMyButton.isEnabled = true
            }
        }
        
    }
    
    @IBOutlet weak var logo42: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.text = ""
        
        let myColor = UIColor(red: 27.0/255.0, green: 202.0/255.0, blue: 142.0/255.0, alpha: 1.0)
        textField.layer.borderColor = myColor.cgColor
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1.5
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back3"))
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        textField.text = ""
        errorLabel.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        User.name = ""
        User.isStaff = false
        User.phone = "(no phone)"
        User.email = "(no email)"
        User.image_url = Constants.imageDefault
        User.correction_point = 0
        User.progress  = 0.0
        User.level = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        super.viewDidAppear(animated)
//        
//        AppDelegate.AppUtility.lockOrientation(.portrait)
//        
//    }
//    
//    
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        
//        super.viewWillDisappear(animated)
//        
//        AppDelegate.AppUtility.lockOrientation(.all)
//        
//    }
    
    
    

}

