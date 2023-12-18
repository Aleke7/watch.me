import UIKit
import SnapKit
import ProgressHUD

protocol RegistrationDelegate: AnyObject {
    func showLoginPage()
    func readInputFields(email: String?, password: String?)
}

final class RegistrationView: SignView {
    
    // MARK: - Properties
    
    public weak var delegate: RegistrationDelegate?
    
    // MARK: - UI
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppImage.checkNotPressed.uiImage, for: .normal)
        button.setImage(AppImage.checkPressed.uiImage, for: .selected)
        button.addTarget(self,
                         action: #selector(checkboxButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let regularText = "I accept the terms of "
        let linkText = "the Privacy Policy"
        let attributedString = NSMutableAttributedString(string: regularText + linkText)
        attributedString.removeAttribute(.link,
                                         range: NSRange(location: regularText.count,
                                                        length: linkText.count))
        attributedString.addAttribute(.foregroundColor,
                                      value: AppColor.grey60.uiColor,
                                      range: NSRange(location: regularText.count,
                                                     length: linkText.count))
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: regularText.count,
                                                     length: linkText.count))
        label.attributedText = attributedString
        label.font = AppFont.medium.s14()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(linkTapped)))
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var registerButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self,
                         action: #selector(registerButtonPressed),
                         for: .touchUpInside)
        button.titleLabel?.font = AppFont.bold.s16()
        return button
    }()
    
    private lazy var enterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let regularText = "Already have an account? "
        let linkText = "Sign In"
        let linkString = NSMutableAttributedString(string: regularText + linkText)
        linkString.removeAttribute(.link,
                                   range: NSRange(location: regularText.count,
                                                  length: linkText.count))
        linkString.addAttribute(.foregroundColor,
                                value: AppColor.grey60.uiColor,
                                range: NSRange(location: regularText.count,
                                               length: linkText.count))
        linkString.addAttribute(.underlineStyle,
                                value: NSUnderlineStyle.single.rawValue,
                                range: NSRange(location: regularText.count,
                                               length: linkText.count))
        label.attributedText = linkString
        label.font = AppFont.medium.s16()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                          action: #selector(enterTapped)))
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
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        let views = [
            checkboxButton,
            linkLabel,
            registerButton,
            enterLabel
        ]
        views.forEach { addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.top.equalTo(getBottomConstraint()).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(getBottomConstraint()).offset(20)
            make.leading.equalTo(checkboxButton.snp.trailing).offset(10)
            make.centerY.equalTo(checkboxButton)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(checkboxButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        enterLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func checkboxButtonTapped() {
        checkboxButton.isSelected.toggle()
    }
    
    @objc
    private func linkTapped() {
        let urlString = "https://www.linkedin.com/in/abgdrv/"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @objc
    private func registerButtonPressed() {
        let email = getEmail()
        let password = getPassword()
        delegate?.readInputFields(email: email, password: password)
    }
    
    @objc
    private func enterTapped() {
        delegate?.showLoginPage()
    }
    
}
