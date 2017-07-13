//
//  Places.swift
//  facebookLogin
//
//  Created by mac on 6/1/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import MapKit




class Places: NSObject, MKAnnotation{
    
    var type:String!
    var place:String!
    var coordinate: CLLocationCoordinate2D
    var latitude:Double!
    var longitude:Double!
    
    init(type: String,place: String, coordinate: CLLocationCoordinate2D, latitude: Double,longitude: Double){
        self.type = type;
        self.place = place;
        self.coordinate = coordinate;
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
