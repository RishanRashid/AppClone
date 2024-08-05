//
//  CategoryViewController.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import UIKit
import UIView_Shimmer


protocol CategoryViewControllerDelegate: AnyObject {
    func didFinishViewingItems(in viewController: CategoryViewController, direction: ScrollDirection)
}
class CategoryViewController: UIViewController {
    var items: [Item] = []
    var titleHeader: String?
    weak var delegate: CategoryViewControllerDelegate?
    
    @IBOutlet weak var catagoryList: UITableView!
    
    private var isLoadingData: Bool = true
    
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
        isLoadingData = true
        catagoryList.setTemplateWithSubviews(true, viewBackgroundColor: .systemBackground)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoadingData = false
            self.catagoryList.setTemplateWithSubviews(false)
            self.catagoryList.reloadData()
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
        
        let item = items[indexPath.row]
        
        if isLoadingData {
            cell.setTemplateWithSubviews(true, viewBackgroundColor: UIColor(red: 0.95, green: 0.73, blue: 0.37, alpha: 1.00))
        } else {
            cell.setTemplateWithSubviews(false)
            cell.productNameLabel.text = item.name
            cell.priceLabel.text = "KD. " + "\(item.regularPrice ?? 0)"
            cell.productDescriptionLabel.text = item.description
            
            if let iconURLString = item.icon, let url = URL(string: iconURLString) {
                ServiceFile.shared.downloadImage(from: url) { image in
                    DispatchQueue.main.async {
                        if let downloadedImage = image {
                            cell.foodImageView.image = downloadedImage
                        } else {
                            cell.foodImageView.image = UIImage(named: "placeholder")
                        }
                    }
                }
            } else {
                cell.foodImageView.image = UIImage(named: "placeholder")
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return titleHeader
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if contentHeight - scrollPosition <= 10 {
            delegate?.didFinishViewingItems(in: self, direction: .forward)
        } else if scrollView.contentOffset.y <= -10 {
            delegate?.didFinishViewingItems(in: self, direction: .backward)
        }
    }
}
