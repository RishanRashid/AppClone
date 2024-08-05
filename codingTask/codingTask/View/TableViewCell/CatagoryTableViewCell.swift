//
//  CatagoryTableViewCell.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import UIKit
import UIView_Shimmer



class CatagoryTableViewCell: UITableViewCell, ShimmeringViewProtocol {
    @IBOutlet weak var foodImageView: UIImageView!
        @IBOutlet weak var productNameLabel: UILabel!
        @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var foodLogo: UIImageView!

    var shimmeringAnimatedItems: [UIView] {
            [
                foodImageView,
                productNameLabel,
                priceLabel,
                productDescriptionLabel,
            ]
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        foodLogo.layer.cornerRadius = 10
        foodLogo.clipsToBounds =  true
    }
    func configure(with item: String) {
            self.productNameLabel.text = item
        }
    override func prepareForReuse() {
           super.prepareForReuse()
           setTemplateWithSubviews(false)
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
