import UIKit

class LibraryTableDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var albums: Albums?
    private var controller: ViewController? = nil

    // MARK: - Table view data source
    
    func setUpAlbums(_ albums: Albums) {
        self.albums = albums
    }

    func setUpController(_ controller: ViewController) {
        self.controller = controller
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return self.setUpCover(tableView, indexPath: indexPath)
        }
        return self.setUpCoverInfo(tableView, indexPath: indexPath)
    }
    
    private func setUpCover(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoverViewCell", for: indexPath) as? CoverViewCell else {
            return UITableViewCell()
        }
        cell.setUpCollectionView()
        cell.setAlbums(albums: self.albums ?? Albums())
        cell.setUpController(self.controller)
        return cell
    }
    
    private func setUpCoverInfo(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableCell", for: indexPath) as? DetailsTableCell else {
            return UITableViewCell()
        }
        let currentAlbum = self.controller?.getCurrentAlbum() ?? Album()
        let currentRow = currentAlbum.getRowDetail(position: indexPath.row)
        cell.setUpTitle(currentRow.getTitle())
        cell.setUpDescription(currentRow.getDetail())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        }
        return UITableView.automaticDimension
    }

}
