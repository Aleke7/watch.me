import UIKit
import SnapKit

protocol HistoryDelegate: AnyObject {
    func deleteHistory(id: UUID?)
    func searchHistory(text: String)
}

final class SearchHistoryCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: SearchHistoryCell.self)
    weak var delegate: HistoryDelegate?
    private var searchModel: SearchModel?
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    // MARK: - UI
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.medium.s12()
        label.textAlignment = .left
        label.text = searchModel?.text
        label.textColor = AppColor.themeButtonColor.uiColor
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "multiply.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = AppColor.themeButtonColor.uiColor
        button.addTarget(self,
                         action: #selector(deleteButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGestureRecognizer?.numberOfTapsRequired = 1
        
        contentView.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(searchLabel)
        contentView.addSubview(deleteButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        searchLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Public
    
    public func configure(searchModel: SearchModel) {
        searchLabel.text = searchModel.text
    }
    
    // MARK: - Actions
    
    @objc
    private func deleteButtonTapped() {
        delegate?.deleteHistory(id: searchModel?.id)
    }
    
    @objc
    private func handleTapGesture() {
        delegate?.searchHistory(text: searchLabel.text ?? "")
    }
    
}
