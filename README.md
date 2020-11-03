# voice
iMessage interface used for sending advanced messages.

---
**OUTSOURCED ASSETS:**

1.
Settings and info icons provied by 
https://hotpot.ai/blog/sf-symbols-online

---
**CODE THAT IS NOT MY OWN:**

1.
https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
- Paul Hudson @twostraws

```
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
```

2. 
https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift
- Aseider and Naveed Ahmad from Stack Overflow
```
override func viewDidLoad()
{
    super.viewDidLoad()

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(tapGestureRecognizer)
}

@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
{
    let tappedImage = tapGestureRecognizer.view as! UIImageView

    // Your action
}
```

---
