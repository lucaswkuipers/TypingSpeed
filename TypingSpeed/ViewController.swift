import UIKit

final class ViewController: UIViewController {
    let words = ["horses", "dogs", "lets", "annual", "festival", "when", "insertion", "what", "should"]
    var currentIndex = 0
    let maximumLength = 13

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentWordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        advanceWord()

        inputTextField.layer.cornerRadius = 10

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
//        let guide = view.safeAreaLayoutGuide
//        let height = guide.layoutFrame.size.height
        inputViewBottomConstraint.constant = keyboardHeight - view.safeAreaInsets.bottom.magnitude
    }

    @objc private func keyboardWillHide() {
        inputViewBottomConstraint.constant = 0
    }

    private func advanceWord() {
        currentIndex += 1
        currentIndex %= words.count
        let nextWord = words[currentIndex]
        currentWordLabel.text = nextWord
        inputTextField.text = ""
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        if textField.text == currentWordLabel.text {
            currentWordLabel.textColor = .green

            DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
                self?.advanceWord()
            }
        } else {
            currentWordLabel.textColor = .red
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= maximumLength
   }
}

/*
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
 }*/
