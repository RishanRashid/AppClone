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
        // Initialization code
    }
    func configure(with item: String) {
            // Update this function to configure the cell with the actual data.
            // For demonstration, we're just setting the product name.
            self.productNameLabel.text = item
            // You can set the image and price here as well.
        }
    override func prepareForReuse() {
           super.prepareForReuse()
           // Reset shimmering effect before reuse
           setTemplateWithSubviews(false)
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
