import UIKit

final class InputTextField: UITextField {

    private var padding: UIEdgeInsets
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(isPassword: Bool) {
        self.padding = isPassword
                       ? UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 50)
                       : UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = AppFont.medium.s16()
        borderStyle = .roundedRect
        textColor = AppColor.grey60.uiColor
        autocorrectionType = .no
        spellCheckingType = .no
        clipsToBounds = true
        backgroundColor = AppColor.themeSecondaryBackgroundColor.uiColor
        autocapitalizationType = .none
    }
    
}
