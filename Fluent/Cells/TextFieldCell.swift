//
// Created by iloveass on 22/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

protocol TextFieldCellDelegate
{
    func nameTextFiledDidChange(to name: String?)
    func returnKeyDidPress()
}

class TextFieldCell: UITableViewCell
{
    var delegate: TextFieldCellDelegate!

    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name your word list"
        return tf
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
        configureTextFiled()
        textFieldDidBeginEditing(textField)
    }

    private func configureTextFiled() {
        textField.enablesReturnKeyAutomatically = true
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: textField)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textDidChange() {
        delegate.nameTextFiledDidChange(to: textField.text)
    }

    private func configureLayout() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.returnKeyDidPress()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}