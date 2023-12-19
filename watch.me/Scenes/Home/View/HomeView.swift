import UIKit
import SnapKit

final class HomeView: UIView {
    
    // MARK: - UI
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(BrandHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: BrandHeaderView.identifier)
        collectionView.register(BrandCell.self,
                                forCellWithReuseIdentifier: BrandCell.identifier)
        collectionView.register(PopularHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PopularHeaderView.identifier)
        collectionView.register(WatchCell.self,
                                forCellWithReuseIdentifier: WatchCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(30))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                
                let width = UIScreen.main.bounds.width * 0.7
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(170))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                                       heightDimension: .absolute(180))
                
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                     subitems: [layoutItem])
                layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                                    leading: 0,
                                                                    bottom: 0,
                                                                    trailing: 0)
                layoutGroup.interItemSpacing = .fixed(2)
                let brandsSectionLayout = NSCollectionLayoutSection(group: layoutGroup)
                brandsSectionLayout.orthogonalScrollingBehavior = .continuous
                brandsSectionLayout.boundarySupplementaryItems = [headerItem]
                
                return brandsSectionLayout
            }
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(30))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
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
            popularSectionLayout.boundarySupplementaryItems = [headerItem]
            
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
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
