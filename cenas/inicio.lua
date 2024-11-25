local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
    local cenaInicio = self.view

    -- Carregando o fundo
    local fundo = display.newImageRect( cenaInicio, "recursos/imagens/fundo3.jpg", x, y )
        fundo.x = x*0.5
        fundo.y = y*0.5
        fundo.alpha = 0.5

    -- Carregando o título
    local title = display.newImageRect( cenaInicio, "recursos/imagens/banner.png", x*0.9, y*0.6 )
        title.x = x*0.5
        title.y = y*0.18

    -- Definindos os padrões para o texto da tela    
    local options1 = 
    {
        scene = cenaInicio,
        text = "Com a falta de espaço na Terra nosso lixo foi enviado para o espaço. Este lixo acabou se acumulavam em órbita, criando um perigo crescente. Um dia uma chuva de asteroides atingiu a Terra, trazendo consigo uma avalanche deste lixo espacial. Você foi encarregado de proteger a Terra dessa invasão de lixo. Seu objetivo é destruir os asteroides e coletar o lixo espacial.",     
        x = x*0.5,
        y = y*0.46,
        width = x*0.9,
        font = fontePrincipal,   
        fontSize = 55,
        align = "center"
    }
    local textoInicio = display.newText( options1 )
    textoInicio:setFillColor( 0.75, 0.78, 1 )

    -- Definindos os padrões para o texto da tela
    local options2 = 
    {
        scene = cenaInicio,
        text = "Regras do jogo:\n•	Destrua asteroides: +100 pontos\n•	Destruir lixo: -100 pontos\n•	Coletar lixo espacial: +200 pontos\n•Colidir com asteroides: -1 vida",     
        x = x*0.5,
        y = y*0.72,
        width = x*0.9,
        font = fontePrincipal,   
        fontSize = 45,
        align = "left"
    }
    local textoRegras = display.newText( options2 )
    textoRegras:setFillColor( 0.75, 0.78, 1 )

    --Função para iniciar o jogo
    local function gotoJogo()
        display.remove( textoInicio )
        display.remove( textoRegras )
        composer.gotoScene( "cenas.jogo", { time=800, effect="crossFade" } )
    end

    --Botão para iniciar o jogo
    local menuButton = display.newText( cenaInicio, "JOGAR", x*0.5, y*0.9, fontePrincipal, 100 )
        menuButton:setFillColor( 0.75, 0.78, 1 )
        menuButton:addEventListener( "touch", gotoJogo )

end
scene:addEventListener( "create", scene )
return scene