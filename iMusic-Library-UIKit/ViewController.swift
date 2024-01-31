import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let tableDelegate = LibraryTableDelegate()
    private lazy var albums: Albums = Albums()
    private var currerntAlbumPosition: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableDelegates()
        self.registerCells()
        self.loadCovers()
    }
    
    private func setUpTableDelegates() {
        self.tableView.dataSource = self.tableDelegate
        self.tableView.delegate = self.tableDelegate
        self.tableDelegate.setUpController(self)
    }
    
    private func registerCells() {
        let cover = UINib(nibName: "CoverViewCell", bundle: nil)
        let coverInfo = UINib(nibName: "DetailsTableCell", bundle: nil)
        self.tableView.register(cover, forCellReuseIdentifier: "CoverViewCell")
        self.tableView.register(coverInfo, forCellReuseIdentifier: "DetailsTableCell")
    }
    
    private func loadCovers() {
        self.tableDelegate.setUpAlbums(self.albums)
    }
    
    func getCurrentAlbumPosition() -> Int {
        return self.currerntAlbumPosition
    }
    
    func setCurrentAlbum(position: Int) {
        self.currerntAlbumPosition = position
        self.tableView.reloadData()
    }
}

