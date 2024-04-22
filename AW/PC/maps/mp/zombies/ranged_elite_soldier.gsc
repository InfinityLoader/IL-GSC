/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\ranged_elite_soldier.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 549 ms
 * Timestamp: 4/22/2024 2:14:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	init_common();
	level.agent_funcs["ranged_elite_soldier_goliath"] = level.agent_funcs["ranged_elite_soldier"];
	level.onspawnfinished["ranged_elite_soldier_goliath"] = ::onspawnfinishedgoliath;
	level.getloadout["ranged_elite_soldier_goliath"] = ::getgoliathloadout;
	var_00 = spawnstruct();
	var_00.agent_type = "ranged_elite_soldier_goliath";
	var_00.isbotagent = 1;
	var_00.health_scale = 4;
	var_00.damage_scale = 0.2;
	var_00.melee_damage_scale = 0.5;
	maps\mp\zombies\_util::agentclassregister(var_00,"ranged_elite_soldier_goliath");
	level.getspawntypefunc["ranged_elite_soldier"] = ::getsoldierroundspawntype;
	level.candroppickupsfunc["ranged_elite_soldier"] = ::soldierroundcandroppickups;
	level.roundstartfunc["ranged_elite_soldier"] = ::soldierroundstart;
	level.roundendfunc["ranged_elite_soldier"] = ::soldierroundend;
	level.randomspawnpointoverride["ranged_elite_soldier"] = ::soldiergetrandomspawnpoint;
	level.numenemiesthisroundfunc["ranged_elite_soldier"] = ::soldierroundnumenemies;
	level.roundspawndelayfunc["ranged_elite_soldier"] = ::soldierroundspawndelay;
	level.getrepulsortagfunc = ::soldiergetrepulsortag;
	level.soldierroundnum = 0;
	level._effect["npc_teleport_enemy"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
	level._effect["goliath_death_fire"] = loadfx("vfx/fire/goliath_death_fire");
	level._effect["goliath_self_destruct"] = loadfx("vfx/explosion/goliath_self_destruct");
}

//Function Number: 2
init_common()
{
	if(isdefined(level.agent_funcs["ranged_elite_soldier"]))
	{
		return;
	}

	level.agent_funcs["ranged_elite_soldier"] = level.agent_funcs["zombie"];
	level.agent_funcs["ranged_elite_soldier"]["think"] = ::soldierthink;
	level.agent_funcs["ranged_elite_soldier"]["spawn"] = ::onsoldierspawned;
	level.agent_funcs["ranged_elite_soldier"]["on_damaged_finished"] = ::maps\mp\agents\_agents::agent_damage_finished;
	level.agent_funcs["ranged_elite_soldier"]["on_killed"] = ::onsoldierkilled;
	var_00 = spawnstruct();
	var_00.agent_type = "ranged_elite_soldier";
	var_00.isbotagent = 1;
	var_00.health_scale = 0.5;
	var_00.damage_scale = 0.015;
	var_00.melee_damage_scale = 0.32;
	var_00.model_bodies = ["atlas_biohazard_body_a"];
	var_00.model_heads = ["atlas_biohazard_head_a"];
	maps\mp\zombies\_util::agentclassregister(var_00,var_00.agent_type);
	if(!isdefined(level.ranged_elite_soldier_weapons))
	{
		level.ranged_elite_soldier_weapons = [];
		level.ranged_elite_soldier_weapons["primary"] = [];
		level.ranged_elite_soldier_weapons["secondary"] = [];
		var_01 = [];
		if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark")
		{
			foreach(var_03 in level.magicboxweapons)
			{
				var_01[var_01.size] = var_03["baseNameNoMP"];
			}

			var_01[var_01.size] = "iw5_titan45zm";
			var_01[var_01.size] = "iw5_hmr9zm";
			var_01[var_01.size] = "iw5_m182sprzm";
			var_01[var_01.size] = "iw5_uts19zm";
		}
		else
		{
			foreach(var_03 in level.magicboxweapons)
			{
				var_01[var_01.size] = var_03["baseNameNoMP"];
			}

			var_01[var_01.size] = "iw5_titan45zm";
			var_01[var_01.size] = "iw5_arx160zm";
			var_01[var_01.size] = "iw5_mp11zm";
			var_01[var_01.size] = "iw5_hbra3zm";
			var_01[var_01.size] = "iw5_hmr9zm";
			var_01[var_01.size] = "iw5_maulzm";
			var_01[var_01.size] = "iw5_m182sprzm";
			var_01[var_01.size] = "iw5_uts19zm";
		}

		foreach(var_03 in var_01)
		{
			if(isvalidsoldierweapon(var_03))
			{
				if(maps\mp\zombies\_util::isvalidprimaryzombies(var_03))
				{
					level.ranged_elite_soldier_weapons["primary"][level.ranged_elite_soldier_weapons["primary"].size] = var_03;
				}
				else if(maps\mp\zombies\_util::isvalidsecondaryzombies(var_03))
				{
					level.ranged_elite_soldier_weapons["secondary"][level.ranged_elite_soldier_weapons["secondary"].size] = var_03;
				}
				else if(!maps\mp\zombies\_util::isvalidequipmentzombies(var_03))
				{
				}
			}
		}
	}
}

//Function Number: 3
init_ally()
{
	init_common();
	level._effect["npc_teleport_ally"] = loadfx("vfx/unique/dlc_teleport_soldier_good");
}

//Function Number: 4
isvalidsoldierweapon(param_00)
{
	switch(param_00)
	{
		case "iw5_exocrossbowzm":
		case "iw5_mahemzm":
		case "iw5_rw1zm":
		case "iw5_linegunzm":
		case "iw5_fusionzm":
		case "iw5_em1zm":
		case "iw5_rhinozm":
		case "iw5_gm6zm":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 5
getsoldierroundspawntype(param_00,param_01)
{
	return "ranged_elite_soldier";
}

//Function Number: 6
soldierroundcandroppickups(param_00)
{
	return 0;
}

//Function Number: 7
soldierroundstart()
{
	level.soldierroundnum++;
	thread soldierroundupdatespawnpoints();
	iprintlnbold("Atlas Cleanup Crew Inbound!");
	level waittill("soldier_spawn_calculated");
}

//Function Number: 8
soldierroundend()
{
	maps\mp\gametypes\zombies::createpickup("ammo",level.lastenemydeathpos,"soldierRoundEnd");
	level notify("soldierRoundUpdateSpawnPoints");
}

//Function Number: 9
soldierroundupdatespawnpoints()
{
	level notify("soldierRoundUpdateSpawnPoints");
	level endon("soldierRoundUpdateSpawnPoints");
	level endon("game_ended");
	level.soldierspawn = undefined;
	level.validsoldiernodes = [];
	var_00 = getallnodes();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!maps\mp\zombies\_util::nodeisinspawncloset(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	wait(0.05);
	var_05 = 0.95;
	var_06 = 0.05;
	var_07 = 0.05;
	var_08 = 0.05;
	var_09 = var_05 - var_06 + var_07 + var_08;
	for(;;)
	{
		var_0A = [];
		var_0B = [];
		foreach(var_0D in level.players)
		{
			if(isalive(var_0D))
			{
				var_0E = var_0D getnearestnode();
				if(isdefined(var_0E))
				{
					var_0A[var_0A.size] = var_0E;
					var_0B[var_0B.size] = nodegetsplitgroup(var_0E);
				}
			}
		}

		if(var_0A.size == 0)
		{
			wait(0.1);
			continue;
		}

		var_10 = !isdefined(level.soldierspawn);
		if(!var_10)
		{
			var_11 = 0;
			foreach(var_13 in var_0A)
			{
				if(nodesvisible(level.soldierspawn,var_13,1))
				{
					var_10 = 1;
					break;
				}

				var_11 = var_11 + distance(level.soldierspawn.origin,var_13.origin);
			}

			if(var_11 / var_0A.size < 500)
			{
				var_10 = 1;
			}

			if(!var_10)
			{
				wait(0.1);
				continue;
			}
		}

		var_15 = [];
		foreach(var_03 in var_01)
		{
			if(!var_03 nodeisdisconnected())
			{
				var_17 = nodegetsplitgroup(var_03);
				if(common_scripts\utility::array_contains(var_0B,var_17))
				{
					var_15[var_15.size] = var_03;
				}
			}
		}

		wait(var_06);
		var_19 = [];
		var_1A = 0;
		var_1B = int(var_15.size / 0.5 * var_09 / 0.05);
		foreach(var_03 in var_15)
		{
			var_1D = 1;
			foreach(var_13 in var_0A)
			{
				if(nodesvisible(var_03,var_13,1))
				{
					var_1D = 0;
					break;
				}
			}

			if(var_1D)
			{
				var_19[var_19.size] = var_03;
			}

			var_1A++;
			if(var_1A % var_1B == 0)
			{
				wait(0.05);
			}
		}

		wait(var_07);
		var_1A = 0;
		var_21 = undefined;
		var_22 = -1;
		var_1B = int(var_19.size / 0.5 * var_09 / 0.05);
		foreach(var_03 in var_19)
		{
			var_24 = 0;
			foreach(var_13 in var_0A)
			{
				var_24 = var_24 + distance(var_03.origin,var_13.origin);
			}

			if(var_24 > var_22)
			{
				var_22 = var_24;
				var_21 = var_03;
			}

			var_1A++;
			if(var_1A % var_1B == 0)
			{
				wait(0.05);
			}
		}

		wait(var_08);
		if(isdefined(var_21))
		{
			level.soldierspawn = var_21;
		}
		else
		{
			level.soldierspawn = common_scripts\utility::random(var_15);
		}

		level notify("soldier_spawn_calculated");
	}
}

//Function Number: 10
comparenodedistances(param_00,param_01)
{
	return level.nodedistances[param_00 getnodenumber()] <= level.nodedistances[param_01 getnodenumber()];
}

//Function Number: 11
soldiergetrandomspawnpoint()
{
	return level.soldierspawn;
}

//Function Number: 12
soldierroundnumenemies(param_00)
{
	var_01 = maps\mp\zombies\_util::getnumplayers();
	var_02 = 4 + level.soldierroundnum * 2;
	var_03 = var_01 * var_02;
	return var_03;
}

//Function Number: 13
soldierroundspawndelay(param_00,param_01)
{
	return 4;
}

//Function Number: 14
soldierthink()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	childthread ammorefillprimary();
	childthread ammorefillsecondary();
	childthread maps\mp\zombies\_zombies::monitorbadzombieai();
	childthread maps\mp\zombies\_util::locateenemypositions();
}

//Function Number: 15
getsoldierloadout()
{
	var_00 = ::maps\mp\bots\_bots_loadout::bot_loadout_choose_from_attachmenttable;
	var_01 = [];
	var_01["loadoutWildcard1"] = "specialty_null";
	var_01["loadoutWildcard2"] = "specialty_null";
	var_01["loadoutWildcard3"] = "specialty_null";
	var_01["loadoutPrimary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["primary"]);
	var_01["loadoutPrimaryAttachment"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutPrimaryAttachment",self.personality,self.difficulty);
	var_01["loadoutPrimaryAttachment2"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutPrimaryAttachment2",self.personality,self.difficulty);
	var_01["loadoutPrimaryAttachment3"] = "none";
	var_01["loadoutPrimaryBuff"] = "specialty_null";
	var_01["loadoutPrimaryCamo"] = "none";
	var_01["loadoutPrimaryReticle"] = "none";
	var_01["loadoutSecondary"] = common_scripts\utility::random(level.ranged_elite_soldier_weapons["secondary"]);
	var_01["loadoutSecondaryAttachment"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutSecondaryAttachment",self.personality,self.difficulty);
	var_01["loadoutSecondaryAttachment2"] = self [[ var_00 ]]("attachmenttable",var_01,"loadoutSecondaryAttachment2",self.personality,self.difficulty);
	var_01["loadoutSecondaryAttachment3"] = "none";
	var_01["loadoutSecondaryBuff"] = "specialty_null";
	var_01["loadoutSecondaryCamo"] = "none";
	var_01["loadoutSecondaryReticle"] = "none";
	var_01["loadoutEquipment"] = getsoldierloadoutequipment();
	var_01["loadoutEquipmentExtra"] = getsoldierloadoutequipmentextra();
	var_01["loadoutOffhand"] = getsoldierloadoutoffhand();
	var_01["loadoutPerk1"] = getsoldierloadoutperk(1,var_01);
	var_01["loadoutPerk2"] = "specialty_null";
	var_01["loadoutPerk3"] = getsoldierloadoutperk(3,var_01);
	var_01["loadoutPerk4"] = "specialty_null";
	var_01["loadoutPerk5"] = getsoldierloadoutperk(5,var_01);
	var_01["loadoutPerk6"] = "specialty_null";
	var_01["loadoutKillstreaks"][0] = "none";
	var_01["loadoutKillstreaks"][1] = "none";
	var_01["loadoutKillstreaks"][2] = "none";
	var_01["loadoutKillstreaks"][3] = "none";
	for(var_02 = 0;var_02 < 6;var_02++)
	{
		var_01["loadoutPerks"][var_02] = var_01["loadoutPerk" + var_02 + 1];
		var_01["loadoutPerk" + var_02 + 1] = undefined;
	}

	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_01["loadoutWildcards"][var_02] = var_01["loadoutWildcard" + var_02 + 1];
		var_01["loadoutWildcard" + var_02 + 1] = undefined;
	}

	return var_01;
}

//Function Number: 16
getgoliathloadout()
{
	var_00 = [];
	var_00["loadoutPrimary"] = "iw5_exominigun";
	var_00["loadoutPrimaryAttachment"] = "none";
	var_00["loadoutPrimaryAttachment2"] = "none";
	var_00["loadoutPrimaryAttachment3"] = "none";
	var_00["loadoutPrimaryBuff"] = "specialty_null";
	var_00["loadoutPrimaryCamo"] = "none";
	var_00["loadoutPrimaryReticle"] = "none";
	var_00["loadoutSecondary"] = "none";
	var_00["loadoutSecondaryAttachment"] = "none";
	var_00["loadoutSecondaryAttachment2"] = "none";
	var_00["loadoutSecondaryAttachment3"] = "none";
	var_00["loadoutSecondaryBuff"] = "specialty_null";
	var_00["loadoutSecondaryCamo"] = "none";
	var_00["loadoutSecondaryReticle"] = "none";
	var_00["loadoutEquipment"] = "none";
	var_00["loadoutOffhand"] = "none";
	var_00["loadoutKillstreaks"][0] = "none";
	var_00["loadoutKillstreaks"][1] = "none";
	var_00["loadoutKillstreaks"][2] = "none";
	var_00["loadoutKillstreaks"][3] = "none";
	var_00["loadoutPerks"] = ["specialty_null","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null","specialty_null"];
	var_00["loadoutWildcards"] = ["specialty_null","specialty_null","specialty_null"];
	var_00["loadoutJuggernaut"] = 1;
	return var_00;
}

//Function Number: 17
getsoldierloadoutoffhand()
{
	if(issoldierally())
	{
		return "specialty_null";
	}

	var_00 = ["exoshield_equipment_mp","exoshield_equipment_mp","exocloak_equipment_mp","exocloak_equipment_mp","exomute_equipment_mp","exomute_equipment_mp"];
	if(level.soldierroundnum >= 2 || level.roundtype != "ranged_elite_soldier" && level.wavecounter >= 10)
	{
		var_00[var_00.size] = "exorepulsor_equipment_mp";
	}

	return common_scripts\utility::random(var_00);
}

//Function Number: 18
getsoldierloadoutequipment()
{
	var_00 = ["frag_grenade_mp","semtex_mp","stun_grenade_mp","emp_grenade_mp"];
	if(!issoldierally())
	{
		var_00[var_00.size] = "smoke_grenade_mp";
	}

	return common_scripts\utility::random(var_00);
}

//Function Number: 19
getsoldierloadoutequipmentextra()
{
	return issoldierally() || level.soldierroundnum >= 2 || level.roundtype != "ranged_elite_soldier" && level.wavecounter >= 10;
}

//Function Number: 20
getsoldierloadoutperk(param_00,param_01)
{
	var_02 = ["specialty_class_coldblooded"];
	for(var_03 = "";var_03 == "" || common_scripts\utility::array_contains(var_02,var_03);var_03 = maps\mp\bots\_bots_loadout::bot_loadout_choose_from_set(["template_any"],"template_any",param_01,"loadoutPerk" + param_00))
	{
	}

	return var_03;
}

//Function Number: 21
issoldierally()
{
	return self.agent_type == "zm_squadmate";
}

//Function Number: 22
onsoldierspawned()
{
	if(isdefined(level.agent_funcs[self.agent_type]["onAIConnect"]))
	{
		[[ maps\mp\agents\_agent_utility::agentfunc("onAIConnect") ]]();
	}

	setsoldierpersonalityanddifficulty();
	maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
	self.nopickups = 1;
	self.chosentemplates = [];
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	if(isdefined(level.getloadout) && isdefined(level.getloadout[self.agent_type]))
	{
		self.pers["gamemodeLoadout"] = self [[ level.getloadout[self.agent_type] ]]();
	}
	else
	{
		self.pers["gamemodeLoadout"] = getsoldierloadout();
	}

	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
	if(isdefined(level.onspawnfinished) && isdefined(level.onspawnfinished[self.agent_type]))
	{
		self thread [[ level.onspawnfinished[self.agent_type] ]]();
		return;
	}

	thread onspawnfinished();
}

//Function Number: 23
onspawnfinished(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("applyLoadout");
	setsoldierbotsettings();
	self agentusescragentclipmask(1);
	self botsetflag("no_enemy_search",1);
	self.pers["numberOfTimesCloakingUsed"] = 0;
	self.pers["numberOfTimesShieldUsed"] = 0;
	var_01 = self.overridebodymodel;
	var_02 = self.overrideheadmodel;
	if(!isdefined(var_01) || !isdefined(var_02))
	{
		if(isdefined(level.agentclasses[self.agent_type].model_bodies))
		{
			var_03 = randomint(level.agentclasses[self.agent_type].model_bodies.size);
			var_01 = level.agentclasses[self.agent_type].model_bodies[var_03];
			var_02 = level.agentclasses[self.agent_type].model_heads[var_03];
		}
	}

	if(isdefined(var_01))
	{
		self setmodel(var_01);
		if(isdefined(self.headmodel))
		{
			self detach(self.headmodel,"");
		}

		self.headmodel = var_02;
		self attach(self.headmodel,"",1);
	}

	self.ignorezombierecycling = 1;
}

//Function Number: 24
playersetjuggexomodelzm(param_00)
{
	self detachall();
	self setmodel("npc_exo_armor_mp_base");
	self attach("head_hero_cormack_sentinel_halo");
	if((isdefined(param_00) && !param_00.hasmaniac) || isdefined(level.ishorde))
	{
		self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
	}

	if(isai(self))
	{
		self.hideondeath = 1;
	}

	self notify("goliath_equipped");
}

//Function Number: 25
onspawnfinishedgoliath()
{
	onspawnfinished();
	playersetjuggexomodelzm();
	self setplayermech(1);
	self botsetstance("stand");
	self allowjump(0);
	self allowladder(0);
	self allowmantle(0);
	self allowcrouch(0);
	self allowprone(0);
	maps\mp\_utility::playerallowhighjump(0,"class");
	maps\mp\_utility::playerallowdodge(0,"class");
	mechattachminigunbarrel();
	thread maps\mp\killstreaks\_juggernaut::playercleanupbarrel();
	thread maps\mp\killstreaks\_juggernaut::play_goliath_death_fx();
}

//Function Number: 26
mechattachminigunbarrel()
{
	self.barrellinker = spawn("script_model",self gettagorigin("tag_barrel"));
	self.barrellinker setmodel("generic_prop_raven");
	self.barrellinker vehicle_jetbikesethoverforcescale(self,"tag_barrel",(12.7,0,-2.9),(90,0,0));
	self.barrel = spawn("script_model",self.barrellinker gettagorigin("j_prop_1"));
	self.barrel setmodel("npc_exo_armor_minigun_barrel");
	self.barrel vehicle_jetbikesethoverforcescale(self.barrellinker,"j_prop_1",(0,0,0),(-90,0,0));
}

//Function Number: 27
setsoldierpersonalityanddifficulty()
{
	maps\mp\bots\_bots_util::bot_set_personality("run_and_gun");
	if(isdefined(self.difficulty))
	{
		maps\mp\bots\_bots_util::bot_set_difficulty(self.difficulty);
	}
	else if(issoldierally())
	{
		maps\mp\bots\_bots_util::bot_set_difficulty("veteran");
	}
	else
	{
		maps\mp\bots\_bots_util::bot_set_difficulty("regular");
	}

	self.difficulty = self botgetdifficulty();
}

//Function Number: 28
setsoldierbotsettings()
{
	if(!issoldierally())
	{
		self botsetdifficultysetting("quickPistolSwitch",1);
		self botsetdifficultysetting("diveChance",0.2);
		self botsetdifficultysetting("diveDelay",300);
		self botsetdifficultysetting("slideChance",0.6);
		self botsetdifficultysetting("cornerFireChance",1);
		self botsetdifficultysetting("cornerJumpChance",1);
		self botsetdifficultysetting("throwKnifeChance",1);
		self botsetdifficultysetting("meleeDist",100);
		self botsetdifficultysetting("meleeChargeDist",160);
		self botsetdifficultysetting("grenadeCookPrecision",100);
		self botsetdifficultysetting("grenadeDoubleTapChance",1);
		self botsetdifficultysetting("strategyLevel",3);
		self botsetdifficultysetting("intelligentSprintLevel",2);
		self botsetdifficultysetting("holdBreathChance",1);
		self botsetdifficultysetting("intelligentReload",1);
		self botsetdifficultysetting("dodgeChance",0.5);
		self botsetdifficultysetting("dodgeIntelligence",0.8);
		self botsetdifficultysetting("boostSlamChance",0.35);
		self botsetdifficultysetting("boostLookAroundChance",1);
		self botsetdifficultysetting("diveDelay",300);
		self botsetdifficultysetting("diveDelay",300);
	}
}

//Function Number: 29
ammorefillprimary()
{
	if(self.primaryweapon == "none")
	{
		return;
	}

	for(;;)
	{
		self givemaxammo(self.primaryweapon);
		wait(12);
	}
}

//Function Number: 30
ammorefillsecondary()
{
	if(self.secondaryweapon == "none")
	{
		return;
	}

	for(;;)
	{
		self givemaxammo(self.secondaryweapon);
		wait(8);
	}
}

//Function Number: 31
onsoldierkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.lastenemydeathpos = self.origin;
	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 maps\mp\_utility::incplayerstat("kills",1);
		param_01 maps\mp\_utility::incpersstat("kills",1);
		param_01.kills = param_01 maps\mp\_utility::getpersstat("kills");
		param_01 maps\mp\gametypes\_persistence::statsetchild("round","kills",param_01.kills);
	}

	if(isdefined(param_01))
	{
		param_01 notify("killed_enemy");
	}

	if(isdefined(level.processenemykilledfunc))
	{
		self thread [[ level.processenemykilledfunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	return maps\mp\agents\_agents::on_agent_player_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 32
soldiergetrepulsortag()
{
	if(maps\mp\killstreaks\_aerial_utility::hastag(self.model,"TAG_JETPACK"))
	{
		return "TAG_JETPACK";
	}

	return "tag_shield_back";
}