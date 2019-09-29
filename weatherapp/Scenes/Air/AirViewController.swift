import UIKit
import Hue

protocol AirViewControllerInput: class {
    func display(_ state: Air.View.State)
}

final class AirViewController: UIViewController {
    
    private var air: Weather
    
    private var interactor: AirInteractorInput!
    private var router: AirRouterInput!
    
    init(with weather: Weather) {
        air = weather
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        interactor.setup(air)
    }
    
    // MARK: - Configuration & Setup
    
    private func configure() {
        let viewController = self
        let interactor = AirInteractor()
        let presenter = AirPresenter()
        let router = AirRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    func setBackground() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(hex: "#C86DD8").cgColor, UIColor(hex: "#3327AE").cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}

extension AirViewController: AirViewControllerInput {
    
    func display(_ state: Air.View.State) {
        let airStack = AirUIBuilder.airStack(state)
        view.addSubview(airStack)
        airStack.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        airStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            airStack.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0).isActive = true
            //guide.bottomAnchor.constraintEqualToSystemSpacingBelow(airStack.bottomAnchor, multiplier: 1.0).isActive = true
            guide.bottomAnchor.constraint(equalTo: airStack.bottomAnchor, constant: 50).isActive = true
        } else {
            airStack.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
            airStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
}

extension AirViewController: UIGestureRecognizerDelegate {
    
    @objc func tappedImage(sender: AnyObject) {
        router.routeToHome()
    }
}
