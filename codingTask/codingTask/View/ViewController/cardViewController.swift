//
//  cardViewController.swift
//  eliteTask
//
//  Created by Allnet Systems on 7/15/24.
//

import UIKit
import LZViewPager
import UIView_Shimmer

enum ScrollDirection {
    case forward
    case backward
}

class cardViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource, CategoryViewControllerDelegate {
    
    @IBOutlet weak var viewPager: LZViewPager!
    @IBOutlet weak var WoopView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var restaurantLogo: UIImageView!
    
    private var titleCatagory: [String] = []
    var subCategories: [String: [Item]] = [:]
    private var subControllers: [UIViewController] = []
    
    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        applyUIConfigurations()
        
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        showBottomView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let shadowRect = CGRect(x: 0, y: -bottomView.layer.shadowRadius, width: bottomView.bounds.width, height: bottomView.layer.shadowRadius)
        bottomView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
    
    private func applyUIConfigurations() {
        Helper.applyCornerRadius(to: searchButton, radius: searchButton.frame.size.width / 2)
        Helper.applyCornerRadius(to: backButton, radius: backButton.frame.size.width / 2)
        Helper.applyCornerRadius(to: sendButton, radius: sendButton.frame.size.width / 2)
        Helper.applyCornerRadius(to: continueButton, radius: 10)
        Helper.applyCornerRadius(to: restaurantLogo, radius: 10)
        Helper.applyCornerRadius(to: WoopView, radius: 10)
        Helper.applyShadow(to: bottomView, color: .black, offset: CGSize(width: 0, height: 2), radius: 5, opacity: 0.5)
    }


    
    func fetchData() {
      
        
        viewModel.fetchItems { [weak self] in
            guard let self = self else { return }
            
            self.titleCatagory.removeAll()
            self.subCategories.removeAll()
            
            let vendorsItems: [VendorsItem] = self.viewModel.vendorsItems
            
            self.titleCatagory = vendorsItems.compactMap { $0.vendorCategoryName }
            
            self.subCategories = vendorsItems.reduce(into: [String: [Item]]()) { result, vendorItem in
                guard let categoryName = vendorItem.vendorCategoryName else { return }
                result[categoryName] = vendorItem.items ?? []
            }
            
            self.subControllers = self.titleCatagory.compactMap { categoryName in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController else {
                    return nil
                }
                categoryVC.titleHeader = categoryName
                categoryVC.items = self.subCategories[categoryName] ?? []
                categoryVC.delegate = self
                
                return categoryVC
            }
            
            self.viewPager.reload()
        }
    }

    private func applyShimmeringEffect() {
        viewPager.setTemplateWithSubviews(true, viewBackgroundColor: .systemOrange)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewPager.setTemplateWithSubviews(false)
        }
    }
    
    private func configureScrollableButtons() {
        if let collectionView = viewPager.subviews.compactMap({ $0 as? UICollectionView }).first {
            let layout = ScrollingFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            collectionView.collectionViewLayout = layout
        }
    }
    
    func showBottomView() {
        bottomView.isHidden = false
        bottomView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.bottomView.alpha = 1
        }
    }
    
    func viewPager(_ viewPager: LZViewPager, headerForSectionAt section: Int) -> UIView {
        let headerView = FoodItemsHeaderView()
        headerView.titleCatagory = titleCatagory
        return headerView
    }

    func numberOfItems() -> Int {
        return titleCatagory.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton(type: .system)
        let title = titleCatagory[index]
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.tintColor = UIColor.orange
        
        button.setTitleColor(UIColor.orange, for: .selected)
        button.backgroundColor = UIColor.systemGray6
        button.tintColor = UIColor.clear
        return button
    }
    
    func viewPager(_ viewPager: LZViewPager, didSelectButtonAt index: Int) {
        viewPager.reload()
    }
    
    func didFinishViewingItems(in viewController: CategoryViewController, direction: ScrollDirection) {
        if let currentIndex = viewPager.currentIndex {
            switch direction {
            case .forward:
                if currentIndex < titleCatagory.count - 1 {
                    viewPager.select(index: currentIndex + 1, animated: true)
                } else {
                    print("Reached the last category.")
                }
            case .backward:
                if currentIndex > 0 {
                    viewPager.select(index: currentIndex - 1, animated: true)
                } else {
                    print("Reached the first category.")
                }
            }
        }
    }

    // MARK: - Customization Methods
    func heightForHeader() -> CGFloat {
        return 40
    }
    
    func backgroundColorForHeader() -> UIColor {
        return .white
    }
    
    func heightForIndicator() -> CGFloat {
        return 2.0
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return .orange
    }
    
    func shouldShowIndicator() -> Bool {
        return true
    }
    
    func widthForButton(at index: Int) -> CGFloat {
        let minWidth: CGFloat = 120
        let maxWidth: CGFloat = viewPager.bounds.width
        let titleWidth = titleCatagory[index].size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 20
        return min(max(titleWidth, minWidth), maxWidth)
    }
    
    func widthForIndicator(at index: Int) -> CGFloat {
        return widthForButton(at: index)
    }
    
    func buttonsAlignment() -> ButtonsAlignment {
        return .left
    }
    
    func shouldEnableSwipeable() -> Bool {
        return true
    }
    
    func shouldShowSeparator() -> Bool {
        return false
    }
    
    func colorForSeparator() -> UIColor {
        return .white
    }
    
    func heightForSeparator() -> CGFloat {
        return 2.0
    }
}

class ScrollingFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attribute in attributes {
            if attribute.representedElementCategory == .cell {
                attribute.frame = CGRect(x: attribute.frame.origin.x, y: attribute.frame.origin.y, width: attribute.frame.size.width, height: attribute.frame.size.height)
            }
        }
        return attributes
    }
}
