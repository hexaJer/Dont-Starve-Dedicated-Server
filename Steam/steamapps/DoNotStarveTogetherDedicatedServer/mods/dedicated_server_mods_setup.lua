--There are two functions that will install mods, ServerModSetup and ServerModCollectionSetup. Put the calls to the functions in this file and they will be executed on boot.

--ServerModSetup takes a string of a specific mod's Workshop id. It will download and install the mod to your mod directory on boot.
	--The Workshop id can be found at the end of the url to the mod's Workshop page.
	--Example: http://steamcommunity.com/sharedfiles/filedetails/?id=350811795
	--ServerModSetup("350811795")

--ServerModCollectionSetup takes a string of a specific mod's Workshop id. It will download all the mods in the collection and install them to the mod directory on boot.
	--The Workshop id can be found at the end of the url to the collection's Workshop page.
	--Example: http://steamcommunity.com/sharedfiles/filedetails/?id=379114180
	--ServerModCollectionSetup("379114180")

	ServerModSetup("382501575") --[DST] Crash Bandicoot 3.0.0
	ServerModSetup("531060374") --San(Princess Mononoke)
	ServerModSetup("603397958") --Woo, Maxwell's Owl
	ServerModSetup("436336891") --Mabel Pines (Updated And Working)
	ServerModSetup("372911249") --Dipper Pines (FULLY UPDATED)
	ServerModSetup("360770741") --Increased Max Players
	ServerModSetup("758532836") --Global Pause
