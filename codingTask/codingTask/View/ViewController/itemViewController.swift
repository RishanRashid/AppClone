//
//  itemViewController.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import UIKit

class itemViewController: UIViewController {
    var items: [String] = []

        private let tableView = UITableView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
        }
        
        private func setupView() {
            view.backgroundColor = .white
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

    extension itemViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = items[indexPath.row]
            return cell
        }
    }
