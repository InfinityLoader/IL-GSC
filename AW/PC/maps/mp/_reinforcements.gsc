/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_reinforcements.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 217 ms
 * Timestamp: 4/22/2024 2:16:09 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(level.rankedmatch && !getdvarint("scr_game_division",0) > 0)
	{
		level thread onplayerconnect();
	}
}

//Function Number: 2
onplayerconnect()
{
	level endon("game_ended");
	level waittill("prematch_over");
	wait 0.05;
	foreach(var_01 in level.players)
	{
		if(isbot(var_01))
		{
			continue;
		}

		var_01 resetreinforcements();
		var_01 thread checkforreinforcements();
	}

	for(;;)
	{
		level waittill("connected",var_01);
		if(isbot(var_01))
		{
			continue;
		}

		var_01 resetreinforcements();
		var_01 thread checkforreinforcements();
	}
}

//Function Number: 3
resetreinforcements()
{
	self setclientomnvar("ui_reinforcement_timer_type",0);
	self setclientomnvar("ui_reinforcement_timer",0);
}

//Function Number: 4
storependingreinforcement(param_00)
{
	self.pers["reinforcements"] = spawnstruct();
	self.pers["reinforcements"].type = param_00;
	self.pers["reinforcements"].starttimepassed = maps\mp\_utility::getgametimepassedms();
}

//Function Number: 5
cancelpendingreinforcement()
{
	self.pers["reinforcements"].type = 0;
}

//Function Number: 6
pendingreinforcementavailable()
{
	return isdefined(self.pers["reinforcements"]);
}

//Function Number: 7
checkforreinforcements()
{
	self endon("disconnect");
	level endon("game_ended");
	if(!maps\mp\_utility::allowclasschoice())
	{
		return;
	}

	if(self.health <= 0)
	{
		self waittill("spawned_player");
	}

	if(pendingreinforcementavailable())
	{
		thread continuereinforcements();
		return;
	}

	var_00 = 0;
	if(maps\mp\_utility::practiceroundgame())
	{
		var_00 = 4;
	}
	else
	{
		var_00 = self consumereinforcement();
	}

	storependingreinforcement(var_00);
	if(var_00 == 0)
	{
		return;
	}

	var_02 = gettimetoreinforcementfortypems(var_00);
	var_03 = gettimeremainingincludingrounds();
	if(var_03 < var_02)
	{
		cancelpendingreinforcement();
		return;
	}

	thread waitforreinforcementoftype(var_00,var_02);
}

//Function Number: 8
continuereinforcements()
{
	var_00 = self.pers["reinforcements"].type;
	if(var_00 == 0)
	{
		return;
	}

	var_01 = gettimetoreinforcementfortypems(var_00);
	var_02 = maps\mp\_utility::getgametimepassedms();
	var_03 = self.pers["reinforcements"].starttimepassed;
	var_01 = var_01 - var_02;
	var_01 = var_01 + var_03;
	thread waitforreinforcementoftype(var_00,var_01);
}

//Function Number: 9
gettimeremainingincludingrounds()
{
	if(maps\mp\_utility::isroundbased())
	{
		var_00 = maps\mp\_utility::getscorelimit();
		var_01 = min(var_00 - maps\mp\_utility::getroundswon("allies"),var_00 - maps\mp\_utility::getroundswon("axis"));
		var_02 = maps\mp\_utility::gettimelimit() * var_01;
		return var_02 * 60 * 1000 - maps\mp\_utility::gettimepassed();
	}

	return maps\mp\gametypes\_gamelogic::gettimeremaining();
}

//Function Number: 10
gettimetoreinforcementfortypems(param_00)
{
	switch(param_00)
	{
		case 1:
			return 120000;

		case 2:
			return 240000;

		case 3:
			return 360000;

		case 4:
			return 60000;

		default:
			break;
	}

	return 0;
}

//Function Number: 11
geticontypeforreinforcementoftype(param_00)
{
	switch(param_00)
	{
		case 1:
			return 1;

		case 2:
			return 2;

		case 3:
			return 3;

		case 4:
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 12
getcarepackagestreakforreinforcementoftype(param_00)
{
	switch(param_00)
	{
		case 1:
			return "airdrop_reinforcement_common";

		case 2:
			return "airdrop_reinforcement_uncommon";

		case 3:
			return "airdrop_reinforcement_rare";

		case 4:
			return "airdrop_reinforcement_practice";

		default:
			break;
	}

	return "";
}

//Function Number: 13
waitforreinforcementoftype(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	var_02 = geticontypeforreinforcementoftype(param_00);
	self setclientomnvar("ui_reinforcement_timer_type",var_02);
	self setclientomnvar("ui_reinforcement_timer",gettime() + param_01);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_01 / 1000);
	self setclientomnvar("ui_reinforcement_timer_type",0);
	self setclientomnvar("ui_reinforcement_timer",0);
	givereinforcementoftype(param_00);
}

//Function Number: 14
givereinforcementoftype(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	var_01 = getcarepackagestreakforreinforcementoftype(param_00);
	var_02 = 500;
	var_03 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex(var_01);
	thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_01,var_02,undefined,undefined,var_03);
	maps\mp\killstreaks\_killstreaks::givekillstreak(var_01);
	cancelpendingreinforcement();
}