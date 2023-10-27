/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_intel.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 22
 * Decompile Time: 367 ms
 * Timestamp: 10/27/2023 1:31:08 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level thread populateintelchallenges();
	level.intelactive = 0;
	if(!isdefined(level.supportintel) || level.supportintel)
	{
		level thread func_595D();
	}

	if(isdefined(level.enableteamintel) && isdefined(level.enableteamintel))
	{
		level thread runteamintel();
	}
}

//Function Number: 2
populateintelchallenges()
{
	level endon("game_ended");
	wait(0.05);
	level.intelchallengearray = [];
	var_00 = level.gametype == "sd" || level.gametype == "sr";
	var_01 = 0;
	for(;;)
	{
		var_02 = tablelookupbyrow("mp/intelChallenges.csv",var_01,0);
		var_03 = castint(tablelookupbyrow("mp/intelChallenges.csv",var_01,2));
		var_04 = castint(tablelookupbyrow("mp/intelChallenges.csv",var_01,3));
		var_05 = castint(tablelookupbyrow("mp/intelChallenges.csv",var_01,4)) == 1;
		var_06 = castint(tablelookupbyrow("mp/intelChallenges.csv",var_01,5)) == 1;
		var_07 = castint(tablelookupbyrow("mp/intelChallenges.csv",var_01,6)) == 1;
		var_01++;
		if(var_02 == "")
		{
			break;
		}

		if(var_00 && !var_05)
		{
			continue;
		}

		level.intelchallengearray[var_02] = addstruct();
		level.intelchallengearray[var_02].challengename = var_02;
		level.intelchallengearray[var_02].challengereward = var_03;
		level.intelchallengearray[var_02].challengetarget = var_04;
		level.intelchallengearray[var_02].teamchallenge = var_06;
		level.intelchallengearray[var_02].juggchallenge = var_07;
	}
}

//Function Number: 3
runteamintel()
{
	level endon("game_ended");
	level.nummeleekillsintel = 0;
	level.numheadshotsintel = 0;
	level.numkillstreakkillsintel = 0;
	level.numequipmentkillsintel = 0;
	for(;;)
	{
		level waittill("giveTeamIntel",var_00);
		var_01 = [];
		foreach(var_03 in level.intelchallengearray)
		{
			if(!var_03.teamchallenge)
			{
				continue;
			}

			var_01[var_01.size] = var_03;
		}

		var_05 = var_01[randomint(var_01.size)];
		var_06 = var_05.challengename;
		level maps\mp\gametypes\_intelchallenges::func_3D12(var_06,var_00);
	}
}

//Function Number: 4
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_4680();
	}
}

//Function Number: 5
func_4680(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("death",var_01);
		if(isdefined(self.hasintel) && self.hasintel)
		{
			if((isdefined(self.onhelisniper) && self.onhelisniper) || self.sessionstate == "spectator")
			{
				self.hasintel = 0;
				level thread func_6305();
			}
			else
			{
				func_591B();
			}

			continue;
		}

		if(!level.intelactive)
		{
			if(level.teambased && isdefined(var_01) && isdefined(var_01.team) && var_01.team == self.team)
			{
				continue;
			}

			level.intelactive = 1;
			func_591B(1);
		}
	}
}

//Function Number: 6
func_591B(param_00)
{
	self.hasintel = 0;
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = self.origin;
	if(isdefined(self.inteldeathposition))
	{
		var_01 = self.inteldeathposition;
		self.inteldeathposition = undefined;
	}

	var_02 = getgroundposition(var_01,42,1000,72);
	var_03 = var_01 + (0,0,32);
	if(param_00)
	{
		var_04 = spawn("script_model",var_03);
		var_04.angles = (0,0,0);
		var_04 setmodel("com_metal_briefcase_intel");
		var_05 = spawn("trigger_radius",var_01,0,96,60);
		var_05.id = "intel";
		var_06 = [];
		var_06["visuals"] = var_04;
		var_06["trigger"] = var_05;
		var_06["owner"] = "none";
		var_06["isActive"] = 1;
		var_06["firstTriggerPlayer"] = undefined;
		var_06["useRate"] = 1;
		var_06["useTime"] = 0.5;
		var_06["useProgress"] = 0;
		var_06["dropped_time"] = gettime();
		level.intelent = var_06;
		level.intelent["trigger"] enablelinkto();
	}
	else
	{
		if(isdefined(level.intelent["visuals"] getlinkedparent()))
		{
			level.intelent["visuals"] unlink();
			level.intelent["trigger"] unlink();
		}

		level.intelent["visuals"] hide();
		level.intelent["visuals"].origin = var_03;
		level.intelent["trigger"].origin = var_02;
	}

	if(level.intelent["visuals"] maps\mp\_utility::func_818D())
	{
		level.intelent["isActive"] = 0;
		level.intelent["visuals"] hide();
		level thread func_6305();
	}

	level.intelent["owner"] = "none";
	level.intelent["isActive"] = 1;
	level.intelent["dropped_time"] = gettime();
	level.intelent["visuals"] scriptmodelplayanim("mp_briefcase_spin");
	thread func_4695();
	level.intelent thread func_4681();
}

//Function Number: 7
func_467F(param_00)
{
	level.intelent["isActive"] = 0;
	level.intelent["visuals"] hide();
	level thread func_6305();
}

//Function Number: 8
func_4695()
{
	level notify("intelTriggerWatcher");
	level endon("intelTriggerWatcher");
	level endon("game_ended");
	level.intelent["visuals"] endon("pickedUp");
	var_00 = level.intelent["trigger"];
	var_01 = addstruct();
	var_01.linkparent = self getmovingplatformparent();
	var_01.endonstring = "intelTriggerWatcher";
	var_01.deathoverridecallback = ::func_467F;
	level.intelent["visuals"] thread maps\mp\_movers::func_3F25(var_01);
	level.intelent["trigger"] linkto(level.intelent["visuals"]);
	wait(0.05);
	level.intelent["visuals"] show();
	for(;;)
	{
		var_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		if(isai(var_02))
		{
			continue;
		}

		if(!isalive(var_02) || isdefined(var_02.fauxdead) && var_02.fauxdead)
		{
			continue;
		}

		if(level.intelent["isActive"])
		{
			if(isdefined(var_02.hasintel) && var_02.hasintel)
			{
				continue;
			}

			var_03 = var_00 func_6229(var_02);
			if(var_03)
			{
				var_02 func_5959();
			}
		}
	}
}

//Function Number: 9
func_4681()
{
	level.intelent["visuals"] endon("pickedUp");
	for(;;)
	{
		if(gettime() > level.intelent["dropped_time"] + -5536)
		{
			break;
		}

		wait(1);
	}

	level.intelent["isActive"] = 0;
	level.intelent["visuals"] hide();
	level thread func_6305();
}

//Function Number: 10
func_5959()
{
	self.hasintel = 1;
	level.intelent["isActive"] = 0;
	level.intelent["visuals"] hide();
	level.intelent["owner"] = self;
	var_00 = [];
	thread maps\mp\gametypes\_rank::giverankxp("challenge",100);
	if(maps\mp\_utility::isjuggernaut())
	{
		foreach(var_02 in level.intelchallengearray)
		{
			var_03 = var_02.challengename;
			if(!var_02.juggchallenge)
			{
				continue;
			}

			if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1)
			{
				if(!issubstr(var_03,"maniac"))
				{
					continue;
				}
			}
			else if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
			{
				if(!issubstr(var_03,"recon"))
				{
					continue;
				}
			}
			else if(!issubstr(var_03,"assault"))
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}
	}
	else
	{
		var_05 = maps\mp\_utility::getotherteam(self.team);
		var_06 = level.teamcount[var_05];
		var_07 = level.alivecount[var_05];
		var_08 = undefined;
		var_08 = getdvarint("scr_player_lives") == 0;
		var_09 = self getweaponslistprimaries();
		foreach(var_02 in level.intelchallengearray)
		{
			var_03 = var_02.challengename;
			var_0B = var_02.challengetarget;
			if(!var_08)
			{
				if(var_03 == "ch_intel_tbag" || var_0B > var_07)
				{
					continue;
				}
			}

			if(var_03 == "ch_intel_secondarykills" && intelcancomplete_secondarykills(self,var_09) == 0)
			{
				continue;
			}

			if(var_03 == "ch_intel_explosivekill" && intelcancomplete_explosivekill(self,var_09) == 0)
			{
				continue;
			}

			if(var_02.teamchallenge)
			{
				continue;
			}

			if(var_02.juggchallenge)
			{
				continue;
			}

			var_00[var_00.size] = var_02;
		}
	}

	var_0D = var_00[randomint(var_00.size)];
	var_0E = var_0D.challengename;
	if(maps\mp\_utility::isjuggernaut())
	{
		maps\mp\gametypes\_intelchallenges::givejuggernautchallenge(var_0E);
	}
	else
	{
		maps\mp\gametypes\_intelchallenges::func_3CE3(var_0E);
		thread watchforjuggernaut();
	}

	thread func_8CEC();
	thread func_9598();
	level.intelent["visuals"] notify("pickedUp");
}

//Function Number: 11
intelcancomplete_secondarykills(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_01)
	{
		if(maps\mp\_utility::func_4890(var_04))
		{
			if(param_00 getammocount(var_04) > 0)
			{
				var_02 = 1;
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 12
intelcancomplete_explosivekill(param_00,param_01)
{
	var_02 = 0;
	if(self.loadoutperkequipment != "specialty_null" && !issubstr(self.loadoutperkequipment,"throwingknife"))
	{
		var_03 = param_00 getammocount(self.loadoutperkequipment);
		if(var_03 > 0)
		{
			var_02 = 1;
		}
	}

	if(var_02 == 0)
	{
		foreach(var_05 in param_01)
		{
			var_06 = weaponclass(var_05);
			if((var_06 == "rocketlauncher" || var_06 == "grenade") && param_00 getammocount(var_05) > 0)
			{
				var_02 = 1;
				break;
			}
			else
			{
				var_07 = weaponaltweaponname(var_05);
				if(isdefined(var_07) && weaponclass(var_07) == "grenade" && param_00 getammocount(var_07) > 0)
				{
					var_02 = 1;
					break;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 13
watchforjuggernaut()
{
	self endon("death");
	self endon("intel_cleanup");
	for(;;)
	{
		level waittill("juggernaut_equipped");
		waittillframeend;
		if(maps\mp\_utility::isjuggernaut())
		{
			thread updatejuggintel();
		}
	}
}

//Function Number: 14
updatejuggintel()
{
	self notify("intel_cleanup");
	self setclientomnvar("ui_intel_active_index",-1);
	func_5959();
}

//Function Number: 15
func_8CEC()
{
	self endon("death");
	self endon("intel_cleanup");
	self waittill("disconnect");
	level thread func_6305();
}

//Function Number: 16
func_9598()
{
	self endon("death");
	self endon("intel_cleanup");
	self endon("stopped_using_remote");
	self waittill("using_remote");
	self.inteldeathposition = self.origin;
	thread func_9555();
}

//Function Number: 17
func_9555()
{
	self endon("death");
	self endon("intel_cleanup");
	self waittill("stopped_using_remote");
	self.inteldeathposition = undefined;
	thread func_9598();
}

//Function Number: 18
func_6305()
{
	level notify("randAssignIntel");
	level endon("randAssignIntel");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = maps\mp\_utility::getrandomplayingplayer();
		if(!isdefined(var_00))
		{
			continue;
		}

		var_00.hasintel = 1;
		level.intelent["owner"] = var_00;
		var_00 thread func_8CEC();
		break;
	}
}

//Function Number: 19
func_11F5(param_00)
{
	self endon("disconnect");
	func_65C4();
	self.hasintel = 0;
	var_01 = level.intelchallengearray[param_00];
	var_02 = var_01.challengename;
	var_03 = castint(var_01.challengereward);
	self setclientomnvar("ui_intel_active_index",-1);
	thread maps\mp\killstreaks\_killstreaks::func_3CF2("airdrop_assault",0,0,self);
	thread maps\mp\gametypes\_hud_message::func_794D(var_02,var_03);
	thread maps\mp\gametypes\_rank::giverankxp("intel",var_03);
	level thread func_6305();
	self thread [[ level.leaderdialogonplayer_func ]]("achieve_carepackage",undefined,undefined,self.origin);
	maps\mp\gametypes\_missions::func_61CE("ch_intelligence");
	self notify("intel_cleanup");
}

//Function Number: 20
func_65C4()
{
	var_00 = self getweaponslistall();
	foreach(var_02 in var_00)
	{
		if(maps\mp\_utility::func_48F7(var_02))
		{
			continue;
		}
		else
		{
			if(weaponinventorytype(var_02) == "offhand")
			{
				if((var_02 == self.loadoutperkequipment && maps\mp\_utility::_hasperk("specialty_extra_deadly")) || var_02 == self.loadoutperkoffhand && maps\mp\_utility::_hasperk("specialty_extra_equipment"))
				{
					self setweaponammoclip(var_02,2);
				}
				else
				{
					self setweaponammoclip(var_02,1);
				}

				continue;
			}

			self givemaxammo(var_02);
		}
	}
}

//Function Number: 21
func_6229(param_00)
{
	if(!isdefined(self))
	{
		return 0;
	}

	self.inuse = 1;
	var_01 = func_622A(param_00);
	if(!isdefined(self))
	{
		return 0;
	}

	level.intelent["useProgress"] = 0;
	return var_01;
}

//Function Number: 22
func_622A(param_00)
{
	self.userate = level.intelent["useRate"];
	self.usetime = level.intelent["useTime"];
	self.curprogress = 0;
	while(!level.gameended && isdefined(self) && maps\mp\_utility::func_4945(param_00))
	{
		if(function_0210(self.origin,param_00.origin) > -28672)
		{
			break;
		}

		level.intelent["useProgress"] = level.intelent["useProgress"] + 0.05 * self.userate;
		self.curprogress = level.intelent["useProgress"];
		param_00 maps\mp\gametypes\_gameobjects::func_874E(self,1);
		if(level.intelent["useProgress"] >= self.usetime)
		{
			param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
			return maps\mp\_utility::func_4945(param_00);
		}

		wait(0.05);
	}

	param_00 maps\mp\gametypes\_gameobjects::func_874E(self,0);
	return 0;
}