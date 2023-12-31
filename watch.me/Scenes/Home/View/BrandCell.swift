import UIKit
import SnapKit
import Kingfisher
import SkeletonView

final class BrandCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: BrandCell.self)
    
    // MARK: - UI
    
    private lazy var containterView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    private lazy var brandImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containterView.layer.shadowColor = AppColor.themeShadowColor.cgColor
        containterView.layer.cornerRadius = 15
        brandImageView.layer.cornerRadius = 15
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(containterView)
        containterView.addSubview(brandImageView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containterView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        brandImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func startAnimation() {
        brandImageView.showAnimatedGradientSkeleton()
    }
    
    private func stopAnimation() {
        layoutSubviews()
        brandImageView.hideSkeleton()
        
    }
    
    // MARK: - Public
    
    public func configure(brand: Brand) {
        if let url = URL(string: brand.imageURL) {
            brandImageView.kf.setImage(
                with: url,
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.stopAnimation()
                    }
                }
            )
            
        }
    }
}
