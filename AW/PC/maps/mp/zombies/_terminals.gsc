/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_terminals.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 124
 * Decompile Time: 1846 ms
 * Timestamp: 4/22/2024 2:13:59 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheterminalfx();
	level.terminalitems = [];
	var_00 = initterminalitem("exo_suit",&"ZOMBIES_EXO_SUIT",&"ZOMBIES_BUY_EXO_SUIT",0,0,"ui_zm_exo_suit");
	var_00 setteminalfx("station_buy_exo_pwr_on","station_buy_exo_pwr_off");
	var_00 = initterminalitem("exo_health",&"ZOMBIES_PERK_HEALTH",&"ZOMBIES_BUY_PERK_HEALTH",2500,1,"ui_zm_exo_health");
	var_00 setteminalfx("station_upgrade_exo_health_pwr_on","station_upgrade_exo_health_pwr_off");
	var_00 = initterminalitem("specialty_fastreload",&"ZOMBIES_PERK_RELOAD",&"ZOMBIES_BUY_PERK_RELOAD",2000,1,"ui_zm_exo_reload");
	var_00 setteminalfx("station_upgrade_exo_reload_pwr_on","station_upgrade_exo_reload_pwr_off");
	if(!maps\mp\zombies\_util::iszombieshardmode())
	{
		var_00 = initterminalitem("exo_revive",&"ZOMBIES_PERK_REVIVE",&"ZOMBIES_BUY_PERK_REVIVE",1500,1,"ui_zm_exo_revive");
		var_00 setsolooverrides(500,0,3);
		var_00 setteminalfx("station_upgrade_exo_revive_pwr_on","station_upgrade_exo_revive_pwr_off");
	}

	var_00 = initterminalitem("exo_stabilizer",&"ZOMBIES_PERK_STABILIZER",&"ZOMBIES_BUY_PERK_STABILIZER",1750,1,"ui_zm_exo_stabilizer");
	var_00 setteminalfx("station_upgrade_exo_stabilizer_pwr_on","station_upgrade_exo_stabilizer_pwr_off");
	var_00 = initterminalitem("exo_slam",&"ZOMBIES_PERK_SLAM",&"ZOMBIES_BUY_PERK_SLAM",2000,1,"ui_zm_exo_slam");
	var_00 setteminalfx("station_upgrade_exo_slam_pwr_on","station_upgrade_exo_slam_pwr_off");
	var_00 = initterminalitem("exo_tacticalArmor",&"ZOMBIES_PERK_TACTICALARMOR",&"ZOMBIES_BUY_PERK_TACTICALARMOR",2000,1,"ui_zm_exo_tacticalarmor");
	var_00 setteminalfx("station_upgrade_exo_tactarmor_pwr_on","station_upgrade_exo_tactarmor_pwr_off");
	initterminalitem("host_cure",&"ZOMBIES_HOST_CURE",&"ZOMBIES_BUY_HOST_CURE",250,0);
	initterminalitem("atm",&"ZOMBIES_MONEY",&"ZOMBIES_BUY_MONEY",0,0);
	level.hostcuremodels = [];
	level.terminals = [];
	initterminals("perk_terminal",::perkterminaltriggerthink);
	initterminals("exo_terminal",::perkterminaltriggerthink);
	initterminals("atm_terminal",::atmterminalthink,::atmterminalroundupdate);
	if(!maps\mp\zombies\_util::iszombieshardmode() && isdefined(level.terminals["exo_revive"]))
	{
		var_01 = level.terminals["exo_revive"];
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			for(var_03 = var_02 + 1;var_03 < var_01.size;var_03++)
			{
				if(isdefined(var_01[var_02].script_index) && isdefined(var_01[var_03].script_index) && var_01[var_02].script_index == var_01[var_03].script_index)
				{
					var_01[var_02].linkedterminal = var_01[var_03];
					var_01[var_03].linkedterminal = var_01[var_02];
				}
			}
		}
	}

	precacheterminalanims();
	level thread playercountwatch();
}

//Function Number: 2
onplayerspawn()
{
	self.zm_perks = [];
	maps\mp\_utility::playerallowhighjumpdrop(0,"exoSlam");
	self setclientomnvar("ui_zm_exo_slam_next_time",0);
	foreach(var_01 in level.terminalitems)
	{
		if(isdefined(var_01.omnvar))
		{
			self setclientomnvar(var_01.omnvar,0);
		}
	}

	perkupdatesortorder();
}

//Function Number: 3
playercountwatch()
{
	for(;;)
	{
		var_00 = level.players.size;
		while(var_00 == level.players.size)
		{
			wait 0.05;
		}

		level notify("playerCountUpdate");
	}
}

//Function Number: 4
precacheterminalanims()
{
	if(getiteminmap("host_cure"))
	{
		precachempanim("xom_host_cure_station_start");
		precachempanim("xom_host_cure_station_loop");
		precachempanim("xom_host_cure_station_stop");
	}
}

//Function Number: 5
precacheterminalfx()
{
	level._effect["zombie_exo_slam"] = loadfx("vfx/gameplay/mp/zombie/dlc_exo_slam_impact");
	level._effect["zombie_host_cure"] = loadfx("vfx/props/dlc_prop_health_station_cure");
	level._effect["zombie_host_cure_idle"] = loadfx("vfx/props/dlc_prop_health_station_idle");
	level._effect["zombie_host_cure_cooldown"] = loadfx("vfx/props/dlc_prop_health_station_cooldown");
	level._effect["exo_equip"] = loadfx("vfx/props/dlc_prop_exo_buy_fx_character");
	level._effect["atm_jackpot"] = loadfx("vfx/props/dlc_prop_cashbox_cash_shooter");
}

//Function Number: 6
initterminalitem(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.name = param_00;
	var_06.locname = param_01;
	var_06.locbuyname = param_02;
	var_06.cost = param_03;
	var_06.requiresexo = param_04;
	var_06.inmap = 0;
	var_06.omnvar = param_05;
	var_06.numbuys = 0;
	var_06.maxbuys = -1;
	level.terminalitems[param_00] = var_06;
	return var_06;
}

//Function Number: 7
setsolooverrides(param_00,param_01,param_02)
{
	self.costsolo = param_00;
	self.requiresexosolo = param_01;
	self.maxbuyssolo = param_02;
}

//Function Number: 8
setteminalfx(param_00,param_01)
{
	self.onfx = common_scripts\utility::getfx(param_00);
	self.offfx = common_scripts\utility::getfx(param_01);
}

//Function Number: 9
hasexosuit()
{
	return isdefined(self.exosuitonline) && self.exosuitonline;
}

//Function Number: 10
getitemlocname(param_00)
{
	return level.terminalitems[param_00].locname;
}

//Function Number: 11
getitemlocbuy(param_00)
{
	return level.terminalitems[param_00].locbuyname;
}

//Function Number: 12
getitemcostsolo(param_00)
{
	var_01 = level.terminalitems[param_00].costsolo;
	if(isdefined(level.penaltycostincrease))
	{
		for(var_02 = 0;var_02 < level.penaltycostincrease;var_02++)
		{
			var_03 = maps\mp\zombies\_util::getincreasedcost(var_01);
			var_01 = var_03;
		}
	}

	return var_01;
}

//Function Number: 13
getitemcost(param_00)
{
	if(isdefined(level.terminalitems[param_00].costsolo) && level.players.size == 1)
	{
		return getitemcostsolo(param_00);
	}

	var_01 = level.terminalitems[param_00].cost;
	if(isdefined(level.penaltycostincrease))
	{
		for(var_02 = 0;var_02 < level.penaltycostincrease;var_02++)
		{
			var_03 = maps\mp\zombies\_util::getincreasedcost(var_01);
			var_01 = var_03;
		}
	}

	return var_01;
}

//Function Number: 14
getitemrequiresexo(param_00)
{
	if(isdefined(level.terminalitems[param_00].requiresexosolo) && level.players.size == 1)
	{
		return level.terminalitems[param_00].requiresexosolo;
	}

	return level.terminalitems[param_00].requiresexo;
}

//Function Number: 15
getitemloccost(param_00)
{
	return maps\mp\zombies\_util::getcoststring(getitemcost(param_00));
}

//Function Number: 16
getiteminmap(param_00)
{
	return level.terminalitems[param_00].inmap;
}

//Function Number: 17
getitemomnvar(param_00)
{
	return level.terminalitems[param_00].omnvar;
}

//Function Number: 18
getitemnumbuys(param_00)
{
	return level.terminalitems[param_00].numbuys;
}

//Function Number: 19
getitemmaxsolobuys(param_00)
{
	return level.terminalitems[param_00].maxbuyssolo;
}

//Function Number: 20
getitemmaxbuys(param_00)
{
	if(isdefined(level.terminalitems[param_00].maxbuyssolo) && level.players.size == 1)
	{
		return level.terminalitems[param_00].maxbuyssolo;
	}

	return level.terminalitems[param_00].maxbuys;
}

//Function Number: 21
setiteminmap(param_00)
{
	level.terminalitems[param_00].inmap = 1;
}

//Function Number: 22
setitemusecount(param_00,param_01)
{
	level.terminalitems[param_00].numbuys = param_01;
}

//Function Number: 23
itemhasuses(param_00)
{
	var_01 = getitemmaxbuys(param_00);
	return var_01 < 0 || var_01 > getitemnumbuys(param_00);
}

//Function Number: 24
getitemtype()
{
	if(isdefined(self.script_parameters))
	{
		return self.script_parameters;
	}

	switch(self.targetname)
	{
		case "exo_terminal":
			return "exo_suit";

		default:
			return "none";
	}
}

//Function Number: 25
getterminaltrigger()
{
	switch(self.itemtype)
	{
		case "atm":
			return getent(self.target,"targetname");

		default:
			return self;
	}
}

//Function Number: 26
getterminalmodel()
{
	switch(self.itemtype)
	{
		case "host_cure":
			return undefined;

		case "exo_tacticalArmor":
		case "exo_slam":
		case "exo_stabilizer":
		case "exo_revive":
		case "specialty_fastreload":
		case "exo_suit":
		case "exo_health":
			return getent(self.target,"targetname");

		default:
			return self;
	}
}

//Function Number: 27
getterminallight()
{
	switch(self.itemtype)
	{
		case "exo_tacticalArmor":
		case "exo_slam":
		case "exo_stabilizer":
		case "exo_revive":
		case "specialty_fastreload":
		case "exo_suit":
		case "exo_health":
			var_00 = getent(self.target,"targetname");
			if(isdefined(var_00) && isdefined(var_00.target))
			{
				return getent(var_00.target,"targetname");
			}
	
			break;

		default:
			break;
	}
}

//Function Number: 28
getterminalhintstring(param_00)
{
	var_01 = terminal_has_power();
	var_02 = 0;
	var_03 = itemhasuses(self.itemtype);
	var_04 = maps\mp\zombies\_util::is_true(self.terminaldisabled);
	if(var_04)
	{
		return "";
	}

	var_05 = self.itemtype == "exo_suit";
	if(isdefined(param_00))
	{
		var_02 = param_00 perkterminalhasexosuit("exo_suit") || !getitemrequiresexo(self.itemtype) && !var_05;
		if(self.itemtype != "host_cure" && !var_05)
		{
			if(!var_03)
			{
				return &"ZOMBIES_ALL_USED";
			}
			else if(!var_02)
			{
				return &"ZOMBIES_REQUIRES_EXO";
			}
			else if(!var_01)
			{
				return &"ZOMBIES_REQUIRES_POWER";
			}
		}
	}

	switch(self.itemtype)
	{
		case "exo_slam":
			if(!param_00 perkterminalhasexoslam(self.itemtype))
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "exo_health":
			if(!param_00 perkterminalhasexohealth(self.itemtype))
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "exo_revive":
			if(!param_00 perkterminalhasexorevive(self.itemtype))
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "exo_stabilizer":
			if(!param_00 perkterminalhasexostabilizer(self.itemtype))
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "specialty_fastreload":
			if(!param_00 perkterminalhas(self.itemtype))
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "exo_tacticalArmor":
			if(!param_00 perkterminalhasexotacticalarmor(self.itemtype))
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "host_cure":
			if(!var_01)
			{
				return &"ZOMBIES_REQUIRES_POWER";
			}
			else if(perkterminalcoolingdown())
			{
				return &"ZOMBIES_CURE_COOLDOWN_HINT";
			}
			else if(maps\mp\zombies\_util::is_true(self.terminalrunning))
			{
				return &"ZOMBIES_CURE_ACTIVE_HINT";
			}
			else
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		case "exo_suit":
			if(!var_01)
			{
				return &"ZOMBIES_REQUIRES_POWER";
			}
			else if(!var_02)
			{
				return getitemlocbuy(self.itemtype);
			}
			break;

		default:
			break;
	}

	return "";
}

//Function Number: 29
getterminalsecondaryhintstring(param_00)
{
	var_01 = terminal_has_power();
	var_02 = 0;
	var_03 = itemhasuses(self.itemtype);
	var_04 = maps\mp\zombies\_util::is_true(self.terminaldisabled);
	self.showtokenstring = 0;
	if(var_04)
	{
		return "";
	}

	var_05 = self.itemtype == "exo_suit";
	if(isdefined(param_00))
	{
		var_02 = param_00 perkterminalhasexosuit("exo_suit") || !getitemrequiresexo(self.itemtype) && !var_05;
		if(self.itemtype != "host_cure" && !var_05)
		{
			if(!var_03)
			{
				return "";
			}
			else if(!var_01 && !var_02)
			{
				return &"ZOMBIES_REQUIRES_POWER";
			}
			else if(!var_02 || !var_01)
			{
				return "";
			}
		}
	}

	switch(self.itemtype)
	{
		case "exo_slam":
			if(level.currentgen && param_00 perkterminalhasexoslam(self.itemtype))
			{
				return "";
			}
	
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			return getitemloccost(self.itemtype);

		case "exo_health":
			if(level.currentgen && param_00 perkterminalhasexohealth(self.itemtype))
			{
				return "";
			}
	
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			return getitemloccost(self.itemtype);

		case "exo_revive":
			if(level.currentgen && param_00 perkterminalhasexorevive(self.itemtype))
			{
				return "";
			}
	
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			return getitemloccost(self.itemtype);

		case "exo_stabilizer":
			if(level.currentgen && param_00 perkterminalhasexostabilizer(self.itemtype))
			{
				return "";
			}
	
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			return getitemloccost(self.itemtype);

		case "specialty_fastreload":
			if(level.currentgen && param_00 perkterminalhasexofastreload(self.itemtype))
			{
				return "";
			}
	
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			return getitemloccost(self.itemtype);

		case "exo_tacticalArmor":
			if(level.currentgen && param_00 perkterminalhasexotacticalarmor(self.itemtype))
			{
				return "";
			}
	
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			return getitemloccost(self.itemtype);

		case "host_cure":
			if(var_01 && !perkterminalcoolingdown() || maps\mp\zombies\_util::is_true(self.terminalrunning))
			{
				self.showtokenstring = getitemcost(self.itemtype) > 0;
				return getitemloccost(self.itemtype);
			}
			break;

		case "exo_suit":
			self.showtokenstring = getitemcost(self.itemtype) > 0;
			break;

		default:
			break;
	}

	return "";
}

//Function Number: 30
terminalhintstringupdate(param_00)
{
	param_00 endon("disconnect");
	thread terminalupdatehintstringonconnect(param_00);
	thread terminalupdatehintstringondisconnect(param_00);
	thread terminalupdatehintstringpower(param_00);
	for(;;)
	{
		waittillframeend;
		var_01 = getterminalhintstring(param_00);
		self sethintstring(var_01);
		var_02 = getterminalsecondaryhintstring(param_00);
		self setsecondaryhintstring(var_02);
		maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(getitemcost(self.itemtype)));
		maps\mp\zombies\_util::tokenhintstring(self.showtokenstring);
		self setcursorhint("HINT_NOICON");
		param_00 common_scripts\utility::waittill_any("terminal_activated","terminalPlayerConnected","terminalPlayerDisconnected","terminalPowerActivated","player_infected","take_perk");
	}
}

//Function Number: 31
cg_onplayerconnectedterminalhintstringupdate(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		param_00 thread cg_terminalhintstringupdate(var_01);
	}
}

//Function Number: 32
cg_terminalhintstringupdate(param_00)
{
	param_00 endon("disconnect");
	thread terminalupdatehintstringonconnect(param_00);
	thread terminalupdatehintstringondisconnect(param_00);
	thread terminalupdatehintstringpower(param_00);
	maps\mp\zombies\_util::cg_setupstorestrings(param_00);
	for(;;)
	{
		while(!param_00 istouching(self))
		{
			wait(0.1);
		}

		waittillframeend;
		param_00.storedescription settext(getterminalhintstring(param_00));
		param_00.storecost settext(getterminalsecondaryhintstring(param_00));
		cg_terminalwaittilltriggerexit(param_00);
		param_00.storedescription settext("");
		param_00.storecost settext("");
	}
}

//Function Number: 33
cg_terminalwaittilltriggerexit(param_00)
{
	param_00 endon("terminalStateChange");
	childthread cg_terminalwaittillstatechange(param_00);
	while(param_00 istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 34
cg_terminalwaittillstatechange(param_00)
{
	param_00 common_scripts\utility::waittill_any("terminal_activated","terminalPlayerConnected","terminalPlayerDisconnected","terminalPowerActivated","player_infected","take_perk");
	param_00 notify("terminalStateChange");
}

//Function Number: 35
terminalupdatehintstringsmulticlient()
{
	thread terminalupdatehintstringonconnect();
	thread terminalupdatehintstringpower();
	for(;;)
	{
		waittillframeend;
		self setcursorhint("HINT_NOICON");
		var_00 = getterminalhintstring();
		self sethintstring(var_00);
		var_01 = getterminalsecondaryhintstring();
		self setsecondaryhintstring(var_01);
		maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(getitemcost(self.itemtype)));
		maps\mp\zombies\_util::tokenhintstring(self.showtokenstring);
		level common_scripts\utility::waittill_any("terminal_activated","terminalPlayerConnected","terminalPowerActivated","player_infected","terminal_cooldown_ended","terminal_cooldown_started","terminal_disabled","terminal_reenabled");
	}
}

//Function Number: 36
terminalupdatehintstringpower(param_00)
{
	if(isdefined(param_00))
	{
		param_00 endon("disconnect");
	}

	if(!terminal_requires_power())
	{
		return;
	}

	for(;;)
	{
		common_scripts\utility::flag_wait(self.script_flag_true);
		if(isdefined(param_00))
		{
			param_00 notify("terminalPowerActivated");
		}

		level notify("terminalPowerActivated");
		common_scripts\utility::flag_waitopen(self.script_flag_true);
		if(isdefined(param_00))
		{
			param_00 notify("terminalPowerActivated");
		}

		level notify("terminalPowerActivated");
	}
}

//Function Number: 37
terminalupdatehintstringonconnect(param_00)
{
	if(isdefined(param_00))
	{
		param_00 endon("disconnect");
	}

	if(!isdefined(level.terminalitems[self.itemtype].costsolo))
	{
		return;
	}

	for(;;)
	{
		level waittill("connected");
		if(isdefined(param_00))
		{
			param_00 notify("terminalPlayerConnected");
		}

		level notify("terminalPlayerConnected");
	}
}

//Function Number: 38
terminalupdatehintstringondisconnect(param_00)
{
	if(!isdefined(level.terminalitems[self.itemtype].costsolo))
	{
		return;
	}

	param_00 waittill("disconnect");
	foreach(param_00 in level.players)
	{
		param_00 notify("terminalPlayerDisconnected");
	}
}

//Function Number: 39
initterminals(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_05.itemtype = var_05 getitemtype();
		if(maps\mp\zombies\_util::iszombieshardmode() && var_05.itemtype == "exo_revive")
		{
			var_06 = var_05 getterminallight();
			if(isdefined(var_06))
			{
				var_06 setlightintensity(0);
			}

			var_05 delete();
			continue;
		}

		if(isdefined(var_05.script_flag_true) && !common_scripts\utility::flag_exist(var_05.script_flag_true))
		{
			common_scripts\utility::flag_init(var_05.script_flag_true);
		}

		setiteminmap(var_05.itemtype);
		var_07 = var_05 getterminaltrigger();
		var_05.trigger = var_07;
		var_07.modelent = var_05 getterminalmodel();
		var_07.light = var_05 getterminallight();
		if(!isdefined(level.terminals[var_05.itemtype]))
		{
			level.terminals[var_05.itemtype] = [];
		}

		var_08 = level.terminals[var_05.itemtype].size;
		level.terminals[var_05.itemtype][var_08] = var_05;
		var_07.itemtype = var_05.itemtype;
		if(level.nextgen)
		{
			if(maps\mp\zombies\_util::isusetriggerforsingleclient(var_07))
			{
				maps\mp\zombies\_util::setupusetriggerforclient(var_07,::terminalhintstringupdate);
			}
			else if(param_00 != "atm_terminal")
			{
				var_07 thread terminalupdatehintstringsmulticlient();
			}
		}
		else if(param_00 != "atm_terminal")
		{
			foreach(var_0A in level.players)
			{
				var_07 thread cg_terminalhintstringupdate(var_0A);
			}

			thread cg_onplayerconnectedterminalhintstringupdate(var_07);
		}

		var_07 thread [[ param_01 ]]();
	}

	if(isdefined(param_02))
	{
		thread [[ param_02 ]](var_03);
	}
}

//Function Number: 40
atmterminalroundupdate(param_00)
{
	var_01 = 1;
	for(;;)
	{
		level waittill("zombie_wave_ended");
		var_02 = 0;
		var_03 = 0;
		var_04 = 1;
		foreach(var_06 in param_00)
		{
			if(var_06.trigger.active)
			{
				var_02++;
			}

			if(var_06.trigger.activationcount < var_01)
			{
				var_04 = 0;
			}
		}

		if(var_04)
		{
			var_01++;
		}

		param_00 = common_scripts\utility::array_randomize(param_00);
		for(var_08 = 0;var_08 < param_00.size && var_02 < 4 && var_03 < 2;var_08++)
		{
			if(param_00[var_08].trigger.active)
			{
				continue;
			}

			if(param_00[var_08].trigger.activationcount >= var_01)
			{
				continue;
			}

			param_00[var_08].trigger notify("atm_on");
			var_02++;
			var_03++;
		}
	}
}

//Function Number: 41
atmterminalthink()
{
	self.activationcount = 0;
	self.usedcount = 0;
	self.forcejackpot = 0;
	thread atmterminalfx();
	maps\mp\_utility::gameflagwait("prematch_done");
	var_00 = 0.01;
	for(;;)
	{
		self.active = 0;
		self sethintstring(&"ZOMBIES_EMPTY_STRING");
		self waittill("atm_on");
		self.activationcount++;
		self.active = 1;
		self sethintstring(getitemlocbuy(self.itemtype));
		self waittill("trigger",var_01);
		self.usedcount++;
		var_02 = randomfloat(1) < var_00 || self.forcejackpot;
		if(var_02)
		{
			self.forcejackpot = 0;
			self sethintstring(&"ZOMBIES_EMPTY_STRING");
			atmjackpot();
		}
		else
		{
			var_01 maps\mp\gametypes\zombies::givepointsforevent("atm",undefined,1);
			var_01 playlocalsound("interact_credit_machine");
		}

		self notify("atm_off");
	}
}

//Function Number: 42
atmjackpot()
{
	playfx(common_scripts\utility::getfx("atm_jackpot"),self.modelent.origin,anglestoforward(self.modelent.angles));
	var_00 = spawn("script_origin",self.modelent.origin);
	playsoundatpos(self.modelent.origin,"cash_machine_malfunction");
	maps\mp\zombies\_zombies_audio_announcer::announcerjackpotdialog(self.modelent.origin);
	wait(5);
	var_00 playloopsound("cash_machine_malfunction_loop");
	var_01 = 120;
	var_02 = var_01 * var_01;
	var_03 = 0.5;
	var_04 = anglestoforward(self.modelent.angles);
	for(var_05 = 0;var_05 < 100;var_05++)
	{
		foreach(var_07 in level.players)
		{
			var_08 = distance2dsquared(var_07.origin,self.modelent.origin);
			if(var_08 > var_02)
			{
				continue;
			}

			var_09 = var_07.origin - self.modelent.origin;
			var_09 = (var_09[0],var_09[1],0);
			var_09 = vectornormalize(var_09);
			var_0A = vectordot(var_09,var_04);
			if(var_0A < var_03)
			{
				continue;
			}

			var_07 maps\mp\gametypes\zombies::givepointsforevent("atm_jackpot");
		}

		wait(0.1);
	}

	playsoundatpos(self.modelent.origin,"cash_machine_malfunction_end");
	var_00 stoploopsound();
	wait 0.05;
	var_00 delete();
}

//Function Number: 43
atmterminalfx()
{
	for(;;)
	{
		self.modelent hidepart("TAG_SCREEN_ON");
		self.modelent showpart("TAG_SCREEN_OFF");
		thread audio_stop_atm_attract();
		self waittill("atm_on");
		self.modelent hidepart("TAG_SCREEN_OFF");
		self.modelent showpart("TAG_SCREEN_ON");
		self scalevolume(1,1);
		self playloopsound("interact_credit_machine_attract");
		self waittill("atm_off");
	}
}

//Function Number: 44
audio_stop_atm_attract()
{
	self scalevolume(0,1);
	wait(1);
	self stoploopsound();
}

//Function Number: 45
perkterminalhas(param_00)
{
	return self hasperk(param_00,1);
}

//Function Number: 46
perkterminalset(param_00,param_01)
{
	maps\mp\_utility::giveperk(param_00,0);
	self playrumbleonentity("damage_heavy");
}

//Function Number: 47
perkterminaltake(param_00)
{
	maps\mp\_utility::_unsetperk(param_00);
}

//Function Number: 48
perkterminalactivate(param_00)
{
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_exo"),self.modelent,"TAG_ORIGIN",1);
}

//Function Number: 49
perkterminalhasexohealth(param_00)
{
	return self.maxhealth == 200;
}

//Function Number: 50
perkterminalsetexohealth(param_00,param_01)
{
	self.maxhealth = 200;
	self.health = 200;
	var_02 = maps\mp\gametypes\zombies::getexosuitperkweaponname("health");
	var_03 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
	maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
}

//Function Number: 51
perkterminaltakeexohealth(param_00)
{
	self.maxhealth = 100;
}

//Function Number: 52
perkterminalhasexostabilizer(param_00)
{
	return self hasperk("specialty_bulletaccuracy",1);
}

//Function Number: 53
perkterminalsetexostabilizer(param_00,param_01)
{
	maps\mp\_utility::giveperk("specialty_bulletaccuracy",0);
	maps\mp\_utility::giveperk("specialty_sprintfire",0);
	maps\mp\_utility::giveperk("specialty_quickswap",0);
	maps\mp\_utility::giveperk("specialty_fastoffhand",0);
	var_02 = maps\mp\gametypes\zombies::getexosuitperkweaponname("stabilizer");
	var_03 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
	maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
}

//Function Number: 54
perkterminaltakeexostabilizer(param_00)
{
	maps\mp\_utility::_unsetperk("specialty_bulletaccuracy");
	maps\mp\_utility::_unsetperk("specialty_sprintfire");
	maps\mp\_utility::_unsetperk("specialty_quickswap");
	maps\mp\_utility::_unsetperk("specialty_fastoffhand");
}

//Function Number: 55
perkterminalhasexorevive(param_00)
{
	return maps\mp\zombies\_zombies_laststand::hasexostim();
}

//Function Number: 56
perkterminalsetexorevive(param_00,param_01)
{
	self.isexostimactive = 1;
	if(hasexosuit())
	{
		var_02 = maps\mp\gametypes\zombies::getexosuitperkweaponname("stim");
		var_03 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
		maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
	}
}

//Function Number: 57
perkterminaltakeexorevive(param_00)
{
	self.isexostimactive = 0;
}

//Function Number: 58
perkterminalhasexoslam(param_00)
{
	return isdefined(self.isexoslamactive) && self.isexoslamactive;
}

//Function Number: 59
perkterminalsetexoslam(param_00,param_01)
{
	self.isexoslamactive = 1;
	maps\mp\_utility::playerallowhighjumpdrop(1,"exoSlam");
	self setclientomnvar("ui_zm_exo_slam_next_time",0);
	var_02 = maps\mp\gametypes\zombies::getexosuitperkweaponname("slam");
	var_03 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
	maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
}

//Function Number: 60
perkterminaltakeexoslam(param_00)
{
	self.isexoslamactive = 0;
	self.exoslamnextusetime = undefined;
	maps\mp\_utility::playerallowhighjumpdrop(0,"exoSlam");
	self setclientomnvar("ui_zm_exo_slam_next_time",0);
}

//Function Number: 61
perkterminalhasexofastreload(param_00)
{
	return self hasperk("specialty_fastreload",1);
}

//Function Number: 62
perkterminalsetexofastreload(param_00,param_01)
{
	maps\mp\_utility::giveperk("specialty_fastreload",0);
	maps\mp\_utility::giveperk("specialty_sprintreload",0);
	var_02 = maps\mp\gametypes\zombies::getexosuitperkweaponname("fastreload");
	var_03 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
	maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
}

//Function Number: 63
perkterminaltakeexofastreload(param_00)
{
	maps\mp\_utility::_unsetperk("specialty_fastreload");
	maps\mp\_utility::_unsetperk("specialty_sprintreload");
}

//Function Number: 64
perkterminalhasexotacticalarmor(param_00)
{
	return self hasperk("specialty_stockpile",1);
}

//Function Number: 65
perkterminalsetexotacticalarmor(param_00,param_01)
{
	maps\mp\_utility::giveperk("specialty_stockpile",0);
	maps\mp\_utility::giveperk("specialty_extralethal",0);
	maps\mp\_utility::giveperk("specialty_extratactical",0);
	var_02 = maps\mp\gametypes\zombies::getexosuitperkweaponname("tacticalarmor");
	var_03 = maps\mp\gametypes\zombies::getexosuitperkweaponduration();
	maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
}

//Function Number: 66
perkterminaltakeexotacticalarmor(param_00)
{
	maps\mp\_utility::_unsetperk("specialty_stockpile");
	maps\mp\_utility::_unsetperk("specialty_extralethal");
	maps\mp\_utility::_unsetperk("specialty_extratactical");
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		var_04 = self getweaponammoclip(var_03);
		var_05 = weaponclipsize(var_03,self);
		if(var_04 > var_05)
		{
			self setweaponammoclip(var_03,var_04);
		}

		if(!isweaponcliponly(var_03))
		{
			var_06 = self setweaponammostock(var_03);
			var_07 = weaponmaxammo(var_03,self);
			if(var_06 > var_07)
			{
				self setweaponammostock(var_03,var_06);
			}
		}
	}

	if(isdefined(self.pers["em1Ammo"]))
	{
		var_09 = maps\mp\gametypes\zombies::getem1maxammo();
		if(self.pers["em1Ammo"].ammo > var_09)
		{
			self.pers["em1Ammo"].ammo = var_09;
		}

		maps\mp\gametypes\zombies::playerupdateem1omnvar();
	}

	if(isdefined(self.primaryweaponsammo))
	{
		foreach(var_0E, var_0B in self.primaryweaponsammo)
		{
			var_0C = weaponclipsize(var_0E,self);
			if(var_0B["ammoclip"] > var_0C)
			{
				self.primaryweaponsammo[var_0E]["ammoclip"] = var_0C;
			}

			if(common_scripts\utility::string_find(var_0E,"akimbo") && isdefined(var_0B["ammoclipleft"]) && var_0B["ammoclipleft"] > var_0C)
			{
				self.primaryweaponsammo[var_0E]["ammoclipleft"] = var_0C;
			}

			if(!isweaponcliponly(var_0E))
			{
				var_0D = weaponmaxammo(var_0E,self);
				if(var_0B["ammostock"] > var_0D)
				{
					self.primaryweaponsammo[var_0E]["ammostock"] = var_0D;
				}
			}
		}
	}
}

//Function Number: 67
perkterminalusershostcure()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(maps\mp\zombies\_util::isplayerinfected(var_02) && var_02 istouching(self.curetrigger))
		{
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.agent_type) && var_06.agent_type == "zombie_host" && var_06 istouching(self.curetrigger))
		{
			var_00[var_00.size] = var_06;
		}

		if(isdefined(level.hostcurefuncoverride) && isdefined(level.hostcurefuncoverride[var_06.agent_type]) && var_06 istouching(self.curetrigger))
		{
			var_00[var_00.size] = var_06;
		}
	}

	return var_00;
}

//Function Number: 68
perkterminalactivatehostcure(param_00)
{
	thread perkterminalactivatehostcurefx(param_00);
	thread perkterminalactivatehostcureanim(param_00);
}

//Function Number: 69
perkterminalactivatehostcureanim(param_00)
{
	if(!isdefined(self.curemodel))
	{
		return;
	}

	level notify("cure_station_active");
	var_01 = gettime();
	self.curemodel scriptmodelplayanim("xom_host_cure_station_start","curestation");
	self.curemodel playsound("interact_decontam_zone");
	self.curemodel waittillmatch("end","curestation");
	thread audio_decontam_attract_in_use_start(self.curemodel);
	self.curemodel scriptmodelplayanim("xom_host_cure_station_loop");
	wait(param_00 - gettime() - var_01 / 1000);
	self.curemodel scriptmodelplayanim("xom_host_cure_station_stop");
	wait(10);
	self.curemodel playsound("interact_decontam_zone_ready");
	thread audio_decontam_attract_in_use_stop(self.curemodel);
	level notify("cure_station_deactive");
}

//Function Number: 70
perkterminalactivatehostcurefx(param_00)
{
	if(!isdefined(self.curemodel))
	{
		return;
	}

	playfxontag(common_scripts\utility::getfx("zombie_host_cure"),self.curemodel,"TAG_FX");
}

//Function Number: 71
perkterminalsethostcure(param_00,param_01)
{
	self notify("cured",1);
	self setwatersheeting(1,0.5);
	var_02 = common_scripts\utility::getstructarray("host_cure_teleport","targetname");
	if(var_02.size)
	{
		var_03 = common_scripts\utility::random(var_02);
		self dontinterpolate();
		self setorigin(var_03.origin);
		self setplayerangles(var_03.angles);
	}
}

//Function Number: 72
perkterminalsethostcurezombie(param_00,param_01)
{
	if(isdefined(level.hostcurefuncoverride) && isdefined(level.hostcurefuncoverride[self.agent_type]))
	{
		self thread [[ level.hostcurefuncoverride[self.agent_type] ]](param_00,param_01);
		return;
	}

	if(!isdefined(level.zombiehostcures) || !isdefined(level.lastzombiehostcuretime))
	{
		level.zombiehostcures = 0;
		level.lastzombiehostcuretime = 0;
	}

	if(gettime() - level.lastzombiehostcuretime > 300)
	{
		level.zombiehostcures = 0;
	}

	level.zombiehostcures++;
	level.lastzombiehostcuretime = gettime();
	self suicide();
}

//Function Number: 73
givecurestationachievement()
{
	if(self.agent_type != "zombie_host")
	{
		return;
	}

	if(!isdefined(level.zombiehostcures) || level.zombiehostcures < 5)
	{
		return;
	}

	foreach(var_01 in level.players)
	{
		var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_ONEMANSPOISON");
	}
}

//Function Number: 74
perkterminalhostcuredisabled()
{
	if(isplayer(self) && isdefined(self.currentzone) && isdefined(level.zone_is_contaminated_func) && [[ level.zone_is_contaminated_func ]](self.currentzone))
	{
		return 1;
	}

	return 0;
}

//Function Number: 75
audio_decontam_attract_on(param_00)
{
	param_00 scalevolume(1,0.25);
	param_00 playloopsound("interact_decontam_zone_attract");
}

//Function Number: 76
audio_decontam_attract_in_use_start(param_00)
{
	param_00 scalevolume(0,0.5);
}

//Function Number: 77
audio_decontam_attract_in_use_stop(param_00)
{
	param_00 scalevolume(1,1);
}

//Function Number: 78
audio_decontam_attract_disable(param_00)
{
	param_00 scalevolume(0,0.5);
}

//Function Number: 79
playergivepostexoequipment()
{
	var_00 = self getlethalweapon();
	if(isdefined(var_00))
	{
		var_01 = maps\mp\zombies\_util::getpostexoequipmentname(var_00);
		if(isdefined(var_01) && var_01 != var_00)
		{
			var_02 = self getweaponammoclip(var_00);
			maps\mp\zombies\_wall_buys::givezombieequipment(self,var_01,0);
			self setweaponammoclip(var_01,var_02);
		}
	}

	var_03 = self gettacticalweapon();
	if(isdefined(var_03))
	{
		var_04 = maps\mp\zombies\_util::getpostexoequipmentname(var_03);
		if(isdefined(var_04) && var_04 != var_03)
		{
			var_02 = self getweaponammoclip(var_03);
			maps\mp\zombies\_wall_buys::givezombieequipment(self,var_04,0);
			self setweaponammoclip(var_04,var_02);
		}
	}
}

//Function Number: 80
perkterminalhasexosuit(param_00)
{
	return hasexosuit();
}

//Function Number: 81
perkterminalsetexosuit(param_00,param_01)
{
	self.exosuitonline = 1;
	givecheapskateachievement();
	thread playequipexosuitfx();
	setexocharactermodel();
	var_02 = maps\mp\gametypes\zombies::getexosuitequipweaponname();
	var_03 = maps\mp\gametypes\zombies::getexosuitequipweaponduration();
	maps\mp\gametypes\zombies::playweaponflourish(var_02,var_03);
	if(self.exosuitround == 0)
	{
		self.exosuitround = level.wavecounter;
	}

	maps\mp\zombies\_util::zombieallowallboost(1,"class");
	playergivepostexoequipment();
	level notify("player_given_exo_suit");
}

//Function Number: 82
setexocharactermodel()
{
	switch(self.characterindex)
	{
		case 0:
			thread maps\mp\zombies\_util::setcharactermodel("security_exo",1);
			break;

		case 1:
			thread maps\mp\zombies\_util::setcharactermodel("exec_exo",1);
			break;

		case 2:
			thread maps\mp\zombies\_util::setcharactermodel("it_exo",1);
			break;

		case 3:
		default:
			if(maps\mp\zombies\_util::getzombieslevelnum() < 3)
			{
				thread maps\mp\zombies\_util::setcharactermodel("janitor_exo",1);
			}
			else
			{
				thread maps\mp\zombies\_util::setcharactermodel("pilot_exo",1);
			}
			break;
	}
}

//Function Number: 83
playequipexosuitfx()
{
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			continue;
		}

		maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("exo_equip"),self,"tag_origin",var_01);
	}
}

//Function Number: 84
givecheapskateachievement()
{
	if(self.moneycurrent != self.moneyearnedtotal || !isdefined(self.joinedround1) || !self.joinedround1)
	{
		return;
	}

	maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_CHEAPSKATE");
}

//Function Number: 85
perkterminaltakeexosuit(param_00)
{
	self.exosuitonline = 0;
	maps\mp\zombies\_util::zombieallowallboost(0,"class");
}

//Function Number: 86
perkterminalactivateexosuit(param_00)
{
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_exo"),self.modelent,"TAG_ORIGIN",1);
}

//Function Number: 87
perkterminalonfx()
{
	var_00 = level.terminalitems[self.itemtype];
	if(isdefined(self.offfxent))
	{
		self.offfxent = undefined;
		maps\mp\zombies\_util::stopfxontagnetwork(var_00.offfx,self.modelent,"tag_origin");
	}

	if(isdefined(var_00.onfx) && !isdefined(self.onfxent))
	{
		maps\mp\zombies\_util::playfxontagnetwork(var_00.onfx,self.modelent,"tag_origin");
		self.onfxent = 1;
	}
}

//Function Number: 88
perkterminalofffx()
{
	var_00 = level.terminalitems[self.itemtype];
	if(isdefined(self.onfxent))
	{
		self.onfxent = undefined;
		maps\mp\zombies\_util::stopfxontagnetwork(var_00.onfx,self.modelent,"tag_origin");
	}

	if(isdefined(var_00.offfx) && !isdefined(self.offfxent))
	{
		maps\mp\zombies\_util::playfxontagnetwork(var_00.offfx,self.modelent,"tag_origin");
		self.offfxent = 1;
	}
}

//Function Number: 89
perkterminallighton()
{
	if(isdefined(self.light))
	{
		self.light setlightcolor((0.501,1,1));
	}
}

//Function Number: 90
perkterminallightoff()
{
	if(isdefined(self.light))
	{
		self.light setlightcolor((1,0,0));
	}
}

//Function Number: 91
perkterminaltriggerthink()
{
	thread perkterminalupdate();
	thread perkterminalusethink();
	wait 0.05;
	if(!maps\mp\zombies\_util::isusetriggerprimary(self))
	{
		return;
	}

	thread perkterminalplayercountwatch();
	thread perkterminalpowerwatch();
	thread perkterminalupdatefx();
}

//Function Number: 92
perkterminalplayercountwatch()
{
	for(;;)
	{
		level waittill("playerCountUpdate");
		self notify("updateFX");
	}
}

//Function Number: 93
perkterminalpowerwatch()
{
	if(!terminal_requires_power())
	{
		return;
	}

	for(;;)
	{
		self notify("updateFX");
		common_scripts\utility::flag_wait(self.script_flag_true);
		self notify("updateFX");
		common_scripts\utility::flag_waitopen(self.script_flag_true);
	}
}

//Function Number: 94
perkterminalupdatefx()
{
	for(;;)
	{
		var_00 = itemhasuses(self.itemtype);
		var_01 = terminal_has_power();
		if(var_00 && var_01)
		{
			perkterminalonfx();
			perkterminallighton();
			perkterminalattractaudioon();
		}
		else
		{
			perkterminalofffx();
			perkterminallightoff();
			perkterminalattractaudiooff();
		}

		self waittill("updateFX");
	}
}

//Function Number: 95
perkterminalattractaudioon()
{
	if(isdefined(self.aud_attract_on) && self.aud_attract_on)
	{
		return;
	}

	self.aud_attract_on = 1;
	switch(self.itemtype)
	{
		case "exo_health":
			self playloopsound("interact_exo_upgrade_attract");
			break;

		case "exo_revive":
			self playloopsound("interact_exo_upgrade_attract");
			break;

		case "exo_slam":
			self playloopsound("interact_exo_upgrade_attract");
			break;

		case "exo_suit":
			self playloopsound("interact_exo_buy_attract");
			self playsound("exo_station_restored");
			break;

		case "exo_stabilizer":
			self playloopsound("interact_exo_upgrade_attract");
			break;

		case "specialty_fastreload":
			self playloopsound("interact_exo_upgrade_attract");
			break;

		case "exo_tacticalArmor":
			self playloopsound("interact_exo_upgrade_attract");
			break;

		default:
			break;
	}
}

//Function Number: 96
perkterminalattractaudiooff()
{
}

//Function Number: 97
perkterminalcuremodellighton()
{
	if(isdefined(self.light) && isdefined(self.light.lightonintensity) && isdefined(self.light.ison) && !self.light.ison)
	{
		self.light setlightintensity(self.light.lightonintensity);
		self.light.ison = 1;
	}
}

//Function Number: 98
perkterminalcuremodellightoff()
{
	if(isdefined(self.light) && isdefined(self.light.lightoffintensity) && isdefined(self.light.ison) && self.light.ison)
	{
		self.light setlightintensity(self.light.lightoffintensity);
		self.light.ison = 0;
	}
}

//Function Number: 99
perkterminalupdate()
{
	switch(self.itemtype)
	{
		case "host_cure":
			thread perkterminalupdatehostcure();
			break;

		default:
			break;
	}
}

//Function Number: 100
perkterminalupdatehostcure()
{
	self.curetrigger = getent(self.target,"targetname");
	if(isdefined(self.curetrigger.target))
	{
		self.curemodel = getent(self.curetrigger.target,"targetname");
		if(isdefined(self.curemodel))
		{
			self.curemodel.terminal = self;
			level.hostcuremodels[level.hostcuremodels.size] = self.curemodel;
		}
	}

	if(isdefined(self.curemodel) && isdefined(self.curemodel.target))
	{
		var_00 = getent(self.curemodel.target,"targetname");
		if(isdefined(var_00) && var_00.code_classname == "light")
		{
			self.curemodel.light = var_00;
			self.curemodel.light.lightonintensity = self.curemodel.light getlightintensity();
			self.curemodel.light.lightoffintensity = 0.1;
			self.curemodel.light.ison = 1;
			self.curemodel perkterminalcuremodellightoff();
		}
	}

	thread perkterminalupdatehostcuredisabled();
	thread perkterminalupdatehostcurefx();
	thread perkterminalupdatehostcureicon();
}

//Function Number: 101
perkterminalupdatehostcuredisabled()
{
	self.terminaldisabled = 0;
	var_00 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.origin);
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		level waittill("contaminate" + var_00);
		self.terminaldisabled = 1;
		self notify("terminal_disabled");
		level notify("terminal_disabled");
		thread maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
		level waittill("clean" + var_00);
		self.terminaldisabled = 0;
		self notify("terminal_reenabled");
		level notify("terminal_reenabled");
		thread maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
	}
}

//Function Number: 102
perkterminalupdatehostcurefx()
{
	for(;;)
	{
		terminal_wait_for_power();
		if(self.terminaldisabled)
		{
			self waittill("terminal_reenabled");
		}

		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_idle"),self.curemodel,"TAG_FX");
		thread audio_decontam_attract_on(self.curemodel);
		common_scripts\utility::waittill_either("terminal_activated","terminal_disabled");
		maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_idle"),self.curemodel,"TAG_FX");
		if(self.terminaldisabled)
		{
			thread audio_decontam_attract_disable(self.curemodel);
			continue;
		}

		self waittill("terminal_cooldown_started");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_cooldown"),self.curemodel,"TAG_FX");
		self waittill("terminal_cooldown_ended");
		maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("zombie_host_cure_cooldown"),self.curemodel,"TAG_FX");
	}
}

//Function Number: 103
perkterminalupdatehostcureicon()
{
	var_00 = 0;
	var_01 = undefined;
	var_02 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.origin);
	for(;;)
	{
		if(isdefined(var_02))
		{
			level common_scripts\utility::waittill_any("player_cured","player_infected","contaminate" + var_02,"clean" + var_02);
		}
		else
		{
			level common_scripts\utility::waittill_any("player_cured","player_infected");
		}

		if(maps\mp\zombies\_util::is_true(self.terminaldeactivated))
		{
			continue;
		}

		var_03 = 0;
		foreach(var_05 in level.players)
		{
			if(maps\mp\zombies\_util::isplayerinfected(var_05))
			{
				var_03 = 1;
				break;
			}
		}

		if(isdefined(level.zone_is_contaminated_func) && [[ level.zone_is_contaminated_func ]](var_02))
		{
			var_03 = 0;
		}

		if(var_00 && !var_03)
		{
			if(isdefined(var_01))
			{
				var_01 destroy();
			}

			var_00 = 0;
			continue;
		}

		if(!var_00 && var_03)
		{
			var_01 = newhudelem();
			var_01 setshader("waypoint_cure_zone",8,8);
			var_01 setwaypoint(1,1);
			var_01.x = self.curemodel.origin[0];
			var_01.y = self.curemodel.origin[1];
			var_01.z = self.curemodel.origin[2] + 70;
			var_00 = 1;
		}
	}
}

//Function Number: 104
perkterminalusethink()
{
	for(;;)
	{
		var_00 = undefined;
		var_01 = "trigger";
		if(getitemcost(self.itemtype))
		{
			var_02 = maps\mp\zombies\_util::waittilltriggerortokenuse();
			var_00 = var_02[0];
			var_01 = var_02[1];
		}
		else
		{
			self waittill("trigger",var_00);
		}

		if(!terminal_has_power())
		{
			continue;
		}

		perkterminalgive(var_00,self.itemtype,var_01,0);
	}
}

//Function Number: 105
perkterminalgive(param_00,param_01,param_02,param_03)
{
	var_04 = &"ZOMBIES_HAVE_PERK";
	var_05 = undefined;
	var_06 = undefined;
	var_07 = ::perkterminalactivate;
	var_08 = "interact_exo_upgrade";
	var_09 = 0;
	var_0A = "killed_player";
	var_0B = 0;
	var_0C = 0;
	var_0D = undefined;
	switch(param_01)
	{
		case "exo_health":
			var_0E = ::perkterminalhasexohealth;
			var_0F = ::perkterminalsetexohealth;
			var_10 = ::perkterminaltakeexohealth;
			break;

		case "exo_revive":
			var_0E = ::perkterminalhasexorevive;
			var_0F = ::perkterminalsetexorevive;
			var_10 = ::perkterminaltakeexorevive;
			break;

		case "exo_slam":
			var_0E = ::perkterminalhasexoslam;
			var_0F = ::perkterminalsetexoslam;
			var_10 = ::perkterminaltakeexoslam;
			break;

		case "host_cure":
			var_0E = undefined;
			var_0F = ::perkterminalsethostcure;
			var_07 = ::perkterminalsethostcurezombie;
			var_06 = ::perkterminalusershostcure;
			var_08 = ::perkterminalactivatehostcure;
			var_10 = undefined;
			var_08 = undefined;
			var_09 = 1;
			var_0C = 5;
			var_0B = 10;
			if(isdefined(level.curestationcooldownmodifier))
			{
				var_0B = var_0B * level.curestationcooldownmodifier;
			}
	
			var_0D = ::perkterminalhostcuredisabled;
			break;

		case "exo_suit":
			var_0E = ::perkterminalhasexosuit;
			var_0F = ::perkterminalsetexosuit;
			var_10 = ::perkterminaltakeexosuit;
			var_07 = ::perkterminalactivateexosuit;
			var_04 = &"ZOMBIES_HAVE_EXO";
			var_08 = "interact_exo_buy";
			break;

		case "exo_stabilizer":
			var_0E = ::perkterminalhasexostabilizer;
			var_0F = ::perkterminalsetexostabilizer;
			var_10 = ::perkterminaltakeexostabilizer;
			break;

		case "specialty_fastreload":
			var_0E = ::perkterminalhasexofastreload;
			var_0F = ::perkterminalsetexofastreload;
			var_10 = ::perkterminaltakeexofastreload;
			break;

		case "exo_tacticalArmor":
			var_0E = ::perkterminalhasexotacticalarmor;
			var_0F = ::perkterminalsetexotacticalarmor;
			var_10 = ::perkterminaltakeexotacticalarmor;
			break;

		default:
			var_0E = ::perkterminalhas;
			var_0F = ::perkterminalset;
			var_10 = ::perkterminaltake;
			break;
	}

	if(!itemhasuses(param_01))
	{
		return;
	}

	if(getitemrequiresexo(param_01) && !param_00 hasexosuit())
	{
		param_00 thread maps\mp\zombies\_zombies_audio::playerexosuitrejected(param_01,"no_suit");
		param_00 playsoundtoplayer("ui_button_error",param_00);
		param_00 iprintlnbold(&"ZOMBIES_NEED_EXO_SUIT");
		return;
	}

	if(isdefined(var_0E) && param_00 [[ var_0E ]](param_01))
	{
		if(isdefined(var_04))
		{
			param_00 iprintlnbold(var_04);
		}

		return;
	}

	if(isdefined(var_0D) && param_00 [[ var_0D ]]())
	{
		return;
	}

	if(var_0B > 0 && !param_03 && perkterminalcoolingdown())
	{
		var_11 = self.nextusetime - gettime();
		var_11 = ceil(var_11 / 1000);
		if(var_11 > 1)
		{
			param_00 iprintlnbold(&"ZOMBIES_TERMINAL_COOLDOWN_SECS",var_11);
		}
		else
		{
			param_00 iprintlnbold(&"ZOMBIES_TERMINAL_COOLDOWN_SEC",var_11);
		}

		return;
	}

	var_12 = getitemcost(param_02);
	if(var_12 > 0)
	{
		if(param_03 == "token")
		{
			param_01 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
		}
		else if(!var_04 && !param_01 maps\mp\gametypes\zombies::attempttobuy(getitemcost(param_02)))
		{
			param_01 thread maps\mp\zombies\_zombies_audio::playerexosuitrejected(param_02,"no_cash");
			return;
		}
	}

	if(!var_04 && isdefined(var_08))
	{
		[[ var_08 ]](var_0D);
	}

	if(isdefined(var_09) && !var_04)
	{
		param_01 playlocalsound(var_09);
	}

	param_01 thread maps\mp\zombies\_zombies_audio::playerexosuit(param_02);
	self.terminalrunning = 1;
	setitemusecount(param_02,getitemnumbuys(param_02) + 1);
	self notify("updateFX");
	if(isdefined(self.linkedterminal))
	{
		self.linkedterminal notify("updateFX");
	}

	self notify("terminal_activated");
	param_01 notify("terminal_activated",param_02);
	level notify("terminal_activated",param_02);
	var_13 = gettime();
	for(;;)
	{
		var_14 = [param_01];
		if(!var_04 && isdefined(var_06))
		{
			var_14 = [[ var_06 ]]();
		}

		foreach(var_16 in var_14)
		{
			if(isplayer(var_16))
			{
				var_17 = getitemomnvar(param_02);
				if(isdefined(var_17))
				{
					var_16 setclientomnvar(var_17,1);
				}

				if(param_02 != "exo_suit")
				{
					param_01 thread maps\mp\zombies\_zombies_audio::moneyspend();
				}

				var_16 iprintlnbold(getitemlocname(param_02));
				var_16 [[ var_10 ]](param_02,param_01);
				level notify("terminal_player",param_02,self.origin,param_01);
				if(!var_0A)
				{
					var_16.zm_perks[var_16.zm_perks.size] = param_02;
					var_16 thread perkterminaltakewait(param_02,var_11,var_0B);
				}

				var_16 perkupdatesortorder();
				continue;
			}

			if(isdefined(var_07))
			{
				var_16 [[ var_07 ]](param_02,param_01);
			}
		}

		var_19 = gettime() - var_13 / 1000;
		if(var_0D <= var_19)
		{
			break;
		}

		wait 0.05;
	}

	level notify("terminal_complete",param_02,self.origin);
	self.terminalrunning = undefined;
	if(var_0C > 0 && !var_04)
	{
		self.nextusetime = gettime() + var_0C * 1000;
		thread terminalcooldownnotifies(var_0C);
	}
}

//Function Number: 106
perkterminalhostcureincooldown(param_00)
{
	return param_00 perkterminalcoolingdown();
}

//Function Number: 107
perkterminalcoolingdown()
{
	return isdefined(self.nextusetime) && self.nextusetime > gettime();
}

//Function Number: 108
perkupdatesortorder()
{
	var_00 = 0;
	var_01 = 1;
	foreach(var_03 in self.zm_perks)
	{
		if(var_03 == "exo_suit")
		{
			continue;
		}

		var_04 = perkgetindex(var_03);
		var_00 = var_00 + var_04 * var_01;
		var_01 = var_01 * 10;
	}

	self setclientomnvar("ui_zm_perk_order",var_00);
}

//Function Number: 109
perkgetindex(param_00)
{
	switch(param_00)
	{
		case "exo_health":
			return 1;

		case "specialty_fastreload":
			return 2;

		case "exo_revive":
			return 3;

		case "exo_stabilizer":
			return 4;

		case "exo_slam":
			return 5;

		case "exo_tacticalArmor":
			return 6;

		default:
			return 0;
	}
}

//Function Number: 110
terminalcooldownnotifies(param_00)
{
	self notify("terminal_cooldown_started");
	level notify("terminal_cooldown_started");
	maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
	wait(param_00);
	self notify("terminal_cooldown_ended");
	level notify("terminal_cooldown_ended");
	maps\mp\zombies\_zombies_laststand::hostzombieupdateoutline();
}

//Function Number: 111
perkterminaltakewait(param_00,param_01,param_02)
{
	self endon("disconnect");
	thread perkterminaltakeonsolo(param_00);
	thread perkterminaltakeonendsolo(param_00);
	common_scripts\utility::waittill_any(param_02,"take_" + param_00);
	self notify("lost_" + param_00);
	self notify("take_perk",param_00);
	self [[ param_01 ]](param_00);
	self.zm_perks = common_scripts\utility::array_remove(self.zm_perks,param_00);
	var_03 = getitemomnvar(param_00);
	if(isdefined(var_03))
	{
		self setclientomnvar(var_03,0);
	}

	perkupdatesortorder();
}

//Function Number: 112
perkterminaltakeonsolo(param_00)
{
	self endon("disconnect");
	self endon("lost_" + param_00);
	var_01 = getitemmaxsolobuys(param_00);
	if(!isdefined(var_01) || var_01 >= getitemnumbuys(param_00))
	{
		return;
	}

	for(;;)
	{
		level waittill("playerCountUpdate");
		if(level.players.size == 1)
		{
			break;
		}
	}

	self notify("take_" + param_00);
}

//Function Number: 113
perkterminaltakeonendsolo(param_00)
{
	self endon("disconnect");
	self endon("lost_" + param_00);
	if(level.players.size != 1)
	{
		return;
	}

	var_01 = getitemcostsolo(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	for(;;)
	{
		level waittill("playerCountUpdate");
		if(level.players.size != 1)
		{
			break;
		}
	}

	self notify("take_" + param_00);
	maps\mp\gametypes\zombies::givemoney(var_01);
}

//Function Number: 114
terminal_requires_power()
{
	return isdefined(self.script_flag_true);
}

//Function Number: 115
terminal_has_power()
{
	if(terminal_requires_power())
	{
		return common_scripts\utility::flag(self.script_flag_true);
	}

	return 1;
}

//Function Number: 116
terminal_wait_for_power()
{
	if(terminal_requires_power())
	{
		common_scripts\utility::flag_wait(self.script_flag_true);
	}
}

//Function Number: 117
perkhud(param_00,param_01)
{
	var_02 = 20;
	if(!isdefined(self.perkhuds))
	{
		self.perkhuds = [];
	}

	if(isdefined(self.perkhuds[param_01]))
	{
		destroyperkhud(param_01);
	}

	var_03 = maps\mp\gametypes\_hud_util::createfontstring("hudbig",1);
	var_03 maps\mp\gametypes\_hud_util::setpoint("BOTTOM LEFT",undefined,0,-100 - var_02 * self.perkhuds.size);
	var_03.label = param_00;
	var_03.color = (1,1,1);
	var_03.alpha = 1;
	foreach(var_05 in self.perkhuds)
	{
		var_03 thread updateperkkhuppos(var_05,var_02);
	}

	self.perkhuds[param_01] = var_03;
}

//Function Number: 118
updateperkkhuppos(param_00,param_01)
{
	self endon("death");
	param_00 waittill("death");
	self.y = self.y + param_01;
}

//Function Number: 119
destroyperkhud(param_00)
{
	if(isdefined(self.perkhuds[param_00]))
	{
		self.perkhuds[param_00] destroy();
		self.perkhuds[param_00] = undefined;
	}
}

//Function Number: 120
zombiegroundslamready()
{
	return !isdefined(self.exoslamnextusetime) || self.exoslamnextusetime <= gettime();
}

//Function Number: 121
zombiesgroundslam(param_00)
{
	self playsoundtoplayer("pc_boost_slam_land_dmg_default",self);
	self playsoundtoteam("npc_boost_slam_land_dmg_default","allies",self);
	zombiegroundslamcommon(param_00);
	return 1;
}

//Function Number: 122
zombiesgroundslamhitplayer(param_00)
{
	zombiegroundslamcommon(undefined,param_00);
	return 1;
}

//Function Number: 123
zombiegroundslamcommon(param_00,param_01)
{
	if(perkterminalhasexoslam() && zombiegroundslamready())
	{
		var_02 = 100;
		var_03 = 250;
		var_04 = 0.1;
		var_05 = 0.5;
		var_06 = 100;
		var_07 = 300;
		var_08 = 10;
		if(isdefined(param_01) && !param_01 maps\mp\zombies\_util::instakillimmune())
		{
			param_01 dodamage(param_01.health,self.origin,self,self,"MOD_TRIGGER_HURT","boost_slam_mp");
			playfx(common_scripts\utility::getfx("gib_full_body"),param_01.origin,(1,0,0));
		}

		if(!isdefined(param_00))
		{
			param_00 = var_02;
		}

		if(param_00 < var_02)
		{
			return;
		}

		thread groudslamcooldown(var_08);
		self.exoslamnextusetime = gettime() + int(var_08 * 1000);
		self setclientomnvar("ui_zm_exo_slam_next_time",self.exoslamnextusetime);
		var_09 = param_00 - var_02 / var_03 - var_02;
		var_09 = clamp(var_09,0,1);
		var_0A = var_07 - var_06 * var_09 + var_06;
		var_0B = level.agentclasses["zombie_generic"].roundhealth;
		self radiusdamage(self.origin,var_0A,var_05 * var_0B,var_04 * var_0B,self,"MOD_EXPLOSIVE","boost_slam_mp");
		physicsexplosionsphere(self.origin,var_0A,20,1);
		playfx(common_scripts\utility::getfx("zombie_exo_slam"),self.origin);
	}
}

//Function Number: 124
groudslamcooldown(param_00)
{
	self endon("lost_exo_slam");
	wait(param_00);
}