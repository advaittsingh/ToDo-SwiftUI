//
//  ContentView.swift
//  ToDo-SwiftUI
//
//  Created by Saumil Shah on 6/24/20.
//  Copyright © 2020 Saumil Shah. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        ListMasterView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice("iPhone 11 Pro")
    }
}
