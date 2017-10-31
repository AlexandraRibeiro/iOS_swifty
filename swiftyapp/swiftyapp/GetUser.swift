//
//  GetUser.swift
//  swiftyapp
//
//  Created by Alexandra RIBEIRO on 10/22/17.
//  Copyright © 2017 Alexandra RIBEIRO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetUser {
    
    func getUserRequest(valid: @escaping (_ result: Bool)->()) {
        
        Alamofire.request(
            Constants.URL_API + "v2/users/" + Constants.login,
            method: .get,
            headers: ["Authorization" : Constants.bearer]
            )
            .validate()
            .responseJSON { response in
                
                print("\ngetUserRequest() ___________________________________")
                
                switch response.result {
                    case .success:
                        let statusCode = (response.response?.statusCode)!
                        print("status code: \(statusCode)")
                        switch statusCode {
                            case 200:
                                valid(true)
                            default:
                                valid(false)
                                print("_____________________________________________________\n")
                        }
                    case .failure(let error):
                        print("error getUserRequest() : \(error)")
                        print("_____________________________________________________\n")
                        valid(false)
                }
                
                if response.result.value != nil {
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    if let url = swiftyJsonVar["image_url"].string {
                        User.image_url = url
                        if User.image_url == "https://cdn.intra.42.fr/images/default.png" {
                            User.image_url = Constants.imageDefault
                        }
                    }
                    if let displayname = swiftyJsonVar["displayname"].string {
                        User.name = displayname
                    }
                    if let staff = swiftyJsonVar["staff?"].bool {
                        User.isStaff = staff
                    }
                    if let tel = swiftyJsonVar["phone"].string {
                        User.phone = tel
                    }
                    if let mail = swiftyJsonVar["email"].string {
                        User.email = mail
                    }
                    if let money = swiftyJsonVar["wallet"].int {
                        User.wallet = money
                    }
                    if let point = swiftyJsonVar["correction_point"].int {
                        User.correction_point = point
                    }
                    
                    if let cursus = swiftyJsonVar["cursus_users"][0]["level"].double {
                        User.level = Float(cursus)
                        let f = Float(cursus.truncatingRemainder(dividingBy: 1))
                        User.progress = f
                    }
                    if let skills = swiftyJsonVar["cursus_users"][0]["skills"].array {
                        User.skills = skills
                    }
                    if let proj = swiftyJsonVar["projects_users"].array {
                        User.projects = proj
                    }
                    

                }
                
                print("_____________________________________________________\n")
            }
    }
    
    
}
