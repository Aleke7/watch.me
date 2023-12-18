import UIKit
import SnapKit

final class BrandCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: BrandCell.self)
    
    // MARK: = UI
    
    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return imageView
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        brandImageView.layer.cornerRadius = 15
        brandImageView.layer.shadowColor = AppColor.themeShadowColor.cgColor
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(brandImageView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        brandImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: - Public
    
    public func configure() {
        
    }
    
}
