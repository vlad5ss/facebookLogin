//
//  DataPlaces.swift
//  facebookLogin
//
//  Created by mac on 6/1/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit

class DataPlaces{
    var listData:[Places]! = []
    var delegate : DataProtocol?
    
    func askForDataWith(_ delegate : DataProtocol){
        self.delegate = delegate
        Alamofire.request("https://aqueous-depths-77407.herokuapp.com/earthquakes.json", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for counter in json.arrayValue {
                    let lat = counter["latitude"].doubleValue
                    let long = counter["longitude"].doubleValue
                    let name = counter["place"].stringValue
                    let type = counter["usgs_ident"].stringValue
                    let coordinate = CLLocationCoordinate2D(latitude : lat, longitude : long)
                    
                    let t  = Places(type: type, place: name, coordinate: coordinate ,latitude:lat,longitude:long)
                    
                    
                    self.listData.append(t)
                    print("Location \(self.listData)")
                }
                if let d = self.delegate{
                    d.didRetrieveData(self.listData)
                }
                
            case .failure(let error):
                print(error)
                //    break
                
            }
        }
    }
    
}


protocol DataProtocol{
    func didRetrieveData(_ places: [Places])
}
