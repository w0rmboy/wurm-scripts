; Right now this is a very basic script I wrote for finishing my guard tower

sleepytime = 250
waitForCraft = 10000
imagefolder = imagesearch/

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Caret, Screen
CoordMode, Menu, Screen

WinGetPos, winX, winY, winW, winH, ahk_exe WurmLauncher.exe

ImageSearch, cartLegendX, cartLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%largecart.png
ImageSearch, cartTLX, cartTLY, cartLegendX-100, cartLegendY-100, cartLegendX+100, cartLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, cartBRX, cartBRY, cartTLX, cartTLY, winX+winW, winY+winH, *TransBlack %imagefolder%inventorycorner.png
if (not cartTLX or not cartBRX)
    MsgBox, Not able to find cart.

ImageSearch, invLegendX, invLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%inventory.png
ImageSearch, invTLX, invTLY, invLegendX-100, invLegendY-100, invLegendX+100, invLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, invBRX, invBRY, invTLX, invTLY, winX+winW, winY+winH, *TransBlack %imagefolder%inventorycorner.png
if (not invTLX or not invBRX)
    MsgBox, Not able to find inventory.

ImageSearch, craftLegendX, craftLegendY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%crafting.png
ImageSearch, craftTLX, craftTLY, craftLegendX-100, craftLegendY-100, craftLegendX+100, craftLegendY+100, *TransBlack %imagefolder%windowcorner.png
ImageSearch, createX, createY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%continue.png
ImageSearch, slotX, slotY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%openslot.png
ImageSearch, craftMaxX, craftMaxY, craftTLX, craftTLY, winX+winW, winY+winH, *TransBlack %imagefolder%craftmax.png
if (not craftTLX or not createX)
    MsgBox, Not able to find crafting window or the create button.

if (not slotX)
    MsgBox, Not able to find open slot on crafting window.

if (not craftMaxX)
    MsgBox, Not able to find max craft button.

StartBuild:

ImageSearch, bricksCartX, bricksCartY, cartTLX, cartTLY, cartBRX, cartBRY, *TransBlack %imagefolder%stonebrick.png
ImageSearch, planksCartX, planksCartY, cartTLX, cartTLY, cartBRX, cartBRY, *TransBlack %imagefolder%planks.png
ImageSearch, clayCartX, clayCartY, cartTLX, cartTLY, cartBRX, cartBRY, *TransBlack %imagefolder%clay.png
if (bricksCartX) {
    MouseClickDrag, Left, bricksCartX, bricksCartY, invBRX-30, invBRY-30
    toCraft = stonebrick.png
} else if (planksCartX) {
    MouseClickDrag, Left, planksCartX, planksCartY, invBRX-30, invBRY-30
    toCraft = planks.png
} else if (clayCartX) {
    MouseClickDrag, Left, clayCartX, clayCartY, invBRX-30, invBRY-30
    toCraft = clay.png
} else {
    MsgBox, Out of materials.
}
sleep %sleepytime%
Send {Enter}
sleep %sleepytime%

ImageSearch, toCraftX, toCraftY, invTLX, invTLY, invBRX, invBRY, *TransBlack %imagefolder%%toCraft%
MouseClickDrag, Left, toCraftX, toCraftY, slotX, slotY
sleep %sleepytime%

MouseClickDrag, Left, rocksInvX, rocksInvY, slotX, slotY
sleep %sleepytime%

MouseClick, Left, craftMaxX, craftMaxY
sleep %sleepytime%

MouseClick, Left, createX, createY
sleep %waitForCraft%

ImageSearch, stamX, stamY, winX, winY, winX+winW, winY+winH, *TransBlack %imagefolder%stamcorner.png
Loop
    ImageSearch, stamFullX, stamFullY, stamX, stamY, stamX+200, stamY+200, *TransBlack %imagefolder%stamfull.png
Until stamFullX
Goto, StartBuild