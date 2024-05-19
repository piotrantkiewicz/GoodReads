import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = myComments()
        configureTableView()
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func configureTableView() {
        tableView.dataSource = self
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
