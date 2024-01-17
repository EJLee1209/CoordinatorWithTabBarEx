//
//  ItemHomeTableViewCell.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit
import SnapKit
import SDWebImage

final class ItemUserTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, genderLabel])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configUI() {
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
            make.size.equalTo(100).priority(999)
        }
        
        contentView.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(10)
        }
    }
    
    func configData(viewModel: ItemUserViewModel) {
        userImageView.sd_setImage(with: viewModel.imageUrl)
        nameLabel.text = viewModel.name
        genderLabel.text = viewModel.gender
    }
}

extension ItemUserTableViewCell: Reuseable {}

