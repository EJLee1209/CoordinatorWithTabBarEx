//
//  HomeViewController.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit
import Combine

protocol HomeViewControllerCoordinator: AnyObject {
    func didFinishLogOut()
}

final class HomeViewController: UITableViewController {
    //MARK: - Properties
    
    private let viewModel: HomeViewModel
    weak var coordinator: HomeViewControllerCoordinator?
    
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Life Cycle
    init(
        viewModel: HomeViewModel,
        coordinator: HomeViewControllerCoordinator?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        stateController()
        viewModel.viewDidLoad()
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
        tableView.register(
            ItemUserTableViewCell.self,
            forCellReuseIdentifier: ItemUserTableViewCell.identifier
        )
        
        let logOutButton = UIBarButtonItem(
            title: "로그아웃",
            style: .plain,
            target: self,
            action: #selector(didTapLogOutButton)
        )
        navigationItem.setRightBarButton(logOutButton, animated: true)
    }
    
    private func stateController() {
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.updateUI(state: state)
            }.store(in: &cancellable)
    }
    
    private func updateUI(state: StateController) {
        hideSpinner()
        
        switch state {
        case .loading:
            showSpinner()
        case .success:
            tableView.reloadData()
        case .fail(let error):
            presentAlert(message: error, title: "Error")
        }
    }
    
    //MARK: - Actions
    @objc private func didTapLogOutButton() {
        coordinator?.didFinishLogOut()
    }
}

//MARK: - DataSource
extension HomeViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.itemUsersCount
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemUserTableViewCell.identifier,
            for: indexPath
        ) as! ItemUserTableViewCell
        let itemUserViewModel = viewModel.makeItemUserViewModel(row: indexPath.row)
        cell.configData(viewModel: itemUserViewModel)
        return cell
    }
}

//MARK: - Delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: MessageDisplayable, SpinnerDisplayable {}
