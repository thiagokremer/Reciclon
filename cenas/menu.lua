local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )
    local cenaMenu = self.view

    -- Incluindo música de fundo no jogo
    audio.play ( audioRandomico, {
        channel = 32,
        loops = -1
        })
        audio.setVolume( 0.5, {channel = 32} )
    
    -- Carregando o fundo
    local fundo = display.newImageRect( cenaMenu, "recursos/imagens/fundo3.jpg", x, y )
        fundo.x = x*0.5
        fundo.y = y*0.5
        fundo.alpha = 0.5

    -- Carregando o título
    local title = display.newImageRect( cenaMenu, "recursos/imagens/banner.png", x*0.9, y*0.6 )
    title.x = x*0.5
    title.y = y*0.18

    -- Carregando botão play
    local playButton = display.newText( cenaMenu, "Jogar", x*0.5, y*0.4, fontePrincipal, 160 )
        playButton:setFillColor( 0.75, 0.78, 1 )

    -- Carregando botão Maiores pontuações
    local highScoresButton = display.newText( cenaMenu, "  Maiores\nPontuações", x*0.5, y*0.55, fontePrincipal, 130 )
        highScoresButton:setFillColor( 0.75, 0.78, 1 )

    -- Carregando botão Créditos
    local creditosButton = display.newText( cenaMenu, "Créditos", x*0.5, y*0.75, fontePrincipal, 130 )
        creditosButton:setFillColor( 0.75, 0.78, 1 )
        
    --Carregando botão Sair
    local textoSair = display.newText(cenaMenu, "Sair", x*0.5, y*0.9, fontePrincipal, 50 )
        textoSair:setFillColor( 0.75, 0.78, 1 )

    -- Função para iniciar o jogo
    local function gotoGame(e)
        if e.phase == "began" then
            composer.gotoScene( "cenas.inicio", { time=800, effect="crossFade" } )  
        end
    end
    playButton:addEventListener( "touch", gotoGame )

    -- Função para ir para os maiores pontos
    local function gotoHighScores(e)
        if e.phase == "began" then
            composer.gotoScene( "cenas.pontuacao", { time=800, effect="crossFade" } )
        end
    end
    highScoresButton:addEventListener( "touch", gotoHighScores )

    -- Função para ir para os créditos
    local function gotoCreditos(e)
        if e.phase == "began" then
            composer.gotoScene( "cenas.creditos", { time=800, effect="crossFade" } )
        end
    end
    creditosButton:addEventListener( "touch", gotoCreditos )

    --Função para fechar o jogo
    function sair(event)
        if event.phase == "began" then
            native.requestExit()
        end
    end
    textoSair:addEventListener("touch", sair)

end
scene:addEventListener("create", scene)
return scene