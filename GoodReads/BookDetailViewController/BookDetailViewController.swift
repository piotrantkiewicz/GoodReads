import UIKit

class BookDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ActionBarCellDelegate {

    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var bookDetails: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let book = bookDetails {
            configure(with: book)
        }
        
        configureCollectionView()
    }

    func configure(with book: Book) {
        bookCoverImageView.image = book.image
        titleLbl.text = book.title
        authorLbl.text = book.author
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ActionBarCell", bundle: nil), forCellWithReuseIdentifier: "ActionBarCell")
    }

    @IBAction func arrowDownTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionBarCell", for: indexPath) as! ActionBarCell
        cell.delegate = self
        return cell
    }

    func didTapCommentButton() {
        let commentsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentsViewController.modalPresentationStyle = .fullScreen
        present(commentsViewController, animated: true)
    }
}

extension BookDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 407, height: 34)
    }
}
