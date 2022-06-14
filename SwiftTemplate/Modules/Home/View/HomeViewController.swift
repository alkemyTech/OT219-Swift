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
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1000)
    
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
    
    lazy var testimonialsTableView: UITableView = {
        let tableV = UITableView()
        tableV.separatorStyle = .none
        tableV.backgroundColor = .white
        tableV.isHidden = true
        return tableV
    }()
    
    private var testimonialsHeader: UILabel = {
        let label = UILabel()
        label.text = "Testimoniales"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero	, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.register(SeeMoreCollectionViewCell.self, forCellWithReuseIdentifier: SeeMoreCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    private var welcomeHeader: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-Alkemy")
        imageView.contentMode = .scaleToFill
        // cargar la imagen ...
        return imageView
    }()
    
    private var welcomeTitle : UILabel = {
        let label = UILabel()
        label.text = "Hola! Bienvenidx"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private var welcomeDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = .black
        return label
    }()
    
    private var contactButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("Contactanos", for: .normal)
        button.backgroundColor = .systemRed
        button.setDimensions(height: 50, width: 200)
        button.layer.cornerRadius = 10.0
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    lazy var viewModel: HomeViewModel = {
        let homeViewModel = HomeViewModel()
        homeViewModel.delegate = self
        homeViewModel.delegateTimer = self
        return homeViewModel
    }()
    
    private var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "LOGO-SOMOS MAS")
        return imageView
    }()
    
    private var Button: UIButton = {
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
        didGetWelcomeData()
        
        
        //ViewModel
        viewModel.getTestimonialsData()
        viewModel.getNewsData()
        viewModel.startTimer()
        
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        testimonialsTableView.delegate = self
        testimonialsTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        testimonialsTableView.frame = view.bounds
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)

        containerView.addSubview(logoImage)
        logoImage.anchor(top: containerView.safeAreaLayoutGuide.topAnchor)
        logoImage.setHeight(90)
        logoImage.centerX(inView: containerView)
        
        [
            welcomeHeader, welcomeImageView, welcomeTitle, welcomeDescription, contactButton,
            newsHeader, newsCollectionView, serParteButton,
            testimonialsHeader, testimonialsTableView, verTestimonios
        ].forEach {
            containerView.addSubview($0)
        }
        
        //Welcome View - newsHeader, collectionView, button
        welcomeHeader.anchor(top: logoImage.bottomAnchor)
        welcomeHeader.centerX(inView: containerView)
//
        welcomeImageView.anchor(top: welcomeHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16,width: 328, height: 250)
        welcomeTitle.anchor(top: welcomeImageView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        welcomeDescription.anchor(top: welcomeTitle.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12, width: 328, height: 126)
        contactButton.anchor(top: welcomeDescription.bottomAnchor, left: containerView.leftAnchor, paddingTop: 15, paddingLeft: 12)
        
        //News View - newsHeader, collectionView, button
        newsHeader.anchor(top: contactButton.bottomAnchor, paddingTop: 20)
        newsHeader.centerX(inView: containerView)
        
        newsCollectionView.anchor(top: newsHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12)
        newsCollectionView.setHeight(400)
        
        serParteButton.anchor(top: newsCollectionView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 12)

        //Testimonials View - testimonialsHeader, tableView, Button
        testimonialsHeader.anchor(top: serParteButton.bottomAnchor, paddingTop: 30)
        testimonialsHeader.centerX(inView: containerView)
        
        testimonialsTableView.anchor(top: testimonialsHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        testimonialsTableView.setHeight(600)
        
        verTestimonios.anchor(top: testimonialsTableView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 20, paddingLeft: 12)
        
        testimonialsTableView.register(UINib(nibName: "TestimonialsCell", bundle: nil), forCellReuseIdentifier: TestimonialsCell.identifier)
        testimonialsTableView.translatesAutoresizingMaskIntoConstraints = false
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
        return viewModel.getNewsCount() > 0 ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeMoreCollectionViewCell.identifier, for: indexPath) as? SeeMoreCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let new = viewModel.getNews(at: indexPath.row)
            cell.configureCell(with: new)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNewsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Delegate

extension HomeViewController: HomeViewModelDelegate, TimerNewsUpdate {
    // Welcome
    func didGetWelcomeData() {
        self.welcomeDescription.text = viewModel.getDescriptionWelcome()
        self.welcomeImageView.image = UIImage(named: viewModel.getImageWelcome())
        self.welcomeHeader.text = ""
    }
    
    func didFailGettingWelcomeData(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    //News
    func didGetNewsData() {
        DispatchQueue.main.async { [weak self] in
            self?.newsCollectionView.reloadData()
            self?.serParteButton.isHidden = false
            self?.newsCollectionView.isHidden = false
        }
    }
    
    func didFailGettingNewsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.newsCollectionView.isHidden = true
            self?.serParteButton.isHidden = true
            self?.viewModel.stopTimer()
            self?.showMessageError(message: error)
        }
    }
    
    func updateImageView(at index: Int) {
        if viewModel.getNewsCount() > 0 {
            DispatchQueue.main.async { [weak self] in
                self?.newsCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    //Testimonials
    func didGetTestimonialsData() {
        DispatchQueue.main.async { [weak self] in
            self?.testimonialsTableView.reloadData()
            self?.testimonialsTableView.isHidden = false
        }
    }
    
    func didFailGettingTestimonialsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showMessageError(message: error)
        }
    }
}


