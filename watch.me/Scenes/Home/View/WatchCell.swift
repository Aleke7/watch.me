import UIKit
import SnapKit

final class WatchCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: WatchCell.self)
    
    // MARK: - UI
    
    private lazy var containterView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundColor = AppColor.themeSecondaryBackgroundColor.uiColor
        view.layer.borderColor = AppColor.themeBorderColor.cgColor
        return view
    }()
    
    private lazy var watchImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var watchNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = AppFont.bold.s12()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.text = "Tissot PRX"
        label.textAlignment = .center
        return label
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
        containterView.layer.borderWidth = 1
        containterView.layer.cornerRadius = 15
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(containterView)
        containterView.addSubview(watchImageView)
        containterView.addSubview(watchNameLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containterView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        watchImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        watchNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: - Public
    
    public func configure() {
        
    }
}
