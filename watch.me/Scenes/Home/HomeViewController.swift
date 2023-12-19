import UIKit

protocol HomeDisplayLogic: AnyObject {
    
}

final class HomeViewController: ThemedViewController, HomeDisplayLogic {

    // MARK: - Properties

    var router: HomeRoutingLogic?
    var interactor: HomeBusinessLogic?

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
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
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
    
}
