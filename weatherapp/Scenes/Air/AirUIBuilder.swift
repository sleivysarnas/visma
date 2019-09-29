import UIKit
import Hue

struct AirUIBuilder {
    //TODO: Cia ir kitur viska ismest i viena funkcija perpanaudojimui, kur galima
    static var logo: UIImageView {
        let image = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    static var backButton: UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(
            self,
            action: #selector(AirViewController.tappedImage),
            for: .touchUpInside
        )
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        return button
    }
    
    static func label(text: String,
                      fontSize: CGFloat = 17,
                      textColor: UIColor = .white,
                      textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
    
    static func temperature(_ temperature: String) -> UILabel {
        return label(
            text: "\(temperature)°",
            fontSize: 160,
            textAlignment: .center
        )
    }
    
    //TODO: Visus tuos ihardcodintus dydzius iskelt i exxtension
    static func name(_ name: String) -> UILabel {
        return label(
            text: name,
            fontSize: 23,
            textAlignment: .center
        )
    }
    
    static func minMaxTemperature(_ temperature: String) -> UILabel {
        return label(
            text: temperature,
            textColor: UIColor(hex: "#3726B0")
        )
    }
    
    static func description(_ description: String) -> UILabel {
        return label(
            text: description,
            textColor: UIColor(hex: "#3726B0")
        )
    }
    
    static func descriptionStack(_ state: Air.View.State) -> UIStackView  {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(minMaxTemperature(state.minMaxTemperature))
        stackView.addArrangedSubview(description(state.description))
        return stackView
    }
    
    static func airStack(_ state: Air.View.State) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(temperature(state.temperature))
        stackView.addArrangedSubview(name(state.name))
        stackView.addArrangedSubview(descriptionStack(state))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
