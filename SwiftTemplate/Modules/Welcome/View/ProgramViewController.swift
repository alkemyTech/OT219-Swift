//
//  ProgramViewController.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 7/6/22.
//

import UIKit

class ProgramViewController: UIViewController{

    //MARK: - Properties
    
    private lazy var viewModel: ProgramsViewModel = {
       let viewModel = ProgramsViewModel()
        return viewModel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero    , collectionViewLayout: layout)
        collectionView.register(ProgramsCollectionViewCell.self, forCellWithReuseIdentifier: ProgramsCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("program view controller")
        setupViews()
        setUpContrains()
    }
    //MARK: - SetUpView
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(logoImage)
        view.addSubview(collectionView)
        view.addSubview(serParteButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUpContrains(){
        
        logoImage.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        logoImage.centerX(inView: view)
        logoImage.setHeight(90)
        
        collectionView.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12)
        collectionView.setHeight(400)
        
        serParteButton.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 12)
    }
}

extension ProgramViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProgramCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramsCollectionViewCell.identifier, for: indexPath) as? ProgramsCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.getProgram(index: indexPath.row) )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
