//
//  WordlistTableViewHeaderView.swift
//  Minne
//
//  Created by scalxrd on 07/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//

import UIKit

protocol RootButtonDelegate
{
    func rootButtonPressed()
}

class RootControllerHeaderCell: UITableViewHeaderFooterView
{
    var delegate: RootButtonDelegate!

    lazy var button: UIImageView = {
        let image = UIImage(named: "plus-gray")?.withTintColor(.lightGray)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(handleAddButton)
        )
        imageView.addGestureRecognizer(tap)

        return imageView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // todo failure
    }

    private func configure() {
        contentView.backgroundColor = .rgb(red: 246, green: 247, blue: 248)
//        button.backgroundColor = .systemPurple
        addSubview(button)

        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    @objc private func handleAddButton() {
        delegate.rootButtonPressed()
        print(#function)
    }

}

protocol CellIdentifiable
{
    static var identifier: String { get }
}

extension UITableViewCell: CellIdentifiable
{
    static var identifier: String {
        get {
            return String(describing: Self.self)
        }
    }
}


extension RootControllerHeaderCell: CellIdentifiable
{
    static var identifier: String {
        get {
            return String(describing: Self.self)
        }
    }
}
