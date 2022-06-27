//
//  ReadingViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 22.05.2022.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore
import Firebase

class ReadingViewController: UIViewController, ObservableObject {
    
    @Published var questions: [Question] = [Question(rightAnswer: "В десять", text: "На краю дороги стоял дуб, вероятно, в десять раз старше берез составлявших лес он был в десять раз толще и в два раза выше каждой березы", wrong1: "В восемь", wrong2: "В пять", wrong3: "В двадцать", question: "Во сколько раз дуб старше берез?"),    Question(rightAnswer: "Победы", text: "Уинстон Смит, ежась от ветра, быстро скользнул в стеклянные двери Дома Победы но все же вихрь песка и пыли успел ворваться вместе с ним", wrong1: "Славы", wrong2: "Силы", wrong3: "Величия", question: "Как назывался дом?"),     Question(rightAnswer: "Андрей", text: "Новое лицо это был князь Андрей Болконский, муж маленькой княгини. Князь Болконский был небольшого роста, весьма красивый молодой человек с определенными и сухими чертами", wrong1: "Антон", wrong2: "Альберт", wrong3: "Владимир", question: "Какое имя было у княза?"),  Question(rightAnswer: "Екатерина", text: "Тогда не то что ныне, при государыне служил, Екатерине. А в те поры все важны! в сорок пуд. Раскланяйся, тупеем не кивнут. Вельможа, в случае, тем паче. Не как другой, и пил, и ел иначе", wrong1: "Елизавета", wrong2: "Виктория", wrong3: "Изабелла", question: "При какой государыне служил?"),   Question(rightAnswer: "Семь", text: "В каком году рассчитывай, в какой земле угадывай, на столбовой дороженьке сошлись семь мужиков: семь временнообязанных. Подтянутой губернии, уезда Терпигорева, пустопорожней волости, из смежных деревень", wrong1: "Восемь", wrong2: "Шесть", wrong3: "Девять", question: "Сколько было мужиков?"),    Question(rightAnswer: "Грузия", text: "Вся поклажа моей тележки состояла из одного небольшого чемодана, который до половины был набит путевыми записками о Грузии. Большая часть из них потеряна, а чемодан с остальными вещами остался цел", wrong1: "Испания", wrong2: "Армения", wrong3: "Швеция", question: "Какая страна была упомянута?"),    Question(rightAnswer: "Москва", text: "Однажды весною, в час небывало жаркого заката, в Москве, на Патриарших прудах, появились два гражданина", wrong1: "Мозырь", wrong2: "Минск", wrong3: "Саратов", question: "В каком городе происходит действие?"),   Question(rightAnswer: "Три", text: "Бегемот, проглотив третий мандарин, сунул лапу в хитрое сооружение из шоколадных плиток, выдернул одну нижнюю и проглотил ее вместе с золотой оберткой", wrong1: "Четыре", wrong2: "Два", wrong3: "Один", question: "Сколько мандаринов съел Бегемот?"),  Question(rightAnswer: "Черный", text: "В воздухе зашумело, и Азазелло, у которого в черном хвосте его плаща летели мастер и Маргарита, опустился вместе с ними возле группы дожидающихся", wrong1: "Красный", wrong2: "Синий", wrong3: "Розовый", question: "Какого цвета был плащ?"),     Question(rightAnswer: "Маргарита", text: "Воланд кивнул Бегемоту, тот очень оживился, надул щеки и свистнул. У Маргариты зазвенело в ушах. Конь ее взбросился на дыбы, в роще посыпались сухие сучья с деревьев, взлетела целая стая ворон и воробьев", wrong1: "Мастер", wrong2: "Воланд", wrong3: "Бегемот", question: "У кого зазвенело в ушах?"),     Question(rightAnswer: "Зимний", text: "Был зимний вечер. Конец января. Предобеденное, предприёмное время. На притолоке у двери в приёмную висел белый лист бумаги, на коем было написано: «Семечки есть в квартире запрещаю». Ф. Преображенский", wrong1: "Летний", wrong2: "Осенний", wrong3: "Весенний", question: "Какой был вечер?"),     Question(rightAnswer: "Шестеро", text: "Судырь ты мой, так начал почтмейстер, несмотря на то что в комнате сидел не один сударь, а целых шестеро, после кампании двенадцатого года вместе с ранеными прислан был и капитан Копейкин", wrong1: "Пятеро", wrong2: "Семеро", wrong3: "Двое", question: "Сколько людей сидело в комнате?"),    Question(rightAnswer: "Чичиков", text: "Уже несколько минут стоял Плюшкин, не говоря ни слова, а Чичиков все еще не мог начать разговора, развлеченный как видом самого хозяина, так и всего того, что было в его комнате", wrong1: "Плюшкин", wrong2: "Коробочка", wrong3: "Собакевич", question: "Кто не мог начать разговор?"),  Question(rightAnswer: "Цирюльник", text: "Марта 25 числа случилось в Петербурге необыкновенно странное происшествие. Цирюльник Иван Яковлевич, живущий на Вознесенском проспекте, проснулся довольно рано и услышал запах горячего хлеба", wrong1: "Повар", wrong2: "Пивовар", wrong3: "Кузнец", question: "Кем работал Иван Яковлевич?"),  Question(rightAnswer: "Пьер", text: "Пьер сидел против Долохова и Николая Ростова. Он много и жадно ел и много пил, как и всегда. Но те, которые его знали коротко, видели, что в нем произошла в нынешний день какая-то большая перемена", wrong1: "Долохов", wrong2: "Ростов", wrong3: "Болконский", question: "С какого имени начинался текст?"),  Question(rightAnswer: "Шестьдесят", text: "Вошел человек лет шестидесяти, беловолосый, худой и смуглый, в коричневом фраке с медными пуговицами и в розовом платочке на шее", wrong1: "Семьдесят", wrong2: "Шестнадцать", wrong3: "Пятьдесят", question: "Сколько лет было человеку?"),  Question(rightAnswer: "Васков", text: "Хмурый старшина Васков, писал рапорты по команде. Когда число их достигало десятка, начальство вкатывало Васкову очередной выговор и сменяло опухший от веселья полувзвод", wrong1: "Витьков", wrong2: "Владимиров", wrong3: "Антонов", question: "Какая была фамилия у старшины?"),   Question(rightAnswer: "Рита", text: "Теперь Рита была довольна: она добилась того, чего хотела. Даже гибель мужа отошла куда-то в самый тайный уголок памяти: у нее была работа, обязанность и вполне реальные цели для ненависти", wrong1: "Вера", wrong2: "Люба", wrong3: "Анжела", question: "Как звали героиню?"),     Question(rightAnswer: "Лиза", text: "Лиза думала о его словах и улыбалась, стесняясь того могучего незнакомого чувства, что нет-нет да и шевелилось в ней, вспыхивая на упругих щеках", wrong1: "Вера", wrong2: "Рита", wrong3: "Люба", question: "Как звали героиню?"),  Question(rightAnswer: "Дома", text: "Базаров ушел, а Аркадием овладело радостное чувство. Сладко засыпать в родимом доме, на знакомой постеле, под одеялом, над которым трудились любимые руки, быть может руки нянюшки, те ласковые, добрые и неутомимые руки", wrong1: "В хлеву", wrong2: "На печи", wrong3: "В сенях", question: "Где спал герой?")]
    lazy var logic = SummaryGameLogic.shared
    private let db = Firestore.firestore()
    var questDocuments: [String] = ["217bEtZZMxC0RL1QkrqV", "4WvTMa05BKFW0TyNVJYQ", "7A5TAVksSaJTTBM5uCiK", "9A7qzzfPQYvywW05gC2r", "C0hA1BrOW0lUaO6rwFKD", "DHkdlkpQOTGDVnbD4b39", "FQWhQHlN9QyNyhqHRZud", "FcUFFxPY2HtFOXJwe9ly", "JgdlZj2DeEnOrwHm0k8L", "Jmt8atAxL9tMSpvnPS0W", "JnBDNhyDeKCGPwbiRR8U", "PA8aqUWuZ1avllTpcygk", "QiFmRkG0iLfX3HhHh33t", "RKaHWi8OGg2MUbiL9KFQ", "Yz8UOvN3ifTjjYTfjsHI", "cqgMAAf3FjrdjMteNj0p", "etbiW39BgVrn78YTYNGa", "f5A4q3t07etN2z1ap4w0", "kSqfBotk4zcqOrgOUNGK", "my0FSuNWGo1f02kIXsaM"]
    var anyQuestion = Question(rightAnswer: "", text: "", wrong1: "", wrong2: "", wrong3: "", question: "")
    let ref1 = Firestore.firestore().collection("textQuestions")
    var answers = 0
    var i = -1
    var iteratorForText = 0
    var bufferArrayString = [String]()
    var timer = Timer()
    var timerForText = Timer()
    var timeForText = 0
    var time = 20{
        didSet{
            timerLabel.text = "\(time)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        timerForText = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(textTick), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData()
        questions.shuffle()
        //print(questions)
        prepareGame()
        

    }
    
    func prepareGame(){
        i += 1
        
        var allAnswers = [String]()
        allAnswers.append(questions[i].rightAnswer)
        allAnswers.append(questions[i].wrong1)
        allAnswers.append(questions[i].wrong2)
        allAnswers.append(questions[i].wrong3)
        
        allAnswers.shuffle()
        questionLabel.isHidden = true
        questionLabel.text = questions[i].question
        
        //print(questions[i].text)
        
        for button in 0...buttonCollection.count - 1{
            buttonCollection[button].backgroundColor = UIColor.blue
            buttonCollection[button].setTitle("\(allAnswers[button])", for: .normal)
            buttonCollection[button].isHidden = true
        }

        bufferArrayString = questions[i].text.components(separatedBy: " ")
        
    }
    
    func fetchData(){
        
        db.collection("textQuestions")
            .addSnapshotListener { querySnapshot, error in
                guard let querySnapshot = querySnapshot else { return }
                
                self.questions = querySnapshot.documents.compactMap { try? $0.data(as: Question.self) }
            }
        
//        db.collection("textQuestions").getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                print("Error in reading documents")
//            } else {
//                for document in querySnapshot!.documents{
//                    let data = document.data()
//                    //anyQuestion["Text"] = data["Text"] as? String ?? ""
//
//                }
//            }
//
//        }
//
//        db.collection("textQuestions").document(questDocuments[0]).getDocument() { result,<#arg#>  in
//            switch result {
//            case .failure(let error):
//                print("error")
//            case .success(let ):
//
//            }
//
//        }
//
//        db.collection("textQuestions").addSnapshotListener { (querySnapshot,  error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No Documents")
//                return
//            }
//            self.questions = documents.compactMap { (queryDocumentSnapshot) -> Question? in
//                let data = queryDocumentSnapshot.data()
//                let rightAnswer = data["RightAnswer"] as? String ?? ""
//                let text = data["Text"] as? String ?? ""
//                let wrong1 = data["Wrong1"] as? String ?? ""
//                let wrong2 = data["Wrong2"] as? String ?? ""
//                let wrong3 = data["Wrong3"] as? String ?? ""
//                let question = data["Question"] as? String ?? ""
//                return Question(rightAnswer: rightAnswer, text: text, wrong1: wrong1, wrong2: wrong2, wrong3: wrong3, question: question)
//            }
//
//        }
    }
    
    @objc func textTick(){
        timeForText += 1
        textLabel.text = bufferArrayString[iteratorForText]
        iteratorForText += 1
        if iteratorForText == bufferArrayString.count{
            timerForText.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
            questionLabel.isHidden = false
            for i in 0...buttonCollection.count - 1{
                buttonCollection[i].isHidden = false
            }
            iteratorForText = 0
            let delay: TimeInterval = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.textLabel.text = ""
            }
        
        }
    }
    
    @objc func tick(){
        textLabel.isHidden = true
        time -= 1
        if time == 0 {
            timer.invalidate()
            SummaryGameLogic.shared.nameOfTheGame = "Чтение текста"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let resaultsViewController = storyboard.instantiateViewController(withIdentifier: "ResaultsViewController") as? ResaultsViewController else { return}
            self.show(resaultsViewController, sender: self)
        }
    }
    

    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonIndex = buttonCollection.firstIndex(of: sender){
            if buttonCollection[buttonIndex].currentTitle == questions[i].rightAnswer{
                print("Правильно")
                buttonCollection[buttonIndex].backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                logic.conclusion(right: 1,wrong: 0)
            } else {
                print("Неправильно")
                buttonCollection[buttonIndex].backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                logic.conclusion(right: 0,wrong: 1)
            }
        }
        prepareGame()
        textLabel.isHidden = false
        timer.invalidate()
        timerForText = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(textTick), userInfo: nil, repeats: true)
    }
    
    
}
