import UIKit
import SnapKit

final class DarkThemeCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = String(describing: DarkThemeCell.self)
    
    // MARK: = UI
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.themeIcon.uiImage?.withTintColor(AppColor.themeButtonColor.uiColor)
        return imageView
    }()
    
    private lazy var darkThemeTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Dark theme"
        label.font = AppFont.medium.s16()
        label.textColor = AppColor.themeButtonColor.uiColor
        return label
    }()
    
    private lazy var themeSwitch: UISwitch = {
        let themeSwitch = UISwitch(frame: .zero)
        themeSwitch.onTintColor = .systemBlue
        themeSwitch.isOn = false
        themeSwitch.isUserInteractionEnabled = true
        return themeSwitch
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
        themeSwitch.addTarget(self,
                              action: #selector(themeSwitchPressed),
                              for: .valueChanged)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(iconImageView)
        contentView.addSubview(darkThemeTitleLabel)
        contentView.addSubview(themeSwitch)
        selectionStyle = .none
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }
        
        darkThemeTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        themeSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Public
    
    public func configure(isOn: Bool) {
        themeSwitch.setOn(isOn, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    private func themeSwitchPressed() {
        ThemeManager.shared.toggleTheme()
    }
    
}
