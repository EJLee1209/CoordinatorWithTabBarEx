//
//  LoginViewController.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

protocol LoginViewControllerCoordinator: AnyObject {
    func didFinishLogIn()
}

final class LoginViewController: UIViewController {
    //MARK: - Properties
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Log In"
        configuration.titlePadding = 10
        button.configuration = configuration
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    weak var coordinator: LoginViewControllerCoordinator?
    
    
    //MARK: - Life Cycle
    init(coordinator: LoginViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    //MARK: - Helpers
    
    private func configUI() {
        view.backgroundColor = .white
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    //MARK: - Actions
    
    @objc private func didTapLoginButton() {
        coordinator?.didFinishLogIn()
    }
}
