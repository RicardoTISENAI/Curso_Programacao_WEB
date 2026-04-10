/* ==========================================================
   LÓGICA DO JOGO: A TÁBUA DA SALVAÇÃO
   ========================================================== */

// 1. VARIÁVEIS DE ESTADO (A memória do nosso jogo)
// No VisualG usávamos "var b5: inteiro". Aqui usamos "let"!
let b5 = 0;           // Quantidade atual de água no balde de 5L
let b3 = 0;           // Quantidade atual de água no balde de 3L
let tempo = 60;       // Cronómetro começa com 60 segundos
let timerId = null;   // Variável que vai "segurar" o relógio para podermos pará-lo no fim
let jogoAtivo = true; // Controla se o jogador ainda pode clicar nos botões

// ==========================================================
// 2. LIGAÇÃO COM O HTML (O DOM)
// Para o JavaScript mudar o HTML, primeiro tem de encontrar os elementos usando o ID.
// ==========================================================
const agua5 = document.getElementById('agua5');
const agua3 = document.getElementById('agua3');
const textoB5 = document.getElementById('textoB5');
const textoB3 = document.getElementById('textoB3');
const displayTempo = document.getElementById('timerDisplay');
const telaFim = document.getElementById('telaFim');
const tituloFim = document.getElementById('tituloFim');
const textoFim = document.getElementById('textoFim');

// ==========================================================
// 3. FUNÇÃO PARA ATUALIZAR A TELA (O nosso Renderizador)
// Sempre que a água mudar, esta função calcula o visual.
// ==========================================================
function atualizarVisual() {
    // Matemática Básica: Regra de 3 simples para achar a percentagem.
    // Se o balde de 5L tem 2L de água -> (2 / 5) * 100 = 40% de altura.
    let perc5 = (b5 / 5) * 100;
    let perc3 = (b3 / 3) * 100;

    // Atualiza a altura das DIVs lá no HTML. O CSS trata de fazer a animação!
    agua5.style.height = perc5 + "%";
    agua3.style.height = perc3 + "%";

    // Atualiza os números (textos) que aparecem debaixo dos baldes
    textoB5.innerText = b5;
    textoB3.innerText = b3;

    // A CONDIÇÃO DE VITÓRIA (O nosso Game Loop!)
    // Se o Balde Maior tem 4L e o jogo ainda está a rodar, o jogador venceu!
    if (b5 === 4 && jogoAtivo === true) {
        finalizarJogo(true); // Chama a função de fim enviando "Verdadeiro" (Venceu)
    }
}

// ==========================================================
// 4. O CRONÓMETRO (O Relógio do Jogo)
// ==========================================================
function iniciarRelogio() {
    jogoAtivo = true;
    
    // O setInterval é um laço (loop) que espera um tempo antes de repetir.
    // Neste caso, repete tudo o que está aqui dentro a cada 1000 milissegundos (1 segundo).
    timerId = setInterval(function() {
        tempo = tempo - 1; // Subtrai 1 segundo do tempo
        displayTempo.innerText = "Tempo: " + tempo + "s"; // Mostra na tela

        // Evento Aleatório: O Vento! 
        // Math.random() gera um número entre 0 e 1. Se for menor que 0.10, significa 10% de chance.
        if (Math.random() < 0.10 && tempo > 5) {
            alert("⚠️ CUIDADO! Um vento forte balançou a tábua! Perdeu 3 segundos!");
            tempo = tempo - 3;
            displayTempo.innerText = "Tempo: " + tempo + "s"; // Atualiza o relógio na tela instantaneamente
        }

        // Condição de Derrota: Se o tempo chegar a zero
        if (tempo <= 0) {
            finalizarJogo(false); // Chama a função de fim enviando "Falso" (Perdeu)
        }
    }, 1000);
}

// ==========================================================
// 5. AÇÕES DOS BOTÕES (A Máquina de Estados)
// Usamos "addEventListener" para avisar o JS: "Quando clicarem aqui, faz isto!"
// ==========================================================

// Botão 1: Encher o Balde de 5L
document.getElementById('btnEncher5').addEventListener('click', function() {
    if (jogoAtivo === false) return; // Se o jogo acabou, não faz nada
    b5 = 5;            // O balde fica cheio!
    atualizarVisual(); // Atualiza a tela
});

// Botão 2: Encher o Balde de 3L
document.getElementById('btnEncher3').addEventListener('click', function() {
    if (jogoAtivo === false) return;
    b3 = 3;
    atualizarVisual();
});

// Botão 3: Esvaziar 5L
document.getElementById('btnEsvaziar5').addEventListener('click', function() {
    if (jogoAtivo === false) return;
    b5 = 0;            // O balde perde a água toda
    atualizarVisual();
});

// Botão 4: Esvaziar 3L
document.getElementById('btnEsvaziar3').addEventListener('click', function() {
    if (jogoAtivo === false) return;
    b3 = 0;
    atualizarVisual();
});

// Botão 5: Transferir 5L para 3L (A Lógica Mais Complexa!)
document.getElementById('btnTransf5_3').addEventListener('click', function() {
    if (jogoAtivo === false) return;
    
    // Passo 1: Quanto espaço livre o balde pequeno tem?
    let espacoLivre = 3 - b3;
    
    // Passo 2: O balde grande tem água suficiente para encher esse espaço?
    if (b5 >= espacoLivre) {
        b5 = b5 - espacoLivre; // O grande perde a água que transferiu
        b3 = 3;                // O pequeno fica cheio
    } else {
        b3 = b3 + b5;          // O pequeno recebe tudo o que o grande tinha
        b5 = 0;                // O grande fica vazio
    }
    atualizarVisual();
});

// Botão 6: Transferir 3L para 5L
document.getElementById('btnTransf3_5').addEventListener('click', function() {
    if (jogoAtivo === false) return;
    
    let espacoLivre = 5 - b5;
    
    if (b3 >= espacoLivre) {
        b3 = b3 - espacoLivre;
        b5 = 5;
    } else {
        b5 = b5 + b3;
        b3 = 0;
    }
    atualizarVisual();
});

// ==========================================================
// 6. FIM DE JOGO E REINÍCIO
// ==========================================================
function finalizarJogo(venceu) {
    jogoAtivo = false;       // Trava os botões
    clearInterval(timerId);  // Pára o relógio (cancela o setInterval)

    telaFim.style.display = 'flex'; // Mostra a tela escura de fim de jogo

    if (venceu === true) {
        tituloFim.innerText = "🏆 VITÓRIA ÉPICA! 🏆";
        tituloFim.style.color = "#00ff00"; // Verde
        textoFim.innerText = "Conseguiste isolar os 4 Litros com " + tempo + " segundos de sobra!";
    } else {
        tituloFim.innerText = "💀 GAME OVER 💀";
        tituloFim.style.color = "#ff0000"; // Vermelho
        textoFim.innerText = "O tempo acabou e a corda queimou...";
    }
}

// Botão de Jogar Novamente
document.getElementById('btnReiniciar').addEventListener('click', function() {
    // 1. Zera todas as variáveis
    b5 = 0;
    b3 = 0;
    tempo = 60;
    displayTempo.innerText = "Tempo: 60s";
    
    // 2. Esconde a tela de fim
    telaFim.style.display = 'none';
    
    // 3. Atualiza a tela para os baldes voltarem a ficar vazios
    atualizarVisual();
    
    // 4. Inicia o relógio outra vez
    iniciarRelogio();
});

// ==========================================================
// START! (O que acontece quando o site é aberto pela primeira vez)
// ==========================================================
atualizarVisual(); // Ajusta os baldes para o zero
iniciarRelogio();  // Começa a contar os 60 segundos