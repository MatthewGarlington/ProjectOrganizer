//
//  PurchasedView.swift
//  ProjectOrganizer
//
//  Created by Matthew Garlington on 4/24/21.
//

import SwiftUI
import CoreHaptics

struct PurchasedView: View {

    static let closedTag: String? = "Purchased"

    @StateObject var viewModel: ViewModel
    @State private var showingSortOrder = false

    @State private var press = false
    @State private var animationStroke: CGFloat = 1
    @State private var explodeStroke: CGFloat = 1
    @GestureState var tap = false
    @State var show = true
    @State var showAwardsModal = false
    @State var waveEffect = false
    @State var rotateEffect = false
    @State var backgroundColor = "Light Blue"
    @State var red = 2
    @State private var tapped = 0
    @State private var isShow = false
    @State private var isRewardsShow = false
    @State private var showDetail = false
    @State private var showAddScreen = false
    @State private var noItem = false

    var purchasedList: some View {

        ScrollView {

            VStack(alignment: .leading) {

                PurchasedListView(title: "Purchase", items: viewModel.moreToExplore, waveEffect: $waveEffect, rotateEffect: $rotateEffect, tapped: $tapped, noItem: $noItem)
            }
            .padding(.horizontal)

        }
    }

    var body: some View {
        NavigationView {
            Group {


                    purchasedList
            }
            .navigationBarTitle("Purchased")

        }
    }

    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct PurchasedViewPreviews: PreviewProvider {

    static var previews: some View {
        PurchasedView(dataController: DataController.preview, showClosedProjects: false)
    }
}




