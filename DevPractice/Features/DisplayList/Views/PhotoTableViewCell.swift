//
//  PhotoTableViewCell.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    // MARK:- Constants
    private let textFont = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
    private let elementSpace: CGFloat = 5
    
    // MARK:- UI Elements
   
    lazy var photoTitle: UILabel = {
        let label = UILabel()
        label.font = textFont
        label.numberOfLines = 0
        return label
    }()
    
    lazy var photoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var photoDetail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [photoImage, photoTitle, photoDetail])
        view.axis = .vertical
        view.spacing = elementSpace
        view.distribution = .fill
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
        photoTitle.text = nil
        photoDetail.text = nil
    }
    
    private func setupUI() {
        contentView.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
    }
}
