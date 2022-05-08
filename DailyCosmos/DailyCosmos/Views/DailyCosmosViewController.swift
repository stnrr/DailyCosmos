//
//  DailyCosmosViewController.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import UIKit

class DailyCosmosViewController: UIViewController {
    @IBOutlet private weak var containerView: UIStackView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: CosmosImageView!
    @IBOutlet private weak var descriptionView: UITextView!
    
    private var viewModel: DailyCosmosViewModel = DailyCosmosViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialState()
        loadDailyCosmos()
    }
    
    private func setInitialState() {
        containerView.isHidden = true
    }
    
    private func loadDailyCosmos() {
        if let model = DailyCosmosModel.getCacheCosmosData(), model.isTodayData() {
            self.display(model: model)
        } else {
            loader.startAnimating()
            viewModel.getDailyCosmosData {[unowned self] result in
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    switch result {
                    case .success(let model):
                        self.display(model: model)
                    case .failure(let error):
                        self.showAlertForError(error: error)
                    }
                }
            }
        }
    }
    
    private func display(model: DailyCosmosModel) {
        titleLabel.text = model.title
        descriptionView.text = model.imageDescription
        if let imageUrl = model.imageUrl {
            imageView.load(from: imageUrl, contentMode: .scaleAspectFit)
        }
        containerView.isHidden = false
    }
    
    private func showAlertForError(error: Error) {
        let alert = UIAlertController(title: "",
                                      message: "We are not connected to the internet, showing you the last image we have.",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { [unowned self]  _ in
            if let model = DailyCosmosModel.getCacheCosmosData() {
                self.display(model: model)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

