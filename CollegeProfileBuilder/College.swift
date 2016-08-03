//
//  College.swift
//  CollegeProfileBuilder
//
//  Created by Diva Harsoor on 7/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class College: NSObject {
    
    var name = ""
    var location = ""
    var enrollment = 0
    var website = "https://google.com"
    var image = UIImage(named: "Default")
    
    convenience init(name: String, location: String, enrollment: Int, website: String, image: UIImage) {
        self.init()
        self.name = name
        self.location = location
        self.enrollment = enrollment
        self.website = website
        self.image = image
    }
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
}
