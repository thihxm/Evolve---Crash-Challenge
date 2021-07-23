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
    @IBOutlet weak var ImageContent: UIImageView!
    @IBOutlet weak var RedLight: UIImageView!
    
    var currentStoryLine = "Intro"
    var previousStoryLine = "Intro"
    let fadeDuration = 0.4
    
    let story: [String: StoryLine] = [
        "Intro": StoryLine(
            "Você está em lugar escuro. Consciente, mas não sabe onde está. Você escolhe:",
            options: [
                ("Debater-se", "Debater-se"),
                ("Esperar", "Esperar")
            ],
            backgroundImage: "Breu",
            imageName: "Ovo"
        ),
        "Debater-se": StoryLine(
            "Parece que a luz está aparecendo...\nUma espécie de ovo eclode, um ser sai de dentro. Aparentemente isso é você, agora só te resta:",
            options: [
                ("Nadar","Nadar"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Estagio 1"
        ),
        "Esperar": StoryLine(
            "Parece que ninguém vira...",
            options: [
                ("Continuar esperando", "Intro"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Nadar": StoryLine(
            "Pequenas bolas rosa estão boiando. Você tem duas opções:",
            options: [
                ("Continuar nadando", "Morte"),
                ("Comer", "Comer")
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Bolinhas Rosa"
        ),
        "Morte": StoryLine(
            "Você sente uma fraqueza. Esgotado e sem energias não consegue mais se movimentar.\nSua vida não durou muito tempo.",
            options: [
                ("Tentar novamente", "Intro"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Comer": StoryLine(
            "Você se sente bem, essas bolinhas são muito nutritivas e uma sensação estranha te faz sentir que está crescendo.\nUm vulto muito grande está cada vez mais perto.",
            options: [
                ("Ignorar e continuar comendo", "Ignorar e continuar comendo"),
                ("Fugir", "Fugir"),
                ("Desta vez a sensação estranha está maior", "A sensação estranha continua")
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Vulto"
        ),
        "Ignorar e continuar comendo": StoryLine(
            "O vulto era um bicho amarelo muito estranho. Repentinamente você sente o mar a sua volta puxando e em alguns instantes você está dentro dele.\nTudo escuro novamente, só te resta esperar.",
            options: [
                ("Esperar", "Esperar"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Estagio 2"
        ),
        "Fugir": StoryLine(
            "Boa ideia! O vulto era um bicho amarelo estranho que devorou tudo que tinha próximo às bolinhas.\nEssa é sua vida: comer, crescer, fugir... acho que devemos seguir isso. Aquela sensação estranha após comer parece ser o caminho certo.",
            options: [
                ("Comer mais", "Comer mais"),
                ("Esperar", "Morte")
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "A sensação estranha continua": StoryLine(
            "Você sente a sensação estranha cada vez mais forte e, repentinamente, você está desacordado.",
            options: [
                ("Acordar", "Acordar"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Comer mais": StoryLine(
            "Aparentemente esta é a solução. Dentro de você algo parece guiá-lo para onde as bolinhas rosa estão. Vamos atrás delas!",
            options: [
                ("Seguir seu instinto", "Seguir seu instinto"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "Seguir seu instinto": StoryLine(
            "Mais bolinhas rosa! Algo te diz para comê-las.",
            options: [
                ("Comer", "Comer"),
                ("Ignorar e continuar nadando", "Morte")
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Bolinhas Rosa"
        ),
        "Acordar": StoryLine(
            "Sua corpo parece estar maior, existem alguns membros novos, sua boca está diferente, aquele guia para bolinhas rosa não existe mais. À sua direita existe uma luz vermelha muito intrigante e chamativa. O que você faz?",
            options: [
                ("Ir em sua direção", "Ir em sua direção"),
                ("Nadar para o outro lado", "Nadar para o outro lado")
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Estagio 2"
        ),
        "Ir em sua direção": StoryLine(
            "Aparentemente essa escolha não foi muito boa. Quanto mais você se aproxima da luz mais você sente que tudo está acabando.\nSua vida durou um pouco mais, mas não foi desta vez!",
            options: [
                ("Tentar novamente", "Intro"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Nadar para o outro lado": StoryLine(
            "Você encontrou bolinhas verde, aparentemente seu guia trocou de objetivo.",
            options: [
                ("Comer", "Comer verde"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Bolinhas Verde"
        ),
        "Comer verde": StoryLine(
            "Essa é melhor coisa que você já comeu! Esse seu guia é muito bom!",
            options: [
                ("Continuar comendo", "Continuar comendo"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "Continuar comendo": StoryLine(
            "Estranhamente o seu guia aponta para novas bolinhas verde, mas as que você está comendo ainda não acabaram...",
            options: [
                ("Seguir o guia", "Seguir o guia"),
                ("Seguir comendo", "Seguir comendo")
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Bolinhas Verde"
        ),
        "Seguir o guia": StoryLine(
            "Boa escolha!\nAproveite as novas bolinhas verde, elas estão divinas!",
            options: [
                ("Comer bastante", "Comer bastante"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Bolinhas Verde"
        ),
        "Seguir comendo": StoryLine(
            "A luz vermelha aparece do atrás de você, tão tentadora e tão próxima. Você não consegue escapar! Sua vida não durou muito...\nAcho que você deveria seguir mais seu guia, a essa altura você já deveria saber que seguí-lo é melhor!",
            options: [
                ("Tentar novamente", "Intro"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "Comer bastante": StoryLine(
            "Aquela sensação estranha voltou e sua visão começa a escurecer. Muito rapidamente você está desacordado.",
            options: [
                ("Acordar de novo", "Acordar parceiro"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Acordar parceiro": StoryLine(
            "Bom dia, você está diferente!?!?! Tem até uma luz vermelha em sua cabeça... Interessante, acho que podemos continuar fazendo o mesmo de cada dia: comer, crescer, fugir...",
            options: [
                ("Nadar por aí", "Nadar por aí"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Estagio 3"
        ),
        "Nadar por aí": StoryLine(
            "Acho que seu guia está diferente. Não consigo mais ver bolinhas, apenas algo muito parecido com você!",
            options: [
                ("Seu foco mudou, vamos atrás desta nova opção", "Novo foco"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "Novo foco": StoryLine(
            "Ainda não achamos nada, mas seu guia está cada vez mais forte.",
            options: [
                ("Continuar nadando", "Continuar nadando"),
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "Continuar nadando": StoryLine(
            "Ahhh, era isso. Você encontrou!\nEm sua frente aparece um parceiro, você sente que deve aproximar-se.",
            options: [
                ("Aproximar-se", "Aproximar-se"),
                ("Ignorar", "Ignorar")
            ],
            backgroundImage: "Fundo Mar",
            imageName: "Dae Parceiro"
        ),
        "Ignorar": StoryLine(
            "Sua existência começa a sumir, o breu se aproxima, a luz começa a acabar e sua vida passa como um filme em seu consciente...",
            options: [
                ("Acordar", "Intro"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Aproximar-se": StoryLine(
            "Você sente a mesma sensação estranha da primeira vez que ficou inconsciente, mas dessa vez ela está misturada com o vazio que você sentiu quando acordou pela primeira vez.",
            options: [
                ("Aceitar", "Aceitar"),
                ("Debater-se", "Não funciona")
            ],
            backgroundImage: "Fundo Mar",
            imageName: nil
        ),
        "Aceitar": StoryLine(
            "Tudo escuro. Muito obrigado, você serviu o seu propósito. Agora só te resta:",
            options: [
                ("Esperar", "Intro"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
        "Não funciona": StoryLine(
            "Você se debate, mas nada ocorre. Qualquer movimento ou ação parece não funcionar. A sensação de vazio aumenta, a escuridão te consome.",
            options: [
                ("Continuar tentando", "Continuar tentando"),
            ],
            backgroundImage: "Escuridao Consome",
            imageName: "Estagio 3"
        ),
        "Continuar tentando": StoryLine(
            "Nada muda... Você já não sente mais nada, esse é seu fim.",
            options: [
                ("Aceitar", "Aceitar"),
            ],
            backgroundImage: "Breu",
            imageName: nil
        ),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let backgroundImageName = story[currentStoryLine]!.backgroundImage {
            view.backgroundColor = UIColor(patternImage: UIImage(named: backgroundImageName)!)
        }
        if let contentImageName = story[currentStoryLine]!.imageName {
            ImageContent.image = UIImage(named: contentImageName)!
        } else {
            ImageContent.image = nil
        }
        
        LabelStory.text = story[currentStoryLine]!.label
        ButtonFirstOption.setTitle(story[currentStoryLine]!.options[0].buttonLabel, for: .normal)
        if let secondButtonOptions = story[currentStoryLine]?.options[1] {
            ButtonSecondOption.setTitle(secondButtonOptions.buttonLabel, for: .normal)
        }
        ButtonThirdOption.isEnabled = false
        ButtonThirdOption.alpha = 0
        RedLight.image = UIImage(named: "Luz Vermelha")!
        RedLight.isHidden = true
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
        ImageContent.fadeTransition(fadeDuration)
        RedLight.fadeTransition(fadeDuration)
        view.fadeTransition(fadeDuration)
        
        if let backgroundImageName = story[currentStoryLine]!.backgroundImage {
            view.backgroundColor = UIColor(patternImage: UIImage(named: backgroundImageName)!)
        }

        if let contentImageName = story[currentStoryLine]!.imageName {
            ImageContent.image = UIImage(named: contentImageName)!
        } else {
            ImageContent.image = nil
        }
        
        print(storyLineLabel)
        if storyLineLabel == "Acordar" {
            RedLight.isHidden = false
        } else {
            RedLight.isHidden = true
        }

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

