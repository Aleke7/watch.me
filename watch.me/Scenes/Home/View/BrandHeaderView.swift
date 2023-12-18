import UIKit
import SnapKit

final class BrandHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = String(describing: BrandHeaderView.self)
    
    // MARK: - UI
    
    private lazy var brandsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Brands"
        label.font = AppFont.bold.s32()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.textAlignment = .left
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
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(brandsLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        brandsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
