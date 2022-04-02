//
//  AppTabsModel.swift
//  SwiftUI Shapes
//
//  Created by Silviu Nicolae on 03.10.2021.
//

import SwiftUI

struct AppTabList : Identifiable {
    var id     = UUID()
    var name   : String
    var view   : AnyView
}
