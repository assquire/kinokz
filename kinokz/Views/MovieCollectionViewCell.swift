//
//  MovieCollectionViewCell.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "dr_strange")
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "Доктор Стрэндж: В мультивселенная безумия"
        label.font = .boldSystemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieGenres: UILabel = {
        let label = UILabel()
        label.text = "боевик, мультфильм"
        label.font = .systemFont(ofSize: 10)
        label.textColor = .gray
        label.numberOfLines = 2
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
    
    func configure(with model: MovieModel) {
        guard let url = URL(string:"\(Constants.Links.imageUrl)\(model.posterPath)") else { return }
        DispatchQueue.main.async { [weak self] in
            if let safeSelf = self {
                safeSelf.movieTitle.text = model.title
                safeSelf.movieGenres.text = model.genreNames.joined(separator: ", ")
                safeSelf.moviePosterImageView.kf.setImage(with: url)
            }
        }
    }
}

//MARK: - Setup views methods

private extension MovieCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieGenres)
    }
    
    func setupConstraints() {
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
        }
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.20)
        }
        movieGenres.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.10)
        }
    }
}
