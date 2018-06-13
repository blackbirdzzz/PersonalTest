-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MENU COFFRE-------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
local fourrx
local fourry
local fourrz 

local vehicules_fourriere = {}

local options = {
    x = 0.1,
    y = 0.2,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = Job_Name,
    menu_subtitle = "Gestion",
    color_r = 30,
    color_g = 144,
    color_b = 255
}
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------

function Main(x,y,z)
    fourrx = x
    fourry = y
    fourrz = z
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
	ClearMenu()
    options.menu_title = "Fourrière"
    options.menu_subtitle = "Gestion"
	Menu.selection = 1
    Menu.addButton("Rentrer le véhicule dans la fourrière", "PutInFourriere", nil)
	Menu.addButton("Sortir un véhicule de la fourrière", "InitOutFourriere", nil)
end


RegisterNetEvent("fourriere:getOutFourriere") 
AddEventHandler("fourriere:getOutFourriere",function(liste)
    if(liste) then
        ClearMenu()
        options.menu_title = "Fourrière"
        options.menu_subtitle = "Gestion"
        Menu.previous = "Main"
        Menu.selection = 1
        for i,c in pairs(liste) do
            Menu.addButton(liste[i].vehicle_name .. " (".. liste[i].vehicle_plate ..") ","getOutFourriere",{ plate = liste[i].vehicle_plate, id = liste[i].ID })
        end
    else
        drawNotification("~r~ Aucun véhicule dans la fourrière !")
    end
    Menu.addButton("Retour", "Main", nil)
end)
