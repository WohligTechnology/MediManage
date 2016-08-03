
//  PageViewerController.swift

//  MediManage

//

//  Created by Harsh Thakkar on 20/05/16.

//  Copyright © 2016 Wohlig Technology. All rights reserved.

//



import UIKit



class PageViewerController: UIPageViewController, UIPageViewControllerDataSource, UIGestureRecognizerDelegate {
    
    
    
    let image = ["splash1", "splash2", "splash3"]
    
    var enrollmentMembersController: UIViewController!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let token = defaultToken.stringForKey("access_token")
        
        let myVC = viewControllerAtIndex(0) as! SplashScreenController
        
        let viewControllers = [myVC]
        
        setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        
        dataSource = self
        
        defaultToken.setObject(true, forKey: "onSplashScreen")

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        
        
        let vc = viewController as! SplashScreenController
        
        var index = vc.pageIndex  as Int
        
        if((index == 0) || (index == NSNotFound)) {
            
            
            
            return nil
            
        }
        
        
        
        index = index - 1
        
        
        
        return viewControllerAtIndex(index)
        
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! SplashScreenController
        
        var index = vc.pageIndex  as Int
        
        if(index == NSNotFound) {
            
            return nil
            
        }
        
        
        
        index = index + 1
        
        
        
        if(index == image.count) {
            
            return nil
            
        }
        
        return viewControllerAtIndex(index)
        
    }
    
    
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        
        if((self.image.count == 0) || (index >= self.image.count)) {
            
            return SplashScreenController()
            
        }
        
        
        
        let myVC = storyboard?.instantiateViewControllerWithIdentifier("splashScreenStoryBoard") as! SplashScreenController
        
        myVC.backgroundImage = image[index]
        
        myVC.pageIndex = index
        
        return myVC
        
    }
}

