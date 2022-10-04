//
//  Authentication.swift
//  
//
//  Created by Catalin Palade on 04/10/2022.
//

import Foundation
import UIKit

public class Authentication {
    
    static private(set) var brandTitle: String = "Authentication Sample App" // default title
    static private(set) var brandColor: UIColor = UIColor.green // default color
    
    private init() { }
    
    public static func inject(
        brandTitle: String,
        brandColor: UIColor
    ) {
        Authentication.brandTitle = brandTitle
        Authentication.brandColor = brandColor
    }
}
