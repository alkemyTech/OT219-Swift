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
        return collectionView
    }()
    
    private var newsHeader: UILabel = {
        let label = UILabel()
        label.text = "News"
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
        return button
    }()
    
    private var errorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "ErrorIcon")
        imageView.isHidden = true
        return imageView
    }()
    
    private var errorMessage: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.text = "Oops, something went wrong. Please try again!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.isHidden = true
        return label
    }()
    
     lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setTitle("Retry?", for: .normal)
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setDimensions(height: 50, width: 200)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10.0
         button.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()

        view.backgroundColor = .white
        
        view.addSubview(logoImage)
        view.addSubview(collectionView)
        view.addSubview(newsHeader)
        view.addSubview(serParteButton)
        view.addSubview(errorImage)
        view.addSubview(errorMessage)
        view.addSubview(retryButton)
        
        
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        logoImage.setHeight(90)
        logoImage.centerX(inView: view)
    
        newsHeader.anchor(top: logoImage.bottomAnchor)
        newsHeader.centerX(inView: view)
        
        collectionView.anchor(top: newsHeader.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12)
        collectionView.setHeight(400)
        
        serParteButton.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        //MARK: - Errors anchors
        errorImage.anchor(top: logoImage.bottomAnchor, paddingTop: 50)
        errorImage.setHeight(100)
        errorImage.centerX(inView: view)
        
        errorMessage.anchor(top: errorImage.bottomAnchor, paddingTop: 20)
        errorMessage.centerX(inView: view)
        
        retryButton.anchor(top: errorMessage.bottomAnchor, paddingTop: 30)
        retryButton.centerX(inView: view)
        
        //viewModel.getNewsData()
        //viewModel.startTimer()
        viewModel.getAllServices()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func didTapRetryButton(){
        viewModel.getAllServices()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
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
    
    func didGetNewsData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            // aca van los hidden invertidos
        }
    }
    
    func didFailGettingNewsData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = true
            self?.serParteButton.isHidden = true
            self?.newsHeader.isHidden = true
            self?.errorImage.isHidden = false
            self?.errorMessage.isHidden = false
            self?.retryButton.isHidden = false
        }
    }
    
    //func didFailAllServices()
    
    func updateImageView(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
