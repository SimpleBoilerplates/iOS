//
//  HUD.swift
//  AlHadith

import SwiftMessages
import UIKit

struct Alert {
    let title: String?
    let message: String?
}

struct AppHUD {
    static func showHUD() {
        LLSpinner.backgroundColor = UIColor(white: 0, alpha: 0.6)
        LLSpinner.style = .white
        LLSpinner.spin()
        // HUD.dimsBackground = false
        // HUD.show(.progress)
    }

    static func hideHUD() {
        LLSpinner.stop()
        // HUD.hide()
    }

    static func showErrorMessage(_ message: String, title: String) {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.error)

        view.button?.isHidden = true

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        // let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        view.configureContent(title: title, body: message, iconText: "")

        // Show the message.
        SwiftMessages.show(view: view)
    }

    static func showWarningMessage(_ message: String, title: String) {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.warning)

        view.button?.isHidden = true

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        // let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        view.configureContent(title: title, body: message, iconText: "")

        // Show the message.
        SwiftMessages.show(view: view)
    }

    static func showSuccessMessage(_ message: String, title: String) {
        let view = MessageView.viewFromNib(layout: .messageView)

        // Theme message elements with the warning style.
        view.configureTheme(.success)

        view.button?.isHidden = true

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        // let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        view.configureContent(title: title, body: message, iconText: "")

        // Show the message.
        SwiftMessages.show(view: view)
    }
}
