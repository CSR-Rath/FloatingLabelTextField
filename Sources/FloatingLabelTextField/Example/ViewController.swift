//
//  ViewController.swift
//  
//
//  Created by Rath! on 11/11/24.
//

import UIKit
import FloatingLabelTextField


//class ViewController: UIViewController {
//    
//    private var nsButton : NSLayoutConstraint!
//    private var textFields : [FloatingLabelTextField] = []
//    
//    lazy var btnDone: UIButton = {
//        let btn = UIButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .orange
//        btn.setTitle("Done", for: .normal)
//        btn.addTarget(self, action:  #selector(didSwitch), for: .touchUpInside)
//        return btn
//    }()
//    
//    lazy var textField: FloatingLabelTextField = {
//        let textField = FloatingLabelTextField()
//        textField.setTilteName(titleName: "Email", isStar: true)
//        textField.setIconTextFieldRight(icon: .image)
//        textField.setIconWarning(icon: .icWarning, text: "Fied email is required", textColor: .red)
//        return textField
//    }()
//    
//    lazy var textField2: FloatingLabelTextField = {
//        let textField = FloatingLabelTextField()
//        textField.setTilteName(titleName: "DOB")
//        textField.setIconWarning(icon: .icWarning, text: "Fied DOB is required", textColor: .red)
//        return textField
//    }()
//    
//    lazy var textField3: FloatingLabelTextField = {
//        let textField = FloatingLabelTextField()
//        textField.setTilteName(titleName: "Select")
//        
//        textField.setIconWarning(icon: .icWarning,
//                                 text: "Fied Select Gender is required",
//                                 textColor: .red)
//        return textField
//    }()
//    
//    lazy var textField4: FloatingLabelTextField = {
//        let textField = FloatingLabelTextField()
//        textField.isOptionalTextField()
//        textField.setTilteName(titleName: "Optional",titleColor: .blue)
//        return textField
//    }()
//    
//    
//    lazy var stackContainer: UIStackView = {
//        let stack  = UIStackView(arrangedSubviews: [ textField,textField2,textField3,textField4,btnDone])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.spacing = 10
//        stack.distribution = .fill
//        return stack
//    }()
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        textFields.forEach({ item in
//            item.resignFirstResponder()
//            
//        })
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupConstraint()
//        
//        
//        textFields = [textField,textField2,textField3,textField4]
//        
//        actionTextFields(textFields: textFields)
//    }
//    
//    deinit{
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    private func setupConstraint(){
//        
//        view.addSubview(stackContainer)
//        
//        NSLayoutConstraint.activate([
//            stackContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
//            stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            //=====
//            btnDone.heightAnchor.constraint(equalToConstant: 50),
//            btnDone.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
//            btnDone.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//        ])
//        
//    }
//    
//    @objc private func didSwitch(){
//        
//        reloadLabel()
//    }
//    
//    
//    
//    private func actionTextFields(textFields: [FloatingLabelTextField]){
//        
//        // Setup when touch begin textfields
//        textFields.forEach({ textField in
//            
//            textField.getEventTextField  = { [self] even in
//                
//                switch even{
//                    
//                case .editingDidBegin:
//                    
//                    textField.isShowWarning(status: true)
//                    textField.setBorderColor(borderColor: .orange, borderWidth: 2)
//                    stackContainer.setCustomSpacing(10, after: textField)
//                    
//                    
//                case .editingChanged:
//                    textField.isShowWarning(status: true)
//                    textField.setBorderColor(borderColor: .orange, borderWidth: 2)
//                    stackContainer.setCustomSpacing(10, after: textField)
//                    
//                case .editingDidEnd:
//                    
//                    textField.setBorderColor(borderColor: .lightGray, borderWidth: 1.5)
//                    
//                case .none:
//                    
//                    break
//                }
//            }
//        })
//        
//    }
//    
//    
//    private func reloadLabel(){
//        
//        view.isValidateTextField(textFields: textFields) { [self] textField in
//            stackContainer.setCustomSpacing(10, after: textField)
//        } failure: { [self] textField in
//            textField.setBorderColor(borderColor: .red, borderWidth: 1.5)
//            stackContainer.setCustomSpacing(20, after: textField)
//        }
//    }
//}
