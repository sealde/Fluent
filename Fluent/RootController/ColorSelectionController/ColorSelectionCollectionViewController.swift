//
// Created by scalxrd on 22/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

protocol ColorSelectionCollectionViewDelegate
{
    func favouriteColorDidChange(to color: UIColor)
}

class ColorSelectionCollectionViewController: UICollectionViewController
{
    var delegate:       ColorSelectionCollectionViewDelegate!
    var colors: [UIColor] = UIColor.FluentColor.allColors
    var favouriteColor: UIColor = UIColor.FluentColor.defaultColor {
        didSet {
            delegate.favouriteColorDidChange(to: favouriteColor)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ColorSelectionCollectionViewCell.identifier,
                for: indexPath as IndexPath) as! ColorSelectionCollectionViewCell
        cell.cellColor = colors[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        favouriteColor = colors[indexPath.row]
    }

    // MARK: - Private Implementation

    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ColorSelectionCollectionViewCell.self,
                                forCellWithReuseIdentifier: ColorSelectionCollectionViewCell.identifier)
    }
}

extension ColorSelectionCollectionViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeRatio.cellWidth, height: SizeRatio.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: SizeRatio.inset,
                            left: SizeRatio.inset,
                            bottom: SizeRatio.inset,
                            right: SizeRatio.inset)
    }
}

extension ColorSelectionCollectionViewController
{
    private struct SizeRatio
    {
        static let inset:      CGFloat = 15
        static let cellHeight: CGFloat = 40
        static let cellWidth:  CGFloat = 40
    }
}

extension ColorSelectionCollectionViewCell: CellIdentifiable
{
    static var identifier: String {
        get {
            return String(describing: Self.self)
        }
    }
}
