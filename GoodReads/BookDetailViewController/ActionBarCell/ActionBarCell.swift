import UIKit

protocol ActionBarCellDelegate: AnyObject {
    func didTapCommentButton()
}

class ActionBarCell: UICollectionViewCell {

    @IBOutlet weak var commentBtn: UIButton!

    weak var delegate: ActionBarCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentBtn.setCornerRadius(17)
    }

    @IBAction func commentBtnTapped(_ sender: Any) {
        delegate?.didTapCommentButton()
    }
}
