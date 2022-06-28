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
        homeViewModel.delegateSpinner = self
        return homeViewModel
    }()
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 1700)

    
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
    
    private var logoView: CustomImage = {
        let image = CustomImage(imageName: HomeViewModelImagesNames.logoONG, mode: .scaleAspectFit)
        return image
    }()
    
    private  var spinnerLoading : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .systemRed
        spinner.style = .large
        return spinner
    }()
    //MARK: - Welcome props
    
    private var welcomeImageView: CustomImage = {
        let image = CustomImage(imageName: "", mode: .scaleToFill)
        return image
    }()
    
    private var welcomeTitle: CustomLabel = {
        let label = CustomLabel(label: "", fontSize: 24, fontWeight: .bold)
        return label
    }()
    
 
    private var welcomeDescription: CustomLabel = {
        let label = CustomLabel(label: "", fontSize: 18, fontWeight: .regular, labelLines: 0)
        return label
    }()

    private var contactButton: CustomButton = {
        let button = CustomButton(titleLabel: HomeViewModelButtonNames.contactButton, width: 200)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.isHidden = true
        return button
    }()
    
    private var welcomeHeader: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.welcomeHeader, fontSize: 20, fontWeight: .bold)
        return label
    }()
    
    //MARK: - News props
    
    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero	, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.register(SeeMoreCollectionViewCell.self, forCellWithReuseIdentifier: SeeMoreCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var newsHeader: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.newsHeader, fontSize: 20, fontWeight: .bold)
        label.isHidden = true
        return label
    }()

    private var serParteButtonNews: CustomButton = {
        let button = CustomButton(titleLabel: HomeViewModelButtonNames.serParteButtonNews, width: 200)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    //MARK: - Nosotros props
    
    private var nosotrosHeader: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.nosotrosHeader, fontSize: 20, fontWeight: .bold)
        return label
    }()
    
    private var profileImageNosotros: CustomImage = {
        let image = CustomImage(imageName: HomeViewModelImagesNames.profileImageNosotros, mode: .scaleAspectFill, radius: 10)
        return image
    }()
    
    private var nameLabelNosotros: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.nameLabelNosotros, fontSize: 20, fontWeight: .bold)
        return label
    }()
    
    private var rolLabelNosotros: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.rolLabelNosotros, fontSize: 20, fontWeight: .regular)
        return label
    }()
  
    private var captionLabelNosotros: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.captionLabelNosotros, fontSize: 16, fontWeight: .regular, labelLines: 0)
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    lazy var collectionViewNosotros: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private var serParteNosotrosButton: CustomButton = {
        let button = CustomButton(titleLabel: HomeViewModelButtonNames.serParteNosotrosButton, width: 250)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    lazy var pageControlNosotros: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 10
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        return pageControl
    }()
    private var leftArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    private var rightArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    //MARK: - Testimonials props
    
    lazy var testimonialsTableView: UITableView = {
        let tableV = UITableView()
        tableV.separatorStyle = .none
        tableV.backgroundColor = .white
        tableV.isHidden = true
        tableV.delegate = self
        tableV.dataSource = self
        return tableV
    }()
    
    private var verTestimoniosButton: CustomButton = {
        let button = CustomButton(titleLabel: HomeViewModelButtonNames.verTestimoniosButton, width: 300)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private var testimonialsHeader: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.testimonialsHeader, fontSize: 20, fontWeight: .bold)
        return label
    }()
    
    //MARK: - Error handler
    
    private var errorImage: CustomImage = {
        let image = CustomImage(imageName: HomeViewModelImagesNames.errorImage, mode: .scaleAspectFit)
        image.isHidden = true
        return image
    }()
    
    private var errorMessage: CustomLabel = {
        let label = CustomLabel(label: HomeViewModelLabels.errorMessage, fontSize: 16, fontWeight: .semibold, labelLines: 0)
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.isHidden = true
        label.frame = CGRect(x: 0, y: 0, width: 200, height: .max)
        return label
    }()
    
    lazy var retryButton: CustomButton = {
        let button = CustomButton(titleLabel: HomeViewModelButtonNames.errorButton, width: 200)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupView()

        viewModel.getAllServices()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        testimonialsTableView.frame = view.bounds
    }
    
    func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)

        scrollView.addSubview(spinnerLoading)
        
        spinnerLoading.centerX(inView: scrollView)
        spinnerLoading.centerY(inView: scrollView)
        
        
        containerView.addSubview(logoView)
        logoView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor)
        logoView.setHeight(90)
        logoView.centerX(inView: containerView)

        
        [
            logoView, welcomeHeader, welcomeImageView, welcomeTitle, welcomeDescription, contactButton,
            newsHeader, newsCollectionView, serParteButtonNews,
            testimonialsHeader, testimonialsTableView, verTestimoniosButton, nosotrosHeader, profileImageNosotros, nameLabelNosotros, rolLabelNosotros, captionLabelNosotros, collectionViewNosotros, pageControlNosotros, leftArrowImage, rightArrowImage, serParteNosotrosButton, errorImage, errorMessage, retryButton
        ].forEach {
            containerView.addSubview($0)
        }
        
        
        logoView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor)
        logoView.setHeight(90)
        logoView.centerX(inView: containerView)
        
        //MARK: - Welcome View - newsHeader, collectionView, button
    
        welcomeHeader.anchor(top: logoView.bottomAnchor)
        welcomeHeader.centerX(inView: containerView)

        welcomeImageView.anchor(top: welcomeHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingLeft: 12, paddingRight: 12)
        welcomeImageView.setHeight(250)
        
        welcomeTitle.anchor(top: welcomeImageView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        welcomeDescription.anchor(top: welcomeTitle.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12)
        welcomeDescription.setHeight(200)
        contactButton.anchor(top: welcomeDescription.bottomAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        //MARK: - News View - newsHeader, collectionView, button
        newsHeader.anchor(top: contactButton.bottomAnchor, paddingTop: 50)
        newsHeader.centerX(inView: containerView)
        
        newsCollectionView.anchor(top: newsHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12)
        newsCollectionView.setHeight(400)
        
        serParteButtonNews.anchor(top: newsCollectionView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 12)

        //MARK: - Nosotros seccion
        
        nosotrosHeader.anchor(top: serParteButtonNews.bottomAnchor, paddingTop: 50)
        nosotrosHeader.centerX(inView: containerView)
        
        profileImageNosotros.anchor(top: nosotrosHeader.bottomAnchor, paddingTop: 12)
        profileImageNosotros.setDimensions(height: 200, width: 150)
        profileImageNosotros.centerX(inView: containerView)
        
        nameLabelNosotros.anchor(top: profileImageNosotros.bottomAnchor, left: containerView.leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        rolLabelNosotros.anchor(top: nameLabelNosotros.bottomAnchor, left: containerView.leftAnchor, paddingTop: 2, paddingLeft: 12)
        
        captionLabelNosotros.anchor(top: rolLabelNosotros.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        collectionViewNosotros.anchor(top: captionLabelNosotros.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        collectionViewNosotros.setHeight(100)
        
        pageControlNosotros.anchor(top: collectionViewNosotros.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor)
        pageControlNosotros.centerX(inView: containerView)
        
        serParteNosotrosButton.anchor(top: pageControlNosotros.bottomAnchor, left: containerView.leftAnchor, paddingTop: 20, paddingLeft: 12)
        
        leftArrowImage.centerY(inView: collectionViewNosotros)
        rightArrowImage.centerY(inView: collectionViewNosotros)
        rightArrowImage.anchor(right: containerView.rightAnchor)
        
        
        //MARK: - Testimonials View - testimonialsHeader, tableView, Button
        testimonialsHeader.anchor(top: serParteNosotrosButton.bottomAnchor, paddingTop: 50)
        testimonialsHeader.centerX(inView: containerView)

        testimonialsTableView.anchor(top: testimonialsHeader.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        testimonialsTableView.setHeight(600)

        verTestimoniosButton.anchor(top: testimonialsTableView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 20, paddingLeft: 12)

        testimonialsTableView.register(UINib(nibName: "TestimonialsCell", bundle: nil), forCellReuseIdentifier: TestimonialsCell.identifier)
        testimonialsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - Errors anchors
          errorImage.anchor(top: welcomeHeader.bottomAnchor, paddingTop: 50)
          errorImage.setHeight(100)
          errorImage.centerX(inView: containerView)

          errorMessage.anchor(top: errorImage.bottomAnchor, paddingTop: 20)
          errorMessage.centerX(inView: containerView)

          retryButton.anchor(top: errorMessage.bottomAnchor, paddingTop: 30)
          retryButton.centerX(inView: containerView)
    }
    
    @objc func pageControlTapHandler(sender: UIPageControl){
        collectionViewNosotros.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .left, animated: true)
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func didTapRetryButton(){
         viewModel.getAllServices()
     }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Home"

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
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
    
    func hideWelcomeSection(){
        [welcomeImageView, welcomeTitle, welcomeDescription,contactButton].forEach { $0.isHidden = true
        }
    }
    
    func showWelcomeSection(){
        [welcomeImageView, welcomeTitle, welcomeDescription,contactButton].forEach { $0.isHidden = false
        }
    }
    
    func hideNewsSection(){
        [newsCollectionView, serParteButtonNews, newsHeader].forEach { $0.isHidden = true
        }
    }
    
    func showNewsSection(){
        [newsCollectionView, serParteButtonNews, newsHeader].forEach { $0.isHidden = false
        }
        newsCollectionView.reloadData()
    }
    
    func hideNosotrosSection(){
        [nosotrosHeader, profileImageNosotros, nameLabelNosotros, rolLabelNosotros, captionLabelNosotros, pageControlNosotros, leftArrowImage, rightArrowImage, collectionViewNosotros, serParteNosotrosButton].forEach { $0.isHidden = true
        }
    }
    
    func showNosotrosSection(){
        [nosotrosHeader, profileImageNosotros, nameLabelNosotros, rolLabelNosotros, captionLabelNosotros, pageControlNosotros, leftArrowImage, rightArrowImage,collectionViewNosotros, serParteNosotrosButton].forEach { $0.isHidden = false
        }
    }
    
    func hideTestimonialsSection(){
        [testimonialsTableView,testimonialsHeader,verTestimoniosButton].forEach { $0.isHidden = true
        }
    }
    
    func showTestimonialsSection(){
        [testimonialsTableView,testimonialsHeader,verTestimoniosButton].forEach { $0.isHidden = false
        }
        testimonialsTableView.reloadData()
    }
    
    func showGeneralError(){
        [errorImage, errorMessage, retryButton].forEach { $0.isHidden = false
        }
    }
    
    func hideGeneralError(){
        [errorImage, errorMessage, retryButton].forEach { $0.isHidden = true
        }
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
        switch collectionView {
        case newsCollectionView:
            return CGSize(width: view.frame.width, height: 400)
        case collectionViewNosotros:
            return CGSize(width: collectionView.frame.width/4, height: 100)
        default:
            break
        }
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case newsCollectionView:
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
        case collectionViewNosotros:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
            

            return cell
        default:
            break
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        

        return cell
     
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newsCollectionView:
            return min(viewModel.getNewsCount(), 4)
        case collectionViewNosotros:
            return 10
        default:
            break
        }
        return min(viewModel.getNewsCount(), 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == newsCollectionView{
            return 0
        }
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewNosotros{
            let viewController = NosotrosDetailViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == collectionViewNosotros{
            pageControlNosotros.currentPage = indexPath.row
        }
    }
}

//MARK: - Delegate

extension HomeViewController: HomeViewModelDelegate, TimerNewsUpdate, SpinnerLoadingDelegate {
    func showSpinner() {
        spinnerLoading.isHidden = false
        spinnerLoading.startAnimating()
    }
    
    func hideSpinner() {
        spinnerLoading.isHidden = true
        spinnerLoading.stopAnimating()
    }
    
    
    // Welcome
    func didGetWelcomeData() {
        self.welcomeDescription.text = viewModel.getDescriptionWelcome()
        self.welcomeImageView.image = UIImage(named: viewModel.getImageWelcome())
    }
    
    func didFailGettingWelcomeData(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    //News
    func didGetNewsData() {
        DispatchQueue.main.async { [weak self] in
            self?.showNewsSection()
            self?.didGetWelcomeData()
            self?.hideGeneralError()
            self?.showWelcomeSection()
            self?.showNosotrosSection()
            self?.showTestimonialsSection()
            self?.viewModel.startTimer()
        }
    }
    
    func didFailGettingNewsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.hideNewsSection()
            self?.showMessageError(message: error)
            self?.showWelcomeSection()
            self?.showNosotrosSection()
            self?.showTestimonialsSection()
            self?.viewModel.stopTimer()
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
            self?.showTestimonialsSection()
            self?.didGetWelcomeData()
            self?.hideGeneralError()
            self?.showWelcomeSection()
            self?.showNosotrosSection()
        }
    }
    
    func didFailGettingTestimonialsData(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.hideTestimonialsSection()
            self?.showMessageError(message: error)
        }
    }
    
    func didFailAllServices() {
        DispatchQueue.main.async { [weak self] in
            self?.hideWelcomeSection()
            self?.hideNewsSection()
            self?.hideNosotrosSection()
            self?.hideTestimonialsSection()
            self?.showGeneralError()
        }
    }
}
