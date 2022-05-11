//
//  CharacterCell.swift
//  RickAndMortyLocations
//
//  Created by M Kaan Adanur on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit

class CharacterCell: UICollectionViewCell {
    let characterImage = UIImageView()
    let characterNameLabel = UILabel()
    
    enum CharacterCellIdentifier: String {
        case identifier = "CharacterCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(characterImage)
        addSubview(characterNameLabel)
      
        characterImage.backgroundColor = .gray
        characterImage.image = UIImage(named: "characterImage")
        characterImage.layer.cornerRadius = 8
        characterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.width.equalTo(138)
        }

        characterNameLabel.text = "Char"
        characterNameLabel.font = UIFont(name: "Inter-Bold", size: 12)
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(8)
            make.left.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
