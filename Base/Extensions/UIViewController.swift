//
//  UIViewController.swift
//  Base
//
//  Created by Aqib Ali on 28/06/20.
//  Copyright © 2020 Aqib Ali. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func set(title:String?,titleColor:UIColor = UIColor.white,barTintColor:UIColor = UIColor.blue,largeNavBarColor:UIColor = .white,prefersLargeTitles:Bool = true,font: UIFont? = UIFont.systemFont(ofSize: 16, weight: .light)){
        
        navigationController?.view.backgroundColor = largeNavBarColor
        
        self.navigationItem.title = title
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        self.navigationController?.navigationBar.backgroundColor = largeNavBarColor
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                     .font:UIFont.systemFont(ofSize: 24, weight: .medium)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor,
                                                .font:font!]
        navBarAppearance.backgroundColor = barTintColor
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.compactAppearance = navBarAppearance
        
        if prefersLargeTitles{
            let largeNavBarAppearance = UINavigationBarAppearance()
            largeNavBarAppearance.configureWithDefaultBackground()
            largeNavBarAppearance.shadowImage = UIImage()
            largeNavBarAppearance.shadowColor = .clear
            largeNavBarAppearance.titleTextAttributes = [.foregroundColor: titleColor,
                                                         .font:font!]
            largeNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                              .font:UIFont.systemFont(ofSize: 24, weight: .medium)]
            largeNavBarAppearance.backgroundColor = largeNavBarColor
            self.navigationController?.navigationBar.scrollEdgeAppearance = largeNavBarAppearance
        }
    
    }
    
    
    
    
    
    func setBackButton(){
        setLeftBarButton(selector:#selector(back))
    }
    
    func setLeftBarButton(selector:Selector){
        
        let leftBarButtonItem = UIBarButtonItem(image: Image.back, style: .plain, target: self, action: selector)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    func setCrossButton(tintColor:UIColor = .black,selector:Selector = #selector(popToRootVC)){
        
        setRightBarButton(tintColor: tintColor, selector: selector, image: Image.cross)
    }
    
    func setRightBarButton(tintColor:UIColor = .black,selector:Selector,image:UIImage?){
        let rightBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    
    
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func popToRootVC(){
        navigationController?.isNavigationBarHidden = true
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    @objc func popToInviteVC(){
//        for vc in navigationController?.viewControllers ?? []{
//            if vc is InviteViewController{
//                navigationController?.popToViewController(vc, animated: true)
//            }
//        }
    }
    
    @objc func close(){
        dismiss(animated: true)
    }
    
}

