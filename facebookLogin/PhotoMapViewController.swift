//
//  PhotoMapViewController.swift
//  facebookLogin
//
//  Created by mac on 4/10/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, DataProtocol, CLLocationManagerDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cameraButton: UIButton!
    
    var listPlaces:[Places]? = []
    //    let data = DataToilets()
    let data = DataPlaces()
    var pickedImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.askForDataWith(self)

        
        
        let initialLocation = CLLocation(latitude: 34.049993, longitude: -118.246038)
        let regionRadius: CLLocationDistance = 500000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRetrieveData(_ places: [Places]) {
        self.mapView.addAnnotations(places)
    }
    
    
    
//    @IBAction func cameraTapped(_ sender: Any) {
//        
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            vc.sourceType = .camera
//        } else {
//            vc.sourceType = .photoLibrary
//        }
//        
//        self.present(vc, animated: true, completion: nil)
//        
//        
//    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.pickedImage = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "tagSegue", sender: nil)
        
        //self.present(locationVC, animated:  true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let locationsViewController = segue.destination as! LocationsViewController
//        locationsViewController.delegate = self
//    }
//    
    
}
