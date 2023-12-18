import UIKit

final class InputTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = AppFont.medium.s16()
        textColor = AppColor.grey40.uiColor
        textAlignment = .left
    }
    
}
