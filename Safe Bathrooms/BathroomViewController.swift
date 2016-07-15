//
//  BathroomViewController.swift
//  UNC Gender Neutral Bathrooms
//
//  Created by Joseph Hooper on 7/5/16.
//  Copyright © 2016 josephdhooper. All rights reserved.
//  Insights from HackerNews.com helped to create the BathroomViewController

import UIKit
import RealmSwift
import QuartzCore

class BathroomViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var room: UITextField!
    @IBOutlet weak var floorNumber: UITextField!
    @IBOutlet weak var signageInfo: UITextField!
    @IBOutlet weak var roomDetails: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var availability: UIImageView!
    
    var image = try! Realm().objects(Bathrooms).sorted("image", ascending: true)
    
    var data: NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.frame = CGRectInset(imageView!.layer.frame, 0, 0 )
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.backgroundColor = UIColor.whiteColor()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        
        self.configureView()
        
    }
    var detailBathroom: Bathrooms? {
        didSet {
            self.configureView()
            
        }
    }
    
    func configureView() {
        if let detailBathroom = detailBathroom {
            if let name = name, room = room, floorNumber = floorNumber, signageInfo = signageInfo, roomDetails = roomDetails, availability = availability, imageView = imageView {
                name.text = detailBathroom.buildingName
                room.text = detailBathroom.roomNumber
                floorNumber.text = detailBathroom.floor
                signageInfo.text = detailBathroom.signageText
                roomDetails.text = detailBathroom.details
                availability.image = UIImage(named: detailBathroom.roomAvailability)
                
                switch detailBathroom.roomAvailability {
                case "Public":
                    availability.image = UIImage(named: "blue")
                case "Limited":
                    availability.image = UIImage(named: "orange")
                default:
                    availability.image = UIImage(named: "blue")
                }

                if let url = NSURL(string: detailBathroom.image) {
                    data = NSData(contentsOfURL:url)
                    if data != nil {
                        imageView.image = UIImage(data:data!)
                        
                
                    }
                }
                
            }
        }
    }
}