//
//  DetailedTaskVC.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import UIKit

class DetailedTaskVC: UIViewController {
    
    // MARK: - Properties (view)
    private let taskLabel = UILabel()
    private let categoryLabel = UILabel()
    private let completeButton = UIButton()
    
    // MARK: - Properties (data)
    private var task: Task
    
    // MARK: - init
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupTaskLabel()
        setupCategoryLabel()
        setupCompleteButton()
    }
    
    // MARK: - Set Up Views
    private func setupTaskLabel() {
        taskLabel.text = task.title
        taskLabel.textColor = .label
        taskLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        taskLabel.numberOfLines = 0
        taskLabel.textAlignment = .center
        
        view.addSubview(taskLabel)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            taskLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            taskLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupCategoryLabel() {
        categoryLabel.text = "Category: \(task.category)"
        categoryLabel.textColor = .gray
        categoryLabel.font = .systemFont(ofSize: 18, weight: .medium)
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        
        view.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            categoryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupCompleteButton() {
        completeButton.setTitle("Mark as Complete", for: .normal)
        completeButton.backgroundColor = .systemBlue
        completeButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        completeButton.layer.cornerRadius = 10
        completeButton.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
        
        view.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeButton.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            completeButton.widthAnchor.constraint(equalToConstant: 200),
            completeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    @objc private func completeTask() {
        if let index = Task.dummyData.firstIndex(of: task) {
            Task.dummyData.remove(at: index)
        }
        navigationController?.popViewController(animated: true)
    }
}
