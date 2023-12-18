import UIKit

final class ProceedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = AppColor.themeButtonColor.uiColor
        setTitleColor(AppColor.themeMainBackgroundColor.uiColor, for: .normal)
        titleLabel?.font = AppFont.bold.s16()
    }
    
}
