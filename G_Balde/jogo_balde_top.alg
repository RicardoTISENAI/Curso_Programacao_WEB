algoritmo "Game_A_Tabua_da_Salvacao_PRO"
// Disciplina  : Lógica de Programação
// Professor   : Ricardo
// Descrição   : Uso de Procedimentos, UI Dinâmica, Timer e Aleatoriedade.

var
   b5, b3, opcao, espacoLivre: inteiro
   tempoSimulado, eventoAleatorio: inteiro
   timer : inteiro

// =========================================================================
// MÓDULO DE INTERFACE (Procedimento para desenhar os baldes na tela)
// Isso mostra aos alunos o poder da "Modularização" (Não repetir código)
// =========================================================================
procedimento RenderizarCenario(val5, val3, tempo: inteiro)
var 
   i: inteiro
inicio

  
   limpatela
   escreval("==========================================================")
   escreval(" 🔥 A TÁBUA DA SALVAÇÃO - TEMPO RESTANTE: ", tempo, "s 🔥")
   escreval("==========================================================")
   escreval("")
   escreval("       [BALDE 5L]      [BALDE 3L]")
   
   // Laço de repetição reverso para desenhar de cima para baixo
   para i de 5 ate 1 passo -1 faca
      escreva("         ")
      
      // Lógica de renderização do Balde de 5L
      se (val5 >= i) entao
         escreva("|~~~~~|") // Representa a água
      senao
         escreva("|     |") // Representa vazio
      fimse
      
      escreva("         ")
      
      // Lógica de renderização do Balde de 3L (só desenha as 3 últimas linhas)
      se (i <= 3) entao
         se (val3 >= i) entao
            escreva("|~~~~~|")
         senao
            escreva("|     |")
         fimse
      fimse
      
      escreval("") // Pula linha do desenho
   fimpara
   escreval("         +-----+         +-----+") // Fundo dos baldes
   escreval("")
   escreval("----------------------------------------------------------")
fimprocedimento
// =========================================================================

inicio
   // Inicialização de Variáveis Globais
   b5 <- 0
   b3 <- 0
   tempoSimulado <- 12
   
   // --- EFEITO CINEMÁTICO DE INTRODUÇÃO ---
   limpatela
   // Atrasa a execução em 100 milissegundos por linha (Efeito Digitação)
   timer 100
   escreval("===============================================================")
   escreval("                MISSÃO: VIDA OU MORTE                          ")
   escreval("===============================================================")
   escreval("Seu amigo está pendurado. A tábua balança sobre o fogo.")
   escreval("Você precisa de EXATAMENTE 4 LITROS no balde maior para")
   escreval("equilibrar o peso. Se falhar, o fogo consumirá a corda.")
   escreval("")
   escreval("ATENÇÃO: Cada segundo conta! Escolha com sabedoria.")
   escreval("===============================================================")  
   escreval("SISTEMA INICIADO...")
   escreval("Sincronizando sensores de peso...")
   escreval("ALERTA: Anomalia térmica detectada. Fogo se aproximando.")
   escreval("OBJETIVO: Isole exatamente 4 Litros no Balde Maior.")
   escreval("")
   timer 0 // Desliga o efeito para o jogo rodar rápido
   escreva("Pressione ENTER para pular na tábua...")
   leia(opcao)

   // --- GAME LOOP PRINCIPAL ---
   enquanto (b5 <> 4) e (tempoSimulado > 0) faca
      
      // Chama o procedimento para renderizar o gráfico passando os valores atuais
      RenderizarCenario(b5, b3, tempoSimulado)
      
      // Evento Aleatório (RNG) - 20% de chance de acontecer
      eventoAleatorio <- Randi(10) + 1
      se (eventoAleatorio > 8) entao
         escreval("⚠️ CUIDADO! Um vento forte balançou a tábua!")
         escreval("Você perdeu 1 segundo tentando se equilibrar!")
         tempoSimulado <- tempoSimulado - 1
         escreval("----------------------------------------------------------")
      fimse
      
      escreval("1 - Encher 5L       |  4 - Esvaziar 3L")
      escreval("2 - Encher 3L       |  5 - Transferir 5L -> 3L")
      escreval("3 - Esvaziar 5L     |  6 - Transferir 3L -> 5L")
      escreva("Ação Rápida (1-6): ")
      leia(opcao)

      // Máquina de Estados
      escolha opcao
         caso 1
            b5 <- 5
            tempoSimulado <- tempoSimulado - 1
         caso 2
            b3 <- 3
            tempoSimulado <- tempoSimulado - 1
         caso 3
            b5 <- 0
            tempoSimulado <- tempoSimulado - 1
         caso 4
            b3 <- 0
            tempoSimulado <- tempoSimulado - 1
         caso 5
            espacoLivre <- 3 - b3
            se (b5 >= espacoLivre) entao
               b5 <- b5 - espacoLivre
               b3 <- 3
            senao
               b3 <- b3 + b5
               b5 <- 0
            fimse
            tempoSimulado <- tempoSimulado - 1
         caso 6
            espacoLivre <- 5 - b5
            se (b3 >= espacoLivre) entao
               b3 <- b3 - espacoLivre
               b5 <- 5
            senao
               b5 <- b5 + b3
               b3 <- 0
            fimse
            tempoSimulado <- tempoSimulado - 1
         outrocaso
            escreval("Ação inválida! O pânico consumiu seu tempo!")
            tempoSimulado <- tempoSimulado - 1
      fimescolha
   fimenquanto

   // --- TELA FINAL ---
   RenderizarCenario(b5, b3, tempoSimulado) // Renderiza a última cena
   
   escreval("==========================================================")
   se (b5 = 4) entao
      escreval("🏆 VITÓRIA ÉPICA! 🏆")
      escreval("Você isolou os 4 Litros e salvou seu amigo do fogo!")
   senao
      escreval("💀 GAME OVER! 💀")
      escreval("O tempo acabou, a tábua cedeu e seu amigo caiu no poço...")
   fimse
   escreval("==========================================================")

fimalgoritmo