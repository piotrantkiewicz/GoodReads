import UIKit

struct Comment {
    let image: UIImage
    let author: String
    let datePosted: String
    let description: String
    let likeCount: String
}

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentAuthorLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var commentLikeCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with comment: Comment) {
        commentImageView.image = comment.image
        commentAuthorLbl.text = "@" + comment.author + " - " + comment.datePosted
        commentLbl.text = comment.description
        commentLikeCountLbl.text = comment.likeCount
    }
}
