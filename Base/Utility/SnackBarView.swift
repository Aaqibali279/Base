//
//  SnackBarView.swift
//  WalletX
//
//  Created by ElintMinds_11 on 06/03/20.
//  Copyright © 2020 ElintMinds_11. All rights reserved.
//

import UIKit
class SnackBarView: UIView {
        
    private var label = { () -> UILabel in
        let label = UILabel()
        label.numberOfLines = 0
        label.tag = 94321
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var button = { () -> UIButton in
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("DONE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action:#selector(btnDoneAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    var action:(()->())?
    var message:String?{
        didSet{
            label.text = message
        }
    }
    var actionText:String?{
        didSet{
            button.setTitle(actionText, for: .normal)
        }
    }
    
    init(message:String?,actionText:String? = "DONE"){
        super.init(frame: .zero)
        
        tag = 943210
        layer.cornerRadius = 0
        clipsToBounds = true
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        
        label.text = message
        button.setTitle(actionText, for: .normal)
        
        let stack = UIStackView(arrangedSubviews: [label,button])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    func showSnackBar(action:(()->())?){
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        layoutIfNeeded()
        self.action = action
        let height = frame.height + 100
        transform = CGAffineTransform(translationX: 0, y: height)
        
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (finished) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let _ = self.superview{
                    self.removeSnackBar()
                }
            }
        }
    }
    
    
    private func removeSnackBar(){
        layoutIfNeeded()
        let height = frame.height + 100
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.transform = .init(translationX: 0, y: height)
        }) { (finished) in
            isSnackBarShown = false
            self.layer.removeAllAnimations()
            self.layoutIfNeeded()
            self.removeFromSuperview()
        }
    }
    
    @objc func btnDoneAction(){
        action?()
        removeSnackBar()
    }
    
    deinit {
        print("Removed",self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


    
    var isSnackBarShown = false
    
func showSnackBar(message:String?,actionText:String? = nil,action:(()->())? = nil){
        guard let window = UIApplication.shared.windows.last else {return}
        guard !isSnackBarShown else {
            if let snackBarView = window.viewWithTag(943210) as? SnackBarView{
                snackBarView.message = message
                snackBarView.actionText = actionText?.uppercased()
                snackBarView.action = action
            }
            return
        }
        isSnackBarShown = true
        
    let snackBarView = SnackBarView(message: message,actionText: actionText?.uppercased())
        
        window.addSubview(snackBarView)
        
        snackBarView.leadingAnchor.constraint(equalTo: window.leadingAnchor,constant: 0).isActive = true
        snackBarView.trailingAnchor.constraint(equalTo: window.trailingAnchor,constant: 0).isActive = true
        snackBarView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor,constant: 0).isActive = true
        
        
        snackBarView.showSnackBar(action:action)
        
        
    }
    
