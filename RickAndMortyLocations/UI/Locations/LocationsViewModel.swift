//
//  LocationsViewModel.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 11.05.2022.
//

import Foundation

class LocationsViewModel {
    
    var locations = [LocationsModel]()
    var pageCounter = 1
    
    func numbersOfRow() -> Int {
        return locations.count
    }
    
    func bindDatas(completion: @escaping ([LocationsModel]?) -> Void) {
        Network.shared.fetchLocations(page: pageCounter) { result in
            if let result = result {
                for i in result {
                    let item = LocationsModel.init(id: i.id!, name: i.name!, type: i.type!, dimension: i.dimension!)
                    self.locations.append(item)
                }
                completion(self.locations)
            } else {
                completion(nil)
            }
        }
    }
    
}
