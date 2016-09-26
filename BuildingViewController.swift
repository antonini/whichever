//
//  BuildingViewController.swift
//  whichever
//
//  Created by Joseph Hooper on 9/22/16.
//  Copyright © 2016 josephdhooper. All rights reserved.
//

import UIKit
import RealmSwift

class BuildingViewController: UITableViewController {
    
    var bathrooms = try! Realm().objects(Bathrooms).sorted("buildingName", ascending: true)
    var image = try! Realm().objects(Bathrooms).sorted("image", ascending: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func unwindToMap(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToBuilding(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showDetail") {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! BathroomViewController
            var bathroom: Bathrooms!
            let indexPath = tableView.indexPathForSelectedRow
            bathroom = bathrooms[indexPath!.row]
            controller.detailBathroom = bathroom
            
        }
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bathrooms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell") as! BuildingCell
        
        let bathroom: Bathrooms
        bathroom = bathrooms[indexPath.row]
        cell.titleLabel.text = bathroom.buildingName
        cell.subtitleLabel.text = ("Room Number: \(bathroom.roomNumber)")
        
        switch bathroom.roomAvailability {
        case "Public":
            cell.dbImage.image = UIImage(named: "blue")
        case "Limited":
            cell.dbImage.image = UIImage(named: "orange")
        default:
            cell.dbImage.image = UIImage(named: "blue")
        }
        
        return cell
    }
    
    
}