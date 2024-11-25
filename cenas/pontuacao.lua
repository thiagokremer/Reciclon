local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
    local cenaPontuacao = self.view

    -- Carregando o fundo
    local fundo = display.newImageRect( cenaPontuacao, "recursos/imagens/fundo3.jpg", x, y )
    fundo.x = x*0.5
    fundo.y = y*0.5
    fundo.alpha = 0.25

    -- Incluindo título da tela
    local highScoreHeader = display.newText( cenaPontuacao, "  Maiores\npontuações", x*0.5, y*0.15, fontePrincipal, 160 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    -- Carregano o json para salvamento dos dados
    local json = require( "json" )
    local scoresTable = {}
    local filePath = system.pathForFile( "pontuacao.json", system.DocumentsDirectory )

    --Função carregar a pontuação do json
    local function loadScores()
        local file = io.open( filePath, "r" )
            if file then
                local contents = file:read( "*a" )
                io.close( file )
                scoresTable = json.decode( contents )
            end

        if ( scoresTable == nil or #scoresTable == 0 ) then
            scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        end
    end
    loadScores()

    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    --Função para ordenar os pontos em ordem alfabética/númerica
    local function ordenar( a, b )
        return a > b
    end
    table.sort( scoresTable, ordenar )

    --Função salvar a pontuação do json
    local function saveScores()
        for i = #scoresTable, 11, -1 do
            table.remove( scoresTable, i )
        end
        local file = io.open( filePath, "w" )
        if file then
            file:write( json.encode( scoresTable ) )
            io.close( file )
        end
    end
    saveScores()

    --Função para ordenar as maiores pontuações e mostrar na tela
    for i = 1, 10 do
        local texto1 = i .. ") " 
        local texto2 = scoresTable[i]
        local distancia = i*80
        local textoRecordes = display.newText( cenaPontuacao, texto1 .. texto2, x*0.5, y*0.25 + 1.5*distancia, fontePrincipal, 100 )
        textoRecordes:setFillColor( 0.75, 0.78, 1 )
    end

    --Função para voltar ao menu
    local function gotoMenu()
        composer.gotoScene( "cenas.menu", { time=800, effect="crossFade" } )
    end

    --Botão para voltar ao menu
    local menuButton = display.newText( cenaPontuacao, "Voltar ao menu", x*0.5, y*0.9, fontePrincipal, 50 )
    menuButton:setFillColor( 0.75, 0.78, 1 )
    menuButton:addEventListener( "touch", gotoMenu )

end
scene:addEventListener( "create", scene )
return scene