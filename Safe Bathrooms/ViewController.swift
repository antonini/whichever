//
//  InstructionsViewController.swift
//  whichever
//
//  Created by Joseph Hooper on 7/13/16.
//  Copyright © 2016 josephdhooper. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var roundedButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedButton.layer.cornerRadius = 4
        
        //Initiate session to call REST GET/API
        let requestURL: NSURL = NSURL(string: "https://gist.githubusercontent.com/josephdhooper/d4c305e57670907874ee72dad77cdc37/raw/37d6a022371a77e9cd553c3c8e15c287866e5981/locations.json")!
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        
        //Create GET call
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            //Prepare for potential errors: According to w3schools.com -> http://www.w3schools.com/tags/ref_httpmessages.asp <- the 200 status code indicates an OK transfer.
            let HTTPResponse = response as! NSHTTPURLResponse
            let statusCode = HTTPResponse.statusCode
            if (statusCode == 200) {
                print("Files from datastore downloaded successfully.")
                
                //Begin error handleing with do-catch statement
                do {
                    
                    // For JSON response data deserialization
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    let locations = (json as! NSDictionary)["locations"] as! [NSDictionary]
                    
                    
                    //Set up to write files to Realm mobile database
                    let realm = try! Realm()
                    try! realm.write {
                        
                        // Save the object in each element of the array
                        for location in locations {
                            
                            //Write files to to Realm mobile database
                            realm.create(Bathrooms.self, value: location, update: true)
                            
                        }
                        
                        //Print files to defualt location on hardrive: Users/username/Library/Developer/CoreSimulator/Devices/location number/data/Containers/Data/Application/location number/Documents/default.realm
                        print(Realm.Configuration.defaultConfiguration.fileURL!)
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        
        //Start task
        task.resume()
        

    }
    
    @IBAction func loadMap(sender: AnyObject) {
        self.performSegueWithIdentifier("mapView", sender: nil)
        activityIndicator.startAnimating()
    }
}
