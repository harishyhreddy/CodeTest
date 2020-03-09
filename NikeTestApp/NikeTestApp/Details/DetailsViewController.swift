//
//  DetailsViewController.swift
//  NikeTestApp
//
//  Created by Harish on 08/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    var musicItem: Music?
    
    private var albumImage: UIImageView
    private var copyright: UILabel
    private var name: UILabel
    private var artist: UILabel
    private var genre: UILabel
    private var releaseDt: UILabel
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        albumImage = UIImageView(frame: CGRect.zero)
        copyright = UILabel(frame: CGRect.zero)
        name = UILabel(frame: CGRect.zero)
        artist = UILabel(frame: CGRect.zero)
        genre = UILabel(frame: CGRect.zero)
        releaseDt = UILabel(frame: CGRect.zero)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Details"
        
        setup()
        // Do any additional setup after loading the view.
        if let mItem = musicItem {
            //populate
            if let imgData = CacheManager.manager.fetch(from: mItem.artworkUrl100), let img = UIImage(data: imgData) {
                albumImage.image = img
            }
            copyright.text = "Copyright: " + mItem.copyright
            name.text = "Title: " + mItem.name
            artist.text = "Artist: " + mItem.artistName
            let genreText = mItem.genres.map{ $0.name }
            genre.text = "Genre: " + genreText.joined(separator: ", ")
            releaseDt.text = "Released on: " + mItem.releaseDate
        }
    }
    
    private func setup() {
        edgesForExtendedLayout = []
        
        albumImage.image = UIImage(named: "placeholder")
        view.addSubview(albumImage)
        
        copyright.text = "add"
        name.text = "adfasf"
        artist.text = "eyeyerty"
        genre.text = " qtri al jqoprui aslfj alfjopqij alsfjalsfdj lqsaffj poj lfkjasl jalf "
        releaseDt.text = "30/21/2038"
        
        copyright.numberOfLines = 0
        view.addSubview(copyright)
        view.addSubview(name)
        view.addSubview(artist)
        
        genre.numberOfLines = 0
        view.addSubview(genre)
        view.addSubview(releaseDt)
        
        albumImage.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(albumImage.snp.width)
        }
        
        copyright.snp.makeConstraints { (make) in
            make.top.equalTo(albumImage.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(copyright.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(20)
        }
        
        artist.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(20)
        }
        
        genre.snp.makeConstraints { (make) in
            make.top.equalTo(artist.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(releaseDt.snp.top).offset(-10)
        }
        
        releaseDt.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(20)
        }
    }
}
