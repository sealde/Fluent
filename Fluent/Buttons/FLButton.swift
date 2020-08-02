//
// Created by scalxrd on 11/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit
import CoreData

protocol FLButtonDelegate
{
    func addButtonPressed()
}

class FLButton: UIView
{
    var delegate: FLButtonDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    init() {
        super.init(frame: .zero)
        configure()
    }

    let plusView: UIImageView = {
        let image    = UIImage(named: SFSymbols.plus)!
                .withTintColor(.white, renderingMode: .alwaysOriginal)
        let plusView = UIImageView(image: image)
        plusView.translatesAutoresizingMaskIntoConstraints = false
        return plusView
    }()

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .rgb(red: 60, green: 61, blue: 62)
        layer.frame = CGRect(origin: .zero, size: CGSize(width: 60, height: 60))
        layer.cornerRadius = frame.height / 2
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(addButtonPressed)))

        addSubview(plusView)
        plusView.centerXAnchor.constraint(
                equalTo: centerXAnchor).isActive = true
        plusView.centerYAnchor.constraint(
                equalTo: centerYAnchor).isActive = true

    }

    private func vibrateWithHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()

        generator.impactOccurred()
    }

    // Testing section
    // todo don't forget to clear

    func readJson() {
        let url     = Bundle.main.url(forResource: "def_example", withExtension: "json")
        let data    = NSData(contentsOf: url!) as! Data
        let context = PersistenceManager.shared.viewContext
        let decoder = JSONDecoder()
        do {
            let mean = try decoder.decode(Meaning.self,
                                          data: data,
                                          in: context,
                                          deferInsertion: true)

            print(mean)
            context.insert(mean)
        } catch let error {
            print("Inserting Failed:", error)
        }
        do {
            //            let object = try JSONSerialization.jsonObject(with: data,
            //                                                          options: .allowFragments)
            //            if let dictionary = object as?  [String: AnyObject] {
            //                print("dictionary: ", dictionary)
            //            } else {
            //                print(2)
            //            }
        } catch let error {
            //            print(error)
        }
    }

    @objc func addButtonPressed() {
        delegate.addButtonPressed()
    }
}

