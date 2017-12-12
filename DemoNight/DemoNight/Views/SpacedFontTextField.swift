import UIKit

/// UITexdtField with easily adjustable character spacing
@IBDesignable class SpacedFontTextField: UITextField {
  /// Done button that sits right above the keyboard when Textfield is being edited.
  var doneButton: UIBarButtonItem?

  /// Spacing between characters
  @IBInspectable var characterSpacing: CGFloat = 0.0 {
    didSet {
      adjustTextSpacing()
      adjustPlaceholderSpacing()
      changePlaceholderColor(to: .black)
    }
  }

  /// Text within the UITextField. Set the value triggers spacing adjustment.
  override var text: String? {
    didSet {
      adjustTextSpacing()
      changePlaceholderColor(to: .black)
    }
  }

  /// The placeholder text of the UITextField
  override var placeholder: String? {
    didSet {
      adjustPlaceholderSpacing()
      changePlaceholderColor(to: .black)
    }
  }

  /// AttributedSring that'll recieve the spacing attribute.
  var attributedString: NSMutableAttributedString!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.commonInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  /**
   Init for SpaceFontTextField
   */
  func commonInit() {
    self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    adjustTextSpacing()
    adjustPlaceholderSpacing()
  }
}

// MARK: - Helper methods
extension SpacedFontTextField {
  /**
   Adjusts the character spacing of the textfield.
   */
  func adjustTextSpacing() {
    guard let text = text else { return }

    if let attributedText = attributedText {
      attributedString = NSMutableAttributedString(attributedString: attributedText)
    } else {
      attributedString = NSMutableAttributedString(string: text)
    }

    attributedString.addAttribute(.kern, value: characterSpacing,
                                  range: NSRange(location: 0, length: attributedString.length))

    attributedText = attributedString
  }

  /**
   Adjusts the character spacing the the texfield's placeholder
   */
  func adjustPlaceholderSpacing() {
    guard let placeholder = placeholder else { return }

    if let attributedPlaceholder = attributedPlaceholder {
      attributedString = NSMutableAttributedString(attributedString: attributedPlaceholder)
    } else {
      attributedString = NSMutableAttributedString(string: placeholder)
    }

    attributedString.addAttribute(.kern, value: characterSpacing,
                                  range: NSRange(location: 0, length: attributedString.length))

    attributedPlaceholder = attributedString
  }

  /**
   Change the color of the placeholder text and keep all other attributes.
   */
  func changePlaceholderColor(to color: UIColor) {
    guard let placeholder = placeholder else { return }

    if let attributedPlaceholder = attributedPlaceholder {
      attributedString = NSMutableAttributedString(attributedString: attributedPlaceholder)
    } else {
      attributedString = NSMutableAttributedString(string: placeholder)
    }

    attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: attributedString.length))

    attributedPlaceholder = attributedString
  }

  /**
   Triggered when the contents of the UITextField are changed. Used to make sure UITextField maintains attributes.
   */
  @objc func textFieldDidChange() {
    adjustTextSpacing()
  }
}

// MARK: - Convenient methods
extension SpacedFontTextField {
  /**
   Adds a simple 'Done' button to the top of the iOS keyboard.
   */
  func addDoneButtonOnKeyboard() {
    if let doneButton = doneButton {
      let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 350, height: 20))
      doneToolbar.barStyle = UIBarStyle.blackTranslucent

      let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      
      doneToolbar.items = [flexSpace, doneButton]
      doneToolbar.sizeToFit()

      self.inputAccessoryView = doneToolbar
    }
  }
}

