// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

struct Sonho: Codable {
    var descricao: String
    var sons: String
    var sentimentos: String
    var comportamental: String
    var apos: String
    var tipo: String
}
// sonhos que criamos só como exemplo
let sonho1: Sonho = Sonho(descricao: "Sonhei que estava na casa da minha avó na infância, brincando com os brinquedos antigos",
                          sons: "Risos das crianças, panelas batendo na cozinha",
                          sentimentos: "Nostalgia, alegria",
                          comportamental: "Correndo pelo jardim, sentindo a grama nos pés",
                          apos: "Ao acordar, senti uma forte vontade de visitar a casa da minha avó novamente",
                          tipo: "recorrente")

let sonho2: Sonho = Sonho(descricao: "Sonhei que estava em um parque de diversões vazio à noite",
                          sons: "Barulho distante de carrossel, vento nas árvores",
                          sentimentos: "Inquietação, mistério",
                          comportamental: "Andando pelos corredores desertos, procurando por algo",
                          apos: "Acordei com uma sensação estranha de desamparo",
                          tipo: "recorrente")

let sonho3: Sonho = Sonho(descricao: "Sonhei que estava voando sobre as nuvens, como se fosse um pássaro",
                          sons: "Vento forte, asas batendo",
                          sentimentos: "Liberdade, êxtase",
                          comportamental: "Explorando o céu, olhando para baixo e vendo paisagens incríveis",
                          apos: "Me senti revigorado e cheio de energia ao acordar",
                          tipo: "recorrente")

let sonho4: Sonho = Sonho(descricao: "Sonhei que estava em uma floresta mágica, cheia de criaturas fantásticas",
                          sons: "Canto de pássaros desconhecidos, riachos borbulhantes",
                          sentimentos: "Maravilha, curiosidade",
                          comportamental: "Caminhando por entre as árvores gigantes, interagindo com seres mágicos",
                          apos: "Ao acordar, desejei poder voltar àquela floresta",
                          tipo: "infancia")

let sonho5: Sonho = Sonho(descricao: "Sonhei que estava em uma cidade flutuante no céu, onde as leis da física não se aplicavam",
                          sons: "Silêncio absoluto, exceto pelo som dos motores das casas voadoras",
                          sentimentos: "Incrédulo, fascinado",
                          comportamental: "Explorando prédios que pairavam no ar, sem gravidade",
                          apos: "Acordei com a mente cheia de ideias malucas sobre ficção científica",
                          tipo: "surrealista"
)

//help
@main
struct DreamDiary: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Personal Dream Diary",
        usage: """
     dreamlog <dream_type> [OPTIONS]
     """,
        discussion: """
     
     ﾟ･★       .•°˜”°•.¸
           •°˜”°      .•°˜★°•.¸    ¸.•°*”¸.•´¸.•★¨ ¸.•★¨★
         /                      \
        |                     ¸.•           ★
        °.¸¸•.¸¸☆★･ﾟ•.¸¸☆★･ﾟ★･ﾟ          ☆        ☆      ·★_★·°¯°·★·°·★·°°★
                                 ★       ﾟ･★   ☆    ★
                  
     ★`★.¸.★´ ★                         .•°˜”°•.¸
     ¸.•´¸.•★¨  ¸.•★¨ ★ zzz       .•°˜”°         .•°˜”°•.¸
      ¸.•´  ¸.•´ .•´ ¸¸.•¨¯`•.   /                      ~ -.       ☆     zzzz★•.｡
                  zzz           |                           |        ﾟ･★zzz
         ☆ zzz     ★  ﾟ･★        °.¸¸•.¸¸☆★･ﾟ•.¸¸☆★･ﾟ•.¸¸☆★･ﾟ       zzzﾟ･★:.｡★:   ★
             ★         ★
                    ☆            ☆                           ★
     ☆

     Welcome to the Dream Diary!
     This tool was developed with the intention of facilitating individuals
     self-writing process regarding their dreams, being able to address behavioral,
     visceral, and reflective questions of each one. The diary guides the dreamer
     through the process, facilitating the logging by allowing you to add, list,
     filter, and delete dreams.
     """,
        subcommands: [Add.self, List.self])
}
//subcommand add
struct Add: ParsableCommand {
    
    @Argument(help: "Type of dream to be recorded, eg. nightmare, recurring, surrealistic, childhood.")
    var dreamType: String
    
    func validarTipoDeSonho(_ tipo: String) -> Bool {
        let tiposValidos = ["recorrente", "surrealista", "infancia", "pesadelo"]
        return tiposValidos.contains(tipo)
        
        //.folding(options: .diacriticInsensitive, locale: .current).lowercased()
    }
    
    func run() throws {
        
        Persistence.projectName = "Dream Diary"
        
        Persistence.saveIfEmpty(model: [Sonho](), filename: "sonhos.json")
        
        //        // Criar sonhos vazios
        //        let sonhos: [Sonho] = []
        //
        //        try Persistence.saveJson(sonhos, file: "sonhos.json")
        
        var diarioDeSonhos: [Sonho] = try Persistence.readJson(file: "sonhos.json")
        
        //      print("sonhos salvos = \(diarioDeSonhos.count)")
        
  //perguntas de ínteracao
        print ("Descreva o sonho!")
        let descricao: String = readLine() ?? ""
        
        print ("Descreva os sons do seu sonho!")
        let sons: String = readLine() ?? ""
        
        print ("Você consegue traduzir as sensações/sentimentos sentidos pelo seu sonho?")
        let sentimentos: String = readLine() ?? ""
        
        print ("Existiu algo no seu dia que você consiga relacionar com seu sonho?")
        let comportamental: String = readLine() ?? ""
        
        print ("Como você se sente agora depois de registrar esse seu sonho?")
        let apos: String = readLine() ?? ""
        
        let novoSonho = Sonho(descricao: descricao, sons: sons, sentimentos: sentimentos, comportamental: comportamental, apos: apos, tipo: dreamType)
        
        diarioDeSonhos.append(novoSonho)
        
        try Persistence.saveJson(diarioDeSonhos, file: "sonhos.json")
        //        print("sonhos salvos = \(diarioDeSonhos.count)")
    }
}
// subcommand list
// swift run dreamdiary list --type infancia --max 10
struct List: ParsableCommand {
    
    @Option(name: .shortAndLong, help: "Tipo de sonho.")
    var type: String
    
    @Option(name: .shortAndLong, help: "Quantidade de sonhos a ser exibida.")
    var max: Int = 10
    
    @Flag(help: "Procurando seus sonhos... Criando sua lista personalizada...")
       var verbose = false
       

//aqui dentro vai a logica de listar o sonho
    func run() throws {
        
        Persistence.saveIfEmpty(model: [Sonho](), filename: "sonhos.json")
        
        func verbosePrint(_ text: String) {
            if verbose == true {
                print(text)
                sleep(1)
            }
        }
        // checar se o tipo é valido, se nao, imprimir uma mensagem de erro
        
        // carregar a lista de sonhos
        
        // busca na lista de sonhos pelo tipo e limitado a quantidade maxima
        
        Persistence.projectName = "Dream Diary"
        var diarioDeSonhos: [Sonho] = try Persistence.readJson(file: "sonhos.json")
            
        verbosePrint("Resgatando sonhos do seu Dream Diary...")
        var sonhosASerListados: [Sonho] = []
            
            for s in diarioDeSonhos {
                if s.tipo == type {
                    sonhosASerListados.append(s)
                }
                else {
                    continue
                }
            }
        
        verbosePrint("Coletando sonhos a partir da sua pesquisa...")
            while true {
                    let quantidadeSonhos = Array(sonhosASerListados.suffix(max))
                    
                    if quantidadeSonhos.isEmpty {
                        print("Nenhum sonho do tipo '\(type)' encontrado.")
                    } else {
                        if quantidadeSonhos.count < max {
                            print("A quantidade de sonhos encontrados é menor do que \(max), então aqui estão todos:")
                        }
                        print(quantidadeSonhos)
                    }
                    break
                }
            }
    }

