//
// Created by iloveass on 26/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit
import CoreData

extension UIColor
{
    convenience init(named name: FluentColor) {
        let rgbaValue = name.rawValue
        let red       = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green     = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue      = CGFloat((rgbaValue >> 8) & 0xff) / 255.0
        let alpha     = CGFloat((rgbaValue) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension ImageAsset
{
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}

extension UIImage
{
    convenience init(asset: ImageAsset) {
        self.init(named: asset.rawValue)!
    }
}

extension UIColor
{
    class func color(withData data: Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }

    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

extension CodingUserInfoKey
{
    /// Required. Must be an NSManagedObjectContext.
    static let context        = CodingUserInfoKey(rawValue: "context")!
    /// Optional. Boolean. If present and true, newly created objects are not inserted into the context.
    static let deferInsertion = CodingUserInfoKey(rawValue: "deferInsertion")!
}

extension JSONDecoder
{
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }

    func decode<T: NSManagedObject & Decodable>(_ type: T.Type, data: Data,
                                                in context: NSManagedObjectContext,
                                                deferInsertion: Bool = false) throws -> T {
        userInfo[.context] = context
        userInfo[.deferInsertion] = deferInsertion
        defer {
            userInfo[.context] = nil
            userInfo[.deferInsertion] = nil
        }
        return try self.decode(type, from: data)
    }
}

extension NSManagedObjectContext
{
    func decode<T: NSManagedObject & Decodable>(_ type: T.Type, data: Data,
                                                with decoder: JSONDecoder,
                                                deferInsertion: Bool = false) throws -> T {
        decoder.userInfo[.context] = self
        decoder.userInfo[.deferInsertion] = deferInsertion
        defer {
            decoder.userInfo[.context] = nil
            decoder.userInfo[.deferInsertion] = nil
        }
        return try decoder.decode(type, from: data)
    }
}

extension UIColor
{
    public static func rgb(red: Int, green: Int, blue: Int) -> UIColor {
        let color = UIColor(red: CGFloat(red) / 255,
                            green: CGFloat(green) / 255,
                            blue: CGFloat(blue) / 255, alpha: 1)
        return color
    }
}