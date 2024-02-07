import UIKit


class CoverViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var coverCollectionView: UICollectionView!
    
    private var albums: Albums?
    private var controller: ViewController? = nil
    
    func setUpCollectionView() {
        self.coverCollectionView.register(UINib(nibName: "CoverImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CoverImageCollectionCell")
        
        self.coverCollectionView.delegate = self
        self.coverCollectionView.dataSource = self
        self.coverCollectionView.reloadData()
    }
    
    func setUpController(_ controller: ViewController?) {
        self.controller = controller
    }
    
    func setAlbums(albums: Albums) {
        self.albums = albums
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums?.getPhotos().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoverImageCollectionCell", for: indexPath) as? CoverImageCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setUpImageTapAction(table: collectionView)
        cell.setCoverImage(for: self.albums?.getPhotos()[indexPath.row] ?? "")
        cell.setUpAlbum(album: self.albums?.getAllAlbums()[indexPath.row] ?? Album())
        cell.setUpController(self.controller)
        return cell
    }
    
}
