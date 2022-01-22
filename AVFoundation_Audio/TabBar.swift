import Foundation

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controllerSetup()
    }

    func controllerSetup(){
        viewControllers = [
            createNavController(for: AudioViewController(), title: "Audio", image: UIImage(systemName: "music.note")!),
            createNavController(for: VideoViewController(), title: "Video", image: UIImage(systemName: "film")!)
        ]
    }

    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.isTranslucent = true
        rootViewController.navigationItem.title = title
        return navController
    }
}




