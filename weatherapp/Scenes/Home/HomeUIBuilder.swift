import UIKit
import Hue

struct HomeUIBuilder {
    
    static var logo: UIImageView {
        let image = #imageLiteral(resourceName: "homelogo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    //TODO: Tekstai turi but confige arba presenteri
    static var cityInput: UITextField {
        let inputField =  UITextField()
        inputField.attributedPlaceholder = NSAttributedString(
            string: "ENTER CITY NAME",
            attributes: [NSAttributedStringKey.foregroundColor: UIColor(hex: "#C26BD6")]
        )
        inputField.setLeftPaddingPoints(10)
        inputField.font = UIFont.systemFont(ofSize: 12)
        inputField.textColor = UIColor(hex: "#C26BD6")
        inputField.backgroundColor = .white
        inputField.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner])
        inputField.contentVerticalAlignment = .center
        inputField.addTarget(
            self,
            action: #selector(HomeViewController.cityInputPressed),
            for: .touchDown
        )
        let inputHeight = NSLayoutConstraint(item: inputField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        inputField.addConstraint(inputHeight)
        return inputField
    }
    
    static var citySubmit: UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        button.addTarget(
            self,
            action: #selector(HomeViewController.cityInputSubmit),
            for: .touchUpInside
        )
        let buttonWidth = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        let buttonHeight = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        button.addConstraints([buttonWidth, buttonHeight])
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    static var inputStack: UIStackView {
        let stackView = UIStackView(arrangedSubviews: [cityInput, citySubmit])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    static var homeStack: UIStackView {
        let stackView = UIStackView(arrangedSubviews: [logo, inputStack])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
