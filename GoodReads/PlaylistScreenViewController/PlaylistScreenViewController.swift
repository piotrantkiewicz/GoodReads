import UIKit

class PlaylistScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = myBooks()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PlaylistScreenHeaderCell", bundle: nil), forCellReuseIdentifier: "PlaylistScreenHeaderCell")
        tableView.register(UINib(nibName: "PlaylistScreenBookCell", bundle: nil), forCellReuseIdentifier: "PlaylistScreenBookCell")
    }
    
    func present(with bookDetails: Book) {
        let bookDetailsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "BookDetailViewController") as! BookDetailViewController
        
        bookDetailsViewController.bookDetails = bookDetails
        
        bookDetailsViewController.modalPresentationStyle = .fullScreen
        
        present(bookDetailsViewController, animated: true)
    }

    private func myBooks() -> [Book] {
        return [
            Book(image: .weywardCover, title: "Weyward", author: "Emilia Hart", timeDuration: "7h 5m"),
            Book(image: .covenantCover, title: "The Covenant of Water", author: "Abraham Verghese", timeDuration: "2h 3m left"),
            Book(image: .ladyTansCircleCover, title: "Lady Tan’s Circle of Women", author: "Lisa See", timeDuration: "5h 5m"),
            Book(image: .theHeavenAndEarthCover, title: "The Heaven & Earth Grocery Store", author: "James McBride", timeDuration: "2h 23m"),
            Book(image: .theEchoCover, title: "The Echo of Old Books", author: "Barbara Davis", timeDuration: "5h 2m"),
            Book(image: .theHouseOfEveCover, title: "The House of Eve", author: "Sadeqa Johnson", timeDuration: "4h 5m"),
            Book(image: .theWindKnowsMyNameCover, title: "The Wind Knows My Name", author: "Isabel Allende", timeDuration: "4h 5m")
        ]
    }
}

extension PlaylistScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistScreenHeaderCell") as? PlaylistScreenHeaderCell else { return UITableViewCell() }
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistScreenBookCell") as? PlaylistScreenBookCell else { return UITableViewCell() }
            
            let books = dataSource[indexPath.row]
            
            cell.configure(with: books)
            
            return cell
        }
    }
}

extension PlaylistScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetails = dataSource[indexPath.row]
        present(with: bookDetails)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 321 : 64
    }
}
