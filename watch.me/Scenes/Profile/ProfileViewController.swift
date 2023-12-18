import UIKit

protocol ProfileDisplayLogic: AnyObject {
    
}

final class ProfileViewController: ThemedViewController, ProfileDisplayLogic {
    
    // MARK: - Properties
    
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    var interactor: ProfileBusinessLogic?
    private var email: String
    
    // MARK: - Object Lifecycle
    
    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        let profileView = ProfileView(email: email)
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    // MARK: - Setup Navigation
    
    private func setupNavigation() {
        navigationItem.title = "Profile"
        let logoutButtonImage = UIImage(systemName: "person.crop.circle.badge.xmark")?.withTintColor(
            AppColor.themeButtonColor.uiColor,
            renderingMode: .alwaysOriginal)
        let logoutButton = UIBarButtonItem(image: logoutButtonImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    // MARK: - Actions
    
    @objc
    private func logoutButtonPressed() {
        
    }
    
}
