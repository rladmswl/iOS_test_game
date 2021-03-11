//
//  ViewController.swift
//  UpDownGame
//
//  Created by 김은지 on 2021/02/25.
//

import UIKit

class ViewController: UIViewController {

    var randomValue: Int = 0
    var tryCount: Int = 0
    
    // outlet은 인터페이스 빌드 위에 올라온 ui요소에 어떤 값을 가져오고 싶을 떄, 그것을 코드에서 활용하고 싶을 떄 사용
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tryCountLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.setThumbImage(#imageLiteral(resourceName: "slider_thumb"), for: .normal) // normal : 항상 나타냄
        reset()
        print(randomValue)
    }
    
    // IBAction은 인터페이스 빌드에 어떤 요소들이 이벤트를 받았을 때, 거기에 반응하기 위한 코드를 작성 할 떄 사용
    @IBAction func sliderValueChange(_ sender: UISlider) {
        print(sender.value)
        let integerValue: Int = Int(sender.value) // 먼저 slider 값을 정수값으로 변환
        sliderValueLabel.text = String(integerValue) // 변환된 정수타입을 string타입으로 변환하여 text로 넣어줌
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.reset()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func touchUpHitButton(_ sender: UIButton) {
        print(slider.value)
        let hitValue: Int = Int(slider.value)// 사용자가 hit버튼을 눌렀을 때, 정수로 받아온다
        slider.value = Float(hitValue)// 그 값을 다시 slider에 넣어준다
        
        tryCount = tryCount + 1
        //tryCountLabel.text = String(tryCount) + " / 5"
        tryCountLabel.text = "\(tryCount) / 5" // 문자열 보간법 \() 사용. tryCount에 있는 변수의 값을 꺼내서 \(tryCount) 부분을 문자열로 바꿔서 치환해준다는 뜻
        
        if randomValue == hitValue {
            //print("YOU HIT!")
            showAlert(message: "YOU HIT!")
            reset() // 맞췄으니 초기화
        }else if tryCount >= 5 {
            //print("YOU LOSE...")
            showAlert(message: "YOU LOSE...")
            reset() // 5번 실패했으니 초기화
        }else if randomValue > hitValue {
            slider.minimumValue = Float(hitValue)
            minimumValueLabel.text = String(hitValue)
        } else {
            slider.maximumValue = Float(hitValue)
            maximumValueLabel.text = String(hitValue)
        }
    }

    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
        reset()
    }
    
    func reset() {
        print("reset!")
        randomValue = Int.random(in: 0...30) // 0~30 사이의 수를 임의로 정하기
        tryCount = 0
        tryCountLabel.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
    }
}

