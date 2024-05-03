//
//  FeedVC.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import UIKit

class FeedVC: UIViewController {

    // MARK: - Properties (view)

    private var collectionView: UICollectionView!
    
    // MARK: - Properties (data)

    private var tasks: [Task] = []
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "To-Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.white

        setupCollectionView()
    }
    
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         tasks = Task.dummyData
         collectionView.reloadData()
     }

    // MARK: - Set Up Views

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CreateTaskCollectionViewCell.self, forCellWithReuseIdentifier: CreateTaskCollectionViewCell.reuse)
        collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: TaskCollectionViewCell.reuse)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension FeedVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let task = tasks[indexPath.row]
            let viewController2 = DetailedTaskVC(task: task)
            navigationController?.pushViewController(viewController2, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateTaskCollectionViewCell.reuse, for: indexPath) as? CreateTaskCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self 
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuse, for: indexPath) as? TaskCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(task: tasks[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return tasks.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 0, bottom: 8, right: 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: indexPath.section == 0 ? 175 : 50)
    }
}

extension FeedVC: CreateTaskDelegate {
    func didAddTask() {
        tasks = Task.dummyData
        collectionView.reloadData()
    }
}
