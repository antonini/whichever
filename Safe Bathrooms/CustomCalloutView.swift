//
//  CustomCalloutView.swift
//  whichever
//
//  Created by Joseph Hooper on 7/29/16.
//  Copyright © 2016 josephdhooper. All rights reserved.
//

import UIKit
import Mapbox

class CustomCalloutView: UIView, MGLCalloutView {
    
    enum PointType {
        case FirstPointType
        case SecondPointType
        case ThirdPointType
        
        var imageName: String {
            get {
                /*
                 You can implement whatever logic you'd like here, but if
                 you follow the pattern of "FirstPointType.png" for your
                 images, defaulting to the case name is probably easiest.
                 */
                return String(self)
            }
        }
        
        var image: UIImage? {
            get {
                return UIImage(named: imageName)
            }
        }
        
    }
    
}