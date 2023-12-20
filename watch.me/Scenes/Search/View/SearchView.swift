import UIKit
import SnapKit

protocol SearchDelegate: AnyObject {
    func readSearchBar(text: String)
    func hideSearchBar()
}

final class SearchView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SearchDelegate?

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
        addSubview(searchBar)
        addSubview(searchHistoryTableView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        searchHistoryTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Public
    
    public func getHistoryTableView() -> UITableView {
        return searchHistoryTableView
    }
    
    public func getSearchBar() -> UISearchBar {
        return searchBar
    }
    
}

extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            delegate?.readSearchBar(text: searchText)
        }
        
        searchBar.resignFirstResponder()
        delegate?.hideSearchBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.hideSearchBar()
    }
}
