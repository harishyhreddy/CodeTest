//
//  MusicTableViewCell.swift
//  NikeTestApp
//
//  Created by Harish on 07/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    var albumArt: UIImageView
    var title: UILabel
    var artist: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        albumArt = UIImageView(frame: CGRect.zero)
        albumArt.image = UIImage(named: "placeholder")
        albumArt.contentMode = .scaleAspectFit
        
        title = UILabel(frame: CGRect.zero)
        title.font = UIFont.systemFont(ofSize: 16)
        title.numberOfLines = 0
        title.text = ""
        
        artist = UILabel(frame: CGRect.zero)
        artist.font = UIFont.systemFont(ofSize: 12)
        artist.textColor = .gray
        artist.text = ""
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func setupCell() {
        contentView.addSubview(albumArt)
        contentView.addSubview(title)
        contentView.addSubview(artist)
        
        albumArt.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(70)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(albumArt.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(artist.snp.top)
        }
        
        artist.snp.makeConstraints { (make) in
            make.left.equalTo(albumArt.snp.right).offset(10)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        title.text = ""
        artist.text = ""
        albumArt.image = UIImage(named: "placeholder")
    }
}
