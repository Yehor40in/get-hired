//
//  SFSafariViewWrapper.swift
//  GetHired
//
//  Created by Yehor Sorokin on 29.11.22.
//

import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}

struct SFSafariViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        SFSafariViewWrapper(url: URL(string: "https://apple.com")!)
    }
}
