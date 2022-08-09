//
//  CardCollectionViewCell.swift
//  SeSAC Week6 Netflix Project
//
//  Created by 이명진 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CardCollectionViewCell"
    
    @IBOutlet weak var cardView: CardView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .yellow
        
        
    }
    
    
}
