//
//  ViewController.swift
//  lotery
//
//  Created by Daniel J Rodrigues on 09/12/21.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

class ViewController: UIViewController {

    @IBOutlet weak var lbTitleType: UILabel!
    @IBOutlet weak var scTypes: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNums(for: .megasena)
    }
    
    func showNums(for type: GameType) {
        lbTitleType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megasena:
                game = generateRandomNums(6, 60)
                balls.last!.isHidden = false
            case .quina:
                game = generateRandomNums(5, 80)
                balls.last!.isHidden = true
        }
        
        for (index, num) in game.enumerated() {
            balls[index].setTitle("\(num)", for: .normal)
        }
    }

    func generateRandomNums(_ amountOfNums: Int, _ maxNum: Int) -> [Int] {
        var result: [Int] = []
        while result.count < amountOfNums {
            let random = Int(arc4random_uniform(UInt32(maxNum))+1)
            if !result.contains(random) {
                result.append(random)
            }
        }
        return result.sorted()
    }
    
    @IBAction func generateGame() {
        switch scTypes.selectedSegmentIndex {
            case 0:
                showNums(for: .megasena)
            default:
                showNums(for: .quina)
        }
    }
    
}

