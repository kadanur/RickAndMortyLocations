//
//  HomeViewController.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit
import SnapKit

class LocationsViewController: UIViewController {
    
    var titleLabel = UILabel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home View Controller loaded.")
        setup()
        setupUI()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.LocationCellIdentifier.identifier.rawValue)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        titleLabel.text = "Location"
        titleLabel.font = UIFont.init(name: "OpenSans-Bold", size: 15)
        titleLabel.font = UIFont(name: "Inter-Bold", size: 24)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.left.equalToSuperview().offset(24)
        }
        
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.LocationCellIdentifier.identifier.rawValue) as! LocationCell
        cell.locationLabel.text = "Earth (C-137)"
        cell.locationDescLabel.text = "Dimension C-137"
        cell.locationTypeLabel.text = "Planet"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}
