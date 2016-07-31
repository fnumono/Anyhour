//
//  SearchMapViewController.swift
//  anyhour
//
//  Created by pramono wang on 7/30/16.
//  Copyright © 2016 fnu. All rights reserved.
//

import UIKit
import MapKit

class SearchMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var searchMap: MKMapView!
    
    let searchRadius: CLLocationDistance = 2000
    //let initialLocation = CLLocationManager()
    
    //34.0493933,-118.2608527
    var currentLocation = CLLocation(latitude: 34.0493933, longitude: -118.2608527)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        
//        initialLocation.delegate = self
//        initialLocation.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        initialLocation.requestWhenInUseAuthorization()
//        initialLocation.startMonitoringSignificantLocationChanges()
//
//        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
//            CLLocationManager.authorizationStatus() == kclauthori){
        if (CLLocationManager.locationServicesEnabled())
        {
            //currentLocation = initialLocation.location!
            
            
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, searchRadius * 2, searchRadius * 2)
            searchMap.setRegion(coordinateRegion, animated: true)
            
            searchInMap()
            
            print("hello")
            
        }
        else
        {
            print("location services has not been enabled yet")
        }
        
        
    }
    
    
    func searchInMap () {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Restaurants"
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        request.region = searchMap.region
        
        
        let search = MKLocalSearch(request: request)
        
        //search.startWithCompletionHandler()
        
        search.startWithCompletionHandler { response, error in
            guard let response = response else {
                print("There was an error searching for: \(request.naturalLanguageQuery) error: \(error)")
                return
            }
            
            print (response.mapItems.count)
            
            for
                item in response.mapItems {
                print("Item name = \(item.name)")
                print("Latitude = \(item.placemark.location!.coordinate.latitude)")
                print("Longitude = \(item.placemark.location!.coordinate.longitude)")
                self.addPinToMapView(item.name!, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
    }
    }
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title)
        
        searchMap.addAnnotation(annotation)
    }
    
}
