import UIKit

protocol WatchesDisplayLogic: AnyObject {
    func displayWatches(viewModel: WatchesModels.ViewModel)
}

final class WatchesViewController: ThemedViewController {

    // MARK: - Properties

    var router: WatchesRoutingLogic?
    var interactor: WatchesBusinessLogic?
    
    private var watches: [Watch] = []
    private var currentPage: Int = 1
    private var pageSize: Int = 8
    private var totalRecords: Int = 0
    private var isLoadingMoreData = false
    private var searchText: String?
    private var loadMoreDebouncer: Debouncer?
    
    private var collectionView: UICollectionView? {
        return (view as? WatchesView)?.getMainCollectionView()
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
        let watchesView = WatchesView()
        view = watchesView
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation() 
        requestWatches()
        loadMoreDebouncer = Debouncer(delay: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentPage = 1
        searchText = nil
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - Setup Navigation
    
    private func setupNavigation() {
        navigationItem.title = "Watches"
        navigationController?.navigationBar.prefersLargeTitles = true
        if let navigationController = navigationController {
            let attributes = [NSAttributedString.Key.foregroundColor: AppColor.themeButtonColor.uiColor]
            navigationController.navigationBar.largeTitleTextAttributes = attributes
        }
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self,
                                           action: #selector(searchButtonTapped))
        searchButton.tintColor = AppColor.themeButtonColor.uiColor
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - Request
    
    private func requestWatches() {
        let request = WatchesModels.Request(searchText: searchText ?? "",
                                            page: currentPage,
                                            pageSize: pageSize)
        interactor?.getWatches(request: request)
    }
    
    private func loadMoreWatches() {
        guard !isLoadingMoreData else {
            return
        }
        currentPage += 1
        isLoadingMoreData = true
        requestWatches()
    }
    
    // MARK: - Actions
    
    @objc
    private func searchButtonTapped() {
        router?.routeToSearch(navigationController: navigationController)
    }

}

// MARK: - WatchesDisplayLogic

extension WatchesViewController: WatchesDisplayLogic {
    func displayWatches(viewModel: WatchesModels.ViewModel) {
        watches.append(contentsOf: viewModel.watches)
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.isLoadingMoreData = false
        }
        
    }
    
}

extension WatchesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return watches.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let watchCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WatchCell.identifier,
            for: indexPath) as? WatchCell else {
            return UICollectionViewCell()
        }
        let watch = watches[indexPath.row]
        watchCell.configure(watch: watch)
        return watchCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        let nearBottom = contentOffsetY + scrollViewHeight >= contentHeight - 100
        
        loadMoreDebouncer?.call {
            if nearBottom {
                self.loadMoreWatches()
            }
        }
    }
    
}

extension WatchesViewController: SearchWatchesDelegate {
    func reloadWatches(watches: [Watch]) {
        self.watches = watches
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}
