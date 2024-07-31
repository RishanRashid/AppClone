//
//  cardViewController.swift
//  eliteTask
//
//  Created by Allnet Systems on 7/15/24.
//

import UIKit
import LZViewPager
import UIView_Shimmer

class cardViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource, CategoryViewControllerDelegate {
    @IBOutlet weak var viewPager: LZViewPager!
    
    private var foodItems: [String] = ["Trending", "Kashta", "Smoothies", "Squeezes Drinks", "Breakfast", "Shakes", "Level Drinks", "Fresh Juices"]
    
    private var subCategories: [String: [String]] = [
        "Trending": ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10"],
        "Kashta": ["Item 11", "Item 12", "Item 13", "Item 14", "Item 15", "Item 16", "Item 17", "Item 18", "Item 19", "Item 20"],
        "Smoothies": ["Item 21", "Item 22", "Item 23", "Item 24", "Item 25", "Item 26", "Item 27", "Item 28", "Item 29", "Item 30"],
        "Squeezes Drinks": ["Item 31", "Item 32", "Item 33", "Item 34", "Item 35", "Item 36", "Item 37", "Item 38", "Item 39", "Item 40"],
        "Breakfast": ["Item 41", "Item 42", "Item 43", "Item 44", "Item 45", "Item 46", "Item 47", "Item 48", "Item 49", "Item 50"],
        "Shakes": ["Item 51", "Item 52", "Item 53", "Item 54", "Item 55", "Item 56", "Item 57", "Item 58", "Item 59", "Item 60"],
        "Level Drinks": ["Item 61", "Item 62", "Item 63", "Item 64", "Item 65", "Item 66", "Item 67", "Item 68", "Item 69", "Item 70"],
        "Fresh Juices": ["Item 71", "Item 72", "Item 73", "Item 74", "Item 75", "Item 76", "Item 77", "Item 78", "Item 79", "Item 80"]
    ]
    
    private var subControllers: [UIViewController] = []
    private var selectedIndex: Int? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        
        subControllers = foodItems.map { category in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
            categoryVC.items = subCategories[category] ?? []
            categoryVC.delegate = self
            return categoryVC
        }
        
        viewPager.reload()
        applyShimmeringEffect()
        configureScrollableButtons()
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
    
    func numberOfItems() -> Int {
        return foodItems.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton(type: .system)
        let title = foodItems[index]
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.tintColor = UIColor.orange
        
        button.setTitleColor(UIColor.orange, for: .selected)
        button.backgroundColor = UIColor.clear
        button.tintColor = UIColor.clear
        return button
    }


    
    func viewPager(_ viewPager: LZViewPager, didSelectButtonAt index: Int) {
        
        viewPager.reload()
    }


    
    // MARK: - CategoryViewControllerDelegate
    func didFinishViewingItems(in viewController: CategoryViewController) {
        if let currentIndex = viewPager.currentIndex {
            if currentIndex < foodItems.count - 1 {
                viewPager.select(index: currentIndex + 1, animated: true)
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
        let titleWidth = foodItems[index].size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width + 20
        return min(max(titleWidth, minWidth), maxWidth)
    }
    
    func widthForIndicator(at index: Int) -> CGFloat {
        return widthForButton(at: index)
    }
    
    func buttonsAligment() -> ButtonsAlignment {
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
                // Ensure horizontal scrolling
                attribute.frame = CGRect(x: attribute.frame.origin.x, y: attribute.frame.origin.y, width: attribute.frame.size.width, height: attribute.frame.size.height)
            }
        }
        return attributes
    }
    
}
