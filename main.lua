local physics = require "physics"
physics.start()
physics.setGravity( 0, 100 )

gameStarted = false

skySpeed = .2
backgroundSpeed = 4
groundSpeed = 10
backgroundSize = display.contentWidth

sky1 = display.newImageRect( "sky.png" ,1024, 768)
sky1.anchorX = 0
sky1.anchorY = 0
sky1.speed = skySpeed

sky2 = display.newImageRect( "sky.png" ,1024, 768)
sky2.anchorX = 0
sky2.anchorY = 0
sky2.x = 1024
sky2.speed = skySpeed

background1 = display.newImageRect('bg.png', backgroundSize,424)
background1.anchorX = 0
background1.anchorY = 1
background1.x = 0
background1.y = display.contentHeight - 200
background1.speed = backgroundSpeed

background2 = display.newImageRect('bg.png',backgroundSize ,424)
background2.anchorX = 0
background2.anchorY = 1
background2.x = backgroundSize
background2.y = display.contentHeight - 200
background2.speed = backgroundSpeed

ground1 = display.newImageRect("ground.png", display.contentWidth, 220 )
ground1.anchorX = 0
ground1.anchorY = 1
ground1.x = 0
ground1.y = display.contentHeight
ground1.speed = groundSpeed

ground2 = display.newImageRect("ground.png", display.contentWidth, 220 )
ground2.anchorX = 0
ground2.anchorY = 1
ground2.x = backgroundSize
ground2.y = display.contentHeight
ground2.speed = groundSpeed

  p_options =
  {
    -- Required params
    width = 90,
    height = 80,
    numFrames = 2,
    -- content scaling
    sheetContentWidth = 180,
    sheetContentHeight = 80,
  }

playerSheet = graphics.newImageSheet( "pigeon.png", p_options )
player = display.newSprite( playerSheet, { name="player", start=1, count=2, time=150 } )
player.anchorX = 0.5
player.anchorY = 0.5
player.x = display.contentCenterX - 100
player.y = display.contentCenterY
physics.addBody(player, "static", {density=.1, bounce=0.1, friction=1})
player:play()

instructions = display.newImageRect("instructions.png",400,328)
instructions.anchorX = 0.5
instructions.anchorY = 0.5
instructions.x = display.contentCenterX
instructions.y = display.contentCenterY

function backgroundScroller(self,event)
  if self.x < (-self.width + (self.speed*2))   then
    self.x = self.width
  else
    self.x = self.x - self.speed
  end
end

function flyUp(event)

   if event.phase == "began" then

    if gameStarted == false then
       player.bodyType = "dynamic"
       gameStarted = true
       instructions.alpha = 0
       player:applyForce(0, -600, player.x, player.y)
    else

      player:applyForce(0, -900, player.x, player.y)

      end
  end
end

background1.enterFrame = backgroundScroller
Runtime:addEventListener("enterFrame", background1)

background2.enterFrame = backgroundScroller
Runtime:addEventListener("enterFrame", background2)

ground1.enterFrame = backgroundScroller
Runtime:addEventListener("enterFrame", ground1)

ground2.enterFrame = backgroundScroller
Runtime:addEventListener("enterFrame", ground2)

sky1.enterFrame = backgroundScroller
Runtime:addEventListener("enterFrame", sky1)

sky2.enterFrame = backgroundScroller
Runtime:addEventListener("enterFrame", sky2)

Runtime:addEventListener("touch", flyUp)