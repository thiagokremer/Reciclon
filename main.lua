
x = display.contentWidth
y = display.contentHeight  

local composer = require( "composer" )

-- Esconder a barra de status do celular
display.setStatusBar( display.HiddenStatusBar )

-- Iniciando o gerador aleátorio com valores diferentes - não previsíveis
math.randomseed( os.time() )

--Incluindo os audios do projeto
audioMusica = {
        audio.loadStream( "recursos/audios/gameSong3.mp3"),
        audio.loadStream( "recursos/audios/gameSong4.mp3")
}
audioRandomico = audioMusica[math.random(1,2)]

audioTiro = audio.loadSound( "recursos/audios/disparo.mp3" )
audioDie = audio.loadSound( "recursos/audios/colisao.mp3" )
audioColeta = audio.loadSound( "recursos/audios/coletaLixo.mp3"  )

--Incluindo as imagens randomicas
fundoJogo = {
        "recursos/imagens/fundoJogo1.jpg",
        "recursos/imagens/fundoJogo2.jpg",
        "recursos/imagens/fundoJogo3.jpg"
}
fundoJogoRandomico = fundoJogo[math.random(1,3)]

fundo = {
        "recursos/imagens/fundo1.jpg",
        "recursos/imagens/fundo2.jpg"
}
fundoRandomico = fundo[math.random(1,2)]

lixo = {
        "recursos/imagens/lixo1.png",
        "recursos/imagens/lixo2.png",
        "recursos/imagens/lixo3.png"
}
--lixoRandomico = lixo[math.random(1,3)]

--Incluindo uma fonte para o projeto
fontePrincipal = native.newFont("recursos/fonts/War.otf")


-- Ir para o menu
composer.gotoScene( "cenas.menu" )