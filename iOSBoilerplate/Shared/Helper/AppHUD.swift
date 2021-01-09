//
//  HUD.swift

import SwiftMessages
import UIKit

struct AlertMessage {
    let title: String?
    let message: String?
}

class AppHUD {
    static let shared: AppHUD = {
        let instance = AppHUD()
        // Setup code
        return instance
    }()

    private init() {}
    func showHUD() {
        LLSpinner.backgroundColor = UIColor(white: 0, alpha: 0.6)
        LLSpinner.style = .white
        LLSpinner.spin()
    }

    func hideHUD() {
        LLSpinner.stop()
    }

    func showErrorMessage(_ message: String, title: String) {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.error)

        view.button?.isHidden = true

        // Add a drop shadow.
        view.configureDropShadow()

        view.configureContent(title: title, body: message, iconText: "")

        // Show the message.
        SwiftMessages.show(view: view)
    }

    func showWarningMessage(_ message: String, title: String) {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.warning)

        view.button?.isHidden = true

        // Add a drop shadow.
        view.configureDropShadow()

        view.configureContent(title: title, body: message, iconText: "")

        // Show the message.
        SwiftMessages.show(view: view)
    }

    func showSuccessMessage(_ message: String, title: String) {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.success)

        view.button?.isHidden = true

        // Add a drop shadow.
        view.configureDropShadow()

        view.configureContent(title: title, body: message, iconText: "")

        // Show the message.
        SwiftMessages.show(view: view)
    }
}
