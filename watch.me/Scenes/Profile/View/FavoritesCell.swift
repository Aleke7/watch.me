import UIKit
import SnapKit

final class FavoritesCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = String(describing: FavoritesCell.self)
    
    // MARK: - UI
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.starIcon.uiImage?.withTintColor(AppColor.themeButtonColor.uiColor)
        return imageView
    }()
    
    private lazy var favoritesTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Favorites"
        label.font = AppFont.medium.s16()
        label.textColor = AppColor.themeButtonColor.uiColor
        return label
    }()
    
    private lazy var arrowIconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.arrowRightIcon.uiImage?.withTintColor(AppColor.themeButtonColor.uiColor)
        return imageView
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
        contentView.addSubview(favoritesTitleLabel)
        contentView.addSubview(arrowIconImageView)
        selectionStyle = .none
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }
        
        favoritesTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        arrowIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }

}
