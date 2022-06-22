//
//  MoviesViewController.swift
//  kinokz
//
//  Created by Askar on 05.06.2022.
//

import UIKit
import SnapKit

final class MoviesViewController: UIViewController {
    
    var viewModel = MovieViewModel()
    
    private let sectionNames: [RequestType] = [.nowPlaying, .popular, .upcoming]
    
    private lazy var sectionTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SectionTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.sectionTableViewCell)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel.delegate = self
        viewModel.fetchAll()
        
        print(viewModel.getGenres())
        print(viewModel.getMovies(with: .nowPlaying))
                    
        configureNavBar()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Table view delegate and data source methods

extension MoviesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.sectionTableViewCell, for: indexPath) as! SectionTableViewCell
        cell.delegate = self
        cell.viewModel = self.viewModel
        cell.requestType = sectionNames[indexPath.section]
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Values.sectionTableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.leftLabel.text = sectionNames[section].rawValue
        return headerView
    }
}

//MARK: - Collection view in table view delegate methods

extension MoviesViewController: CollectionViewInTableViewDelegate {
    func cellTapped(data: MovieModel) {
        let vc = DetailsViewController()
        vc.label.text = "Title is \(data.title)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Movie view model delegate methods

extension MoviesViewController: MovieViewModelDelegate {
    func didUpdateViewModel(_ viewModel: MovieViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Setup views methods

private extension MoviesViewController {
    
    func configureNavBar() {
        let rightIcon = UIImage(systemName: Constants.Icons.location)
        navigationItem.title = Constants.Values.mainTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon, style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .orange
    }
    
    func setupViews() {
        view.addSubview(sectionTableView)
    }
    
    func setupConstraints() {
        //MARK: Collection view constraints
        sectionTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        sectionTableView.dataSource = self
        sectionTableView.delegate = self
    }
}
