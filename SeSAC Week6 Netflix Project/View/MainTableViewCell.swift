

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    @IBOutlet weak var contentsSortLabel: UILabel!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func setupUI() {
        contentsSortLabel.font = .boldSystemFont(ofSize: 20)
        //contentsSortLabel.text = "넷플릭스 인기 콘텐츠"
        self.backgroundColor = .black
        contentCollectionView.backgroundColor = .black
        
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 180)
//        layout.minimumLineSpacing = 16
//        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return layout
    }
    
    
}
