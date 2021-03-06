sleepytime = 250
waitForCraft = 10000
imagefolder = imagesearch/

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Caret, Screen
CoordMode, Menu, Screen

WinGetPos, winX, winY, winW, winH, ahk_exe WurmLauncher.exe

; Find the crate, then rock locations, need to find a generic blank area in the crate GUI to drop the stone.
ImageSearch, crateLegendX, crateLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%largecrate.png
ImageSearch, crateTLX, crateTLY, crateLegendX-100, crateLegendY-100, crateLegendX+100, crateLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, crateBRX, crateBRY, crateTLX, crateTLY, winX+winW, winY+winH, *TransBlack %imagefolder%inventorycorner.png
if (not crateTLX or not crateBRX)
    MsgBox, Not able to find crate.

; Find the inventory and a good spot for dropping items.
ImageSearch, invLegendX, invLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%inventory.png
ImageSearch, invTLX, invTLY, invLegendX-100, invLegendY-100, invLegendX+100, invLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, invBRX, invBRY, invTLX, invTLY, winX+winW, winY+winH, *TransBlack %imagefolder%inventorycorner.png
if (not invTLX or not invBRX)
    MsgBox, Not able to find inventory.

; Find the crafting window, create button, empty slot, and craft max
ImageSearch, craftLegendX, craftLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%crafting.png
ImageSearch, craftTLX, craftTLY, craftLegendX-100, craftLegendY-100, craftLegendX+100, craftLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, createX, createY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%create.png
ImageSearch, slotX, slotY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%openslot.png
ImageSearch, craftMaxX, craftMaxY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%craftmax.png
if (not craftTLX or not createX)
    MsgBox, Not able to find crafting window or the create button.

if (not slotX)
    MsgBox, Not able to find open slot on crafting window.

if (not craftMaxX)
    MsgBox, Not able to find max craft button.

; Start of the loop
StartBrick:

; Looks for bricks and rocks in the inventory, so we can move them into the crate. This should be done for any other process.
ImageSearch, bricksInvX, bricksInvY, invTLX, invTLY, invBRX, invBRY, *TransBlack %imagefolder%stonebrick.png
if (bricksInvX)
    MouseClickDrag, Left, bricksInvX, bricksInvY, crateBRX-30, crateBRY-30

ImageSearch, rocksInvX, rocksInvY, invTLX, invTLY, invBRX, invBRY, *TransBlack %imagefolder%stoneshards.png
if (rocksInvX)
    MouseClickDrag, Left, rocksInvX, rocksInvY, crateBRX-30, crateBRY-30

; Look for rocks to process in crate.
ImageSearch, rocksCrateX, rocksCrateY, crateTLX, crateTLY, crateBRX, crateBRY, *TransBlack %imagefolder%stoneshards.png
if (not rocksCrateX)
    MsgBox, Out of rocks.

; Drag stone from the crate to inventory
MouseClickDrag, Left, rocksCrateX, rocksCrateY, invBRX-30, invBRY-30
sleep %sleepytime%
Send 10
sleep %sleepytime%
Send {Enter}
sleep %sleepytime%

; Redo the rocks inventory search to get new coords. Find the + near the stone icon, click it.
ImageSearch, rocksInvX, rocksInvY, invTLX, invTLY, invBRX, invBRY, *TransBlack %imagefolder%stoneshards.png
MouseClick, Left, rocksInvX - 10, rocksInvY

; Select the top stone icon
MouseClick, Left, rocksInvX - 10, rocksInvY + 15, 2
sleep %sleepytime%

; Multi select the other 9
Send {LShift down}
MouseClick, Left, rocksInvX - 10, rocksInvY + 165
Send {LShift up}
sleep %sleepytime%

; Combine
MouseClick, Right, rocksInvX - 10, rocksInvY + 165
sleep %sleepytime%
MouseClick, Left, rocksInvX + 10, rocksInvY + 227
sleep %sleepytime%

; Drag to open slot
MouseClickDrag, Left, rocksInvX, rocksInvY, slotX, slotY
sleep %sleepytime%

; Ensure we have stone brick picked
ImageSearch, craftBrickX, craftBrickY, craftX, craftY, winX+winW, winY+winH, *TransBlack %imagefolder%stonebricktext.png
MouseClick, Left, craftBrickX, craftBrickY
sleep %sleepytime%

; Set it to full by clicking the |> icon
MouseClick, Left, craftMaxX, craftMaxY
sleep %sleepytime%

; Start processing
MouseClick, Left, createX, createY
sleep %waitForCraft% ; It will take at least 10 seconds.

; Find stamina
ImageSearch, stamX, stamY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%stamcorner.png

; Wait for stamina to be full
Loop
    ImageSearch, stamFullX, stamFullY, stamX, stamY, stamX+200, stamY+200, *TransBlack %imagefolder%stamfull.png
Until stamFullX
Goto, StartBrick