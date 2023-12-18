import UIKit
import SnapKit

protocol LoginDelegate: AnyObject {
    func showRegistrationPage()
    func readInputFields(email: String?, password: String?)
}

final class LoginView: SignView {
    
    // MARK: - Properties
    
    weak var delegate: LoginDelegate?
    
    // MARK: - UI
    
    private lazy var loginButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self,
                         action: #selector(loginButtonPressed),
                         for: .touchUpInside)
        button.titleLabel?.font = AppFont.bold.s16()
        return button
    }()
    
    private lazy var enterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let regularText = "Don't have an account? "
        let linkText = "Sign Up"
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
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        let views = [
            loginButton,
            enterLabel
        ]
        views.forEach { addSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(getBottomConstraint()).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        enterLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func loginButtonPressed() {
        let email = getEmail()
        let password = getPassword()
        delegate?.readInputFields(email: email, password: password)
    }
    
    @objc
    private func enterTapped() {
        delegate?.showRegistrationPage()
    }
    
}
