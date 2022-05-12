//
//  LocationsCell.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation

import UIKit
import SnapKit

class LocationCell: UITableViewCell {
    
    let cellContainer = UIView()
    var locationLabel = UILabel()
    let locationDescLabel = UILabel()
    let locationTypeContainer = UIView()
    let locationTypeLabel = UILabel()
    let locationIcon = UIImageView()
    
    enum LocationCellIdentifier: String {
        case identifier = "LocationCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(cellContainer)
        cellContainer.layer.cornerRadius = 8
        cellContainer.backgroundColor = UIColor(rgb: 0xF5F5F5)
        cellContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview()//.offset(24)
            make.right.equalToSuperview()//.offset(-24)
        }
        
        cellContainer.addSubview(locationIcon)
        locationIcon.image = UIImage(named: "locationIcon")
        locationIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19.5)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(16)
        }
        
        cellContainer.addSubview(locationTypeContainer)
        locationTypeContainer.backgroundColor = UIColor(rgb: 0xB2FFBF)
        locationTypeContainer.layer.cornerRadius = 4
        locationTypeContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        cellContainer.addSubview(locationLabel)
        locationLabel.font = UIFont(name: "Inter-Bold", size: 16)
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalTo(locationIcon.snp.right).offset(8)
            make.right.equalTo(locationTypeContainer.snp.left).offset(-8)
        }
        
        cellContainer.addSubview(locationDescLabel)
        locationDescLabel.font = UIFont(name: "Inter-Regular", size: 14)
        locationDescLabel.textColor = UIColor(rgb: 0x6E6E6E)
        locationDescLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        locationTypeContainer.addSubview(locationTypeLabel)
        locationTypeLabel.font = UIFont(name: "Inter-Bold", size: 12)
        locationTypeLabel.layer.opacity = 0.7
        locationTypeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
}

