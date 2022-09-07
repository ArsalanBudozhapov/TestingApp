//
//  ViewController.swift
//  TestingApp
//
//  Created by мак on 04.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var id: String
   
    private var networkDataFetcher = NetworkDataFetcher()
    
    var urls = [URLType.RawValue:String]()
    var height: Int = 0
    var width: Int = 0
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
       return imageView
    }()
    
    private let created_atLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.backgroundColor = .black
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.backgroundColor = .black
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let downloadsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.backgroundColor = .black
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .white
        label.backgroundColor = .black
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    convenience init() {
        self.init(image: nil, id: nil)
        }
    
    
    init(image: UIImage?, id: String?) {
        self.photoImageView.image = image
        self.id = id ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        addConstraints()

        setupNavigationBar()
        requestById()
    }
    
    private func requestById(){
        networkDataFetcher.fetchImageById(id: id) { [weak self] (idResults) in
            guard let results = idResults else { return }
            self?.locationLabel.text = results.location.city
            self?.authorLabel.text = results.user.username
            self?.downloadsLabel.text = String(results.downloads)
            self?.created_atLabel.text = results.created_at
            self?.urls = results.urls
            self?.height = results.height
            self?.width = results.width
        }
    }
    
    private func setupViews() {
        view.addSubview(photoImageView)
        view.addSubview(locationLabel)
        view.addSubview(created_atLabel)
        view.addSubview(downloadsLabel)
        view.addSubview(authorLabel)
    }
    
    private func addConstraints(){
        guard let image = photoImageView.image else { return }
        var aspectR: CGFloat = 0.0

       aspectR = image.size.width/image.size.height

       NSLayoutConstraint.activate([
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        photoImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
        photoImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1/aspectR),
        
        locationLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
        locationLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),

        created_atLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -20),
        created_atLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),

        downloadsLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -20),
        downloadsLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),

        authorLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
        authorLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor)
       ])
    }
       
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc func addBarButtonTapped(){
        print("sncks")
        var photo = UnsplashPhoto.init(width: self.width, height: self.height, id: self.id, urls: self.urls)
        let alertController = UIAlertController(title: "", message: "фото будут добавлены в альбом", preferredStyle: .alert)
        let add = UIAlertAction(title: "Добавить", style: .default) { [self] (action) in
            let tabbar = self.tabBarController as! MainTabBarController
            let navVC = tabbar.viewControllers?[1] as! UINavigationController
            let likesVC = navVC.topViewController as! LikesCollectionViewController
            likesVC.photos.append(photo)
            likesVC.authors.append(self.authorLabel.text!)
            likesVC.collectionView.reloadData()
           
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel) { (action) in
        }
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}

