//
// Created by iloveass on 22/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

class ColorSelectionTableViewCell: UITableViewCell
{
    let paletteImageView: UIImageView = {
        let image     = UIImage(named: "icons8-paint-palette-30")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let chevronRightImageView: UIImageView = {
        let image     = UIImage(named: "icons8-chevron-right-30")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let colorImageView: UIView = UIView()

    let colorLabel: UILabel = {
        let label                                     = UILabel()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.rgb(red: 23, green: 24, blue: 28)
        ]
        label.attributedText = NSAttributedString(string: "Color", attributes: attributes)
        return label
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        configureColorImageViewLayer()
        configureSubviewLayout()
    }

    private func configureColorImageViewLayer() {
        colorImageView.layer.cornerRadius = SizeRatio.colorImageViewWidth / 2
        colorImageView.layer.masksToBounds = true
    }

    private func configureSubviewLayout() {
        configureCharonRightImageViewLayout()
        configureColorImageViewLayout()
        configurePaletteImageViewLayout()
        configureColorLabelLayout()
    }

    private func addViewToSuperViewAndActivateConstraints(for view: UIView,
                                                          constraints: [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate(constraints)
    }

    private func configurePaletteImageViewLayout() {
        let constraints: [NSLayoutConstraint] = [
            paletteImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            paletteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            paletteImageView.heightAnchor.constraint(equalToConstant: SizeRatio.paletteImageViewHeight),
            paletteImageView.widthAnchor.constraint(equalToConstant: SizeRatio.paletteImageViewWidth)
        ]
        addViewToSuperViewAndActivateConstraints(for: paletteImageView, constraints: constraints)
    }

    private func configureColorLabelLayout() {
        let constraints: [NSLayoutConstraint] = [
            colorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorLabel.leftAnchor.constraint(equalTo: paletteImageView.rightAnchor, constant: 10)
        ]
        addViewToSuperViewAndActivateConstraints(for: colorLabel, constraints: constraints)
    }

    private func configureCharonRightImageViewLayout() {
        let constraints: [NSLayoutConstraint] = [
            chevronRightImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            chevronRightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronRightImageView.heightAnchor.constraint(equalToConstant: SizeRatio.chevronRightImageViewHeight),
            chevronRightImageView.widthAnchor.constraint(equalToConstant: SizeRatio.chevronRightImageViewWidth),
        ]
        addViewToSuperViewAndActivateConstraints(for: chevronRightImageView,
                                                 constraints: constraints)
    }

    private func configureColorImageViewLayout() {
        let constraints: [NSLayoutConstraint] = [
            colorImageView.widthAnchor.constraint(equalToConstant: SizeRatio.colorImageViewWidth),
            colorImageView.heightAnchor.constraint(equalToConstant: SizeRatio.colorImageViewHeight),
            colorImageView.rightAnchor.constraint(equalTo: chevronRightImageView.rightAnchor,
                                                  constant: -20),
            colorImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        addViewToSuperViewAndActivateConstraints(for: colorImageView, constraints: constraints)
    }
}

extension ColorSelectionTableViewCell
{
    private struct SizeRatio
    {
        static let colorImageViewWidth:         CGFloat = 25
        static let colorImageViewHeight:        CGFloat = 25
        static let chevronRightImageViewHeight: CGFloat = 16
        static let chevronRightImageViewWidth:  CGFloat = 16
        static let paletteImageViewWidth:       CGFloat = 30
        static let paletteImageViewHeight:      CGFloat = 30
    }
}