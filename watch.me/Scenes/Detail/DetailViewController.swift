import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: ThemedViewController {
    
    // MARK: - Properties
    
    private var watch: Watch?
    
    // MARK: - UI
    
    private lazy var watchImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        if let url = URL(string: watch?.imageURL ?? "") {
            imageView.kf.setImage(with: url)
        }
        return imageView
    }()
    
    private lazy var watchNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s24()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "\(watch?.brand ?? "") \(watch?.model ?? "")"
        return label
    }()
    
    private lazy var watchDialLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "Dial color: \(watch?.dialColor ?? "")"
        return label
    }()
    
    private lazy var watchStrapLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "Strap type: \(watch?.strapType ?? "")"
        return label
    }()
    
    private lazy var watchDiameterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "Diameter: \(watch?.diameter ?? 0)"
        return label
    }()
    
    private lazy var watchEnergyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "Energy: \(watch?.energy ?? "")"
        return label
    }()
    
    private lazy var watchGenderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "Gender: \(watch?.gender ?? .male)"
        return label
    }()
    
    private lazy var watchPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = AppFont.bold.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.numberOfLines = 0
        label.text = "Price: \(watch?.price ?? 0)$"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    init(watch: Watch? = nil) {
        self.watch = watch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigation()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.themeMainBackgroundColor.uiColor
        view.addSubview(watchImageView)
        view.addSubview(stackView)
        [watchNameLabel,
         watchDialLabel,
         watchStrapLabel,
         watchDiameterLabel,
         watchGenderLabel,
         watchEnergyLabel,
         watchPriceLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        watchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(watchImageView.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Setup Navigation
    
    private func setupNavigation() {
        navigationItem.title = watch?.brand
        navigationItem.hidesBackButton = true
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(saveButtonTapped))
        saveButton.tintColor = AppColor.themeButtonColor.uiColor
        navigationItem.rightBarButtonItem = saveButton
        
        let backButton = UIBarButtonItem(image: AppImage.arrowIcon.uiImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = AppColor.themeButtonColor.uiColor
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Actions
    
    @objc
    private func saveButtonTapped() {
        
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
