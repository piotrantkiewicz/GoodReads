import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    
    var bookDetails: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBtn.setCornerRadius(14.5)
        if let book = bookDetails {
            configure(with: book)
        }
    }
    
    func configure(with book: Book) {
        bookCoverImageView.image = book.image
        titleLbl.text = book.title
        authorLbl.text = book.author
    }
    
    @IBAction func arrowDownTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func commentBtnTapped(_ sender: Any) {
    }
    
}