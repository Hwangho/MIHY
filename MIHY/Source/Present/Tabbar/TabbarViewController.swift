//
//  TabbarViewController.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/11.
//

import UIKit



class TabbarViewController: UITabBarController {
    
    enum type: Int {
        case policy
        case spacy
    }
    
    
    let policySupportViewController = PolicySupportViewController()
    
    let spaceRentalViewController = SpaceRentalViewController()
    
    
    // variable
    var defaultIndex: type {
        didSet {
            self.selectedIndex = defaultIndex.rawValue
        }
    }
    
    
    // initialize
    init(index: type) {
        self.defaultIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabbar()
    }
    
    
    // Custom Func
    private func setupAttributes() {
        view.backgroundColor = Color.BaseColor.background
        
        tabBar.backgroundColor = UIColor.white
        tabBar.tintColor = Color.BaseColor.highlight
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.isHidden = false
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tabBar.addSubview(lineView)
    }
    
    func setTabbar() {
        let firstNavigationController = UINavigationController()
        
        firstNavigationController.addChild(policySupportViewController)
        firstNavigationController.tabBarItem.image = UIImage(systemName: "text.book.closed")
        
        let secondNavigationController = UINavigationController()
        secondNavigationController.addChild(spaceRentalViewController)
        secondNavigationController.tabBarItem.image = UIImage(systemName: "map")
        
        let viewControllers = [firstNavigationController, secondNavigationController]
        self.setViewControllers(viewControllers, animated: true)
    }
}


