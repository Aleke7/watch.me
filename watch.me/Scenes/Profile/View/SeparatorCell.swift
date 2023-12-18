import UIKit
import SnapKit

final class SeparatorCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: SeparatorCell.self)
    
    // MARK: - UI
    
    private lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColor.themeButtonColor.uiColor
        return view
    }()
    
    // MARK: - Object Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        separatorView.backgroundColor = AppColor.themeBorderColor.uiColor
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(separatorView)
        selectionStyle = .none
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
}
