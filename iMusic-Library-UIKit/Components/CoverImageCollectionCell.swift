import UIKit

class CoverImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var coverImage: UIImageView!
    
    private var currentAlbum: Album = Album()
    private var controller: ViewController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCoverImage(for name: String) {
        let coverImage = UIImage(named: name)
        self.coverImage.image = coverImage
    }
    
    func setUpController(_ controller: ViewController?) {
        self.controller = controller
    }
    
    func setUpAlbum(album: Album) {
        self.currentAlbum = album
    }
    
    func setUpImageTapAction(table: UICollectionView) {
        let imageTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        self.addGestureRecognizer(imageTappedRecognizer)
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        self.controller?.setCurrentAlbum(album: self.currentAlbum)
        self.controller?.setCurrentSong()
    }
}
