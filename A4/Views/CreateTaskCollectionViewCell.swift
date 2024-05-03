//
//  CreateTaskCollectionViewCell.swift
//  A3
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

protocol CreateTaskDelegate: AnyObject {
    func didAddTask()
}

class CreateTaskCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let addButton = UIButton()
    private let taskTextField = UITextField()
    private let categoryTextField = UITextField()
    
    // MARK: - Properties (data)
    
    static let reuse: String = "CreateTaskCollectionViewCellReuse"
    weak var delegate: CreateTaskDelegate?

    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a4.offWhite

        layer.cornerRadius = 16
        
        setupTaskTextField()
        setupCategoryTextField()
        setupAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up Views
    
    private func setupTaskTextField() {
        taskTextField.placeholder = "Enter a task"
        taskTextField.font = .systemFont(ofSize: 16)
        
        contentView.addSubview(taskTextField)
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let sidePadding: CGFloat = 24
        NSLayoutConstraint.activate([
            taskTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            taskTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sidePadding),
            taskTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sidePadding)
        ])
    }
    
    private func setupCategoryTextField() {
        categoryTextField.placeholder = "Enter category"
        categoryTextField.font = .systemFont(ofSize: 16)
        
        contentView.addSubview(categoryTextField)
        categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryTextField.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 16),
            categoryTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            categoryTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupAddButton() {
        addButton.backgroundColor = UIColor(red: 0xCA / 255.0, green: 0x42 / 255.0, blue: 0x38 / 255.0, alpha: 1.0)
        addButton.layer.cornerRadius = 4
        addButton.setTitle("Add Task", for: .normal)
        addButton.setTitleColor(UIColor.a4.offWhite, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)

        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: categoryTextField.bottomAnchor, constant: 32),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addButton.widthAnchor.constraint(equalToConstant: 96),
            addButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    // MARK: - Button Helpers
    
    @objc private func addTask() {
        let text = taskTextField.text ?? ""
        let category = categoryTextField.text ?? ""
        let new_task = Task(title: text, category: category)
        Task.dummyData.append(new_task)
        delegate?.didAddTask()
    }
}
