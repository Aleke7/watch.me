import UIKit
import SnapKit

class SignView: UIView {

    // MARK: - UI
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.appLogo.uiImage
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "watch.me"
        label.font = AppFont.bold.s32()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailLabel: InputTitleLabel = {
        let label = InputTitleLabel(frame: .zero)
        label.text = "Email"
        return label
    }()
    
    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField(isPassword: false)
        textField.placeholder = "Enter your email"
        return textField
    }()
    
    private lazy var passwordLabel: InputTitleLabel = {
        let label = InputTitleLabel(frame: .zero)
        label.text = "Password"
        return label
    }()
    
    private lazy var passwordTextField: InputTextField = {
        let textField = InputTextField(isPassword: true)
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        let tintColor = AppColor.grey60.uiColor
        button.setImage(AppImage.eyeClosed.uiImage?.withTintColor(tintColor),
                        for: .normal)
        button.setImage(AppImage.eyeOpened.uiImage?.withTintColor(tintColor),
                        for: .selected)
        button.addTarget(self,
                         action: #selector(togglePasswordVisibility),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var headphonesImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.headphones.uiImage
        return imageView
    }()
    
    private lazy var supportServiceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Support service"
        label.font = AppFont.medium.s16()
        label.textColor = AppColor.grey60.uiColor
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: - Object lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        appIconImageView.layer.shadowRadius = 10
        appIconImageView.layer.shadowColor = AppColor.themeShadowColor.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 8
        emailTextField.layer.borderColor = AppColor.themeBorderColor.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderColor = AppColor.themeBorderColor.cgColor
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = AppColor.themeMainBackgroundColor.uiColor
        let views = [
            appIconImageView,
            appNameLabel,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            passwordToggleButton,
            bottomStackView
        ]
        views.forEach { addSubview($0) }
        bottomStackView.addArrangedSubview(headphonesImageView)
        bottomStackView.addArrangedSubview(supportServiceLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        appIconImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
        
        passwordToggleButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-20)
            make.size.equalTo(24)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Setup Gestures
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    // MARK: - Public
    
    public func getBottomConstraint() -> ConstraintItem {
        return passwordTextField.snp.bottom
    }
    
    public func getEmail() -> String? {
        return emailTextField.text
    }
    
    public func getPassword() -> String? {
        return passwordTextField.text
    }
    
    // MARK: - Actions
    
    @objc
    private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordToggleButton.isSelected = !passwordTextField.isSecureTextEntry
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer?) {
        endEditing(true)
    }
    
}
