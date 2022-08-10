

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let view = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        
        view.frame = bounds
        
        self.addSubview(view)
    }
    
}
