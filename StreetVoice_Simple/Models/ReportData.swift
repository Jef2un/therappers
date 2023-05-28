import Foundation
import UIKit

struct Report{
    let managerImage: UIImage? = UIImage(named: "therappers")
    let managerName: String
    let content: String
    let contentImage: UIImage?

    init(managerName: String, content: String, contentImage: UIImage?) {
        self.managerName = managerName
        self.content = content
        self.contentImage = contentImage
    }
}
