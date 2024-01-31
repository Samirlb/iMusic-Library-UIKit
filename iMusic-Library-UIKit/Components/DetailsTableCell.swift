import UIKit

class DetailsTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setUpDescription(_ description: String) {
        self.descriptionLabel.text = description
    }

}
