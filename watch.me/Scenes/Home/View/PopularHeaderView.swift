import UIKit
import SnapKit

final class PopularHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = String(describing: PopularHeaderView.self)
    
    // MARK: - UI
    
    private lazy var popularLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Popular"
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
        addSubview(popularLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        popularLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
