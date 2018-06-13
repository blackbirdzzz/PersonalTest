function PoleMainMenu()
    DisplayHelpText("~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ pour ~y~monter/descendre~w~ et ~y~Entrer~w~")
    ClearMenu()
    options.menu_title = "Trium Emploi"
    options.menu_subtitle = "Liste des metiers"
    Menu.selection = 1
    Menu.addButton("Voir les métiers privés", "MenuMetiersPrives", nil)
    Menu.addButton("Voir les métiers ouverts ", "MenuMetiersOuverts", nil)
end

function MenuMetiersPrives()
    ClearMenu()
    Menu.selection = 1
    for _, v in pairs(entreprises) do
        if(v.metier_prive and (not v.pole_ignore)) then
            Menu.addButton('~g~' .. v.metier .. ' ~w~pour ~b~' .. v.nom, "CheckBeforeTake", v.jobid)
        end
    end
    Menu.addButton("Retour", "PoleMainMenu", nil)
end

function MenuMetiersOuverts()
    ClearMenu()
    Menu.selection = 1
    for _, v in pairs(entreprises) do
        if((not v.metier_prive) and (not v.pole_ignore)) then
            Menu.addButton('~g~' .. v.metier .. ' ~w~pour ~b~' .. v.nom, "CheckBeforeTake", v.jobid)
        end
    end
    Menu.addButton("Retour", "PoleMainMenu", nil)
end

function CheckBeforeTake(jobID)
    Citizen.CreateThread(function()
        for _, v in pairs(entreprises) do
            if(v.jobid == jobID) then
                if (v.metier_prive == true) then
                    DisplayHelpText("Pour ~y~rejoindre ~w~un métier privé tu dois te renseigner dans la ~y~ville ~w~!")
                    Citizen.Wait(5000)
                    break
                else
                    TriggerServerEvent("metiers:jobs", v.jobid)
                    DisplayHelpText("Bienvenue chez ~y~"..v.nom.."~w~ ! Tu es maintenant ~y~" .. v.metier .. " ~w~")
                    Initialisation_Systeme_Metiers()
                    --Menu.hidden = true
                    break
                end
            end
        end
    end)
end










