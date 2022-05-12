//
//  UIIMageView+Extension.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 12.05.2022.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    }
}
