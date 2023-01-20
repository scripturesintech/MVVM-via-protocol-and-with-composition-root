//
//  ViewController.swift
//  kanye
//
//  Created by ScripturesInTech on 19/01/23.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: ViewModel

    @IBOutlet weak var messageLabel: UILabel!

    required init?(coder aDecoder: NSCoder, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(coder: aDecoder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(fetchQuote))
        
        self.viewModel.loopingIn()
        
        self.viewModel.output = self
    }
    
    
    /// fetchQuote
    @objc func fetchQuote() {
        viewModel.fetchQuote()
    }
}

extension ViewController: QuoteViewModelResult {
    
    /// updateView
    /// - Parameter model: Quote
    func updateView(model: Quote) {
        self.view.backgroundColor = .random
        self.messageLabel.text = model.quote
    }
}


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                       blue: .random(in: 0...1), alpha: 1)
    }
}
