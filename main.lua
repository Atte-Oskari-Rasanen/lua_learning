-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- Your code here
-- Functions
 
local Main = {}
local startButtonListeners = {}
local showGameView = {}
local gameListeners = {}
local hitTestObjects = {}
local dragShape = {}
local alert = {}

local bg = display.newImageRect( "background.png", 360, 570 )

--these were earlier contentcenter
bg.x = display.contentHeight
bg.y = display.contentWidth
display.setStatusBar(display.HiddenStatusBar)

--adds listeners to titleview buttons
function startButtonListeners(action)
    if(action == 'add') then
        playBtn:addEventListener('tap', showGameView)
        creditsBtn:addEventListener('tap', showCredits)
    else
        playBtn:removeEventListener('tap', showGameView)
        creditsBtn:removeEventListener('tap', showCredits)
    end
end
function Main()
    titleBg = display.newImage('ims/title.jpg', 17, 35)
    playBtn = display.newImage('ims/play.png', 138, 240)
    titleView = display.newGroup(titleBg, playBtn, creditsBtn)
 
    startButtonListeners('add')
end
function showGameView:tap(e)
    transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') display.remove(titleView) titleView = nil end})
end
    --title view
local titleBg
local playBtn
local creditsBtn
local titleView

-- Instructions
local ins

-- Shapes Placeholder
local sweden
local spain


--countries with animals - draggable shapes
local sweden_cow
local spain_fox

-- Alert
local alertView

-- Sounds
 
local cow = audio.loadSound('sounds/cow.waf')
local fox = audio.loadSound('sounds/pig.waf')
-- Place holders
sweden = display.newImage('ims/sweden.png', 15, 130)
spain = display.newImage('ims/spain.png', 115, 130)
-- Shapes
 
sweden_cow = display.newImage('ims/sweden.png', 240, 386)
spain_fox = display.newImage('ims/spain.png', 32, 386)
     
sweden_cow.name = 'cow'
spain_fox.name = 'fox'



-- game listener function to add listeners to start the game
function gameListeners()
    function gameListeners()
    cow:addEventListener('touch', dragShape)
    fox:addEventListener('touch', dragShape)
    end
end
gameListeners()


-- collision detection function
function hitTestObjects(obj1, obj2)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return (left or right) and (up or down)
end
function alert()
    alertView = display.newImage('ims/cow.png', 95, 270)
    transition.from(alertView, {time = 200, alpha = 0.1})
end

-- main function of the game, handles object dragging by checking its pos and moving it to the event position
function dragShape(e)
    if(e.phase == 'began') then
        lastX = e.x - e.target.x
        lastY = e.y - e.target.y
    elseif(e.phase == 'moved') then
        e.target.x = e.x - lastX
        e.target.y = e.y - lastY
    elseif(e.target.name == 'sweden_cow' and e.phase == 'ended' and hitTestObjects(e.target, sHolder)) then
        e.target.x = 60.5
        e.target.y = 175
        e.target:removeEventListener('touch', dragShape)
        correct = correct + 1
        audio.play(correctSnd)
    elseif(e.target.name == 'spain_fox' and e.phase == 'ended' and hitTestObjects(e.target, pHolder)) then
        e.target.x = 160
        e.target.y = 172
        e.target:removeEventListener('touch', dragShape)
        correct = correct + 1
        audio.play(correctSnd)
        if(e.phase == 'ended' and correct == 2) then
            audio.stop()
            audio.play(winSnd)
            alert()
        end
    end
end

    
Main()
