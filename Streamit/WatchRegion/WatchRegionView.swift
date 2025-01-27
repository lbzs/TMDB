//
//  WatchRegionView.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import SwiftUI

struct WatchRegionView: View {
    @ObservedObject
    private var viewModel: WatchRegionViewModel
    
    init(viewModel: WatchRegionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Select a region")
            .onAppear(perform: {
                viewModel.handle(action: .viewDidAppear)
            })
    }
}

//#Preview {
//    WatchRegionView()
//}
