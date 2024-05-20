import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentAvatarImageView: UIImageView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentViewSafeBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentSafeView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentTextFieldLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentBtn: UIButton!
    
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = myComments()
        configureTableView()
        configureKeyboard()
        configureTextField()
        configureCommentViewBorder()
        
        setCommentButton(enabled: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTextField() {
        commentTextField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }
    
    private var isCommentValid: Bool {
        guard let text = commentTextField.text else { return false }
        return !text.isEmpty
    }
    
    @objc private func didChangeText() {
        setCommentButton(enabled: isCommentValid)
    }
    
    private func setCommentButton(enabled isEnabled:Bool) {
        commentBtn.isPointerInteractionEnabled = isEnabled
        commentBtn.tintColor = isEnabled ? UIColor(hex: "#FFFFFF") : UIColor(hex: "#FFFFFF")?.withAlphaComponent(0.25)
    }
    
    private func configureCommentViewBorder() {
        let borderView = UIView()
        borderView.backgroundColor = UIColor(hex: "#A7AEC1")
        borderView.translatesAutoresizingMaskIntoConstraints = false
        commentView.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: commentView.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        if isKeyboardHidden {
            commentViewSafeBottomConstraint.constant = 0
            commentTextFieldLeftConstraint.constant = 12
            setCommentButton(enabled: false)
        } else {
            commentViewSafeBottomConstraint.constant = -endFrame.height + view.safeAreaInsets.bottom
            commentTextFieldLeftConstraint.constant = 56
        }
        
        UIView.animate(withDuration: duration) {
            self.commentBtn.alpha = isKeyboardHidden ? 0 : 1
            self.view.layoutIfNeeded()
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tableView.rowHeight = 118
    }
    
    private func myComments() -> [Comment] {
        return [
            Comment(image: .avatar1, author: "dayganat", datePosted: "2 months ago", description: "Such a magnificent book. Haunting and hugely underrated", likeCount: "30"),
            Comment(image: .avatar2, author: "s.penkevich", datePosted: "1 month ago", description: "I find it hard to stay positive in this rubbish world.", likeCount: "226"),
            Comment(image: .avatar3, author: "CanadianJen", datePosted: "3 months ago", description: "Allende is a master at spinning an epic story. I really wanted this one to ...", likeCount: "223"),
            Comment(image: .avatar4, author: "theoverbookedbibliophile", datePosted: "12 hours ago", description: "In I938 Vienna, in the aftermath of Kristallnacht, six-year-old Samuel...", likeCount: "223"),
            Comment(image: .avatar5, author: "AngelaM", datePosted: "3 months ago", description: "In two different times, in two different places, under different and horrible...", likeCount: "118"),
            Comment(image: .avatar6, author: "Helga", datePosted: "3 months ago", description: "There is a star where the people and the animals all live happily, and it’s even ...", likeCount: "41")

        ]
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func commentBtnTapped(_ sender: Any) {
        guard isCommentValid, let text = commentTextField.text else { return }
        
        let itemTrimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        comments.append(Comment(image: .avatar7, author: "beanenthusiast64", datePosted: "now", description: itemTrimmed, likeCount: "0"))
        
        let indexPath = IndexPath(row: comments.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        commentTextField.text = ""
        setCommentButton(enabled: false)
        
        view.endEditing(true)
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentCell
        else { return UITableViewCell() }
        
        let comments = comments[indexPath.row]
        
        cell.configure(with: comments)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CommentsViewController: UIScrollViewDelegate, UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
