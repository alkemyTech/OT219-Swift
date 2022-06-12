//  PruebaViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 01/06/2022.

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?)
}

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: HomeViewControllerDelegate?
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 700)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableV = UITableView()
        tableV.separatorStyle = .none
        tableV.backgroundColor = .white
        tableV.isHidden = true
        return tableV
    }()
    
    lazy var viewModel: HomeViewModel = {
        let homeViewModel = HomeViewModel()
        homeViewModel.delegate = self
        homeViewModel.delegateTimer = self
        return homeViewModel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero	, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.register(SeeMoreCollectionViewCell.self, forCellWithReuseIdentifier: SeeMoreCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var testimonialsHeader: UILabel = {
        let label = UILabel()
        label.text = "Testimoniales"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "LOGO-SOMOS MAS")
        return imageView
    }()
    
    private var serParteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("¡Quiero ser parte!", for: .normal)
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setDimensions(height: 50, width: 200)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10.0
        button.isHidden = true
        return button
    }()
    
    private var verTestimonios: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("Ver todos los testimonios", for: .normal)
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setDimensions(height: 50, width: 300)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupView()
        
        //ViewModel
        viewModel.getTestimonialsData()
        viewModel.getNewsData()
        viewModel.startTimer()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(logoImage)
        logoImage.anchor(top: containerView.safeAreaLayoutGuide.topAnchor)
        logoImage.setHeight(90)
        logoImage.centerX(inView: containerView)
        
        //News View - newsHeader, collectionView, button
        containerView.addSubview(newsHeader)
        newsHeader.anchor(top: logoImage.bottomAnchor)
        newsHeader.centerX(inView: containerView)
        
        containerView.addSubview(collectionView)
        collectionView.anchor(top: newsHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12)
        collectionView.setHeight(400)
        
        containerView.addSubview(serParteButton)
        serParteButton.anchor(top: collectionView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 12)

        //Testimonials View - testimonialsHeader, tableView, Button
        containerView.addSubview(testimonialsHeader)
        testimonialsHeader.anchor(top: serParteButton.bottomAnchor, paddingTop: 30)
        testimonialsHeader.centerX(inView: containerView)
        
        containerView.addSubview(tableView)
        tableView.anchor(top: testimonialsHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        tableView.setHeight(600)
        
        containerView.addSubview(verTestimonios)
        verTestimonios.anchor(top: tableView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 20, paddingLeft: 12)
        
        tableView.register(UINib(nibName: "TestimonialsCell", bundle: nil), forCellReuseIdentifier: TestimonialsCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    func showMessageError(message: String){
        let alert = UIAlertController(title: "Fail", message: message, preferredStyle: .alert)
        let actionRetry = UIAlertAction(title: "Retry?", style: .default) { [weak self] _ in
            self?.viewModel.getNewsData()
            self?.viewModel.getTestimonialsData()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(actionRetry)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
}
//MARK: - TableView Delegate, Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel.getTestimonialsCount(), 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestimonialsCell.identifier, for: indexPath) as? TestimonialsCell else { return UITableViewCell() }
        let testimonial = viewModel.getTestimonials(at: indexPath.row)
        cell.configureCell(with: testimonial)
        return cell
    }
}

//MARK: - CollectionView Delegate, DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 3{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeMoreCollectionViewCell.identifier, for: indexPath) as? SeeMoreCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let new = viewModel.getNews(at: indexPath.row)
            cell.configureCell(with: new)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(viewModel.getNewsCount(), 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Delegate

extension HomeViewController: HomeViewModelDelegate, TimerNewsUpdate {
    //News
    func didGetNewsData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.serParteButton.isHidden = false
            self?.collectionView.isHidden = false
        }
    }
    
    func didFailGettingNewsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = true
            self?.serParteButton.isHidden = true
            self?.viewModel.stopTimer()
            self?.showMessageError(message: error)
        }
    }
    
    func updateImageView(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    //Testimonials
    func didGetTestimonialsData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    
    func didFailGettingTestimonialsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showMessageError(message: error)
        }
    }
}

