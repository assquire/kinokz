//
//  ProfileViewController.swift
//  kinokz
//
//  Created by Askar on 05.06.2022.
//

import UIKit

enum scrollViewCases {
    case tableView, collectionView
}

final class DetailsViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
}

//MARK: - Setup views methods

private extension DetailsViewController {
    
    func setupViews() {
        view.addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.center.equalToSuperview()
        }
    }
}
