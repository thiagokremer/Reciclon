local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
    local cenaCreditos = self.view

    -- Carregando o fundo
    local fundo = display.newImageRect( cenaCreditos, "recursos/imagens/fundo3.jpg", x, y )
        fundo.x = x*0.5
        fundo.y = y*0.5
        fundo.alpha = 0.25

    -- Incluindo título da tela
    local highScoreHeader = display.newText( cenaCreditos, "Créditos", x*0.5, y*0.1, fontePrincipal, 160 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    -- Incluindo os créditos na tela
    local highScoreHeader = display.newText( cenaCreditos, "Adriana Salesbrum dos Santos", x*0.5, y*0.2, fontePrincipal, 60 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    local highScoreHeader = display.newText( cenaCreditos, "Jaime Paula Farias Júnior", x*0.5, y*0.25, fontePrincipal, 60 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    local highScoreHeader = display.newText( cenaCreditos, "Kamila Bitencourt", x*0.5, y*0.30, fontePrincipal, 60 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    local highScoreHeader = display.newText( cenaCreditos, "Leonardo Martins Rinaldi", x*0.5, y*0.35, fontePrincipal, 60 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    local highScoreHeader = display.newText( cenaCreditos, "Marcelo Knoth Júnior", x*0.5, y*0.4, fontePrincipal, 60 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    local highScoreHeader = display.newText( cenaCreditos, "Thiago Augusto Kremer dos Santos", x*0.5, y*0.45, fontePrincipal, 50 )
    highScoreHeader:setFillColor( 0.75, 0.78, 1 )

    -- Carregando a imagem do créditos
    local creditos = display.newImageRect( cenaCreditos, "recursos/imagens/creditos.png", x*0.40, y*0.30 )
        creditos.x = x*0.5
        creditos.y = y*0.68
    
    --Função para voltar ao menu
    local function gotoMenu()
        composer.gotoScene( "cenas.menu", { time=800, effect="crossFade" } )
    end

    --Botão para voltar ao menu
    local menuButton = display.newText( cenaCreditos, "Voltar ao menu", x*0.5, y*0.9, fontePrincipal, 50 )
    menuButton:setFillColor( 0.75, 0.78, 1 )
    menuButton:addEventListener( "touch", gotoMenu )

end
scene:addEventListener( "create", scene )
return scene