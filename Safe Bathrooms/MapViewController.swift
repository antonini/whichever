//
//  MapViewController.swift
//  whichever
//
//  Created by Joseph Hooper on 5/23/16.
//  Copyright © 2016 josephdhooper. All rights reserved.
//
//
import UIKit
import Mapbox
import CoreLocation
import RealmSwift

let MapboxAccessToken = "pk.eyJ1IjoiamRob29wZXIiLCJhIjoiY2ltNWZibjYxMDFrMHU0bTY0ZmhkbDN1ZiJ9.QfG6ts2mzoZIg13N-JqMSQ"

class MapViewController: UIViewController, MGLMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MGLMapView!
    var annotations = [MGLPointAnnotation]()
    var bathrooms = try! Realm().objects(Bathrooms)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateMap()
        self.mapView.userTrackingMode  = MGLUserTrackingMode.FollowWithHeading
        
    }
    
    @IBAction func searchButton(sender: AnyObject) {
        performSegueWithIdentifier("about", sender: sender)
        
    }
    
    func populateMap() {
        
        bathrooms = try! Realm().objects(Bathrooms)
        
        for bathroom in bathrooms {
            let annotation = MGLPointAnnotation()
            let coordinate = CLLocationCoordinate2DMake(bathroom.latitude, bathroom.longitude);
            annotation.coordinate = coordinate
            annotation.title = bathroom.buildingName
            annotation.subtitle = "Availability: \(bathroom.buildingAvailability)"
            
            annotations.append(annotation)
            mapView.delegate = self
            mapView.addAnnotations(annotations)
        }
    }
    
    @IBAction func unwindToMap(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func centerToUserLocationTapped(sender: AnyObject) {
        centerToUsersLocation()
    }
    
    func centerToUsersLocation() {
        let center = mapView.userLocation!.coordinate
        mapView.setCenterCoordinate(center, zoomLevel: 15, animated: true)
    }
    
    
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        return nil
    }
    
    func mapView(mapView: MGLMapView, leftCalloutAccessoryViewForAnnotation annotation: MGLAnnotation) -> UIView? {
        
        if (annotation.subtitle! == "Availability: Public"){
        
            let imageView = UIImageView(image: UIImage(named: "blueNote")!)
            self.view.addSubview(imageView)
            return imageView
            
        }
        
        if (annotation.subtitle! == "Availability: Limited"){
            let imageView = UIImageView(image: UIImage(named: "orangeNote")!)
            self.view.addSubview(imageView)
            return imageView
            
        }
        
        if (annotation.subtitle! == "Availability: Limited and Public"){
            let imageView = UIImageView(image: UIImage(named: "darkblueNote")!)
            self.view.addSubview(imageView)
            return imageView
        }
        
        return nil
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    
}