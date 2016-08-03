//
//  MapViewController.swift
//  CollegeProfileBuilder
//
//  Created by Diva Harsoor on 7/28/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = data
        textFieldShouldReturn(textField)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!, completionHandler:
            {(placemarks, error) in
                if error != nil {
                    print (error)
                }
                else {
                    let placemark = placemarks!.first as CLPlacemark!
                    let center = placemark.location!.coordinate
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    self.displayMap(center, span: span, pinTitle: textField.text!)
                    
                    let alert = UIAlertController(title: "Locations Found", message: "Select the most accurate location.", preferredStyle: .ActionSheet)
                    let count = placemarks!.count <= 10 ? placemarks!.count : 10
                    for i in 0..<count {
                        alert.addAction(UIAlertAction(title: placemarks![i].name, style: .Default, handler: { (UIAlertAction) in
                            let placemark = placemarks![i] as CLPlacemark!
                            let center = placemark.location!.coordinate
                            let span = MKCoordinateSpanMake(0.1, 0.1)
                            self.displayMap(center, span: span, pinTitle: textField.text!)
                        }))
                        }
                    alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        })
        textField.resignFirstResponder()
        return true
    }
    
    func displayMap(center: CLLocationCoordinate2D, span: MKCoordinateSpan, pinTitle: String) {
        let region = MKCoordinateRegionMake(center, span)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = pinTitle
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }
}