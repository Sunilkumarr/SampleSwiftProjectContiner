//
//  ContinerViewController.swift
//  SampleSwiftProjectContiner
//
//  Created by apple on 08/03/21.
//

import Foundation
import UIKit
import Applozic

class ContinerViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContinerView()
        self.setupView()
    }

    func setupView()  {
        let barbackButtonItem = UIBarButtonItem(customView:self.navBackButton())

        self.navigationItem.title = ALApplozicSettings .getTitleForConversationScreen()

        self.navigationItem.leftBarButtonItem = barbackButtonItem

        let rightStartNewButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(startNewConversationVC(_:)))

        let profileImage = ALUIUtilityClass .getImageFromFramworkBundle("contact_default.png").scale(with: CGSize(width: 25, height: 25))

        let profileButton = UIBarButtonItem(image: profileImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(startUserProfile(_:)))

        self.navigationItem.rightBarButtonItems = [rightStartNewButton, profileButton]

    }

    func setupContinerView()  {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])

        // Add child view controller view to container
        let story = UIStoryboard(name: "Applozic", bundle: Bundle(for: ALMessagesViewController.self))
        let controller = story.instantiateViewController(withIdentifier: "ALViewController")
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)

        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        controller.didMove(toParent: self)
    }


    func navBackButton() -> UIView {
        let imageView = UIImageView(image: ALUIUtilityClass.getImageFromFramworkBundle("bbb.png"))
        imageView.frame = CGRect(x: -10, y: 0, width: 30, height: 30)
        imageView.tintColor = UIColor.white
        let label = UILabel(frame: CGRect(x: imageView.frame.origin.x + imageView.frame.size.width - 5, y: imageView.frame.origin.y + 5, width: 20, height: 15))
        label.textColor = ALApplozicSettings.getColorForNavigationItem()
        label.text = "Back"
        label.sizeToFit()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.size.width + label.frame.size.width, height: imageView.frame.size.height))
        view.bounds = CGRect(x: view.bounds.origin.x + 8, y: view.bounds.origin.y - 1, width: view.bounds.size.width, height: view.bounds.size.height)
        view.addSubview(imageView)
        view.addSubview(label)

        let backTap = UITapGestureRecognizer(target: self, action: #selector(backAction(_:)))
        backTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(backTap)

        return view
    }

    @objc func backAction(_ sender: Any?) {
        let uiController = navigationController?.popViewController(animated: true)
        if uiController == nil {
            dismiss(animated: true)
        }
    }

    @objc func startNewConversationVC(_ sender: Any?)  {
        let storyboard = UIStoryboard(name: "Applozic", bundle: Bundle(for: ALChatViewController.self))
        let contactVC = storyboard.instantiateViewController(withIdentifier: "ALNewContactsViewController") as? ALNewContactsViewController
        contactVC?.forGroup = NSNumber(value: 0)
        if let contactVC = contactVC {
            navigationController?.pushViewController(contactVC, animated: true)
        }
    }

    @objc func startUserProfile(_ sender: Any?)  {
        let storyboard = UIStoryboard(name: "Applozic", bundle: Bundle(for: ALChatViewController.self))
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ALUserProfileView") as? ALUserProfileVC
        if let profileVC = profileVC {
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}



extension UIImage {
    func scale(with size: CGSize) -> UIImage? {
        var scaledImageRect = CGRect.zero

        let aspectWidth: CGFloat = size.width / self.size.width
        let aspectHeight: CGFloat = size.height / self.size.height
        let aspectRatio: CGFloat = min(aspectWidth, aspectHeight)

        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0

        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        draw(in: scaledImageRect)

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }
}
