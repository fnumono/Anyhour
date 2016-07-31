//
//  ShowMapViewController.swift
//  anyhour
//
//  Created by pramono wang on 7/30/16.
//  Copyright © 2016 fnu. All rights reserved.
//

import UIKit
import MapKit

class ShowMapViewController: UIViewController {

    var name = String()
    var state = String()
    var zipcode = String()
    var address = String()
    
     var myRoute : MKRoute!
    
    var addr = String()
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation: MKAnnotation!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    var directionsResponse = MKDirectionsResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addr = address + " " + state + " " + zipcode
        
        //let location: String = "10001 venice blvd, california, 90034"
        let location: String = addr
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
                let topResult: CLPlacemark = (placemarks?[0])!
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                var region: MKCoordinateRegion = self.mapView.region
                
                region.center.latitude = (placemark.location?.coordinate.latitude)!
                region.center.longitude = (placemark.location?.coordinate.longitude)!
                
                region.span = MKCoordinateSpanMake(0.5, 0.5)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(placemark)
                
                let request = MKDirectionsRequest()
                
                
                let latitude = 34.0232605
                let longitude = -118.4024097
                //request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059), addressDictionary: nil))
                //request.source =  CLLocation(latitude: 34.0493933, longitude: -118.2608527)
                
                    
                let initp = MKPlacemark(coordinate: CLLocationCoordinate2DMake(latitude, longitude), addressDictionary: nil)
                
                request.source = MKMapItem(placemark: initp)
                    
                print(request.source)
                request.destination = MKMapItem(placemark: placemark)
                print(request.destination)
                request.requestsAlternateRoutes = true
                request.transportType = .Automobile
                
                let directions = MKDirections(request: request)
                
                
                directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
                    guard response == nil else { return }
                    
                    self.mapView.mapType = .Satellite
                    
                    self.directionsResponse = response!
                    self.myRoute = self.directionsResponse.routes[0] 
                    self.mapView.addOverlay(self.myRoute.polyline)
                }
                /////////////////////////////////////////////////////////
                
            }
        })
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print (name)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
        if overlay is MKPolyline{
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.purpleColor()
            pr.lineWidth = 5
            return pr
        }
        
        return MKPolylineRenderer()
    
    }
    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
//        myLineRenderer.strokeColor = UIColor.blueColor()
//        myLineRenderer.lineWidth = 10
//        return myLineRenderer
//    
//    }


    
    
}
