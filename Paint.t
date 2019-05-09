% Nicholas Glenn
% June 8, 2018
% Mr. Rosen
% This program (named after Alan Turing) is a paint program with a variety of tools to create your own masterpieces.

% Imports
import GUI

% Declaration Section
var mainWin := Window.Open ("position:400;200,graphics:640;400")
var paintColour : int := 40
var mMenuButton : int := 0
var drawTool : string := "pencil"
var shapeFill : boolean := true

process music
    Music.PlayFileLoop ("ambientmusic.mp3")
end music

procedure title
    cls
    put "" : 36, "AT Paint"
    put ""
end title

procedure colourPick (pickedColour : int)
    if paintColour not= pickedColour then % If picked colour is different from active colour
	paintColour := pickedColour
	locate (6, 1)
	if paintColour = 40 then
	    put "Paint colour changed to red"
	elsif paintColour = 44 then
	    put "Paint colour changed to yellow"
	elsif paintColour = 33 then
	    put "Paint colour changed to blue"
	else
	    put "Paint colour changed to black"
	end if
    end if
end colourPick

procedure drawPick (pickedDraw : string)
    if drawTool not= pickedDraw then % If picked draw tool is different from active draw tool
	drawTool := pickedDraw
	locate (6, 1)
	put "Draw tool changed to ", drawTool
    end if
end drawPick

procedure fillPick (pickedFill : boolean)
    if shapeFill not= pickedFill then % If picked fill is different from active fill
	shapeFill := pickedFill
	locate (6, 1)
	put "Shape fill changed to ", shapeFill
    end if
end fillPick

procedure clearPaint
    for x : 0 .. 639
	drawline (0 + x, 0, 0 + x, 300, white)
    end for
    locate (6, 1)
    put "Paint canvas cleared"
end clearPaint

procedure goodbye
    title
    locate (5, 1)
    put "" : 20, "Thanks for using this program, come again!"
    locate (24, 1)
    put "Programmed by: Nicholas Glenn"
    delay (2000)
    Window.Close (mainWin)
end goodbye

forward procedure mainMenu

procedure paint
    var rangeX, rangeY, oldRangeX, oldRangeY, shapeX, shapeY, button : int := -1
    var finished : boolean := false
    fork music
    title
    % Mouse button headers
    locate (5, 6)
    put "Freehand"
    locate (5, 19)
    put "Shapes"
    locate (5, 30)
    put "Shape Fill"
    locate (5, 50)
    put "Colours"
    locate (5, 70)
    put "Other"
    for x : 0 .. 20     % Draws mouse buttons
	drawline (42, 365 + x, 102, 365 + x, 27)     % Pencil
	drawline (42, 333 + x, 102, 333 + x, 27)     % Eraser
	drawoval (169, 375, 30 - x, 10 - x, 27)     % Oval
	drawoval (170, 375, 30 - x, 10 - x, 27)     % Oval
	drawline (136, 333 + x, 207, 333 + x, 27)     % Rectangle
	drawline (242, 365 + x, 302, 365 + x, 27)     % Fill
	drawline (342, 365 + x, 402, 365 + x, 40)     % Red
	drawline (342, 333 + x, 402, 333 + x, 44)     % Yellow
	drawline (442, 365 + x, 502, 365 + x, 33)     % Blue
	drawline (442, 333 + x, 502, 333 + x, 16)     % Black
	drawline (542, 365 + x, 602, 365 + x, 27)     % Clear
	drawline (536, 333 + x, 608, 333 + x, 27)     % Main Menu
    end for
    drawbox (135, 333, 208, 353, 16)     % Border around rectangle mouse button
    drawbox (242, 333, 302, 353, 27)     % Unfill mouse button
    % Mouse button labels
    colourback (27) % Colour back grey
    locate (2, 7)
    put "Pencil" ..
    locate (4, 7)
    put "Eraser" ..
    locate (2, 20)
    put "Oval" ..
    locate (4, 18)
    put "Rectangle" ..
    locate (2, 33)
    put "Fill" ..
    colourback (31) % Colour back white
    locate (4, 32)
    put "Unfill" ..
    colourback (40) % Colour back red
    locate (2, 46)
    put "Red" ..
    colourback (44) % Colour back yellow
    locate (4, 44)
    put "Yellow" ..
    colourback (33) % Colour back blue
    locate (2, 58)
    put "Blue" ..
    Text.Colour (31) % Makes text white
    colourback (16) % Colour back black
    locate (4, 57)
    put "Black" ..
    Text.Colour (16) % Makes text black (back to default)
    colourback (27) % Colour back grey
    locate (2, 70)
    put "Clear" ..
    locate (4, 68)
    put "Main Menu" ..
    colourback (31) % Colour back white
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then % If mouse button is held down
	    if (rangeX >= 42 and rangeX <= 102) and (rangeY >= 365 and rangeY <= 385) then % If pointer clicked 'Pencil'
		drawPick ("pencil")
	    elsif (rangeX >= 42 and rangeX <= 102) and (rangeY >= 333 and rangeY <= 353) then % If pointer clicked 'Eraser'
		drawPick ("eraser")
	    elsif (rangeX >= 142 and rangeX <= 202) and (rangeY >= 365 and rangeY <= 385) then % If pointer clicked 'Oval'
		drawPick ("oval")
	    elsif (rangeX >= 136 and rangeX <= 208) and (rangeY >= 333 and rangeY <= 353) then % If pointer clicked 'Rectangle'
		drawPick ("rect")
	    elsif (rangeX >= 242 and rangeX <= 302) and (rangeY >= 365 and rangeY <= 385) then % If pointer clicked 'Fill'
		fillPick (true)
	    elsif (rangeX >= 242 and rangeX <= 302) and (rangeY >= 333 and rangeY <= 353) then % If pointer clicked 'Unfill'
		fillPick (false)
	    elsif (rangeX >= 342 and rangeX <= 402) and (rangeY >= 365 and rangeY <= 385) then % If pointer clicked 'Red'
		colourPick (40)
	    elsif (rangeX >= 342 and rangeX <= 402) and (rangeY >= 333 and rangeY <= 353) then % If pointer clicked 'Yellow'
		colourPick (44)
	    elsif (rangeX >= 442 and rangeX <= 502) and (rangeY >= 365 and rangeY <= 385) then % If pointer clicked 'Blue'
		colourPick (33)
	    elsif (rangeX >= 442 and rangeX <= 502) and (rangeY >= 333 and rangeY <= 353) then % If pointer clicked 'Black'
		colourPick (16)
	    elsif (rangeX >= 542 and rangeX <= 602) and (rangeY >= 365 and rangeY <= 385) then % If pointer clicked 'Clear'
		clearPaint
	    elsif (rangeX >= 536 and rangeX <= 608) and (rangeY >= 333 and rangeY <= 353) then % If pointer clicked the exit prompt
		finished := true
	    elsif rangeY <= 300 then % If pointer is on canvas
		if drawTool = "pencil" then % If picked tool is the pencil
		    if oldRangeX not= -1 then % If another point to draw the line exists
			drawline (oldRangeX, oldRangeY, rangeX, rangeY, paintColour)
		    end if
		elsif drawTool = "eraser" then % If picked tool is the eraser
		    if oldRangeX not= -1 then % If another point to draw the line exists
			drawline (oldRangeX, oldRangeY, rangeX, rangeY, 31)
		    end if
		else
		    if shapeX = -1 then % If another point to draw a shape doesn't exist
			shapeX := rangeX
			shapeY := rangeY
		    end if
		end if
		oldRangeX := rangeX % Stores old x position of cursor for next loop
		oldRangeY := rangeY % Stores old y position of cursor for next loop
	    end if
	else
	    if shapeX not= -1 then % If user has been holding the mouse button down
		if rangeY > 300 then % If user let go of the mouse above the canvas
		    rangeY := 300 % Forces shape to be drawn within canvas
		end if
		if drawTool = "oval" then % If picked tool is the oval
		    if shapeFill then % If fill is chosen
			drawfilloval (min (rangeX, shapeX) + (abs (rangeX - shapeX)) div 2, min (rangeY, shapeY) + (abs (rangeY - shapeY)) div 2, (abs (rangeX - shapeX)) div 2, (abs (rangeY -
			    shapeY)) div 2, paintColour) % Continued (too long to fit in one line)
		    else % If unfill is chosen
			drawoval (min (rangeX, shapeX) + (abs (rangeX - shapeX)) div 2, min (rangeY, shapeY) + (abs (rangeY - shapeY)) div 2, (abs (rangeX - shapeX)) div 2, (abs (rangeY -
			    shapeY)) div 2, paintColour) % Continued (too long to fit in one line)
		    end if
		else % If picked tool is the rectangle
		    if shapeFill then % If fill is chosen
			drawfillbox (shapeX, shapeY, rangeX, rangeY, paintColour)
		    else % If unfill is chosen
			drawbox (shapeX, shapeY, rangeX, rangeY, paintColour)
		    end if
		end if
	    end if
	    oldRangeX := -1 % Resets stored coordinates when mouse button is released
	    oldRangeY := -1
	    shapeX := -1
	    shapeY := -1
	end if
	exit when finished
    end loop
    Music.PlayFileStop
    mainMenu
end paint

procedure instructions
    title
    GUI.Show (mMenuButton)
    put "This paint program has four different tools, the pencil, eraser, oval, and"
    put "rectangle. All of these tools can be used by clicking and dragging on the screen"
    put ". The shapes can be filled and unfilled, colours can be switched, and the whole"
    put "screen can be cleared."
end instructions

body procedure mainMenu
    title
    GUI.Hide (mMenuButton)
    var newButton := GUI.CreateButton (274, 240, 0, "Start Paint", paint)
    var instructionButton := GUI.CreateButton (270, 150, 0, "Instructions", instructions)
    var exitButton := GUI.CreateButton (290, 60, 0, "Exit", GUI.Quit)
end mainMenu

procedure intro
    title
    for x : 0 .. 810 % Intro Animation
	drawfillbox (-122 + x, 20, 209 + x, 300, white) % Erase
	drawfillarc (-122 + x, 60, 50, 40, 210, 270, (x mod 33) div 2 + 32) % Paint Trail
	drawfillarc (-121 + x, 60, 50, 40, 210, 30, yellow) % Brush Hair
	drawfillarc (-1 + x, 300, 210, 270, 240, 250, brown) % Brush Handle
	drawfillarc (-1 + x, 300, 21, 27, 240, 252, white) % Handle Erase
	delay (12)
    end for
    put "This program (named after Alan Turing) is a paint program with a variety of"
    put "tools to create your own masterpieces."
    mMenuButton := GUI.CreateButton (272, 200, 0, "Main Menu", mainMenu)
end intro

% Main Program
intro
loop
    exit when GUI.ProcessEvent
end loop
goodbye
% End of Program

