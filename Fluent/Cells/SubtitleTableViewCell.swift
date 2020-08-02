//
// Created by scalxrd on 21/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

protocol SubtitleTableViewCellDelegate
{
    func handleAddButtonPressed(at word: ResponseModal)
}

class SubtitleTableViewCell: UITableViewCell
{
    var delegate: SubtitleTableViewCellDelegate?
    var word: ResponseModal? {
        didSet {
            textLabel?.text = word?.text
            detailTextLabel?.text = word?.meanings![0].translation?.text
        }
    }

    lazy var addButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: SFSymbols.plus))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAddButton))
        imageView.addGestureRecognizer(tap)

        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//        addSubview(addButton)
//        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleAddButton() {
        if let word = word {
            delegate?.handleAddButtonPressed(at: word)
        }
    }
}
