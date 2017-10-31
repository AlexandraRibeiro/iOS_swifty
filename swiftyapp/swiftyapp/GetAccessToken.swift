//
//  GetAccessToken.swift
//  swiftyapp
//
//  Created by Alexandra RIBEIRO on 10/21/17.
//  Copyright © 2017 Alexandra RIBEIRO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetAccessToken {
    
    init() {
        verifToken()
    }
    
    
    func verifToken() {
        if UserDefaults.standard.value(forKey: Constants.accessToken) != nil {
            let token :String = UserDefaults.standard.value(forKey: Constants.accessToken)! as! String
            Constants.bearer = "Bearer " + token
        }
        Alamofire.request(
            Constants.URL_API + "oauth/token/info",
            method: .get,
            headers: ["Authorization" : Constants.bearer]
            )
                .responseJSON { response in
                    print("verifToken() ________________________________________")
                        
                    switch response.result {
                        case .success:
                            let statusCode = (response.response?.statusCode)!
                            switch statusCode {
                                case 200:
                                    print("This token is valid\n")
                                default:
                                    self.getTokenRequest()
                            }
                            print("status code: \(statusCode)")
                            print(response.result.value ?? 0)
                        case .failure(let error):
                            print("token not valid : \(error)")
                            self.getTokenRequest()
                    }

                    print("_____________________________________________________\n")

                }
    }
    
    
    
    func getTokenRequest() {
        Alamofire.request(
            Constants.URL_API + "oauth/token",
            method: .post,
            parameters: ["grant_type" : "client_credentials", "client_id" : Constants.CLIENT_ID, "client_secret" : Constants.CLIENT_SECRET]
            )
            .validate()
            .responseJSON { response in
                
                print("getTokenRequest() ___________________________________")
                
                switch response.result {
                    case .success:
                        let statusCode = (response.response?.statusCode)!
                        print("status code: \(statusCode)")
                    case .failure(let error):
                        print("error getTokenRequest() : \(error)")
                        return;
                }
                
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    print(swiftyJsonVar)
                    if let token = swiftyJsonVar["access_token"].string {
                        UserDefaults.standard.set(token, forKey: Constants.accessToken)
                        Constants.bearer = "Bearer " + token
                    }
                }
                
                print("_____________________________________________________")
                
        }
    }

}
