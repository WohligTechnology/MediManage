//
//  PageViewerController.swift
//  MediManage
//
//  Created by Harsh Thakkar on 20/05/16.
//  Copyright © 2016 Wohlig Technology. All rights reserved.
//

import UIKit

class PageViewerController: UIPageViewController, UIPageViewControllerDataSource {
    
    let image = ["splash1", "splash2", "splash3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myVC = viewControllerAtIndex(0) as! SplashScreenController
        let viewControllers = [myVC]
        
        dataSource = self
        
        setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)

        // Do any additional setup after loading the view.
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
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return image.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
