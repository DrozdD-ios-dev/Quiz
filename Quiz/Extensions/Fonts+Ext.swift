import SwiftUI

enum FontType {
    case poppins400
    case poppins500
    case poppins600
    case poppins700
    case poppins800
}

extension Font {
    
    static let customFont: (FontType, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .poppins400:
            Font.custom("Poppins-Regular", size: size)
        case .poppins500:
            Font.custom("Poppins-Medium", size: size)
        case .poppins600:
            Font.custom("Poppins-SemiBold", size: size)
        case .poppins700:
            Font.custom("Poppins-Bold", size: size)
        case .poppins800:
            Font.custom("Poppins-ExtraBold", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontType: FontType, _ size: CGFloat) -> Text {
        return self.font(.customFont(fontType, size))
    }
}
