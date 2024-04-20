//
//  FilterCollectionViewCell.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let filterButton = UIButton()
    private var filterType: String = ""
    private var filterSelected = false
     
    static let reuse = "FilterCollectionViewCellReuse"
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFilterButton()
        filterButton.isUserInteractionEnabled = false 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(filter: Filter) {
        self.filterType = filter.type
        if filter.selected {
            self.filterSelected = true
            filterButton.setTitleColor(.white, for: .normal)
            filterButton.backgroundColor = UIColor(red: 0xFF / 255.0, green: 0xAA / 255.0, blue: 0x33 / 255.0, alpha: 1.0)
            
        } else {
            filterButton.setTitleColor(.black, for: .normal)
            filterButton.backgroundColor = UIColor(red: 0xF0 / 255.0, green: 0xF0 / 255.0, blue: 0xF0 / 255.0, alpha: 1.0)
        }
        
        
        filterButton.setTitle(self.filterType, for: .normal)
    }
    
    private func setupFilterButton() {
    
        filterButton.layer.cornerRadius = 16

        contentView.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }

}
