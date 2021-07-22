//
//  ViewController.swift
//  Evolve Crash Challenge
//
//  Created by Thiago Medeiros on 21/07/21.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var LabelStory: UILabel!
    @IBOutlet weak var ButtonFirstOption: UIButton!
    @IBOutlet weak var ButtonSecondOption: UIButton!
    @IBOutlet weak var ButtonThirdOption: UIButton!
    
    var currentStoryLine = "Intro"
    var previousStoryLine = "Intro"
    let fadeDuration = 0.4
    
    let story: [String: StoryLine] = [
        "Intro": StoryLine(
            "Você está em lugar escuro. Consciente, mas não sabe onde está. Você escolhe:",
            options: [
                ("Debater-se", "Debater-se"),
                ("Esperar", "Esperar")
            ]
        ),
        "Debater-se": StoryLine(
            "Parece que a luz está aparecendo...\nUma espécie de ovo eclode, uma célula sai de dentro. Aparentemente isso é você, agora só te resta:",
            options: [
                ("Nadar","Nadar"),
            ]
        ),
        "Esperar": StoryLine(
            "Parece que ninguém vira...",
            options: [
                ("Continuar esperando", "Intro"),
            ]
        ),
        "Nadar": StoryLine(
            "Pequenas bolas azuis estão boiando. Você tem duas opções:",
            options: [
                ("Continuar nadando", "Morte"),
                ("Comer", "Comer")
            ]
        ),
        "Morte": StoryLine(
            "Você sente uma fraqueza. Esgotado e sem energias não consegue mais se movimentar.\nSua vida não durou muito tempo.",
            options: [
                ("Tentar novamente", "Intro"),
            ]
        ),
        "Comer": StoryLine(
            "Você se sente bem, essas bolinhas são muito nutritivas e uma sensação estranha te faz sentir que está crescendo.\nUm vulto muito grande está cada vez mais perto.",
            options: [
                ("Ignorar e continuar comendo", "Ignorar e continuar comendo"),
                ("Fugir", "Fugir"),
                ("Desta vez a sensação estranha está maior", "A sensação estranha continua")
            ]
        ),
        "Ignorar e continuar comendo": StoryLine(
            "O vulto era um bicho amarelo muito estranho. Repentinamente você sente o mar a sua volta puxando e em alguns instantes você está dentro dele.\nTudo escuro novamente, só te resta esperar.",
            options: [
                ("Esperar", "Esperar"),
            ]
        ),
        "Fugir": StoryLine(
            "Boa ideia! O vulto era um bicho amarelo estranho que devorou tudo que tinha próximo às bolinhas.\nEssa é sua vida: comer, crescer, fugir... acho que devemos seguir isso. Aquela sensação estranha após comer parece ser o caminho certo.",
            options: [
                ("Comer mais", "Comer mais"),
                ("Esperar", "Morte")
            ]
        ),
        "A sensação estranha continua": StoryLine(
            "Você sente a sensação estranha cada vez mais forte e, repentinamente, você está desacordado.",
            options: [
                ("Acordar", "Acordar"),
            ]
        ),
        "Comer mais": StoryLine(
            "Aparentemente esta é a solução. Dentro de você algo parece guiá-lo para onde as bolinhas azuis estão. Vamos atrás delas!",
            options: [
                ("Seguir seu instinto", "Seguir seu instinto"),
            ]
        ),
        "Seguir seu instinto": StoryLine(
            "Mais bolinhas azuis! Algo te diz para comê-las.",
            options: [
                ("Comer", "Comer"),
                ("Ignorar e continuar nadando", "Morte")
            ]
        ),
        "Acordar": StoryLine(
            "Sua corpo parece estar maior, existem alguns membros novos, sua boca está diferente, aquele guia para bolinhas azuis não existe mais. À sua direita existe uma luz vermelha muito intrigante e chamativa.",
            options: [
                ("Ir em sua direção", "Ir em sua direção"),
                ("Nadar para o outro lado", "Nadar para o outro lado")
            ]
        ),
        "Ir em sua direção": StoryLine(
            "Aparentemente essa escolha não foi muito boa. Quanto mais você se aproxima da luz mais você sente que tudo está acabando.\nSua vida durou um pouco mais, mas não foi desta vez!",
            options: [
                ("Tentar novamente", "Intro"),
            ]
        ),
        "Nadar para o outro lado": StoryLine(
            "Você encontrou bolinhas verdes, aparentemente seu guia trocou de objetivo.",
            options: [
                ("Comer", "Comer verde"),
            ]
        ),
        "Comer verde": StoryLine(
            "Essa é melhor coisa que você já comeu! Esse seu guia é muito bom!",
            options: [
                ("Continuar comendo", "Continuar comendo"),
            ]
        ),
        "Continuar comendo": StoryLine(
            "Estranhamente o seu guia aponta para novas bolinhas verdes, mas as que você está comendo ainda não acabaram...",
            options: [
                ("Seguir o guia", "Seguir o guia"),
                ("Seguir comendo", "Seguir comendo")
            ]
        ),
        "Seguir o guia": StoryLine(
            "Boa escolha!\nAproveite as novas bolinhas verdes, elas estão divinas!",
            options: [
                ("Comer bastante", "Comer bastante"),
            ]
        ),
        "Seguir comendo": StoryLine(
            "A luz vermelha aparece do atrás de você, tão tentadora e tão próxima. Você não consegue escapar! Sua vida não durou muito...\nAcho que você deveria seguir mais seu guia, a essa altura você já deveria saber que seguí-lo é melhor!",
            options: [
                ("Tentar novamente", "Intro"),
            ]
        ),
        "Comer bastante": StoryLine(
            "Aquela sensação estranha voltou e sua visão começa a escurecer. Muito rapidamente você está desacordado.",
            options: [
                ("Acordar de novo", "Acordar parceiro"),
            ]
        ),
        "Acordar parceiro": StoryLine(
            "Bom dia, você está menos pontudo!?!?! Interessante, acho que podemos continuar fazendo o mesmo de cada dia: comer, crescer, fugir...",
            options: [
                ("Nadar por aí", "Nadar por aí"),
            ]
        ),
        "Nadar por aí": StoryLine(
            "Acho que seu guia está diferente. Não consigo mais ver bolinhas, apenas algo muito parecido com você!",
            options: [
                ("Seu foco mudou, vamos atrás desta nova opção", "Novo foco"),
            ]
        ),
        "Novo foco": StoryLine(
            "Ainda não achamos nada, mas seu guia está cada vez mais forte.",
            options: [
                ("Continuar nadando", "Continuar nadando"),
            ]
        ),
        "Continuar nadando": StoryLine(
            "Ahhh, era isso. Você encontrou!\nEm sua frente aparece um parceiro, você sente que deve aproximar-se.",
            options: [
                ("Aproximar-se", "Aproximar-se"),
                ("Ignorar", "Ignorar")
            ]
        ),
        "Ignorar": StoryLine(
            "Sua existência começa a sumir, o breu se aproxima, a luz começa a acabar e sua vida passa como um filme em seu consciente...",
            options: [
                ("Acordar", "Intro"),
            ]
        ),
        "Aproximar-se": StoryLine(
            "Você sente a mesma sensação estranha da primeira vez que ficou inconsciente, mas dessa vez ela está misturada com o vazio que você sentiu quando acordou pela primeira vez.",
            options: [
                ("Aceitar", "Aceitar"),
                ("Debater-se", "Não funciona")
            ]
        ),
        "Aceitar": StoryLine(
            "Tudo escuro. Muito obrigado, você serviu o seu propósito. Agora só te resta:",
            options: [
                ("Esperar", "Intro"),
            ]
        ),
        "Não funciona": StoryLine(
            "Você se debate, mas nada ocorre. Qualquer movimento ou ação parece não funcionar. A sensação de vazio aumenta, a escuridão te consome.",
            options: [
                ("Continuar tentando", "Continuar tentando"),
            ]
        ),
        "Continuar tentando": StoryLine(
            "Nada muda... Você já não sente mais nada, esse é seu fim.",
            options: [
                ("Aceitar", "Aceitar"),
            ]
        ),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        LabelStory.text = story[currentStoryLine]!.label
        ButtonFirstOption.setTitle(story[currentStoryLine]!.options[0].buttonLabel, for: .normal)
        if let secondButtonOptions = story[currentStoryLine]?.options[1] {
            ButtonSecondOption.setTitle(secondButtonOptions.buttonLabel, for: .normal)
        }
        ButtonThirdOption.isEnabled = false
        ButtonThirdOption.alpha = 0
    }

    @IBAction func FirstButtonTouchDown(_ sender: Any) {
        guard let nextStoryLine = story[currentStoryLine]?.options[0] else {
            return
        }

        changeStoryLine(nextStoryLine.storyLineLabel)
    }
    
    @IBAction func SecondButtonTouchDown(_ sender: Any) {
        guard let nextStoryLine = story[currentStoryLine]?.options[1] else {
            return
        }

        changeStoryLine(nextStoryLine.storyLineLabel)
    }

    @IBAction func ThirdButtonTouchDown(_ sender: Any) {
        guard let nextStoryLine = story[currentStoryLine]?.options[2] else {
            return
        }
        ButtonThirdOption.isEnabled = false
        ButtonThirdOption.alpha = 0

        changeStoryLine(nextStoryLine.storyLineLabel)
    }
    
    func changeStoryLine(_ storyLineLabel: String) {
        story[currentStoryLine]!.timesVisited += 1
        if storyLineLabel == "Comer" && currentStoryLine == "Seguir seu instinto" {
            if story["Comer"]!.timesVisited >= 2 {
                ButtonThirdOption.setTitle(story["Comer"]!.options[2].buttonLabel, for: .normal)
                ButtonThirdOption.isEnabled = true
                ButtonThirdOption.alpha = 1
            }
        }
        previousStoryLine = currentStoryLine
        currentStoryLine = storyLineLabel

        LabelStory.fadeTransition(fadeDuration)
        ButtonFirstOption.fadeTransition(fadeDuration)
        ButtonSecondOption.fadeTransition(fadeDuration)
        ButtonThirdOption.fadeTransition(fadeDuration)

        LabelStory.text = story[currentStoryLine]!.label
        ButtonFirstOption.setTitle(story[currentStoryLine]!.options[0].buttonLabel, for: .normal)
        if story[currentStoryLine]!.options.count > 1 {
            let secondButtonOptions = story[currentStoryLine]!.options[1]
            ButtonSecondOption.setTitle(secondButtonOptions.buttonLabel, for: .normal)
            ButtonSecondOption.isEnabled = true
            ButtonSecondOption.alpha = 1
        } else {
            ButtonSecondOption.isEnabled = false
            ButtonSecondOption.alpha = 0
        }
    }
}

