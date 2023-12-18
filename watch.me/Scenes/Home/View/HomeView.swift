import UIKit
import SnapKit

final class HomeView: UIView {
    
    // MARK: - UI
    
//    private lazy var mainCollectionView: UICollectionView = {
//        let 
//    }()
    
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        return UICollectionViewCompositionalLayout { sectionIndex, _ in
//            if sectionIndex == 0 {
//                
//            }
//        }
//    }
    
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
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = AppColor.themeMainBackgroundColor.uiColor
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
    }
    
}
