/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_water.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 441 ms
 * Timestamp: 10/27/2023 1:49:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["water_wake"] = loadfx("vfx/treadfx/body_wake_water");
	level._effect["water_wake_stationary"] = loadfx("vfx/treadfx/body_wake_water_stationary");
	level._effect["water_splash_emerge"] = loadfx("vfx/water/body_splash_exit");
	level._effect["water_splash_enter"] = loadfx("vfx/water/body_splash");
	precacheshellshock("underwater");
	if(!isdefined(level.waterline_ents))
	{
		level.waterline_ents = [];
	}

	if(!isdefined(level.waterline_offset))
	{
		level.waterline_offset = 0;
	}

	if(!isdefined(level.shallow_water_weapon))
	{
		setshallowwaterweapon("iw5_combatknife_mp");
	}

	if(!isdefined(level.deep_water_weapon))
	{
		setdeepwaterweapon("iw5_underwater_mp");
	}

	if(!isdefined(level.allow_swimming))
	{
		level.allow_swimming = 1;
	}

	if(level.deep_water_weapon == level.shallow_water_weapon)
	{
		level.allow_swimming = 0;
	}

	if(!isdefined(level.swimming_depth))
	{
		level.swimming_depth = 48;
	}

	var_00 = getentarray("trigger_underwater","targetname");
	level.water_triggers = var_00;
	foreach(var_02 in var_00)
	{
		var_02 create_clientside_water_ents();
		var_02 thread watchplayerenterwater();
		level thread clearwatervarsonspawn(var_02);
	}

	level thread onplayerconnectfunctions();
	setdvar("scr_ball_water_drop_delay",10);
}

//Function Number: 2
player_set_in_water(param_00)
{
	if(param_00)
	{
		self.inwater = 1;
		if(!isscriptedagent(self) && maps\mp\_utility::isaigameparticipant(self) && !isdefined(level.bots_ignore_water))
		{
			self botsetflag("in_water",1);
			return;
		}

		return;
	}

	self.inwater = undefined;
	if(!isscriptedagent(self) && maps\mp\_utility::isaigameparticipant(self) && !isdefined(level.bots_ignore_water))
	{
		self botsetflag("in_water",0);
	}
}

//Function Number: 3
watchforhostmigration()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("player_migrated");
		foreach(var_01 in level.waterline_ents)
		{
			self initwaterclienttrigger(var_01.script_noteworthy,var_01);
		}
	}
}

//Function Number: 4
onplayerconnectfunctions()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread watchforhostmigration();
		foreach(var_02 in level.waterline_ents)
		{
			var_00 initwaterclienttrigger(var_02.script_noteworthy,var_02);
		}
	}
}

//Function Number: 5
create_clientside_water_ents()
{
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_00.origin = var_00.origin + (0,0,level.waterline_offset);
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_01 show();
	if(isdefined(self.script_noteworthy))
	{
		var_01.script_noteworthy = self.script_noteworthy;
		level.waterline_ents = common_scripts\utility::array_add(level.waterline_ents,var_01);
	}
}

//Function Number: 6
clearwatervarsonspawn(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_01);
		if(!var_01 istouching(param_00))
		{
			var_01 player_set_in_water(0);
			var_01.underwater = undefined;
			var_01.inthickwater = undefined;
			var_01.isswimming = undefined;
			var_01.iswading = undefined;
			var_01.water_last_weapon = undefined;
			var_01.isshocked = undefined;
			var_01 notify("out_of_water");
		}
	}
}

//Function Number: 7
watchplayerenterwater()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isdefined(level.ishorde) && level.ishorde && isagent(var_00) && isdefined(var_00.horde_type) && var_00.horde_type == "Quad" && !isdefined(var_00.inwater))
		{
			var_00 thread hordedoginwater(self);
		}

		if(!isplayer(var_00) && !isai(var_00))
		{
			continue;
		}

		if(!isalive(var_00))
		{
			continue;
		}

		if(!isdefined(var_00.inwater))
		{
			var_00 player_set_in_water(1);
			var_00 thread playerinwater(self);
		}
	}
}

//Function Number: 8
hordedoginwater(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	player_set_in_water(1);
	for(;;)
	{
		if(!inshallowwater(param_00,40))
		{
			wait(2.5);
			if(!inshallowwater(param_00,20))
			{
				self dodamage(self.health,self.origin);
			}
		}

		wait 0.05;
	}
}

//Function Number: 9
playerinwater(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	thread inwaterwake(param_00);
	thread playerwaterclearwait();
	self.eyeheightlastframe = 0;
	self.eye_velocity = 0;
	for(;;)
	{
		if(maps\mp\_utility::isusingremote())
		{
			if(isdefined(self.underwater) && isdefined(self.isshocked))
			{
				self stopshellshock();
				self.isshocked = undefined;
			}
		}
		else if(isdefined(self.underwater) && !isdefined(self.isshocked))
		{
			self shellshock("underwater",19,0,0);
			self.isshocked = 1;
		}

		if(!self istouching(param_00))
		{
			player_set_in_water(0);
			self.underwater = undefined;
			self.inthickwater = undefined;
			self.isswimming = undefined;
			self.movespeedscaler = level.baseplayermovescale;
			maps\mp\gametypes\_weapons::updatemovespeedscale();
			self notify("out_of_water");
			break;
		}

		if(isdefined(self.inthickwater) && inshallowwater(param_00,32))
		{
			self.inthickwater = undefined;
			self.movespeedscaler = level.baseplayermovescale;
			maps\mp\gametypes\_weapons::updatemovespeedscale();
		}

		if(inshallowwater(param_00,32))
		{
			self.inthickwater = undefined;
			if(isdefined(level.watermovescale))
			{
				self.movespeedscaler = level.baseplayermovescale * level.watermovescale;
			}
			else
			{
				self.movespeedscaler = level.baseplayermovescale;
			}

			maps\mp\gametypes\_weapons::updatemovespeedscale();
		}

		if(!isdefined(self.inthickwater) && !inshallowwater(param_00,32))
		{
			self.inthickwater = 1;
			self.movespeedscaler = 0.7 * level.baseplayermovescale;
			maps\mp\gametypes\_weapons::updatemovespeedscale();
		}

		if(!isdefined(self.underwater) && !isabovewaterline(param_00,0))
		{
			if(isdefined(self.balldropdelay) && self.balldropdelay > 0)
			{
				self.balldropdelay--;
				wait 0.05;
				continue;
			}

			self.underwater = 1;
			if(isdefined(level.waterplayerhandledamagefunc))
			{
				self thread [[ level.waterplayerhandledamagefunc ]]();
			}
			else
			{
				thread playerhandledamage();
			}

			if(maps\mp\_utility::isaugmentedgamemode())
			{
				disableexo();
			}

			if(!maps\mp\_utility::isusingremote())
			{
				self shellshock("underwater",19,0,0);
				self.isshocked = 1;
			}

			var_01 = self getcurrentweapon();
			if(var_01 != "none")
			{
				var_02 = weaponinventorytype(var_01);
				if(var_02 == "primary" || var_02 == "altmode")
				{
					self.water_last_weapon = var_01;
				}
				else if(isdefined(self.lastnonuseweapon) && self hasweapon(self.lastnonuseweapon))
				{
					self.water_last_weapon = self.lastnonuseweapon;
				}
			}

			if(isdefined(level.gamemodeonunderwater))
			{
				self [[ level.gamemodeonunderwater ]](param_00);
			}

			if(isdefined(level.hordeonunderwater))
			{
				self [[ level.hordeonunderwater ]](param_00);
			}

			if(!level.iszombiegame)
			{
				maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
			}
		}

		if(isdefined(self.underwater) && isdefined(self.isswimming) || !isdefined(self.iswading) && inshallowwater(param_00,level.swimming_depth) || self getstance() == "prone" || !level.allow_swimming)
		{
			self.iswading = 1;
			self.isswimming = undefined;
			playerdisableunderwater();
			if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1)
			{
				playerenableunderwater("none");
				self allowfire(0);
				self disableoffhandsecondaryweapons();
			}
			else if(!isdefined(level.iszombiegame) || !isscriptedagent(self))
			{
				playerenableunderwater("shallow");
			}
		}

		if(isdefined(self.underwater) && isdefined(self.iswading) || !isdefined(self.isswimming) && !inshallowwater(param_00,level.swimming_depth) && self getstance() != "prone" && level.allow_swimming)
		{
			self.isswimming = 1;
			self.iswading = undefined;
			playerdisableunderwater();
			if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1)
			{
				playerenableunderwater("none");
				self allowfire(0);
				self disableoffhandsecondaryweapons();
			}
			else if(!isdefined(level.iszombiegame) || !isscriptedagent(self))
			{
				playerenableunderwater("deep");
			}
		}

		if(isdefined(self.balldropdelay))
		{
			self.balldropdelay = getdvarint("scr_ball_water_drop_delay",10);
		}

		if(isdefined(self.underwater) && isabovewaterline(param_00,0))
		{
			self.underwater = undefined;
			self.isswimming = undefined;
			self.iswading = undefined;
			self notify("above_water");
			var_03 = distance(self getvelocity(),(0,0,0));
			var_04 = (self.origin[0],self.origin[1],getwaterline(param_00));
			playfx(level._effect["water_splash_emerge"],var_04,anglestoforward((0,self.angles[1],0) + (270,180,0)));
			if(!maps\mp\_utility::isusingremote())
			{
				self stopshellshock();
				self.isshocked = undefined;
			}

			playerdisableunderwater();
			if(maps\mp\_utility::isaugmentedgamemode())
			{
				enableexo();
			}

			if(!level.iszombiegame)
			{
				maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
			}
		}

		wait(0.05);
	}
}

//Function Number: 10
isactivekillstreakwaterrestricted(param_00)
{
	if(isdefined(param_00.killstreakindexweapon))
	{
		var_01 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
		if(isdefined(var_01))
		{
			if(common_scripts\utility::string_find(var_01,"turret") > 0 || common_scripts\utility::string_find(var_01,"sentry") > 0)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 11
playerwaterclearwait()
{
	var_00 = common_scripts\utility::waittill_any_return("death","out_of_water");
	self.underwatermotiontype = undefined;
	self.dont_give_or_take_weapon = undefined;
	player_set_in_water(0);
	self.underwater = undefined;
	self.inthickwater = undefined;
	self.water_last_weapon = undefined;
	self.movespeedscaler = level.baseplayermovescale;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 12
inwaterwake(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("out_of_water");
	var_01 = distance(self getvelocity(),(0,0,0));
	if(var_01 > 90)
	{
		var_02 = (self.origin[0],self.origin[1],getwaterline(param_00));
		playfx(level._effect["water_splash_enter"],var_02,anglestoforward((0,self.angles[1],0) + (270,180,0)));
	}

	for(;;)
	{
		var_03 = self getvelocity();
		var_01 = distance(var_03,(0,0,0));
		if(var_01 > 0)
		{
			wait(max(1 - var_01 / 120,0.1));
		}
		else
		{
			wait(0.3);
		}

		if(var_01 > 5)
		{
			var_04 = vectornormalize((var_03[0],var_03[1],0));
			var_05 = anglestoforward(vectortoangles(var_04) + (270,180,0));
			var_02 = (self.origin[0],self.origin[1],getwaterline(param_00)) + var_01 / 4 * var_04;
			playfx(level._effect["water_wake"],var_02,var_05);
			continue;
		}

		var_02 = (self.origin[0],self.origin[1],getwaterline(param_00));
		playfx(level._effect["water_wake_stationary"],var_02,anglestoforward((0,self.angles[1],0) + (270,180,0)));
	}
}

//Function Number: 13
playerhandledamage()
{
	level endon("game_ended");
	self endon("death");
	self endon("stopped_using_remote");
	self endon("disconnect");
	self endon("above_water");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	thread onplayerdeath();
	wait(13);
	for(;;)
	{
		if(!isdefined(self.isjuggernaut) || self.isjuggernaut == 0)
		{
			radiusdamage(self.origin + anglestoforward(self.angles) * 5,1,20,20,undefined,"MOD_TRIGGER_HURT");
		}

		wait(1);
	}
}

//Function Number: 14
onplayerdeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("above_water");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		common_scripts\utility::waittill_any("death","becameSpectator");
	}
	else
	{
		self waittill("death");
	}

	player_set_in_water(0);
	self.underwater = undefined;
	self.inthickwater = undefined;
	self.isswimming = undefined;
	self.iswading = undefined;
	self.water_last_weapon = undefined;
	self.underwatermotiontype = undefined;
	self.eye_velocity = 0;
	self.eyeheightlastframe = 0;
	if(!level.iszombiegame)
	{
		maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
	}
}

//Function Number: 15
inshallowwater(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 32;
	}

	if(level getwaterline(param_00) - self.origin[2] <= param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
isabovewaterline(param_00,param_01)
{
	if(getplayereyeheight() + param_01 >= level getwaterline(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
getplayereyeheight()
{
	var_00 = self geteye();
	self.eye_velocity = var_00[2] - self.eyeheightlastframe;
	self.eyeheightlastframe = var_00[2];
	return var_00[2];
}

//Function Number: 18
getwaterline(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
	var_02 = var_01.origin[2];
	return var_02;
}

//Function Number: 19
playerenableunderwater(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("end_swimming");
	if(!isdefined(param_00))
	{
		param_00 = "shallow";
	}

	if((param_00 == "shallow" && self hasweapon(level.shallow_water_weapon)) || param_00 == "deep" && self hasweapon(level.deep_water_weapon) || isdefined(level.disable_water_weapon_swap))
	{
		self.dont_give_or_take_weapon = 1;
	}

	switch(param_00)
	{
		case "deep":
			break;

		case "shallow":
			break;

		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 20
playerdisableunderwater()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	if(isdefined(self.underwatermotiontype))
	{
		var_00 = self.underwatermotiontype;
		self notify("end_swimming");
		self enableweaponpickup();
		common_scripts\utility::_enableweaponswitch();
		common_scripts\utility::_enableoffhandweapons();
		if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1 && isdefined(self.heavyexodata))
		{
			self allowfire(1);
			if(!isdefined(self.heavyexodata.haslongpunch) || self.heavyexodata.haslongpunch == 0)
			{
				self disableoffhandweapons();
			}

			if(!isdefined(self.heavyexodata.hasrockets) || self.heavyexodata.hasrockets == 0)
			{
				self disableoffhandsecondaryweapons();
			}
			else
			{
				self enableoffhandsecondaryweapons();
			}
		}

		if(isdefined(level.ishorde) && isplayer(self))
		{
			maps\mp\gametypes\_weapons::restoreweapon("underwater");
		}
		else if(isdefined(self.water_last_weapon))
		{
			maps\mp\_utility::switch_to_last_weapon(self.water_last_weapon);
		}

		switch(var_00)
		{
			case "deep":
				break;

			case "shallow":
				break;

			case "none":
				break;

			default:
				break;
		}
	}
}

//Function Number: 21
give_water_weapon(param_00)
{
	if(!isdefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon)
	{
		self giveweapon(param_00);
	}
}

//Function Number: 22
take_water_weapon(param_00)
{
	if(!isdefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon)
	{
		self takeweapon(param_00);
	}
}

//Function Number: 23
enableexo()
{
	maps\mp\_utility::playerallowhighjump(1);
	maps\mp\_utility::playerallowhighjumpdrop(1);
	maps\mp\_utility::playerallowboostjump(1);
	maps\mp\_utility::playerallowpowerslide(1);
	maps\mp\_utility::playerallowdodge(1);
}

//Function Number: 24
disableexo()
{
	maps\mp\_utility::playerallowhighjump(0);
	maps\mp\_utility::playerallowhighjumpdrop(0);
	maps\mp\_utility::playerallowboostjump(0);
	maps\mp\_utility::playerallowpowerslide(0);
	maps\mp\_utility::playerallowdodge(0);
}

//Function Number: 25
setshallowwaterweapon(param_00)
{
	level.shallow_water_weapon = param_00;
}

//Function Number: 26
setdeepwaterweapon(param_00)
{
	level.deep_water_weapon = param_00;
}

//Function Number: 27
isvalidunderwaterweapon(param_00)
{
	switch(param_00)
	{
		case "iw5_underwater_mp":
		case "iw5_combatknife_mp":
		case "none":
			break;

		default:
			break;
	}
}