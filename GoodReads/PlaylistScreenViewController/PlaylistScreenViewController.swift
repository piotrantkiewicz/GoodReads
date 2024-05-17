import UIKit

class PlaylistScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PlaylistScreenHeaderCell", bundle: nil), forCellReuseIdentifier: "PlaylistScreenHeaderCell")
    }
}

extension PlaylistScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistScreenHeaderCell") as? PlaylistScreenHeaderCell else { return UITableViewCell() }
        
        return cell
    }
}
