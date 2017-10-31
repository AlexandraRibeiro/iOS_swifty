//
//  ViewController2.swift
//  swiftyapp
//
//  Created by Alexandra RIBEIRO on 10/22/17.
//  Copyright © 2017 Alexandra RIBEIRO. All rights reserved.
//

import UIKit
import SwiftyJSON

extension UIImageView{
    
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
    
}

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var skillsActivated : Bool = false
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var walletLabel: UILabel!
    
    @IBOutlet weak var corrLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var skillsLabel: UILabel!

    @IBOutlet weak var projectLabel: UILabel!
    
    
    @IBAction func skillsButton(_ sender: UIButton) {
        middleView.backgroundColor = UIColor(red: 27.0/255.0, green: 202.0/255.0, blue: 142.0/255.0, alpha: 1.0)
        skillsLabel.textColor = UIColor(red: 2.0/255.0, green: 184.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        projectLabel.textColor = UIColor.gray
        tableView.isHidden = false
        skillsActivated = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func projectButton(_ sender: Any) {
       middleView.backgroundColor = UIColor(red: 27.0/255.0, green: 202.0/255.0, blue: 142.0/255.0, alpha: 1.0)
        projectLabel.textColor = UIColor(red: 2.0/255.0, green: 184.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        skillsLabel.textColor = UIColor.gray
        tableView.isHidden = false
        skillsActivated = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if skillsActivated == true {
            return User.skills.count
        } else {
            return User.projects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable") as? view2TableViewCell
        if skillsActivated == true {
            let jsonvar = JSON(User.skills)
            cell?.name_slugLabel.text = jsonvar[indexPath.row]["name"].string
            cell?.notationLabel.text = "Level \(jsonvar[indexPath.row]["level"].float!)"
            cell?.validateLabel.text = ""
        } else {
            let jsonvar = JSON(User.projects)
            cell?.name_slugLabel.text = jsonvar[indexPath.row]["project"]["slug"].string
            if let final = jsonvar[indexPath.row]["final_mark"].int {
                cell?.notationLabel.text = "Final mark \(final)"
            } else {
                cell?.notationLabel.text = "Final mark (not defined)"
            }
            if let validate = jsonvar[indexPath.row]["validated?"].bool {
                if validate == true {
                    cell?.validateLabel.text = "✓"
                    cell?.validateLabel.textColor = UIColor(red: 2.0/255.0, green: 184.0/255.0, blue: 143.0/255.0, alpha: 1.0)
                }
                else {
                    cell?.validateLabel.text = "X"
                    cell?.validateLabel.textColor = UIColor(red: 255.0/255.0, green: 82.0/255.0, blue: 41.0/255.0, alpha: 1.0)
                }
            } else {
                cell?.validateLabel.text = "-"
                cell?.validateLabel.textColor = UIColor.gray
            }
        }

        return cell!
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skillsLabel.textColor = UIColor.lightGray
        projectLabel.textColor = UIColor.lightGray
        
        
        topView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back3"))
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back3"))
        middleView.backgroundColor = UIColor.lightGray
        
        
        loginLabel.text = Constants.login
        nameLabel.text = User.name
        if User.isStaff == true {
            gradeLabel.text = "Staff"
        } else {
            gradeLabel.text = "Student"
        }
        phoneLabel.text = User.phone
        mailLabel.text = User.email
        walletLabel.text = "\(User.wallet) ₳"
        corrLabel.text = "\(User.correction_point) correction points"
        
        levelLabel.text = "\(User.level)"
        progressBar.progress = User.progress
        
        
        loginLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let urlString = User.image_url
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
                self.imageView.asCircle()
            }
            }.resume()
        
        tableView.isHidden = true
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//    
    
    

}
