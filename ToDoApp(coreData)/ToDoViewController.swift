//
//  ToDoViewController.swift
//  ToDoApp(coreData)
//
//  Created by Dmitry Logachev on 05.04.2022.
//

import UIKit

class ToDoViewController: UIViewController {
    private lazy var textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews(textField)
        setConstraints()
    }
    
    private func setupSubViews(_ subview: UIView...) {
        subview.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
