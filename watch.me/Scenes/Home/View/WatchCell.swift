import UIKit
import SnapKit
import Kingfisher
import SkeletonView

protocol WatchCellDelegate: AnyObject {
    func openDetail(watch: Watch)
}

final class WatchCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = String(describing: WatchCell.self)
    private var watch: Watch?
    weak var delegate: WatchCellDelegate?
    
    // MARK: - UI
    
    private lazy var containterView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundColor = AppColor.grey0.uiColor
        view.layer.borderColor = AppColor.themeBorderColor.cgColor
        view.isSkeletonable = true
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
        label.textColor = AppColor.grey100.uiColor
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containterView.layer.borderWidth = 1
        containterView.layer.cornerRadius = 15
        setupGestureRecognizers()
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
            make.edges.equalToSuperview()
        }
        
        watchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.top.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        watchNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.top.equalTo(watchImageView.snp.bottom).offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    
    private func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        containterView.addGestureRecognizer(tapGestureRecognizer)
        containterView.isUserInteractionEnabled = true
    }
    
    @objc
    private func handleTapGesture() {
        if let watch = watch {
            delegate?.openDetail(watch: watch)
        }
    }
    
    // MARK: - Public
    
    public func configure(watch: Watch) {
        self.watch = watch
        if let url = URL(string: watch.imageURL) {
            watchImageView.kf.setImage(with: url)
        }
        watchNameLabel.text = "\(watch.brand) \(watch.model)"
    }
}
