# mint-houseRobbery
Requirements:

    qb-core -- https://github.com/qbcore-framework/qb-core
    qb-target -- https://github.com/qbcore-framework/qb-target
    cd_drawtextui -- https://github.com/dsheedes/cd_drawtextui
    ps-dispatch -- https://github.com/Project-Sloth/ps-dispatch -- ONLY IF YOU SET Config.Dispatch to ps-dispatch

# Description:
Clean and simple house robbery script, originally released by MintKind then converted updated and fixed up by WEEZOOKA.
Built for QBCore and can be configured to being used anywhere using coordinates to allow you to use ipls mlos and more. 
Enjoy and if you encounter any issues or want to make a suggestion create an issue.

# Config
## Dispatch and general config
```
    Config.Dispatch = "ps-dispatch" -- available options | ps-dispatch | QBCore | anything else and it wont send a dispatch message

    Config.ItemRequired = "advancedlockpick" -- the item ID that you want the player to have in order to enter
    Config.Shoulduseitem = true -- weather or not to remove the item from their inventory after use
    Config.Robsuccesscooldown = 10 -- minutes
    Config.Robfailedcooldown = 10 -- minutes
```
## Custom Locations
I suggest this page for getting gta online interior's coordinates https://wiki.rage.mp/index.php?title=Interiors_and_Locations it is for ragemp but will work fine with fivem as these coordinates are just base gta stuff
```
    { -- if you want to add your own robbery copy this table entry ( from the start of this line till the en of line 38 ) paste and edit
        name = "Tinsel Towers", -- Name identifier
        canrob = true, -- do not change this
        location = vector3(-614.64, 46.96, 43.70), -- Target location
        inside = vector3(-596.34, 59.45, 108.03), -- Where the player gets placed on entry
        exit = vector3(-596.38, 56.47, 108.03), -- Where the exit prompt is when inside the robbery
        outside = vector3(-615.12, 42.58, 43.59), -- where the player is placed on exit
        loot = {
            vector3(-605.21, 55.93, 108.04), -- loot location
            vector3(-610.6, 52.52, 106.62), -- loot location
            vector3(-617.01, 56.08, 101.83), -- loot location
            vector3(-609.27, 58.22, 101.82), -- loot location
        }
    },
```
## Custom Loot
```
Config.Items = {
    normalItems = { -- Most common type of item 70% chance
        "cryptostick",
        "vodka",
        "iphone",
        "samsungphone"
    },
    rareItems = { -- mid tier items 28% chance
        "tablet",
        "laptop",
        "rolex",
        "goldchain",
        "diamond_ring",
        "10kgoldchain"
    },
    veryRareItems = { -- Rare items 2% chance
        "drill",
        "moneybag"
    }
}
```


# To-Do:

    Done - Some type of puzzle/minigame when entering
    Done - Police Alerts
    Done - Item requierment to start
    In progress - Code cleanup
    Update to reduce number of requirements
    Further optimisation
    Any suggestions? go to issues and post there :)

