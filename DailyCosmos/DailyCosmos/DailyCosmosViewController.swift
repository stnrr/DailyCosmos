//
//  DailyCosmosViewController.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import UIKit

class DailyCosmosViewController: UIViewController {
    @IBOutlet private weak var containerView: UIStackView!
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
        viewModel.getDailyCosmosData {[unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.display(model: model)
                case .failure(let error):
                    print(error.localizedDescription)
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
}

