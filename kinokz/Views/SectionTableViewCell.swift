//
//  MovieSectionTableViewCell.swift
//  kinokz
//
//  Created by Askar on 06.06.2022.
//

import UIKit

protocol CollectionViewInTableViewDelegate: AnyObject {
    func cellTapped(data: MovieModel)
}

final class SectionTableViewCell: UITableViewCell {
    
    weak var delegate: CollectionViewInTableViewDelegate?
    weak var viewModel: MovieViewModel?
    var requestType: RequestType?
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constants.Values.movieCollectionViewCellWidth, height: Constants.Values.sectionTableViewCellHeight)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.movieCollectionViewCell)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        setupViews()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Collection view methods

extension SectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.movieCollectionViewCell, for: indexPath) as! MovieCollectionViewCell
        if let safeViewModel = viewModel {
            guard let safeRequestType = requestType else { fatalError() }
            let movieModel = safeViewModel.getMovies(with: safeRequestType)[indexPath.row]
            cell.configure(with: movieModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let safeViewModel = viewModel {
            guard let safeRequestType = requestType else { fatalError() }
            let movieModel = safeViewModel.getMovies(with: safeRequestType)[indexPath.row]
            delegate?.cellTapped(data: movieModel)
        }
    }
}

//MARK: - Setup views methods

private extension SectionTableViewCell {
    
    func setupViews() {
        contentView.addSubview(moviesCollectionView)
    }
    
    func setupConstraints() {
        moviesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        moviesCollectionView.dataSource = self
    }
}
