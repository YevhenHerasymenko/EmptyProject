import UIKit

extension UIViewController {
  
    @objc func autoLocalize() {
        if let tabBarController = self.tabBarController {
            for viewController in tabBarController.viewControllers ?? [] {
                if let tabBarItem = viewController.tabBarItem {
                    tabBarItem.title = String.localizedString(tabBarItem.title)
                }
            }
        }

        let item = navigationItem
        item.title = String.localizedString(item.title)
        item.leftBarButtonItem?.title = String.localizedString(item.leftBarButtonItem?.title)
        item.rightBarButtonItem?.title = String.localizedString(item.rightBarButtonItem?.title)

        view.autoLocalize()
    }

}

extension UIView {

    @objc func autoLocalize() {
        for view in subviews {
            view.autoLocalize()
        }
    }

}

extension UILabel {

    override func autoLocalize() {
        super.autoLocalize()

        let localizedText = String.localizedString(text)
        if localizedText == text {
            return
        }
        text = localizedText
    }

}

extension UIButton {

    override func autoLocalize() {
        super.autoLocalize()
        setTitle(String.localizedString(title(for: .normal)), for: .normal)
        setTitle(String.localizedString(title(for: .highlighted)), for: .highlighted)
        setTitle(String.localizedString(title(for: .selected)), for: .selected)
        setTitle(String.localizedString(title(for: .disabled)), for: .disabled)
    }

}

extension UISegmentedControl {

    override func autoLocalize() {
        super.autoLocalize()
        for index in (0..<numberOfSegments) {
            setTitle(String.localizedString(titleForSegment(at: index)), forSegmentAt: index)
        }
    }

}

extension UITextField {

    override func autoLocalize() {
        super.autoLocalize()
        text = String.localizedString(text)
        placeholder = String.localizedString(placeholder)
    }

}

extension UITextView {

    override func autoLocalize() {
        super.autoLocalize()
        text = String.localizedString(text)
    }
  
}

extension UISearchBar {
  
    override func autoLocalize() {
        super.autoLocalize()
        text = String.localizedString(text)
        placeholder = String.localizedString(placeholder)
        prompt = String.localizedString(prompt)
        if let scopeButtonTitles = self.scopeButtonTitles {
            var translatedTitles = [String]()
            for title in scopeButtonTitles {
                translatedTitles.append(String.localizedString(title) ?? "")
            }
            self.scopeButtonTitles = translatedTitles
        }
    }

}
