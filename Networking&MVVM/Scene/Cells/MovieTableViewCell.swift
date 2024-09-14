//
//  MovieTableViewCell.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import UIKit


class MovieTableViewCell: UITableViewCell {
    
    enum Identifier: String{
        case custom = "movieCell"
    }
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        return lbl
    }()
    private let subTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.backgroundColor = .yellow
        [titleLabel, subTitleLabel].forEach{
            contentView.addSubview($0)
        }
        [titleLabel, subTitleLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func cellDoldur(title: String, subTitle: String){
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
