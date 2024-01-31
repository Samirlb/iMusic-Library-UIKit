import UIKit


class CoverViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var coverCollectionView: UICollectionView!
    
    private var photosNames: [String] = []
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
    
    func setPhotos(names: [String]) {
        self.photosNames = names
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoverImageCollectionCell", for: indexPath) as? CoverImageCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setUpImageTapAction(table: collectionView)
        cell.setCoverImage(for: self.photosNames[indexPath.row])
        cell.setUpLibrary(index: indexPath.row)
        cell.setUpController(self.controller)
        return cell
    }
    
}
