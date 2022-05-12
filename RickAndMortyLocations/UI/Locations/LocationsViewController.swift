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
    var viewModel = LocationsViewModel()
    var titleLabel = UILabel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home View Controller loaded.")
        setup()
        setupUI()
    }
    
    func getData() {
        viewModel.bindDatas { result in
            if let result = result {
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error", message: ("Fetching data error."), preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated:true, completion: nil)
            }
        }
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.LocationCellIdentifier.identifier.rawValue)
        getData()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        titleLabel.text = "Locations"
        titleLabel.font = UIFont.init(name: "OpenSans-Bold", size: 15)
        titleLabel.font = UIFont(name: "Inter-Bold", size: 24)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.left.equalToSuperview().offset(24)
        }
        
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
    }
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.LocationCellIdentifier.identifier.rawValue) as! LocationCell
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        let location = viewModel.locations[indexPath.row]
        cell.locationLabel.text = location.name
        cell.locationDescLabel.text = location.dimension
        cell.locationTypeLabel.text = location.type
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DetailsViewModel.id = viewModel.locations[indexPath.row].id
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .custom
        detailVC.transitioningDelegate = self
        present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = viewModel.numbersOfRow() - 1
        if indexPath.row == lastIndex {
            viewModel.pageCounter += 1
            print(viewModel.pageCounter)
            getData()
        }
    }
}

extension LocationsViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
