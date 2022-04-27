import UIKit

final class ViewController: UIViewController {
    let contentText = "This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. This is a story. Let's see if it works! Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextView.attributedText = NSMutableAttributedString(string: contentText)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        inputViewBottomConstraint.constant = -keyboardHeight
    }

    @objc private func keyboardWillHide() {
        inputViewBottomConstraint.constant = 0
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text,
              inputText.count <= contentTextView.text.count
        else { return }

        let cleanText = NSAttributedString(string: contentTextView.text)
        contentTextView.attributedText = cleanText

        if inputText.isEmpty { return }

        let currentCharacterIndex = inputText.count - 1

        print("Current char index \(currentCharacterIndex)")

        for charIndex in 0...currentCharacterIndex {
            let contentTextIndex = contentTextView.text.index(contentTextView.text.startIndex, offsetBy: charIndex)
            let contentTextViewTextAtIndex = String(contentTextView.text[contentTextIndex])

            let inputTextIndex = inputText.index(inputText.startIndex, offsetBy: charIndex)
            let inputTextAtIndex = String(inputText[inputTextIndex])

            print("Content text at index: \(contentTextViewTextAtIndex)")
            print("Input text at index: \(inputTextAtIndex)")

            let color: UIColor = contentTextViewTextAtIndex == inputTextAtIndex ? .green : .red

            let attributes = contentTextViewTextAtIndex == " " ? [NSAttributedString.Key.backgroundColor: color] : [NSAttributedString.Key.foregroundColor: color]
            let range = NSRange(location: charIndex, length: 1)
            let result = NSMutableAttributedString(attributedString: contentTextView.attributedText)

            result.addAttributes(attributes, range: range)

//                contentTextView.attributedText = contentTextView.text.highlightWordsIn(highlightedWords: inputTextAtIndex, attributes: attributes)
            contentTextView.attributedText = result


//                contentTextView.attributedText[contentTextIndex] = coloredAttributedText
        }
    }
}

extension String {

    func highlightWordsIn(highlightedWords: String, attributes: [[NSAttributedString.Key: Any]]) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: highlightedWords)
        let result = NSMutableAttributedString(string: self)

        for attribute in attributes {
            result.addAttributes(attribute, range: range)
        }

        return result
    }
}
