//
//  SectionHeaderView.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import UIKit

final class SectionHeaderView: UIView {

    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .orange
        label.text = "Все"
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Views setup methods

private extension SectionHeaderView {
    
    func setupViews() {
        addSubview(leftLabel)
        addSubview(rightLabel)
    }
    
    func setupConstraints() {
        leftLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        rightLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(leftLabel.snp.trailing)
        }
    }
}

