//
// Created by scalxrd on 12/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

class WordListCell: UITableViewCell
{
    var wordList: WordList? {
        didSet {
            nameLabel.text = wordList?.name
            nameLabel.font = wordList?.typeId == 1 ? UIFont.systemFont(ofSize: 14) : UIFont.boldSystemFont(ofSize: 15)
            if let imageData = wordList?.imageData {
                wordListImageView.image = UIImage(data: imageData)
            }
        }
    }

    let wordListImageView: UIImageView = {
        let imageView        = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(wordListImageView)
        addSubview(nameLabel)
        configureSubviewsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configureSubviewsLayout() {
        configureWordListImageViewLayout()
        configureNameLabelLayout()
    }

    private func configureNameLabelLayout() {
        let constraints = [
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: wordListImageView.rightAnchor, constant: 15)
        ]
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    private func configureWordListImageViewLayout() {
        let constraints = [
            wordListImageView.heightAnchor.constraint(equalToConstant: 20),
            wordListImageView.widthAnchor.constraint(equalToConstant: 20),
            wordListImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            wordListImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        ]
        wordListImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}