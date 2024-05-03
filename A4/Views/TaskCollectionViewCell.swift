//
//  TaskCollectionViewCell.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties (view)

    private let taskLabel = UILabel()
    
    static let reuse = "TaskCollectionViewCellReuse"
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a4.offWhite
        layer.cornerRadius = 16
        
        setupTaskLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(task: Task) {
        taskLabel.text = task.title
    }
    
    private func setupTaskLabel() {
        taskLabel.textColor = .label
        taskLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        taskLabel.numberOfLines = 1

        contentView.addSubview(taskLabel)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    

}
