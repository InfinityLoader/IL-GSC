/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_horde_laststand.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 17
 * Decompile Time: 252 ms
 * Timestamp: 10/27/2023 1:31:00 AM
*******************************************************************/

//Function Number: 1
func_194E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_646D(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	if(func_36FD(self))
	{
		self.uselaststandparams = 1;
		maps\mp\_utility::_suicide();
		hordeendgame();
		return;
	}

	if(!func_5122(self))
	{
		self.uselaststandparams = 1;
		maps\mp\_utility::_suicide();
		return;
	}

	self.var_465B = 1;
	self.laststand = 1;
	self.ignoreme = 1;
	self.health = 1;
	self hudoutlineenable(1,0);
	common_scripts\utility::_disableusability();
	thread func_4CB2();
}

//Function Number: 2
func_36FD(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		if(param_00 == var_03 && !maps\mp\gametypes\_horde_util::func_3FF9(param_00))
		{
			continue;
		}

		if(!maps\mp\gametypes\_horde_util::isonhumanteam(var_03))
		{
			continue;
		}

		if(maps\mp\gametypes\_horde_util::func_4934(var_03) && !maps\mp\gametypes\_horde_util::func_3FF9(var_03))
		{
			continue;
		}

		if(!isdefined(var_03.sessionstate) || var_03.sessionstate != "playing")
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return !var_01;
}

//Function Number: 3
hordeendgame()
{
	level.finalkillcam_winner = level.enemyteam;
	level thread maps\mp\gametypes\_gamelogic::endgame(level.enemyteam,game["end_reason"][level.playerteam + "_eliminated"]);
}

//Function Number: 4
func_5122(param_00)
{
	if(param_00 maps\mp\_utility::func_818D())
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_646D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = addstruct();
	var_07.einflictor = param_00;
	var_07.attacker = param_01;
	var_07.idamage = param_02;
	var_07.attackerposition = param_01.origin;
	var_07.smeansofdeath = param_03;
	var_07.sweapon = param_04;
	var_07.vdir = param_05;
	var_07.shitloc = param_06;
	var_07.laststandstarttime = gettime();
	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		var_07.sprimaryweapon = param_01 getcurrentprimaryweapon();
	}
	else
	{
		var_07.sprimaryweapon = undefined;
	}

	self.laststandparams = var_07;
}

//Function Number: 6
func_4CB2()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	self notify("force_cancel_placement");
	level thread maps\mp\gametypes\_horde_util::func_6047("mp_safe_team_last_stand");
	level thread maps\mp\_utility::func_4D30("ally_down",level.playerteam,"status");
	level thread func_5B9A(self);
	thread laststandwaittilldeathhorde();
	thread func_4CAA();
	thread func_4CAE();
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("tag_origin");
	var_00 setcursorhint("HINT_NOICON");
	var_00 sethintstring(&"PLATFORM_REVIVE");
	var_00 makeusable();
	var_00.inuse = 0;
	var_00.curprogress = 0;
	var_00.usetime = level.laststandusetime;
	var_00.userate = 1;
	var_00.id = "last_stand";
	var_00.targetname = "revive_trigger";
	var_00.owner = self;
	var_00 linkto(self,"tag_origin",(0,0,20),(0,0,0));
	var_00 thread maps\mp\gametypes\_damage::deleteonreviveordeathordisconnect();
	var_01 = newteamhudelem(self.team);
	var_01 setmaterial("waypoint_revive",8,8);
	var_01 setwaypoint(1,1);
	var_01 settargetent(self);
	var_01.color = (0.33,0.75,0.24);
	var_01 thread maps\mp\gametypes\_damage::func_2658(var_00);
	thread func_4CB7(var_00,var_01,25);
	thread func_4CB5(25,var_00);
	var_00 thread func_669B();
	var_00 thread func_4CBC();
	var_00 endon("death");
	wait(25);
	while(isdefined(var_00.inuse) && var_00.inuse)
	{
		common_scripts\utility::func_8AFE();
	}

	level thread maps\mp\_utility::func_4D30("ally_dead",level.playerteam,"status");
	self hudoutlinedisable();
	maps\mp\_utility::_suicide();
}

//Function Number: 7
func_669B()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self makeusable();
		self waittill("trigger",var_00);
		self makeunusable();
		self.curprogress = 0;
		self.inuse = 1;
		self.owner.beingrevived = 1;
		var_00 freezecontrols(1);
		var_00 common_scripts\utility::_disableweapon();
		var_00.isreviving = 1;
		var_01 = maps\mp\gametypes\_damage::useholdthinkloop(var_00);
		self.inuse = 0;
		if(isdefined(self.owner))
		{
			self.owner.beingrevived = 0;
		}

		if(isdefined(var_00) && maps\mp\_utility::func_4945(var_00))
		{
			var_00 freezecontrols(0);
			var_00 common_scripts\utility::_enableweapon();
			var_00.isreviving = 0;
			if(isdefined(var_01) && var_01)
			{
				var_00 thread maps\mp\gametypes\_hud_message::func_794D("horde_reviver");
				var_00 thread maps\mp\perks\_perkfunctions::func_7063(850);
				if(isplayer(var_00))
				{
					maps\mp\gametypes\_horde_util::func_8F94(var_00);
				}
				else if(isdefined(var_00.owner) && isplayer(var_00.owner) && var_00.owner != self.owner)
				{
					maps\mp\gametypes\_horde_util::func_8F94(var_00.owner);
				}
			}

			if(!isdefined(var_01))
			{
				var_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
			}
		}

		if(isdefined(var_01) && var_01)
		{
			self.owner notify("revive_trigger",var_00);
			break;
		}
	}
}

//Function Number: 8
func_4CBC()
{
	self endon("death");
	self endon("game_ended");
	var_00 = self.owner;
	var_00 waittill("revive_trigger",var_01);
	if(isdefined(var_01) && isplayer(var_01) && var_01 != var_00)
	{
		var_00 thread maps\mp\gametypes\_hud_message::func_5F9A("revived",var_01);
	}

	var_00 func_4CB1(self);
}

//Function Number: 9
func_4CB1(param_00)
{
	self notify("revive");
	self.laststand = undefined;
	self.var_465B = 0;
	self.headicon = "";
	self.health = self.maxhealth;
	self.movespeedscaler = 1;
	self.ignoreme = 0;
	self.beingrevived = 0;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::func_4E12();
	}

	self hudoutlinedisable();
	self laststandrevive();
	self setstance("crouch");
	common_scripts\utility::_enableusability();
	maps\mp\gametypes\_weapons::func_8707();
	maps\mp\_utility::func_1D47("last_stand");
	maps\mp\_utility::func_3CFB("specialty_pistoldeath",0);
	if(!canspawn(self.origin))
	{
		maps\mp\_movers::func_85CB(self,0);
	}

	param_00 delete();
}

//Function Number: 10
laststandwaittilldeathhorde()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	self.laststand = undefined;
	self.var_465B = 0;
	self.ignoreme = 0;
}

//Function Number: 11
func_4CAE()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	for(;;)
	{
		self.health = 2;
		common_scripts\utility::func_8AFE();
		self.health = 1;
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 12
func_4CB7(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	param_00 endon("death");
	maps\mp\_utility::func_5D5B();
	wait(param_02 / 3);
	param_01.color = (1,0.64,0);
	while(param_00.inuse)
	{
		wait(0.05);
	}

	maps\mp\_utility::func_5D5B();
	wait(param_02 / 3);
	param_01.color = (1,0,0);
	while(param_00.inuse)
	{
		wait(0.05);
	}

	maps\mp\_utility::func_5D5B();
}

//Function Number: 13
func_4CB5(param_00,param_01)
{
	self endon("disconnect");
	var_02 = 90;
	if(!issplitscreen())
	{
		var_02 = 135;
	}

	var_03 = maps\mp\gametypes\_hud_util::createtimer("hudsmall",1);
	var_03 maps\mp\gametypes\_hud_util::func_70A4("CENTER",undefined,0,var_02);
	var_03.label = &"MP_HORDE_BLEED_OUT";
	var_03.color = (0.804,0.804,0.035);
	var_03.archived = 0;
	var_03.showinkillcam = 0;
	var_03 settimer(param_00 - 1);
	param_01 waittill("death");
	if(!isdefined(var_03))
	{
	}

	var_03 notify("destroying");
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 14
func_4CAA()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	for(;;)
	{
		wait(1.5);
		var_00 = self getcurrentprimaryweapon();
		if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_00))
		{
			continue;
		}

		var_01 = self getweaponammostock(var_00);
		var_02 = weaponclipsize(var_00);
		if(var_01 < var_02)
		{
			self setweaponammostock(var_00,var_02);
		}
	}
}

//Function Number: 15
func_5B9A(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	if(!isplayer(param_00))
	{
	}

	while(maps\mp\gametypes\_horde_util::func_4934(param_00) && param_00.horde_perks.size > 0)
	{
		var_01 = param_00.horde_perks[param_00.horde_perks.size - 1]["name"];
		var_02 = param_00.horde_perks[param_00.horde_perks.size - 1]["index"];
		param_00 thread func_3410(var_02);
		var_03 = param_00 common_scripts\utility::waittill_any_return_no_endon_death("remove_perk","death","revive");
		if(var_03 == "death")
		{
		}

		if(var_03 == "revive")
		{
			if(isdefined(param_00.flashingperkindex))
			{
				if(param_00.flashingperkindex == var_02)
				{
					param_00 setclientomnvar("ui_horde_update_perk",var_02);
					param_00.flashingperkindex = undefined;
				}
			}
		}

		if(var_03 == "remove_perk")
		{
			param_00 setclientomnvar("ui_horde_update_perk",var_02 * -1);
			param_00 maps\mp\_utility::_unsetperk(var_01);
			param_00.horde_perks = array_remove_perk(param_00.horde_perks,var_01);
		}
	}
}

//Function Number: 16
array_remove_perk(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(var_04["name"] != param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 17
func_3410(param_00)
{
	self endon("death");
	self endon("revive");
	wait(0.5);
	self setclientomnvar("ui_horde_update_perk",param_00);
	self.flashingperkindex = param_00;
	wait(8);
	self notify("remove_perk");
}