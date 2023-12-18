import UIKit

extension UIImage {
    
    public func removeWhiteBackground() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
}
