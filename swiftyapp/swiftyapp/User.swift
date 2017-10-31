//
//  User.swift
//  swiftyapp
//
//  Created by Alexandra RIBEIRO on 10/25/17.
//  Copyright © 2017 Alexandra RIBEIRO. All rights reserved.
//

import Foundation

struct User {
    static var name : String = ""
    static var isStaff : Bool = false
    static var phone : String = "(no phone)"
    static var email : String = ""
    static var image_url : String = Constants.imageDefault
    static var correction_point : Int = 0
    static var wallet : Int = 0
    static var progress : Float = 0.0
    static var level : Float = 0.0
    static var skills : Array<Any> = []
    static var projects : Array<Any> = []
}
