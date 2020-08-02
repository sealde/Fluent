//
// Created by scalxrd on 11/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

enum SFSymbols
{
    static let search        = "magnifyingglass"
    static let setting       = "gear"
    static let notifications = "bell"
    static let achievements  = "rosette"
    static let plus          = "plus"
}

enum ImageAsset: String
{
    case circle             = "circle.fill"
    case plus               = "plus-black"
    case calendar           = "blue.calendar"
//    case calendarBadgeMinus = "calendar.badge.minus"
    case calendarBadgePlus  = "calendar.badge.plus"
    case calendarCircleFill = "calendar.circle.fill"
    case trayFull           = "tray.full"
    case chevronRight       = "chevron.right"
    case bell               = "bell"
//    case inboxUpcoming = "inbox-upcoming"
//    case inboxComplete = "inbox.complete"
    case inbox = "blue.inbox"
    case hint = "hint"
}

extension UIColor
{
    enum FluentColor: UInt32, CaseIterable
    {
        case ArticleBody  = 0x339666ff
        case Cyan         = 0xff66ccff
        case ArticleTitle = 0x33fe66ff
        case Brown        = 0xc8ad93ff
        case Gray         = 0x7f8081ff
        case Pink         = 0xfc8e86ff
        case Cerise       = 0xde5295ff
        case Redviolet    = 0xe998ebff
        case Purple       = 0xac3aeaff
        case Blueviolet   = 0x874dfeff
        case Skyblue      = 0x3e74ffff
        case Paleblue     = 0x95c2ecff
        case Azure        = 0x09aaf5ff
        case Seagreen     = 0x0f90adff
        case Turquoise    = 0x67cbb7ff
        case Green        = 0x259539ff
        case Applegreen   = 0x7ccc4aff
        case Lime         = 0xadb73cff
        case Yellow       = 0xf7ce00ff
        case Redorange    = 0xff5349ff
        case Carmine      = 0xd94136ff
        case Crimson      = 0xb5265fff
        static var allColors = allCases.map { UIColor(named: $0) }
        static var defaultColor: UIColor = UIColor(named: Gray)
    }
}

