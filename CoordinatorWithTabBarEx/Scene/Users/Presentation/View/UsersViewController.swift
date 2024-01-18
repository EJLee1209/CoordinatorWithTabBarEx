//
//  UsersViewController.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit
import Combine

protocol UsersViewControllerCoordinator: AnyObject {
    func didFinishLogOut()
    func didSelectUser(user: User)
}

final class UsersViewController: UITableViewController {
    //MARK: - Properties
    
    private let viewModel: UsersViewModel
    weak var coordinator: UsersViewControllerCoordinator?
    
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Life Cycle
    init(
        viewModel: UsersViewModel,
        coordinator: UsersViewControllerCoordinator?
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
        addSpinnerLastCell()
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
        switch state {
        case .loading:
            break
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
extension UsersViewController {
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
extension UsersViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        coordinator?.didSelectUser(user: viewModel.getUser(row: indexPath.row))
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        tableView.tableFooterView?.isHidden = viewModel.isLastPage
    }
}

extension UsersViewController: MessageDisplayable {}
