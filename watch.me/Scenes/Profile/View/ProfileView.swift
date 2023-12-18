import UIKit
import SnapKit

final class ProfileView: UIView {
    
    // MARK: - UI
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SeparatorCell.self, forCellReuseIdentifier: SeparatorCell.identifier)
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(EmailCell.self, forCellReuseIdentifier: EmailCell.identifier)
        tableView.register(DarkThemeCell.self, forCellReuseIdentifier: DarkThemeCell.identifier)
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = 40
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
        addSubview(profileTableView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        profileTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath)
                    as? TitleCell else {
                return UITableViewCell(frame: .zero)
            }
            return cell
        }
        
        if indexPath.row == 2 {
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: EmailCell.identifier, for: indexPath)
                    as? EmailCell else {
                return UITableViewCell(frame: .zero)
            }
            return cell
        }
        
        if indexPath.row == 3 {
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: DarkThemeCell.identifier, for: indexPath)
                    as? DarkThemeCell else {
                return UITableViewCell(frame: .zero)
            }
            cell.configure(isOn: (ThemeManager.shared.currentTheme == .dark))
            return cell
        }
        
        if indexPath.row == 4 {
            guard let cell =
                    tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath)
                    as? FavoritesCell else {
                return UITableViewCell(frame: .zero)
            }
            return cell
        }
        
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: SeparatorCell.identifier, for: indexPath)
                as? SeparatorCell else {
            return UITableViewCell(frame: .zero)
        }
        
        return cell
    }
    
}
