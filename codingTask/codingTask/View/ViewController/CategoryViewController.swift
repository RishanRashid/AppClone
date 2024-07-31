//
//  CategoryViewController.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import UIKit
import UIView_Shimmer


protocol CategoryViewControllerDelegate: AnyObject {
    func didFinishViewingItems(in viewController: CategoryViewController)
}

class CategoryViewController: UIViewController {
    var items: [String] = []
       weak var delegate: CategoryViewControllerDelegate?
       
       @IBOutlet weak var catagoryList: UITableView!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupTableView()
           applyShimmeringEffect()
       }
       
       private func setupTableView() {
           guard catagoryList != nil else {
               fatalError("catagoryList should not be nil in viewDidLoad")
           }
           
           catagoryList.dataSource = self
           catagoryList.delegate = self
           catagoryList.register(UINib(nibName: "CatagoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CatagoryTableViewCell")
           catagoryList.rowHeight = UITableView.automaticDimension
           catagoryList.estimatedRowHeight = 200
       }
       
       private func applyShimmeringEffect() {
           // Start shimmering effect
           catagoryList.setTemplateWithSubviews(true, viewBackgroundColor: .systemBackground)
           
           // Stop shimmering effect after 3 seconds
           DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
               self.catagoryList.setTemplateWithSubviews(false)
           }
       }
   }

   extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return items.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryTableViewCell", for: indexPath) as? CatagoryTableViewCell else {
               return UITableViewCell()
           }
           
           // Configure cell
           cell.productNameLabel.text = items[indexPath.row]
           cell.setTemplateWithSubviews(false) // Ensure shimmering is off initially
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           delegate?.didFinishViewingItems(in: self)
       }
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if let shimmeringCell = cell as? ShimmeringViewProtocol {
               // Apply shimmering effect when the cell is about to be displayed
               shimmeringCell.setTemplateWithSubviews(true, viewBackgroundColor: .systemBackground)
           }
       }
       
       func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if let shimmeringCell = cell as? ShimmeringViewProtocol {
               // Stop shimmering effect when the cell is no longer displayed
               shimmeringCell.setTemplateWithSubviews(false)
           }
       }
   }
