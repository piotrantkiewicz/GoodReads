import UIKit

class PlaylistScreenBookCell: UITableViewCell {

    @IBOutlet weak var bookThumbnailImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with book: Book) {
        bookThumbnailImageView.image = book.image
        titleLbl.text = book.title
        authorLbl.text = book.author
    }
}