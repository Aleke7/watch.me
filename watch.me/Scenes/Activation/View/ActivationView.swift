import UIKit
import SnapKit
import ProgressHUD

protocol ActivationDelegate: AnyObject {
    func readActivationCode(activationCode: String)
}

final class ActivationView: UIView {
    
    // MARK: = Properties
    
    weak var delegate: ActivationDelegate?
    
    private var activationCode: String {
        let digit1 = digit1TextField.text ?? ""
        let digit2 = digit2TextField.text ?? ""
        let digit3 = digit3TextField.text ?? ""
        let digit4 = digit4TextField.text ?? ""
        let code = digit1 + digit2 + digit3 + digit4
        return code
    }
    
    // MARK: - UI
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Activation code sent to email"
        label.font = AppFont.medium.s16()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        if let email = UserDefaults.standard.string(forKey: "email") {
            label.text = email.maskEmail()
        }
        label.font = AppFont.medium.s20()
        label.textColor = AppColor.themeButtonColor.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var digit1TextField = digitTextField()
    
    private lazy var digit2TextField = digitTextField()
    
    private lazy var digit3TextField = digitTextField()
    
    private lazy var digit4TextField = digitTextField()

    private lazy var digitStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private func digitTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.backgroundColor = AppColor.themeSecondaryBackgroundColor.uiColor
        textField.textColor = AppColor.themeButtonColor.uiColor
        textField.font = AppFont.bold.s24()
        textField.clipsToBounds = true
        textField.delegate = self
        textField.textAlignment = .center
        textField.addTarget(self,
                            action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        return textField
    }
    
    private lazy var continueButton: ProceedButton = {
        let button = ProceedButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.addTarget(self,
                         action: #selector(continueButtonPressed),
                         for: .touchUpInside)
        button.titleLabel?.font = AppFont.bold.s16()
        return button
    }()
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGestures()
        observeKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let subviews = [
            digit1TextField,
            digit2TextField,
            digit3TextField,
            digit4TextField
        ]
        subviews.forEach { textField in
            textField.layer.borderWidth = 2
            textField.layer.cornerRadius = 12
            textField.layer.borderColor = AppColor.themeBorderColor.cgColor
        }
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = AppColor.themeMainBackgroundColor.uiColor
        let views = [
            instructionLabel,
            emailLabel,
            digitStackView,
            continueButton
        ]
        views.forEach { addSubview($0) }
        let subviews = [
            digit1TextField,
            digit2TextField,
            digit3TextField,
            digit4TextField
        ]
        subviews.forEach { digitStackView.addArrangedSubview($0) }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        digitStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(digitStackView.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailLabel.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - Setup Gestures
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    // MARK: - Keyboard
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    // MARK: - Actions
    
    @objc 
    private func textFieldDidChange(_ textField: UITextField) {
        if (textField.text != nil) {
            switch textField {
            case digit1TextField:
                digit2TextField.becomeFirstResponder()
            case digit2TextField:
                digit3TextField.becomeFirstResponder()
            case digit3TextField:
                digit4TextField.becomeFirstResponder()
            case digit4TextField:
                digit4TextField.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    @objc
    private func continueButtonPressed() {
        guard activationCode.count == 4 else {
            ProgressHUD.showBanner("Oops", "Enter activation code")
            return
        }
        delegate?.readActivationCode(activationCode: activationCode)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? CGRect {
            let keyboardHeight = keyboardFrame.height + 16
            
            continueButton.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(-keyboardHeight)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(52)
            }

            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        continueButton.snp.remakeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer?) {
        endEditing(true)
    }
    
}

extension ActivationView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}
