//
//  UserDetailViewController.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//

import UIKit

final class UserDetailViewController: UIViewController {
    //MARK: - Properties
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGroupedBackground
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = makeLabel(font: .systemFont(ofSize: 25))
    private lazy var genderLabel: UILabel = makeLabel(font: .systemFont(ofSize: 20))
    
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Send Message"
        config.contentInsets = .init(top: 10, leading: 18, bottom: 10, trailing: 18)
        button.configuration = config
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, genderLabel, UIView(), sendMessageButton])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configData()
    }
    
    //MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(userImageView.snp.width)
        }
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).inset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
    
    func configData() {
        userImageView.sd_setImage(with: viewModel.imageUrl)
        
        nameLabel.text = viewModel.name
        genderLabel.text = viewModel.gender
    }
    
    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textAlignment = .center
        return label
    }
    
    //MARK: - Actions
    
}
