import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemOrange
        tabBar.unselectedItemTintColor = .systemGray
        
        // Add subtle shadow
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOpacity = 0.1
    }
    
    private func setupViewControllers() {
        let homeFeedVC = HomeFeedViewController()
        let homeFeedNav = UINavigationController(rootViewController: homeFeedVC)
        homeFeedNav.tabBarItem = UITabBarItem(title: "Home Feed", image: UIImage(systemName: "house"), tag: 0)
        
        let myCatsVC = MyCatsViewController()
        let myCatsNav = UINavigationController(rootViewController: myCatsVC)
        myCatsNav.tabBarItem = UITabBarItem(title: "My Cats", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        let uploadVC = UploadViewController()
        let uploadNav = UINavigationController(rootViewController: uploadVC)
        // Make the center button larger and more prominent
        uploadNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        uploadNav.tabBarItem.imageInsets = UIEdgeInsets(top: -4, left: 0, bottom: 4, right: 0)
        
        let careVC = CareViewController()
        let careNav = UINavigationController(rootViewController: careVC)
        careNav.tabBarItem = UITabBarItem(title: "Care", image: UIImage(systemName: "cross.case"), tag: 3)
        
        let settingsVC = SettingsViewController()
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        viewControllers = [homeFeedNav, myCatsNav, uploadNav, careNav, settingsNav]
    }
}