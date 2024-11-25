local composer = require("composer")

local scene = composer.newScene()

function scene:create( event )
    local cenaJogo = self.view

    -- Carregando e configurando a física
    local physics = require( "physics" )
    physics.start()
    physics.setGravity( 0, 0 )
    --physics.setDrawMode( "hybrid" )

    -- Criando grupos para separar os itens na tela
    local backGroup = display.newGroup()
    cenaJogo:insert ( backGroup )
    local mainGroup = display.newGroup()
    cenaJogo:insert ( mainGroup )
    local uiGroup = display.newGroup()
    cenaJogo:insert ( uiGroup )

    -- Carregando o fundo
    local fundo = display.newImageRect( backGroup, "recursos/imagens/fundoJogo3.jpg", x, y )
    fundo.x = x*0.5
    fundo.y = y*0.5
    fundo.alpha = 0.75

    -- Configurando as imagens com o spritSheet
    local sheetOptions =
    {
        frames =
        {
            {   --[[ 1 - asteroid 1]] x = 0, y = 0, width = 102, height = 85},
            {   --[[ 2 - asteroid 2]] x = 0, y = 85, width = 90, height = 83},
            {   --[[ 3 - asteroid 3]] x = 0, y = 168, width = 100, height = 97},
            {   --[[ 4 - nave]] x = 0, y = 265, width = 98, height = 79},
            {   --[[ 5 - laser]] x = 98, y = 265, width = 14, height = 40},
        },
    }
    local objectSheet = graphics.newImageSheet( "recursos/imagens/gameObjects.png", sheetOptions )

    -- Criando a nave
    local ship = display.newImageRect( mainGroup, "recursos/imagens/nave.png", x*0.1, y*0.1 )
    ship.x = x*0.5
    ship.y = y*0.9
    physics.addBody( ship, { radius=80, isSensor=true } )
    ship.myName = "ship"

    -- Iniciando as variáveis
    local lives = 5
    local score = 0
    local died = false

    local asteroidsTable = {}
    local lixoTable = {}

    local gameLoopTimer

    -- Mostrar vidas e pontos
    local livesText = display.newText( uiGroup, "Lives: " .. lives, x*0.2, y*0.03, fontePrincipal, 36 )
    local scoreText = display.newText( uiGroup, "Score: " .. score, x*0.8, y*0.03, fontePrincipal, 36 )

    -- Função atualizar vidas e pontos
    local function updateText()
        livesText.text = "Lives: " .. lives
        scoreText.text = "Score: " .. score
    end

    -- função para criar o lixo
    local function createLixo()
        -- Criando os lixos
        local newLixo = display.newImageRect( mainGroup, lixoRandomico,  x*0.1, y*0.04 )
        table.insert( lixoTable, newLixo )
        physics.addBody( newLixo, "dynamic", { radius=40, bounce=0.8 } )
        newLixo.myName = "lixo"
        
        --Local de "nascimento" dos lixo
        local whereFrom = math.random( 3 )
        if ( whereFrom == 1 ) then
            -- Da esquerda
            newLixo.x = -60
            newLixo.y = math.random( 500 )
            newLixo:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
        elseif ( whereFrom == 2 ) then
            -- De cima
            newLixo.x = math.random( x )
            newLixo.y = -60
            newLixo:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
        elseif ( whereFrom == 3 ) then
            -- Da direita
            newLixo.x = x + 60
            newLixo.y = math.random( 500 )
            newLixo:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
        end
        newLixo:applyTorque( math.random( -6,6 ) )
    end

    -- Função para criar os asteroides
    local function createAsteroid()
        local newAsteroid = display.newImageRect( mainGroup, objectSheet, math.random( 3 ), 102, 85 )
        table.insert( asteroidsTable, newAsteroid )
        physics.addBody( newAsteroid, "dynamic", { radius=40, bounce=0.8 } )
        newAsteroid.myName = "asteroid"

        --Local de "nascimento" dos asteroides
        local whereFrom = math.random( 3 )
        if ( whereFrom == 1 ) then
            -- Da esquerda
            newAsteroid.x = -60
            newAsteroid.y = math.random( 500 )
            newAsteroid:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
        elseif ( whereFrom == 2 ) then
            -- De cima
            newAsteroid.x = math.random( x )
            newAsteroid.y = -60
            newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
        elseif ( whereFrom == 3 ) then
            -- Da direita
            newAsteroid.x = x + 60
            newAsteroid.y = math.random( 500 )
            newAsteroid:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
        end
        newAsteroid:applyTorque( math.random( -6,6 ) )
        
    end

    -- Função do tiro de laser
    local function fireLaser(e)
        if e.phase == "ended" then
            audio.play( audioTiro )
            local newLaser = display.newImageRect( mainGroup, objectSheet, 5, 14, 40 )
            physics.addBody( newLaser, "dynamic", { isSensor=true } )
            newLaser.isBullet = true
            newLaser.myName = "laser"
            newLaser.x = ship.x
            newLaser.y = ship.y
            newLaser:toBack()
            transition.to( newLaser, { y=-40, time=500, onComplete = function() display.remove( newLaser ) end } )
        end        
    end
    ship:addEventListener( "touch", fireLaser )

    -- Movimentando a nave
    local function dragShip( event )
        local ship = event.target
        local phase = event.phase
        
        if ( "began" == phase ) then
            display.currentStage:setFocus( ship )
            ship.touchOffsetX = event.x - ship.x
            ship.touchOffsetY = event.y - ship.y
        elseif ( "moved" == phase ) then
            ship.x = event.x - ship.touchOffsetX
            ship.y = event.y - ship.touchOffsetY
        elseif ( "ended" == phase or "cancelled" == phase ) then
            display.currentStage:setFocus( nil )
        end

        return true
    end
    ship:addEventListener( "touch", dragShip )

    --Função loop para criar os lixos
    local function gameLoopLixo()
        lixoRandomico = lixo[math.random(1,3)]
        createLixo()
        for i = #lixoTable, 1, -1 do
            local thisLixo = lixoTable[i]
                if ( thisLixo.x < -100 or
                    thisLixo.x > display.contentWidth + 100 or
                    thisLixo.y < -100 or
                    thisLixo.y > display.contentHeight + 100 )
                then
                    --physics.removeBody(thisLixo)
                    display.remove( thisLixo )
                    table.remove( lixoTable, i )
                end
        end
    end
    gameLoopTimer = timer.performWithDelay( 4500, gameLoopLixo, 0 )

    --Função loop para criar os asteroides
    local function gameLoopAsteroid()
        createAsteroid()
        for i = #asteroidsTable, 1, -1 do
            local thisAsteroid = asteroidsTable[i]
                if ( thisAsteroid.x < -100 or
                    thisAsteroid.x > display.contentWidth + 100 or
                    thisAsteroid.y < -100 or
                    thisAsteroid.y > display.contentHeight + 100 )
                then
                    --physics.removeBody(thisAsteroid)
                    display.remove( thisAsteroid )
                    table.remove( asteroidsTable, i )
                end
        end
    end
    gameLoopTimer = timer.performWithDelay( 1500, gameLoopAsteroid, 0 )

    --Recriando a nave após colisão com asteroid
    local function restoreShip()
        ship.isBodyActive = false
        ship.x = x*0.5
        ship.y = y*0.9

        transition.to( ship, { alpha=1, time=4000,
            onComplete = function()
                ship.isBodyActive = true
                died = false
            end
        } )
    end

    --Função para encerrar o jogo após acabar as vidas
    local function endGame()
        --função para remover todos os corpos físicos, porém não localiza os corpos para exclusão
        --physics.removeAllBodies()
        physics.pause()
        
        -- Limpar tabelas
        asteroidsTable = {}
        lixoTable = {}

        composer.removeScene( "cenas.jogo" )
        composer.setVariable( "finalScore", score )
        composer.gotoScene( "cenas.pontuacao", { time=800, effect="crossFade" } )
    end

    --Função das colisões do lixo
    local function onCollisionLixo( event )
        if ( event.phase == "began" ) then
            
            local obj1 = event.object1
            local obj2 = event.object2
            if ( ( obj1.myName == "laser" and obj2.myName == "lixo" ) or ( obj1.myName == "lixo" and obj2.myName == "laser" ) ) then
                display.remove( obj1 )
                display.remove( obj2 )

                --physics.removeBody(obj1)
                --physics.removeBody(obj2)

                for i = #lixoTable, 1, -1 do
                    if ( lixoTable[i] == obj1 or lixoTable[i] == obj2 ) then
                        table.remove( lixoTable, i )
                        break
                    end
                end

                score = score - 100
                scoreText.text = "Score: " .. score

            elseif ( ( obj1.myName == "ship" and obj2.myName == "lixo" ))  then
                audio.play ( audioColeta )
                display.remove( obj2 )

                for i = #lixoTable, 1, -1 do
                    if ( lixoTable[i] == obj1 or lixoTable[i] == obj2 ) then
                        table.remove( lixoTable, i )
                        break
                    end
                end

                score = score + 200
                scoreText.text = "Score: " .. score
            end
        end
    end
    Runtime:addEventListener( "collision", onCollisionLixo )

    --Função das colisões dos asteroides
    local function onCollision( event )
        if ( event.phase == "began" ) then
            
            local obj1 = event.object1
            local obj2 = event.object2
            if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or ( obj1.myName == "asteroid" and obj2.myName == "laser" ) ) then
                display.remove( obj1 )
                display.remove( obj2 )

                --physics.removeBody(obj1)
                --physics.removeBody(obj2)

                for i = #asteroidsTable, 1, -1 do
                    if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 ) then
                        table.remove( asteroidsTable, i )
                        break
                    end
                end

                score = score + 100
                scoreText.text = "Score: " .. score

            elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or ( obj1.myName == "asteroid" and obj2.myName == "ship" ) ) then
                if ( died == false ) then
                    audio.play( audioDie )
                    died = true
                    lives = lives - 1
                    livesText.text = "Lives: " .. lives

                    if ( lives == 0 ) then
                        display.remove( ship )
                        timer.performWithDelay( 2000, endGame )
                    else
                        ship.alpha = 0
                        timer.performWithDelay( 1000, restoreShip )
                    end
                end
            end
        end
    end
    Runtime:addEventListener( "collision", onCollision )

end

scene:addEventListener("create", scene)
return scene