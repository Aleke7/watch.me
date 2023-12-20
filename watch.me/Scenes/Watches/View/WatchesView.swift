import UIKit
import SnapKit

final class WatchesView: UIView {

    // MARK: - UI
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(WatchCell.self,
                                forCellWithReuseIdentifier: WatchCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let width = (UIScreen.main.bounds.width - 52) / 2
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                                  heightDimension: .absolute(220))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(220))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [layoutItem])
            layoutGroup.interItemSpacing = .fixed(20)
            
            let popularSectionLayout = NSCollectionLayoutSection(group: layoutGroup)
            popularSectionLayout.interGroupSpacing = 16
            popularSectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                                         leading: 16,
                                                                         bottom: 0,
                                                                         trailing: 16)
            return popularSectionLayout
        }
    }
    
    // MARK: - Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = AppColor.themeMainBackgroundColor.uiColor
        addSubview(mainCollectionView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Public
    
    public func getMainCollectionView() -> UICollectionView? {
        return mainCollectionView
    }
    
}
