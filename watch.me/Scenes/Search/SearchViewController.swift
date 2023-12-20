import UIKit
import SnapKit

protocol SearchDisplayLogic: AnyObject {
    func displayWatches(viewModel: WatchesModels.ViewModel)
}

protocol SearchWatchesDelegate: AnyObject {
    func reloadWatches(watches: [Watch])
}

final class SearchViewController: ThemedViewController {

    // MARK: - Properties

    var router: SearchRoutingLogic?
    var interactor: SearchBusinessLogic?
    
    weak var delegate: SearchWatchesDelegate?
    
    private var searches: [SearchModel] = HistoryService.shared.retrieveSearchModels()
    
    // MARK: - UI
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .prominent
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    private lazy var searchHistoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchHistoryCell.self,
                           forCellReuseIdentifier: SearchHistoryCell.identifier)
        tableView.rowHeight = 30
        tableView.backgroundColor = .red
        return tableView
    }()
    
    
    // MARK: - Object Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.searchHistoryTableView.reloadData()
        }
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.themeMainBackgroundColor.uiColor
        view.addSubview(searchBar)
        view.addSubview(searchHistoryTableView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        searchHistoryTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - SearchDisplayLogic

extension SearchViewController: SearchDisplayLogic {
    func displayWatches(viewModel: WatchesModels.ViewModel) {
        delegate?.reloadWatches(watches: viewModel.watches)
    }
    
}

// MARK: - SearchDelegate

extension SearchViewController: SearchDelegate {
    func readSearchBar(text: String) {
        searches = HistoryService.shared.retrieveSearchModels()
        searches.removeAll { $0.text == text }
        searches.insert(SearchModel(text: text), at: 0)
        DispatchQueue.main.async {
            self.searchHistoryTableView.reloadData()
        }
        HistoryService.shared.saveSearchModels(searches)
        print(searches)
        let request = SearchModels.Request(searchText: text,
                                           page: 1,
                                           pageSize: 20)
        interactor?.searchWatches(request: request)
    }
    
    func hideSearchBar() {
        dismiss(animated: true)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(searches.count)
        return searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryCell.identifier,
                                                       for: indexPath) as? SearchHistoryCell else {
            return UITableViewCell()
        }
        
        let searchModel = searches[indexPath.row]
        cell.configure(searchModel: searchModel)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - HistoryDelegate

extension SearchViewController: HistoryDelegate {
    func deleteHistory(id: UUID?) {
        searches = HistoryService.shared.retrieveSearchModels()
        searches.removeAll { $0.id == id }
        DispatchQueue.main.async {
            self.searchHistoryTableView.reloadData()
        }
        HistoryService.shared.saveSearchModels(searches)
    }
    
    func searchHistory(text: String) {
        searchBar.text = text
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            readSearchBar(text: searchText)
        }
        
        searchBar.resignFirstResponder()
        hideSearchBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
}
