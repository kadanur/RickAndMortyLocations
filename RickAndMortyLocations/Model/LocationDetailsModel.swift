//
//  LocationDetailsModel.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 12.05.2022.
//

import Foundation

struct LocationDetailsModel {
    var name: String
    var dimension: String
    var type: String
    var residents: [ResidentsModel]
}

struct ResidentsModel {
    var name: String
    var image: String
}
