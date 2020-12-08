//
//  ViewController.swift
//  dz3-2
//
//  Created by Apple iMac 27 on 03.12.2020.
//

import UIKit

class ViewController: UIViewController {

    var scoreLabel: UILabel!
    var scoreView: UIView!
    var score: Int = 0
    
    var tapBeg: CGFloat = 0
    var tapBeg2: CGPoint = .zero
    var tapBeg3: CGFloat = 5
    
    private lazy var recognizerScore : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didTap(_:)))
    
    @objc func didTap(_ sender: UIPanGestureRecognizer) {
         if sender.state == .began {
             tapBeg2 = sender.translation(in: self.view!.superview)
             tapBeg = 0
         }
         else if sender.state == .changed {
            
            let nextP = sender.translation(in: self.view!.superview)
            
            tapBeg += nextP.y - tapBeg2.y
            
            if tapBeg > tapBeg3 {
                tapBeg += tapBeg3
                 score -= 1
             }
            
            if tapBeg < -tapBeg3 {
                 tapBeg -= tapBeg3
                 score += 1
             }
            scoreLabel.newScore(to: score)
            tapBeg2 = nextP
         }
        
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.newScore(to: score)
        
        scoreView = UIView()
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.backgroundColor = .systemYellow
        scoreView.addGestureRecognizer(recognizerScore)
        
        view.addSubview(scoreView)
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            scoreView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 40),
            scoreView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            scoreView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            scoreView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)
        ])
    }

}

extension UILabel{
    func newScore(to newScores: Int) {
        self.text = "Число = \(newScores)"
    }
}



