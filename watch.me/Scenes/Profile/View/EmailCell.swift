import UIKit
import SnapKit

final class EmailCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = String(describing: EmailCell.self)
    
    // MARK: - UI
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.profileIcon.uiImage?.withTintColor(AppColor.themeButtonColor.uiColor)
        return imageView
    }()
    
    private lazy var emailTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Email"
        label.font = AppFont.medium.s16()
        label.textColor = AppColor.themeButtonColor.uiColor
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        if let email = UserDefaults.standard.string(forKey: "email") {
            label.text = email
        }
        label.font = AppFont.medium.s16()
        label.textColor = AppColor.grey60.uiColor
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(emailTitleLabel)
        contentView.addSubview(emailLabel)
        selectionStyle = .none
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }
        
        emailTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
    
}
