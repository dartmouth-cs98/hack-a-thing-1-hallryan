//
//  ViewController.swift
//  DogsVsCats
//
//  Created by Brian Advent on 17.01.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkAnimalButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    
    @IBAction func selectImageSource(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let imageSourceActions = UIAlertController(title: "Image Source", message: "Choose an image source to continue.", preferredStyle: .actionSheet)
        imageSourceActions.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }))
        
        imageSourceActions.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(imageSourceActions, animated:true)
    }
    
    
    @IBAction func checkAnimal(_ sender: Any) {
        AnimalDetector.startAnimalDetection(imageView) { (results) in guard let animal = results.first else { print("No detection possible"); return}
        
        
        DispatchQueue.main.async {
            self.classificationLabel.text = "It's a \(animal)"
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else { picker.dismiss(animated: true); print("Could not select image!"); return
        }
        
        imageView.image = selectedImage
        imageView.contentMode = .scaleAspectFill
        checkAnimalButton.isEnabled = true
        
        picker.dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
