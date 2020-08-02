//
//  SearchVC.swift
//  Minne
//
//  Created by scalxrd on 04/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//

import UIKit

protocol SearchItemControllerDelegate
{
    func handleAddButtonPressed(at word: ResponseModal)
}

class SearchItemController: UITableViewController, SubtitleTableViewCellDelegate
{
    var delegate: SearchItemControllerDelegate?

    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func handleAddButtonPressed(at word: ResponseModal) {
        print(#function, "word=\(word.text)")
        saveWords.append(word)
        delegate?.handleAddButtonPressed(at: word)
    }

    let searchController = UISearchController(searchResultsController: nil)
    var words            = [ResponseModal]()
    var saveWords        = [ResponseModal]()

    //    override func viewWillAppear(_ animated: Bool) {
    //        self.navigationController?.isNavigationBarHidden = true
    //    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(next2))

    }

    @objc func next2() {
        print(#function)
    }

    private func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
    }

    private func configureTableView() {
        //        view.backgroundColor = .systemRed

        tableView.separatorColor = .rgb(red: 238, green: 239, blue: 239)
        tableView.tableFooterView = UIView()
        tableView.register(SubtitleTableViewCell.self,
                           forCellReuseIdentifier: SubtitleTableViewCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarEmpty ? saveWords.count : words.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier,
                                                       for: indexPath) as? SubtitleTableViewCell else {
            fatalError("Unexpected Index Path")
        }

        if !isSearchBarEmpty {
            cell.word = words[indexPath.row]
            cell.delegate = self
        } else {
            cell.word = saveWords[indexPath.row]
        }
        return cell
    }
}

extension SearchItemController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            NetworkManager.shared.search(for: searchText, page: 1, pageSize: 100) {
                response in
                self.words = (try? response.get()) ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

class TextFiledController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableViewCell.identifier,
                                                       for: indexPath) as? SubtitleTableViewCell else {
            fatalError("Unexpected Index Path")
        }

        cell.word = words[indexPath.row]
        return cell
    }

    var words            = [ResponseModal]()

    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add a word"
        return tf
    }()

    let myInputView: UIView = {
      return UIView()
    }()

    let tableView: UITableView = {
      return UITableView()
    }()

    private func configureTextFiled() {
        textField.enablesReturnKeyAutomatically = true
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFiled()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(myInputView)
        myInputView.addSubview(textField)
        textField.becomeFirstResponder()
        myInputView.backgroundColor = .white
        myInputView.translatesAutoresizingMaskIntoConstraints = false
        myInputView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        myInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350).isActive = true
        myInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .systemPurple

        textField.topAnchor.constraint(equalTo: myInputView.topAnchor, constant: 10).isActive = true
        textField.leftAnchor.constraint(equalTo: myInputView.leftAnchor, constant: 15).isActive = true
        textField.rightAnchor.constraint(equalTo: myInputView.rightAnchor, constant: -15).isActive = true
        textField.bottomAnchor.constraint(equalTo: myInputView.topAnchor, constant: 40).isActive = true

        view.addSubview(tableView)
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: myInputView.topAnchor, constant: -5).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .rgb(red: 238, green: 239, blue: 239)
        tableView.tableFooterView = UIView()
        tableView.register(SubtitleTableViewCell.self,
                           forCellReuseIdentifier: SubtitleTableViewCell.identifier)
        tableView.isHidden = true
        textField.delegate = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textDidChange() {
        print(textField.text, textField.text?.isEmpty)
        guard let text = textField.text else { return }
        if text.isEmpty {
            tableView.isHidden = true

        } else {
            tableView.isHidden = false
        }

        NetworkManager.shared.search(for: text, page: 1, pageSize: 100) {
            response in
            self.words = (try? response.get()) ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension RootTableViewController: FLButtonDelegate {
    func addButtonPressed() {

        let popOver = TextFiledController()
        popOver.modalPresentationStyle = .overCurrentContext
        self.present(popOver, animated: true)
    }

}


extension TextFiledController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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