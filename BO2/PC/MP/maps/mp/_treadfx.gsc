/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_treadfx.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:11:04 AM
*******************************************************************/

//Function Number: 1
loadtreadfx(vehicle)
{
	treadfx = vehicle.treadfxnamearray;
	if(IsDefined(treadfx))
	{
		vehicle.treadfx = [];
		if(IsDefined(treadfx["asphalt"]) && treadfx["asphalt"] != "")
		{
			vehicle.treadfx["asphalt"] = loadfx(treadfx["asphalt"]);
		}

		if(IsDefined(treadfx["bark"]) && treadfx["bark"] != "")
		{
			vehicle.treadfx["bark"] = loadfx(treadfx["bark"]);
		}

		if(IsDefined(treadfx["brick"]) && treadfx["brick"] != "")
		{
			vehicle.treadfx["brick"] = loadfx(treadfx["brick"]);
		}

		if(IsDefined(treadfx["carpet"]) && treadfx["carpet"] != "")
		{
			vehicle.treadfx["carpet"] = loadfx(treadfx["carpet"]);
		}

		if(IsDefined(treadfx["ceramic"]) && treadfx["ceramic"] != "")
		{
			vehicle.treadfx["ceramic"] = loadfx(treadfx["ceramic"]);
		}

		if(IsDefined(treadfx["cloth"]) && treadfx["cloth"] != "")
		{
			vehicle.treadfx["cloth"] = loadfx(treadfx["cloth"]);
		}

		if(IsDefined(treadfx["concrete"]) && treadfx["concrete"] != "")
		{
			vehicle.treadfx["concrete"] = loadfx(treadfx["concrete"]);
		}

		if(IsDefined(treadfx["cushion"]) && treadfx["cushion"] != "")
		{
			vehicle.treadfx["cushion"] = loadfx(treadfx["cushion"]);
		}

		if(IsDefined(treadfx["none"]) && treadfx["none"] != "")
		{
			vehicle.treadfx["none"] = loadfx(treadfx["none"]);
		}

		if(IsDefined(treadfx["dirt"]) && treadfx["dirt"] != "")
		{
			vehicle.treadfx["dirt"] = loadfx(treadfx["dirt"]);
		}

		if(IsDefined(treadfx["flesh"]) && treadfx["flesh"] != "")
		{
			vehicle.treadfx["flesh"] = loadfx(treadfx["flesh"]);
		}

		if(IsDefined(treadfx["foliage"]) && treadfx["foliage"] != "")
		{
			vehicle.treadfx["foliage"] = loadfx(treadfx["foliage"]);
		}

		if(IsDefined(treadfx["fruit"]) && treadfx["fruit"] != "")
		{
			vehicle.treadfx["fruit"] = loadfx(treadfx["fruit"]);
		}

		if(IsDefined(treadfx["glass"]) && treadfx["glass"] != "")
		{
			vehicle.treadfx["glass"] = loadfx(treadfx["glass"]);
		}

		if(IsDefined(treadfx["grass"]) && treadfx["grass"] != "")
		{
			vehicle.treadfx["grass"] = loadfx(treadfx["grass"]);
		}

		if(IsDefined(treadfx["gravel"]) && treadfx["gravel"] != "")
		{
			vehicle.treadfx["gravel"] = loadfx(treadfx["gravel"]);
		}

		if(IsDefined(treadfx["metal"]) && treadfx["metal"] != "")
		{
			vehicle.treadfx["metal"] = loadfx(treadfx["metal"]);
		}

		if(IsDefined(treadfx["mud"]) && treadfx["mud"] != "")
		{
			vehicle.treadfx["mud"] = loadfx(treadfx["mud"]);
		}

		if(IsDefined(treadfx["paintedmetal"]) && treadfx["paintedmetal"] != "")
		{
			vehicle.treadfx["paintedmetal"] = loadfx(treadfx["paintedmetal"]);
		}

		if(IsDefined(treadfx["paper"]) && treadfx["paper"] != "")
		{
			vehicle.treadfx["paper"] = loadfx(treadfx["paper"]);
		}

		if(IsDefined(treadfx["plaster"]) && treadfx["plaster"] != "")
		{
			vehicle.treadfx["plaster"] = loadfx(treadfx["plaster"]);
		}

		if(IsDefined(treadfx["plastic"]) && treadfx["plastic"] != "")
		{
			vehicle.treadfx["plastic"] = loadfx(treadfx["plastic"]);
		}

		if(IsDefined(treadfx["rock"]) && treadfx["rock"] != "")
		{
			vehicle.treadfx["rock"] = loadfx(treadfx["rock"]);
		}

		if(IsDefined(treadfx["rubber"]) && treadfx["rubber"] != "")
		{
			vehicle.treadfx["rubber"] = loadfx(treadfx["rubber"]);
		}

		if(IsDefined(treadfx["sand"]) && treadfx["sand"] != "")
		{
			vehicle.treadfx["sand"] = loadfx(treadfx["sand"]);
		}

		if(IsDefined(treadfx["water"]) && treadfx["water"] != "")
		{
			vehicle.treadfx["water"] = loadfx(treadfx["water"]);
		}

		if(IsDefined(treadfx["wood"]) && treadfx["wood"] != "")
		{
			vehicle.treadfx["wood"] = loadfx(treadfx["wood"]);
		}
	}
}

//Function Number: 2
preloadtreadfx(vehicle)
{
	treadfx = getvehicletreadfxarray(vehicle);
	for(i = 0;i < treadfx.size;i++)
	{
		loadfx(treadfx[i]);
	}
}