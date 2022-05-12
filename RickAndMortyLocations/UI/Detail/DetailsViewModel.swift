//
//  DetailsViewModel.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 12.05.2022.
//

import Foundation

class DetailsViewModel{
    static var id = ""
    var location = LocationDetailsModel(name: "", dimension: "", type: "", residents: [])
    
    func numbersOfItems() -> Int {
        return location.residents.count
    }
    
    func imageUrl(urlString: String) -> URL{
        return (URL(string: urlString)!)
    }
    
    func bindDatas(completion: @escaping (LocationDetailsModel?) -> Void) {
        Network.shared.fetchOneLocation(id: DetailsViewModel.id) { result in
            if let result = result {
                self.location.name = result.name!
                self.location.dimension = result.dimension!
                self.location.type = result.type!
                
                for i in result.residents {
                    let item = ResidentsModel(name: (i?.name)!, image: (i?.image)!)
                    self.location.residents.append(item)
                }
                completion(self.location)
            }
        }
    }
}
