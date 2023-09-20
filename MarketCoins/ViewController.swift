//
//  ViewController.swift
//  MarketCoins
//
//  Created by Rafael Badaró on 12/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
        preconditionFailure("This method must be overriden")
    }
    
    func showError(for mensagem: String, handler:((UIAlertAction) -> Void)? = nil) {
    
        let alert = UIAlertController(title: "Erro", message: messagem, preferredStyle: .alert)
        
        alert.addAction (UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
        exit(0)
        }))
        
        alert.addAction (UIAlertAction(title: "Tentar novamente", style: .default, handler: handler))
        present(alert, animated: true)
        
    }
    
}
