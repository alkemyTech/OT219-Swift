//
//  NosotrosViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 07/06/2022.
//

import UIKit


class NosotrosViewController: UIViewController {

    //MARK: - Properties
    
    weak var delegate: HomeViewControllerDelegate?
    
    private var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "LOGO-SOMOS MAS")
        return imageView
    }()
    
    private var nosotrosHeader:CustomLabel = {
        let label = CustomLabel(label: "¡Nuestro staff!", fontSize: 20, fontWeight: .bold)
        return label
    }()

    private var profileImageNosotros: CustomImage = {
        let image = CustomImage(imageName: "profilePic", mode: .scaleAspectFill)
        image.layer.cornerRadius = 20
        return image
    }()
    
    
    private var nameLabelNosotros: CustomLabel = {
        let label = CustomLabel(label: "Roberto Martinez", fontSize: 20, fontWeight: .bold)
        return label
    }()
    
    private var rolLabelNosotros: CustomLabel = {
        let label = CustomLabel(label: "Coordinador", fontSize: 20, fontWeight: .regular)
        return label
    }()
    
    private var captionLabelNosotros : CustomLabel = {
        let label = CustomLabel(label: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tristique ex massa, sit amet viverra nisi porta eu. Aliquam erat volutpat. Nulla vel aliquet enim. Vivamus aliquet nibh nec magna volutpat", fontSize: 16, fontWeight: .regular)
        label.numberOfLines = 0
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
    
    lazy var pageControl: UIPageControl = {
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
    
    private var serParteNosotrosButton: CustomButton = {
        let button = CustomButton(titleLabel: "¡Ver todos los miembros!", width: 250)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(logoImage)
        view.addSubview(nosotrosHeader)
        view.addSubview(serParteNosotrosButton)
        view.addSubview(profileImageNosotros)
        view.addSubview(nameLabelNosotros)
        view.addSubview(rolLabelNosotros)
        view.addSubview(captionLabelNosotros)
        view.addSubview(collectionViewNosotros)
        view.addSubview(pageControl)
        view.addSubview(leftArrowImage)
        view.addSubview(rightArrowImage)
        
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        logoImage.setHeight(90)
        logoImage.centerX(inView: view)
        
        nosotrosHeader.anchor(top: logoImage.bottomAnchor)
        nosotrosHeader.centerX(inView: view)
        
        profileImageNosotros.anchor(top: nosotrosHeader.bottomAnchor, paddingTop: 12)
        profileImageNosotros.setDimensions(height: 200, width: 150)
        profileImageNosotros.centerX(inView: view)
        
        nameLabelNosotros.anchor(top: profileImageNosotros.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        rolLabelNosotros.anchor(top: nameLabelNosotros.bottomAnchor, left: view.leftAnchor, paddingTop: 2, paddingLeft: 12)
        
        captionLabelNosotros.anchor(top: rolLabelNosotros.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        
        collectionViewNosotros.anchor(top: captionLabelNosotros.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
        collectionViewNosotros.setHeight(100)
        
        pageControl.anchor(top: collectionViewNosotros.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        pageControl.centerX(inView: view)
        
        serParteNosotrosButton.anchor(top: pageControl.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 12)
        
        leftArrowImage.centerY(inView: collectionViewNosotros)
        rightArrowImage.centerY(inView: collectionViewNosotros)
        rightArrowImage.anchor(right: view.rightAnchor)
        
        configureNavigationBar()
    }
    

    //MARK: - Helpers
    
    @objc func pageControlTapHandler(sender: UIPageControl){
        collectionViewNosotros.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .left, animated: true)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Nosotros"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    

}

extension NosotrosViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = NosotrosDetailViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
   
}
