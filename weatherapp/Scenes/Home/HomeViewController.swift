import UIKit
import GooglePlaces
import GoogleMaps
import GooglePlacePicker

protocol HomeViewControllerInput: class {
    func setupLayout()
    func display(_ weather: Weather)
    func display(_ error: UIAlertController)
    func cityInputPressed(cityInput: UITextField)
}

final class HomeViewController: UIViewController {
    
    private var city: String?
    private let homeStack: UIStackView
    
    private var interactor: HomeInteractorInput!
    private var router: HomeRouterInput!
    
    // MARK: - Initializers
    
    init() {
        homeStack = HomeUIBuilder.homeStack
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        setupLayout()
        setBackground()
    }
    
    // MARK: - Configuration & Setup
    
    private func configure() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    func setupLayout() {
        view.addSubview(homeStack)
        homeStack.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        homeStack.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        homeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setBackground() {
        let background = UIImage(named: "background")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
}

extension HomeViewController: HomeViewControllerInput {
    
    func display(_ weather: Weather) {
        router.routeToWeather(with: weather)
    }
    
    func display(_ error: UIAlertController) {
        self.present(error, animated: true, completion: nil)
    }
    
    @objc func cityInputPressed(cityInput: UITextField) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        acController.autocompleteFilter = GMSAutocompleteFilter()
        acController.autocompleteFilter?.type = .city
        self.present(acController, animated: true, completion: nil)
    }
    
    @objc func cityInputSubmit(sender: UIButton!) {
        for subview in homeStack.subviews[1].subviews {
            if let cityInput = subview as? UITextField {
                interactor.submitCityInput(cityInput.text)
            }
        }
    }
}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        for subview in homeStack.subviews[1].subviews {
            if let cityInput = subview as? UITextField {
                cityInput.text = place.name
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }
}
