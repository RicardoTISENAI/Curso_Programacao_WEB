algoritmo "Game_Missao_Sobrevivencia"
// Disciplina  : Lógica de Programação
// Professor   : Ricardo
// Descrição   : Jogo interativo do enigma dos baldes (5L e 3L).

var
   b5, b3, opcao, tentativas, maxTentativas, espacoLivre: inteiro

inicio
   // 1. Configurações Iniciais do Jogo (Estado Zero)
   b5 <- 0
   b3 <- 0
   tentativas <- 0
   maxTentativas <- 10
   
   escreval("===========================================")
   escreval("       MISSÃO MILITAR: OS 4 LITROS         ")
   escreval("===========================================")
   escreval("O Sargento ordenou: Consiga exatos 4 litros no balde maior!")
   escreval("Você tem ", maxTentativas, " tentativas antes de ser punido.")
   escreval("Pressione ENTER para iniciar a missão...")

   // Pausa dramática antes de começar
   leia(opcao) 
   // 2. O Loop do Jogo (Roda até vencer ou acabar as tentativas)
   enquanto (b5 <> 4) e (tentativas < maxTentativas) faca
      limpatela
      
      escreval("--- STATUS DO ACAMPAMENTO ---")
      escreval("Balde Maior [5L]: ", b5, " litros de água.")
      escreval("Balde Menor [3L]: ", b3, " litros de água.")
      escreval("Tentativas Restantes: ", maxTentativas - tentativas)
      escreval("-----------------------------")
      escreval("")
      
      // 3. O Menu de Ações
      escreval("ESCOLHA SUA AÇÃO:")
      escreval("1 - Encher o balde de 5L no poço")
      escreval("2 - Encher o balde de 3L no poço")
      escreval("3 - Esvaziar o balde de 5L no chão")
      escreval("4 - Esvaziar o balde de 3L no chão")
      escreval("5 - Despejar do balde de 5L para o de 3L")
      escreval("6 - Despejar do balde de 3L para o de 5L")
      escreva("Comando: ")
      leia(opcao)
      
      // 4. Processando a escolha do jogador
      escolha opcao
         caso 1
            b5 <- 5
         caso 2
            b3 <- 3
         caso 3
            b5 <- 0
         caso 4
            b3 <- 0

         // Lógica: Transferir 5L -> 3L   
         caso 5 
            espacoLivre <- 3 - b3 // Quanto cabe no pequeno?
            
            se (b5 >= espacoLivre) entao
               // Se o grande tem água suficiente para encher o pequeno
               b5 <- b5 - espacoLivre
               b3 <- 3
            senao
               // Se o grande tem pouca água, ele vira tudo no pequeno e seca
               b3 <- b3 + b5
               b5 <- 0
            fimse

         // Lógica: Transferir 3L -> 5L  
         caso 6 
            espacoLivre <- 5 - b5 // Quanto cabe no grande?
            
            se (b3 >= espacoLivre) entao
               b3 <- b3 - espacoLivre
               b5 <- 5
            senao
               b5 <- b5 + b3
               b3 <- 0
            fimse
            
         outrocaso
            escreval("Comando inválido, recruta! Você perdeu tempo.")
      fimescolha
      
      // Conta a tentativa após realizar a ação
      tentativas <- tentativas + 1
   fimenquanto
   
   // 5. O Fim do Jogo (Julgamento)
   limpatela
   escreval("===========================================")
   se (b5 = 4) entao
      escreval("VITÓRIA! O Sargento está orgulhoso!")
      escreval("Você resolveu o enigma em ", tentativas, " tentativas.")
   senao
      escreval("GAME OVER! Acabaram suas tentativas.")
      escreval("O Sargento colocou você para limpar as latrinas!")
   fimse
   escreval("Status Final -> Balde Maior: ", b5, "L | Balde Menor: ", b3, "L")
   escreval("===========================================")

fimalgoritmo