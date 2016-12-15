//
//  ViewController.swift
//  QuizApp
//
//  Created by 川崎 隆介 on 2015/11/25.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    var questionList:[[String:AnyObject]] = []
    var quizNumber = 0
    var answer = 0
    var correctAnswerNum = 0

    func goBackToBegining(_ alert:UIAlertAction!){
        self.quizNumber = 0
        self.correctAnswerNum = 0
        setQuizView(quizNumber: quizNumber)
    }
    
    func goToNextQuiz(_ alert:UIAlertAction!){
        if quizNumber < questionList.count {
            setQuizView(quizNumber: quizNumber)
        }else {
            let alertController = UIAlertController(title: "最終結果", message: "\(questionList.count)問中\(correctAnswerNum)問正解", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler:self.goBackToBegining)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func pushAnswerButton(_ sender: AnyObject) {
        self.quizNumber += 1
        var alertMessage = ""
        if sender.tag == answer {
            correctAnswerNum += 1
            alertMessage = "正解"
        }else{
            alertMessage = "不正解"
        }
        let alertController = UIAlertController(title: "結果", message: alertMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler:self.goToNextQuiz)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)

    }
    
    func loadPropertyList() {
        if let path = Bundle.main.path(forResource: "quiz", ofType: "plist"){
            if let array = NSArray(contentsOfFile: path) {
                questionList = array as! [[String:AnyObject]]
            }
        }
    }
    
    func setQuizView(quizNumber index:Int){
        let dic = self.questionList[index]
        numberLabel.text = "第\(quizNumber + 1)問"
        questionLabel.text =  dic["question"] as? String
        
        let choices = dic["choices"] as! [String]
        firstButton.setTitle(choices[0], for: .normal)
        secondButton.setTitle(choices[1], for: .normal)
        thirdButton.setTitle(choices[2], for: .normal)
        fourthButton.setTitle(choices[3], for: .normal)
        
        answer = dic["answer"] as! Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadPropertyList()
        setQuizView(quizNumber: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

