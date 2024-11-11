// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public enum StatusTextField {
    case editingDidBegin
    case editingChanged
    case editingDidEnd
    case none
}


public class FloatingLabelTextField: UITextField{
    
    private var statusTextField: StatusTextField = .editingDidEnd
    private var isEditingDidBegin: Bool = false
    private var isRequired: Bool = false
    
    public var isOptionalField: Bool = false
    public var didEditingDidBegin: (() -> ())?
    
    public var getEventTextField: ((_ event: StatusTextField) -> ())?
    
    // MARK: - Handle title color
    public var titleName: String = "" {
        didSet {
            if isRequired {
                let last = " *"
                let fullText = titleName + last
                let rangesAndColors: [(NSRange, UIColor)] = [
                    (NSRange(location: 0, length: titleName.count), .black),
                    (NSRange(location: titleName.count, length: 2), .red),
                ]
                labelTitle.setAttributedTextWithColors(text: fullText,
                                                       rangesAndColors: rangesAndColors)
            } else {
                labelTitle.text = titleName
            }
        }
    }
    
    public var titleColor: UIColor = .black {
        didSet {
            labelTitle.textColor = titleColor
        }
    }
    
    public var isValidate: Bool = false {
        didSet {
            if isValidate {
                if statusTextField == .editingDidBegin {
                    viewBorder.layer.borderColor = UIColor.orange.cgColor
                } else if statusTextField == .editingChanged {
                    viewBorder.layer.borderColor = UIColor.blue.cgColor
                } else if statusTextField == .editingDidEnd {
                    viewBorder.layer.borderColor = UIColor.orange.cgColor
                }
            } else {
                viewBorder.layer.borderColor = UIColor.red.cgColor
            }
            
            stackWorning.isHidden = isValidate
        }
    }
    
    override public var backgroundColor: UIColor? {
        didSet {
            labelTitle.backgroundColor = backgroundColor
        }
    }
    
    private let labelTitle: SSPaddingLabel = {
        let label = SSPaddingLabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.text = "_"
        label.padding = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconWarning: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let labelWarning: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Field is required!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackWorning: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.isHidden = true
        return stack
    }()
    
    private let iconRightImg: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if text == "" && isEditingDidBegin == false {
            UIView.animate(withDuration: 0.2) { [self] in
                labelTitle.alpha = 0.5
                iconRightImg.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { [self] _ in
                labelTitle.alpha = 1
                iconRightImg.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        self.becomeFirstResponder()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setCornerRadius()
        setBorderColorDefault()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Handle TextField element change
extension FloatingLabelTextField {
    
    public func setCornerRadius(cornerRadius: CGFloat = 5) {
        viewBorder.layer.cornerRadius = cornerRadius
    }
    
    public func setBorderColorDefault(borderColor: UIColor = .lightGray,
                                      borderWidth: CGFloat = 1.5) {
        viewBorder.layer.borderColor = borderColor.cgColor
        viewBorder.layer.borderWidth = borderWidth
    }
    
    public func setBorderColorSelected(borderColor: UIColor = .blue,
                                       borderWidth: CGFloat = 2) {
        viewBorder.layer.borderColor = borderColor.cgColor
        viewBorder.layer.borderWidth = borderWidth
    }
    
    public func setBorderColorEditChange(borderColor: UIColor = .blue,
                                         borderWidth: CGFloat = 2) {
        viewBorder.layer.borderColor = borderColor.cgColor
        viewBorder.layer.borderWidth = borderWidth
    }
    
    public func setBorderColorEndEditChange(borderColor: UIColor = .lightGray,
                                            borderWidth: CGFloat = 1.5) {
        viewBorder.layer.borderColor = borderColor.cgColor
        viewBorder.layer.borderWidth = borderWidth
    }
    
    public func isRequiredStar() {
        isRequired = true
    }
    
    public func isOptionalTextField() {
        isOptionalField = true
    }
    
    public func setIconWarning(icon: UIImage,
                               text: String,
                               textColor: UIColor,
                               font: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)) {
        iconWarning.image = icon
        labelWarning.text = text
        labelWarning.textColor = textColor
        labelWarning.font = font
    }
    
    public func setIconTextFieldRight(icon: UIImage? = nil) {
        if let icon = icon {
            iconRightImg.image = icon
            setPadding(left: 12, right: 40)
        } else {
            setPadding(left: 12, right: 12)
        }
    }
}

// MARK: - Action textfield
extension FloatingLabelTextField {
    
    @objc private func editingDidBegin() {
        setBorderColorSelected()
        getEventTextField?(.editingDidBegin)
       
        
        statusTextField = .editingDidBegin
        stackWorning.isHidden = true
        isEditingDidBegin = true
        
        animateFloatingLabel(to: 1)
    }
    
    @objc private func editingChanged() {
        setBorderColorEditChange()
        getEventTextField?(.editingChanged)
        
        
        statusTextField = .editingChanged
    }
    
    @objc private func editingDidEnd() {
        setBorderColorEndEditChange()
        getEventTextField?(.editingDidEnd)
       
        
        isEditingDidBegin = false
        
        statusTextField = .editingDidEnd
        
        if text?.isEmpty == true {
            UIView.animate(withDuration: 0.2) {
                self.labelTitle.transform = .identity
            }
        }
    }
    
    private func animateFloatingLabel(to alpha: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.labelTitle.alpha = alpha
            self.labelTitle.transform = alpha == 1 ? CGAffineTransform(translationX: 0, y: -25) : .identity
        }
    }
}

// MARK: - Setup layoutConstraint
extension FloatingLabelTextField {
    
    private func setupUI() {
        let fullView = UIView(frame: self.bounds)
        fullView.backgroundColor = .orange.withAlphaComponent(0.1)
        addSubview(fullView)
        
        setPadding(left: 12, right: 12)
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(viewBorder)
        addSubview(labelTitle)
        addSubview(iconRightImg)
        addSubview(stackWorning)
        
        stackWorning.addArrangedSubview(iconWarning)
        stackWorning.addArrangedSubview(labelWarning)
        stackWorning.backgroundColor = .cyan.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            labelTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            
            viewBorder.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewBorder.heightAnchor.constraint(equalToConstant: 50),
            viewBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewBorder.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackWorning.topAnchor.constraint(equalTo: bottomAnchor,constant:  -10),
            stackWorning.leftAnchor.constraint(equalTo: viewBorder.leftAnchor),
            stackWorning.rightAnchor.constraint(equalTo: viewBorder.rightAnchor),
            
            iconWarning.heightAnchor.constraint(equalToConstant: 20),
            iconWarning.widthAnchor.constraint(equalToConstant: 20),
            
            iconRightImg.heightAnchor.constraint(equalToConstant: 20),
            iconRightImg.widthAnchor.constraint(equalToConstant: 20),
            iconRightImg.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconRightImg.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
        ])
        
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
}

// MARK: - Handle Array FloatingLabelTextField
//extension UIView {
//    
//    public func arrayTextFieldsResignFirstResponder(textFields: [FloatingLabelTextField]) {
//        textFields.forEach { $0.resignFirstResponder() }
//    }
//    
//    public func isValidateTextField(textFields: [FloatingLabelTextField],
//                                    success: @escaping (_ success: FloatingLabelTextField) -> (),
//                                    failure: @escaping (_ failure: FloatingLabelTextField) -> ()) {
//        textFields.forEach { item in
//            if (item.text == "" || item.text == "  ") && !item.isOptionalField {
//                item.isValidate = false
//                failure(item)
//            } else {
//                success(item)
//                item.isValidate = true
//            }
//        }
//    }
//}
