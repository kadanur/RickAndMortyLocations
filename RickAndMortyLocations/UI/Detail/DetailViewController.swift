//
//  DetailViewController.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    var viewModel = DetailsViewModel()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let indicatorView = UIView()
    let typeContainer = UIView()
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let dimensionLabel = UILabel()
    let charactersLabel = UILabel()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailVC loaded.")
        view.backgroundColor = .white
        setup()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    func getData() {
        viewModel.bindDatas { result in
            if let result = result {
                self.titleLabel.text = result.name
                self.dimensionLabel.text = result.dimension
                self.typeLabel.text = result.type
                self.collectionView.reloadData()
            }
        }
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.CharacterCellIdentifier.identifier.rawValue)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 138,height: 161)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        getData()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    func setupUI() {
        view.addSubview(indicatorView)
        indicatorView.backgroundColor = UIColor(rgb: 0xEBEBEB)
        indicatorView.layer.cornerRadius = 2
        indicatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(4)
            make.width.equalTo(32)
        }
        
        view.addSubview(typeContainer)
        typeContainer.backgroundColor = UIColor(rgb: 0xB2FFBF)
        typeContainer.layer.cornerRadius = 4
        typeContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.left.equalToSuperview().offset(24)
        }
        
        typeContainer.addSubview(typeLabel)
        typeLabel.text = "Planet"
        typeLabel.font = UIFont(name: "Inter-Bold", size: 12)
        typeLabel.layer.opacity = 0.7
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(-8)
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = ""
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.font = UIFont(name: "Inter-Bold", size: 24)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(typeContainer.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(dimensionLabel)
        dimensionLabel.text = ""
        dimensionLabel.font = UIFont(name: "Inter-Regular", size: 14)
        dimensionLabel.textColor = UIColor(rgb: 0x6E6E6E)
        dimensionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(charactersLabel)
        charactersLabel.text = "Characters"
        charactersLabel.font = UIFont(name: "Inter-Bold", size: 24)
        charactersLabel.snp.makeConstraints { make in
            make.top.equalTo(dimensionLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(charactersLabel.snp.bottom).offset(16)
            make.left.equalTo(24)
            make.right.equalToSuperview()
            make.height.equalTo(161)
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbersOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.CharacterCellIdentifier.identifier.rawValue, for: indexPath) as! CharacterCell
        let data = viewModel.location.residents[indexPath.row]
        cell.characterNameLabel.text = data.name
        cell.characterImage.kf.setImage(with: viewModel.imageUrl(urlString: data.image))
        return cell
    }
}

