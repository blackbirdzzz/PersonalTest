-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MENU COFFRE-------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
local Job_ID = 0
local Job_Name = ""
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
    color_b = 255, 
}
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------

function CoffreMainmenu(Job_I, Job_N)
    if(Job_I ~= nil and Job_I ~= "") then Job_ID = Job_I end
    if(Job_N ~= nil and Job_N ~= "") then Job_Name = Job_N end
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Coffre"
    options.menu_subtitle = "Gestion"
    Menu.selection = 1
    Menu.addButton("Gérer l'argent", "GererArgent", nil)
    Menu.addButton("Gérer les employés", "GererEmploy", nil)
end

function GererArgent()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Argent"
    options.menu_subtitle = "Gestion"
    Menu.previous = "CoffreMainmenu"
    Menu.selection = 1
    Menu.addButton("Voir le solde actuel", "VoirSolde", nil)
    Menu.addButton("Déposer de l'argent", "AjouterSolde", nil)
    Menu.addButton("Retirer de l'argent", "RetirerSolde", nil)
    Menu.addButton("Pourcentage des employes", "GererPartage", nil)
end

function GererEmploy()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Employes"
    options.menu_subtitle = "Gestion des employés"
    Menu.previous = "CoffreMainmenu"
    Menu.selection = 1
    Menu.addButton("Voir la liste des employés", "VoirEmploye", nil)
    Menu.addButton("Embaucher une personne", "EmbEmploye", nil)
end
-------------------------------------------------
----------------FONCTION COFFRE------------------
-------------------------------------------------

function VoirEmploye()
    TriggerServerEvent('entreprises:voiremploye', Job_ID)
end

function EmbEmploye()
    DisplayHelpText("Entrer l'~r~ID~w~ du joueur présent en bas de sa ~g~carte d'identité")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
        
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        if(tonumber(result) ~= nil and tonumber(result) ~= "") then
            TriggerServerEvent('entreprises:recruteremp', result, Job_ID)
        else
            GererEmploy()
        end
    end

end

RegisterNetEvent("entreprises:voirlisteemploye") 
AddEventHandler("entreprises:voirlisteemploye", function(liste)
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    options.menu_subtitle = "Employés"
    ClearMenu()
    Menu.previous = "GererEmploy"
    if(liste[1].job == 2) then
        for i, c in pairs(liste) do
            if(liste[i].leader == 1) then
                Menu.addButton("[Coffre]["..liste[i].rank .. "] " ..liste[i].nom .. " "..liste[i].prenom, "GestionPolice", liste[i].id)
            else
                Menu.addButton("["..liste[i].rank .. "] " ..liste[i].nom .. " "..liste[i].prenom, "GestionPolice", liste[i].id)
            end
        end
    else
        for i, c in pairs(liste) do
            if(liste[i].leader == 1) then
                Menu.addButton("[Coffre] " .. liste[i].nom .. " "..liste[i].prenom, "VirerEmploy", liste[i].id)
            else
                Menu.addButton(liste[i].nom .. " "..liste[i].prenom, "VirerEmploy", liste[i].id)
            end
        end
    end
end)

function GestionPolice(id)
    options.menu_subtitle = "Gestion"
    Menu.previous = "GererEmploy"
    ClearMenu()
    Menu.selection = 1
    Menu.addButton("Donner l'accés au coffre", "AccessCoffre", {toggle = 1, idemp = id})
    Menu.addButton("Retirer l'accés au coffre", "AccessCoffre", {toggle = 0, idemp = id})
    Menu.addButton("Monter en grade", "PromotionPolice", id)
    Menu.addButton("Baisser de grade", "RetroPolice", id)
    Menu.addButton("Renvoyer l'employé(e)", "RV", id)
    Menu.addButton("Retour", "GererEmploy", nil)
end

function PromotionPolice(num)
    TriggerServerEvent('entreprises:modifgradepolice', num)
end

function RetroPolice(num)
    TriggerServerEvent('entreprises:modifgradepoliceretro', num)
end

function VirerEmploy(id, prenom)
    options.menu_subtitle = "Gestion"
    Menu.previous = "GererEmploy"
    ClearMenu()
    Menu.selection = 1
    Menu.addButton("Donner l'accés au coffre", "AccessCoffre", {toggle = 1, idemp = id})
    Menu.addButton("Retirer l'accés au coffre", "AccessCoffre", {toggle = 0, idemp = id})
    Menu.addButton("Renvoyer l'employé(e)", "RV", id)
    Menu.addButton("Retour", "GererEmploy", nil)
end

function RV(id)
    TriggerServerEvent('entreprises:licencieremploye', id)
end

function AccessCoffre(accesCoffre)
    TriggerServerEvent('entreprises:accesCoffre', accesCoffre)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function AjouterSolde()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
        
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        if(tonumber(result) and tonumber(result) > 0) then
            TriggerServerEvent('entreprises:ajoutsolde', result, Job_ID)
        end
        --end
    end
end

function RetirerSolde()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
        
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent('entreprises:retirersolde', result, Job_ID)
        --end
    end

end

function GererPartage()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 2)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0); 
        Wait(0); 
        
    end
    if (GetOnscreenKeyboardResult()) then
        --if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
        TriggerServerEvent('entreprises:gererpartage', result, Job_ID)
        --end
    end
end
function VoirSolde()
    TriggerServerEvent('entreprises:showsolde')
end
