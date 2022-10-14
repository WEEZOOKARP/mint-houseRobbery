Config = {}

Config.Dispatch = "ps-dispatch" -- available options | ps-dispatch | QBCore | anything else and it wont send a dispatch message

Config.Locations = {
    {
        name = "Wild Oats Drive",
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
    --[[{
        name = "Integrity Way",
        location = vector3(-48.29, -587.09, 37.95),
        insde = vector3(0,0,0),
        exit = vector3(0,0,0),
        loot = {
            vector3(0,0,0),
            vector3(0,0,0),
            vector3(0,0,0),
            vector3(0,0,0),
        }
    },]]

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

