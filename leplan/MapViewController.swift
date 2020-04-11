//
//  MapViewController.swift
//  leplan
//
//  Created by MayuUenishi on 2020/04/10.
//  Copyright © 2020 MayuUenishi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var spots = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
   /* @IBAction func labeiaction(_ sender: Any) {
        print(a)
    }*/
    @IBOutlet weak var Map: MKMapView!
    
    func pinsetting(sight : String){
        let geocorder = CLGeocoder()
        geocorder.geocodeAddressString(sight, completionHandler: {(placemarks,error) in
            
            if let unwrappedPlacemarks = placemarks{
                if let firstPlacemark = unwrappedPlacemarks.first{
                    if let location = firstPlacemark.location{
                        
                    }
                }
            }
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


