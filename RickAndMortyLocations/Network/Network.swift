//
//  Network.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 11.05.2022.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
    
    func fetchLocations(page: Int, completion: @escaping ([LocationDetail]?) -> Void){
        Network.shared.apollo.fetch(query: GetLocationsQuery(page: page)) { response in
            do {
                let data = try response.get().data
                if let result = data?.locations?.results?.compactMap({$0?.fragments.locationDetail}) {
                    completion(result)
                }
            } catch {
                completion(nil)
                print("FETCH LOCATIONS ERROR ->")
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchOneLocation(id: String, completion: @escaping (OneLocationDetail?) -> Void) {
        Network.shared.apollo.fetch(query: GetLocationQuery(id: id)) { response in
            do {
                let data = try response.get().data
                if let result = data?.location?.fragments.oneLocationDetail {
                    completion(result)
                    print(result.residents)
                }
            } catch {
                completion(nil)
                print("FETCH ONE LOCATION ERROR ->")
                print(error.localizedDescription)
            }
        }
    }
}


