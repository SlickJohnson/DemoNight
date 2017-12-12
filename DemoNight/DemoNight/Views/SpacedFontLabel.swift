import UIKit

@IBDesignable class SpacedFontLabel: UILabel {

  @IBInspectable var characterSpacing: CGFloat = 0.0 {
    didSet {
      adjustTextSpacing()
    }
  }
  
  override var text: String? {
    didSet {
      adjustTextSpacing()
    }
  }

  var attributedString: NSMutableAttributedString!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.commonInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  func commonInit() {
    adjustTextSpacing()
  }

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
}
