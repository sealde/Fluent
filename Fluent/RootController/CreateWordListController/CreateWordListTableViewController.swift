//
// Created by scalxrd on 21/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

class CreateWordListTableViewController: UITableViewController
{
    var favouriteColor: UIColor = .lightGray
    var name:           String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationItem()
    }

    @objc func done() {
        let image = ImageAsset.circle.image.withTintColor(favouriteColor)
        if let name = name, let imageData = image.pngData() {
            _ = try? PersistenceManager.shared.createAndSaveWordList(
                    ofType: .Custom, withName: name, andImageData: imageData)
        }
        dismiss(animated: true)

    }

    @objc func cancel() {
        dismiss(animated: true)
    }

    // Private Implementation

    private func configureNavigationItem() {
        let rightBarButtonItem = UIBarButtonItem(
                title: "Done", style: .done, target: self, action: #selector(done))
        let leftBarButtonItem  = UIBarButtonItem(
                title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    private func configureTableView() {
        tableView.separatorColor = .rgb(red: 238, green: 239, blue: 239)
        tableView.backgroundColor = .rgb(red: 246, green: 247, blue: 248)
        tableView.tableFooterView = UIView()
    }
}

extension CreateWordListTableViewController
{
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) {
            return SizeRatio.heightCellForTextFiled
        }
        return SizeRatio.defaultHeightCell
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 1, section: 0) {
            let cell = ColorSelectionTableViewCell()
            cell.colorImageView.backgroundColor = favouriteColor
            return cell
        }

        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = TextFieldCell()
            cell.delegate = self
            return cell
        }
        fatalError("Unexpected IndexPath")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(#function)
        if indexPath == IndexPath(row: 1, section: 0) {
            let flowLayout = UICollectionViewFlowLayout()
            let controller = ColorSelectionCollectionViewController(collectionViewLayout: flowLayout)
            controller.delegate = self
            controller.title = "Color"
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension CreateWordListTableViewController
{
    private struct SizeRatio
    {
        static let heightCellForTextFiled: CGFloat = 70
        static let defaultHeightCell:      CGFloat = 50
    }
}


extension CreateWordListTableViewController: TextFieldCellDelegate
{
    func returnKeyDidPress() {
        done()
    }

    func nameTextFiledDidChange(to text: String?) {
        name = text
        if let text = text, !text.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension CreateWordListTableViewController: ColorSelectionCollectionViewDelegate
{
    func favouriteColorDidChange(to uiColor: UIColor) {
        navigationController?.popViewController(animated: true)
        favouriteColor = uiColor
        let indexPaths = [IndexPath(row: 1, section: 0)]
        tableView.reloadRows(at: indexPaths, with: .none)
    }
}