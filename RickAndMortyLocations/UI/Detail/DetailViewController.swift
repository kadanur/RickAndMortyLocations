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
    let typeContainer = UIView()
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let dimensionLabel = UILabel()
    let charactersLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailVC loaded.")
        view.backgroundColor = .white
        setup()
        setupUI()
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
    }
    
    func setupUI() {
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

