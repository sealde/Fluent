//
// Created by scalxrd on 25/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

class ColorSelectionCollectionViewCell: UICollectionViewCell
{
    var cellColor: UIColor? {
        didSet {
            contentView.backgroundColor = cellColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayerCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private Implementation

    private func configureLayerCell() {
        contentView.layer.cornerRadius = contentView.frame.width / 2
        contentView.layer.masksToBounds = true
    }
}