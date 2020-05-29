//
//  HomeTabbar.swift
//  guest-escort
//
//  Created by MacbookPro on 1/2/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

enum TabbarType: Int, CaseIterable {
    case home
//    case search
    case notify
    case profile
    case tips
    
    var icon: (normal: UIImage?, selected: UIImage?) {
        switch self {
        case .home:
            return (UIImage(named: "ic_boom"), UIImage(named: "ic_boom"))
        case .notify:
            return (UIImage(named: "feedback"), UIImage(named: "feedback"))
//        case .search:
//            return (UIImage(named: "plus"), UIImage(named: "plus"))
        case .profile:
            return (UIImage(named: "tips"), UIImage(named: "tips"))
        case .tips:
            return (UIImage(named: "contact"), UIImage(named: "contact"))
        }
    }
    
}

class HomeTabbar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
    }
    override func viewWillLayoutSubviews() {
        self.tabBar.frame.origin.y = self.view.frame.height - 80
        self.tabBar.frame.size.height = 80
    }
    
    private func visualize() {
//        let home = UIStoryboard.init(name: "HomeScreenVC", bundle: nil).instantiateViewController(withIdentifier: "HomeScreenVC") as! HomeScreenVC
        //        let home = HomeScreenVC()
        let home = HomeScreenVC(nibName: "HomeScreenVC", bundle: nil)
        let notify = FeedBacckVC(nibName: "FeedBacckVC", bundle: nil)
        let tipsApple = TipsApple(nibName: "TipsApple", bundle: nil)
        let profile = ContactVC(nibName: "ContactVC", bundle: nil)

        
        //        ProfileVC
        viewControllers = [home, notify, tipsApple, profile]
        TabbarType.allCases.forEach { (type) in
            if let controller = viewControllers {
                let item = controller[type.rawValue]
                item.tabBarItem.image = type.icon.normal
                item.tabBarItem.selectedImage = type.icon.selected
                item.tabBarItem.imageInsets = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
    
}
