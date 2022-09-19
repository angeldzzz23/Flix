//
//  TabBarVienctronller.swift
//  Flix
//
//  Created by Angel Zambrano on 9/13/22.
//

import UIKit

class TabBarVienctronller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let vc1 = UINavigationController(rootViewController: MovieViewController())
        vc1.title = "hh"
        
        
        
        let vc2 = UINavigationController(rootViewController: UIViewController())
        vc2.title = "aa"
//        vc2.view.backgroundColor = .yellow
        
        let vc3 = UINavigationController(rootViewController: UIViewController())
        vc3.title = "settings"
        
        let vcs = [vc1, vc2,vc3]
        
//        self.tabBar.isTranslucent = false
        
        setViewControllers(vcs, animated: true)
        
        let images = ["now_playing_tabbar_item", "superhero_tabbar_item"]
        
        guard let items = tabBar.items else {return}
        
        for x in 0..<items.count-1 {
            items[x].image = UIImage(named: images[x])!
        }
        
        items[2].image = UIImage(systemName: "gear")!
        
    
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
