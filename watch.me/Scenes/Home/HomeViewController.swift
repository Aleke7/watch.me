import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayWatches(viewModel: HomeModels.ViewModel)
}

final class HomeViewController: ThemedViewController {

    // MARK: - Properties

    var router: HomeRoutingLogic?
    var interactor: HomeBusinessLogic?
    
    private var watches: [Watch] = []
    private var currentPage: Int = 1
    private var pageSize: Int = 8
    private var totalRecords: Int = 0
    
    private var brands: [Brand] = [
        Brand(imageURL: "https://www.butterfieldjewelers.com/media/catalog/category/tissot_1.jpg"),
        Brand(imageURL: "https://www.thewatchcompany.com/media/tm_blog/p/o/7/6485/post_7_6485.jpg"),
        Brand(imageURL: "https://usa.watchpro.com/2019/09/Patek-Philippe-logo2.jpg"),
        Brand(imageURL: "https://1000logos.net/wp-content/uploads/2018/10/watch-brand-Panerai.jpg")
    ]
    
    private var collectionView: UICollectionView? {
        return (view as? HomeView)?.getMainCollectionView()
    }

    // MARK: - Object Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        let homeView = HomeView()
        homeView.getMainCollectionView()?.delegate = self
        homeView.getMainCollectionView()?.dataSource = self
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        requestWatches()
    }
    
    // MARK: - Setup Navigation
    
    private func setupNavigation() {
        navigationItem.title = "Watch.me"
        if let navigationBar = navigationController?.navigationBar {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: AppFont.headerTitle.s26()]
            navigationBar.standardAppearance = navBarAppearance
        }
    }
    
    // MARK: - Request
    
    private func requestWatches() {
        let request = HomeModels.Request(page: currentPage, pageSize: pageSize)
        interactor?.getWatches(request: request)
    }
    
}

// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    func displayWatches(viewModel: HomeModels.ViewModel) {
        watches = viewModel.watches
        collectionView?.reloadData()
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return brands.count
        }
        return watches.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let brandCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BrandCell.identifier,
                for: indexPath) as? BrandCell else {
                return UICollectionViewCell()
            }
            
            let brand = brands[indexPath.item]
            brandCell.configure(brand: brand)
            return brandCell
        }
        
        guard let watchCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WatchCell.identifier,
            for: indexPath) as? WatchCell else {
            return UICollectionViewCell()
        }
        let watch = watches[indexPath.item]
        watchCell.configure(watch: watch)
        return watchCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                guard let brandsSectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: BrandHeaderView.identifier,
                    for: indexPath) as? BrandHeaderView else {
                    return UICollectionReusableView()
                }
                
                return brandsSectionHeader
            }
            
            guard let popularSectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PopularHeaderView.identifier,
                for: indexPath) as? PopularHeaderView else {
                return UICollectionReusableView()
            }
            
            return popularSectionHeader
        }
        
        return UICollectionReusableView()
    }
}
