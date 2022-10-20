Config = {}

Config.Dispatch = "ps-dispatch" -- available options | ps-dispatch | QBCore | anything else and it wont send a dispatch message

Config.ItemRequired = "advancedlockpick" -- the item ID that you want the player to have in order to enter
Config.Shoulduseitem = true -- weather or not to remove the item from their inventory after use
Config.Robsuccesscooldown = 10 -- minutes
Config.Robfailedcooldown = 10 -- minutes

Config.Locations = {
    {
        name = "Wild Oats Drive",
        canrob = true, -- do not change this
        location = vector3(-174.07, 502.62, 137.42),
        inside = vector3(-173.72, 495.69, 137.57),
        exit = vector3(-174.34, 497.89, 137.67),
        outside = vector3(-177.07, 503.4, 137.03),
        loot = {
            vector3(-166.92, 495.6, 137.65),
            vector3(-165.97, 482.16, 137.27),
            vector3(-167.31, 487.45, 133.84),
            vector3(-174.65, 492.51 ,130.04),
        }
    }, 
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
}

Config.Items = {
    normalItems = {
        "cryptostick",
        "vodka",
        "iphone",
        "samsungphone"
    },
    rareItems = {
        "tablet",
        "laptop",
        "rolex",
        "goldchain",
        "diamond_ring",
        "10kgoldchain"
    },
    veryRareItems = {
        "drill",
        "moneybag"
    }
}

