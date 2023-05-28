
import UIKit

struct TileCollectionViewCellViewModel{
    let name: String
    let image: UIImage?

}

class TileCollectionViewCell: UICollectionViewCell {
    static let identifier = "TileCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // or .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor 
    }
    
    required init?(coder:NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        imageView.layer.cornerRadius = 10
    }
    
    func config(with viewModle: TileCollectionViewCellViewModel){
        imageView.image = viewModle.image

    }
}
