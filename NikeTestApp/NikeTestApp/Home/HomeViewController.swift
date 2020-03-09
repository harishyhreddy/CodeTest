//
//  HomeViewController.swift
//  NikeTestApp
//
//  Created by Harish on 07/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var musicList: UITableView
    
    var musicItems = [Music]()
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        musicList = UITableView(frame: CGRect.zero)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "iTunes Music"
        view.backgroundColor = .brown
        
        setupTableView()
        
        let refreshBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshBtn
        
        fetchDataFromServer()
    }
    
    private func setupTableView() {
        musicList.tableFooterView = UIView()
        musicList.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicCellId")
        musicList.dataSource = self
        musicList.delegate = self
        view.addSubview(musicList)
        musicList.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchDataFromServer() {
        APIManager.manager.fetchMusicItems { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self.musicItems = models
                    self.musicList.reloadData()
                case .failure(let error):
                    print("Error: \(error)")
                    self.showWarning(message: "Failed to fetch the music items")
                }
            }
        }
    }
    
    @objc
    func refresh() {
        fetchDataFromServer()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCellId", for: indexPath) as? MusicTableViewCell {
            
            let item = musicItems[indexPath.row]
            cell.artist.text = item.artistName
            cell.title.text = item.name
            if let image = CacheManager.manager.fetch(from: item.artworkUrl100), let img = UIImage(data: image) {
                cell.albumArt.image = img
            } else {
                APIManager.manager.downloadImage(url: item.artworkUrl100) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let received):
                            CacheManager.manager.cahceImage(url: received.1, data: received.0)
                            if let cell = tableView.cellForRow(at: indexPath) as? MusicTableViewCell, let img = UIImage(data: received.0) {
                                cell.albumArt.image = img
                            }
                        case .failure(let error):
                            print("Failed to download image: \(error)")
                        }
                    }
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailsViewController()
        destVC.musicItem = musicItems[indexPath.row]
        navigationController?.show(destVC, sender: nil)
    }
}
