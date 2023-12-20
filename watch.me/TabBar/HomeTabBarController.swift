import UIKit

final class HomeTabBarController: UITabBarController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupTabbar()
        selectedIndex = 1
    }
    
    // MARK: - Setup Tab Bar
    
    private func setupTabBarAppearance() {
        let positionOnX: CGFloat = 90
        let positionOnY: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX,
                                y: tabBar.bounds.minY - positionOnY,
                                width: width,
                                height: height),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.addSublayer(roundLayer)
        
        tabBar.itemWidth = width / 6
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = AppColor.grey70.cgColor
        tabBar.tintColor = AppColor.grey0.uiColor
        tabBar.unselectedItemTintColor = AppColor.grey60.uiColor
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
    }
    
    private func setupTabbar() {
        let imageYPositionAdjustment: CGFloat = -20
        let first = UINavigationController(rootViewController: WatchesAssembler.assemble())
        first.tabBarItem = UITabBarItem(title: nil,
                                        image: UIImage(systemName: "watch.analog"),
                                        selectedImage: UIImage(systemName: "watch.analog"))
        first.tabBarItem.imageInsets = UIEdgeInsets(top: imageYPositionAdjustment,
                                                    left: 0,
                                                    bottom: -imageYPositionAdjustment,
                                                    right: 0)
        
        let second = UINavigationController(rootViewController: HomeAssembler.assemble())
        second.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house.fill"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        second.tabBarItem.imageInsets = UIEdgeInsets(top: imageYPositionAdjustment,
                                                     left: 0,
                                                     bottom: -imageYPositionAdjustment,
                                                     right: 0)
        
        let third = UINavigationController(rootViewController: ProfileAssembler.assemble())
        third.tabBarItem = UITabBarItem(title: nil,
                                        image: UIImage(systemName: "person.fill"),
                                        selectedImage: UIImage(systemName: "person.fill"))
        third.tabBarItem.imageInsets = UIEdgeInsets(top: imageYPositionAdjustment,
                                                    left: 0,
                                                    bottom: -imageYPositionAdjustment,
                                                    right: 0)
        
        self.viewControllers = [first, second, third]
    }
}
