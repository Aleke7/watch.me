import UIKit
import SnapKit

final class TitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: TitleCell.self)
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Information about you"
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.textAlignment = .left
        return label
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
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
        selectionStyle = .none
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
    
}
