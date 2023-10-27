/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_weapons.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 176
 * Decompile Time: 3083 ms
 * Timestamp: 10/27/2023 1:31:55 AM
*******************************************************************/

//Function Number: 1
attachmentgroup(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
		return tablelookup("mp/alien/alien_attachmentTable.csv",4,param_00,2);
	}

	return tablelookup("mp/attachmentTable.csv",4,param_00,2);
}

//Function Number: 2
func_44DF()
{
	level.scavenger_altmode = 1;
	level.scavenger_secondary = 1;
	level.maxperplayerexplosives = max(maps\mp\_utility::func_3ADD("scr_maxPerPlayerExplosives",2),1);
	level.riotshieldxpbullets = maps\mp\_utility::func_3ADD("scr_riotShieldXPBullets",15);
	createthreatbiasgroup("DogsDontAttack");
	createthreatbiasgroup("Dogs");
	setignoremegroup("DogsDontAttack","Dogs");
	switch(maps\mp\_utility::func_3ADD("perk_scavengerMode",0))
	{
		case 1:
			level.scavenger_altmode = 0;
			break;

		case 2:
			level.scavenger_secondary = 0;
			break;

		case 3:
			level.scavenger_altmode = 0;
			level.scavenger_secondary = 0;
			break;
	}

	var_00 = getdvar("g_gametype");
	var_01 = maps\mp\_utility::getattachmentlistbasenames();
	var_01 = common_scripts\utility::alphabetize(var_01);
	var_02 = 149;
	level.weaponlist = [];
	level.weaponattachments = [];
	var_03 = "mp/statstable.csv";
	if(maps\mp\_utility::func_47BB())
	{
		var_03 = "mp/alien/mode_string_tables/alien_statstable.csv";
	}

	for(var_04 = 0;var_04 <= var_02;var_04++)
	{
		var_05 = tablelookup(var_03,0,var_04,4);
		if(var_05 == "")
		{
			continue;
		}

		if(!issubstr(tablelookup(var_03,0,var_04,2),"weapon_"))
		{
			continue;
		}

		if(issubstr(var_05,"iw5") || issubstr(var_05,"iw6"))
		{
			var_06 = strtok(var_05,"_");
			var_05 = var_06[0] + "_" + var_06[1] + "_mp";
			level.weaponlist[level.weaponlist.size] = var_05;
			continue;
		}
		else
		{
			level.weaponlist[level.weaponlist.size] = var_05 + "_mp";
		}

		var_07 = [];
		for(var_08 = 0;var_08 < 10;var_08++)
		{
			if(var_00 == "aliens")
			{
				var_09 = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv",0,var_04,var_08 + 11);
			}
			else
			{
				var_09 = maps\mp\_utility::getweaponattachmentfromstats(var_05,var_08);
			}

			if(var_09 == "")
			{
				break;
			}

			var_07[var_09] = 1;
		}

		var_0A = [];
		foreach(var_09 in var_01)
		{
			if(!isdefined(var_07[var_09]))
			{
				continue;
			}

			level.weaponlist[level.weaponlist.size] = var_05 + "_" + var_09 + "_mp";
			var_0A[var_0A.size] = var_09;
		}

		var_0D = [];
		for(var_0E = 0;var_0E < var_0A.size - 1;var_0E++)
		{
			var_0F = tablelookuprownum("mp/attachmentCombos.csv",0,var_0A[var_0E]);
			for(var_10 = var_0E + 1;var_10 < var_0A.size;var_10++)
			{
				if(tablelookup("mp/attachmentCombos.csv",0,var_0A[var_10],var_0F) == "no")
				{
					continue;
				}

				var_0D[var_0D.size] = var_0A[var_0E] + "_" + var_0A[var_10];
			}
		}

		foreach(var_12 in var_0D)
		{
			level.weaponlist[level.weaponlist.size] = var_05 + "_" + var_12 + "_mp";
		}
	}

	foreach(var_15 in level.weaponlist)
	{
		precacheitem(var_15);
	}

	thread maps\mp\_flashgrenades::func_4FDD();
	thread maps\mp\_entityheadicons::func_44DF();
	thread maps\mp\_empgrenade::func_44DF();
	initbombsquaddata();
	maps\mp\_utility::func_1855();
	maps\mp\_utility::buildweaponperkmap();
	level._effect["weap_blink_friend"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_detonator_blink_cyan");
	level._effect["weap_blink_enemy"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_detonator_blink_orange");
	level._effect["emp_stun"] = loadfx("vfx/gameplay/mp/equipment/vfx_emp_grenade");
	level._effect["equipment_explode_big"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
	level._effect["equipment_smoke"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["equipment_sparks"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion");
	level.weaponconfigs = [];
	if(!isdefined(level.weapondropfunction))
	{
		level.weapondropfunction = ::dropweaponfordeath;
	}

	var_18 = 70;
	level.claymoredetectiondot = cos(var_18);
	level.claymoredetectionmindist = 20;
	level.claymoredetectiongraceperiod = 0.75;
	level.claymoredetonateradius = 192;
	level.minedetectiongraceperiod = 0.3;
	level.minedetectionradius = 100;
	level.minedetectionheight = 20;
	level.minedamageradius = 256;
	level.minedamagemin = 70;
	level.minedamagemax = 210;
	level.minedamagehalfheight = 46;
	level.mineselfdestructtime = 120;
	level.mine_launch = loadfx("fx/impacts/bouncing_betty_launch_dirt");
	level.mine_explode = loadfx("fx/explosions/bouncing_betty_explosion");
	var_19 = addstruct();
	var_19.model = "projectile_bouncing_betty_grenade";
	var_19.bombsquadmodel = "projectile_bouncing_betty_grenade_bombsquad";
	var_19.mine_beacon["enemy"] = loadfx("fx/misc/light_c4_blink");
	var_19.mine_beacon["friendly"] = loadfx("fx/misc/light_mine_blink_friendly");
	var_19.mine_spin = loadfx("fx/dust/bouncing_betty_swirl");
	var_19.armtime = 2;
	var_19.ontriggeredsfx = "mine_betty_click";
	var_19.onlaunchsfx = "mine_betty_spin";
	var_19.onexplodesfx = "grenade_explode_metal";
	var_19.launchheight = 64;
	var_19.launchtime = 0.65;
	var_19.ontriggeredfunc = ::func_5241;
	var_19.headiconoffset = 20;
	level.weaponconfigs["bouncingbetty_mp"] = var_19;
	level.weaponconfigs["alienbetty_mp"] = var_19;
	var_19 = addstruct();
	var_19.model = "weapon_motion_sensor";
	var_19.bombsquadmodel = "weapon_motion_sensor_bombsquad";
	var_19.mine_beacon["enemy"] = common_scripts\utility::func_3AB9("weap_blink_enemy");
	var_19.mine_beacon["friendly"] = common_scripts\utility::func_3AB9("weap_blink_friend");
	var_19.mine_spin = loadfx("fx/dust/bouncing_betty_swirl");
	var_19.armtime = 2;
	var_19.ontriggeredsfx = "motion_click";
	var_19.ontriggeredfunc = ::func_5258;
	var_19.onlaunchsfx = "motion_spin";
	var_19.launchvfx = level.mine_launch;
	var_19.launchheight = 64;
	var_19.launchtime = 0.65;
	var_19.onexplodesfx = "motion_explode_default";
	var_19.onexplodevfx = loadfx("vfx/gameplay/mp/equipment/vfx_motionsensor_exp");
	var_19.headiconoffset = 25;
	var_19.markedduration = 4;
	level.weaponconfigs["motion_sensor_mp"] = var_19;
	var_19 = addstruct();
	var_19.armingdelay = 1.5;
	var_19.detectionradius = 232;
	var_19.detectionheight = 512;
	var_19.detectiongraceperiod = 1;
	var_19.headiconoffset = 20;
	var_19.killcamoffset = 12;
	level.weaponconfigs["proximity_explosive_mp"] = var_19;
	var_19 = addstruct();
	var_1A = 800;
	var_1B = 200;
	var_19.radius_max_sq = var_1A * var_1A;
	var_19.radius_min_sq = var_1B * var_1B;
	var_19.onexplodevfx = loadfx("vfx/gameplay/mp/equipment/vfx_flashbang");
	var_19.onexplodesfx = "flashbang_explode_default";
	var_19.vfxradius = 72;
	level.weaponconfigs["flash_grenade_mp"] = var_19;
	level.delayminetime = 3;
	level.sentry_fire = loadfx("fx/muzzleflashes/shotgunflash");
	level.stingerfxid = loadfx("fx/explosions/aerial_explosion_large");
	level.primary_weapon_array = [];
	level.side_arm_array = [];
	level.grenade_array = [];
	level.missile_array = [];
	level.inventory_array = [];
	level.mines = [];
	level._effect["equipment_explode"] = loadfx("fx/explosions/sparks_a");
	level._effect["sniperDustLarge"] = loadfx("fx/dust/sniper_dust_kickup");
	level._effect["sniperDustSmall"] = loadfx("fx/dust/sniper_dust_kickup_minimal");
	level._effect["sniperDustLargeSuppress"] = loadfx("fx/dust/sniper_dust_kickup_accum_suppress");
	level._effect["sniperDustSmallSuppress"] = loadfx("fx/dust/sniper_dust_kickup_accum_supress_minimal");
	level thread func_595D();
	level.c4explodethisframe = 0;
	common_scripts\utility::func_F1B(getentarray("misc_turret","classname"),::func_84F2);
}

//Function Number: 3
dumpit()
{
	wait(5);
}

//Function Number: 4
initbombsquaddata()
{
	level.bomb_squad = [];
	level.bomb_squad["c4_mp"] = addstruct();
	level.bomb_squad["c4_mp"].model = "weapon_c4_iw6_bombsquad";
	level.bomb_squad["c4_mp"].tag = "tag_origin";
	level.bomb_squad["claymore_mp"] = addstruct();
	level.bomb_squad["claymore_mp"].model = "weapon_claymore_bombsquad";
	level.bomb_squad["claymore_mp"].tag = "tag_origin";
	level.bomb_squad["frag_grenade_mp"] = addstruct();
	level.bomb_squad["frag_grenade_mp"].model = "projectile_m67fraggrenade_bombsquad";
	level.bomb_squad["frag_grenade_mp"].tag = "tag_weapon";
	level.bomb_squad["frag_grenade_short_mp"] = addstruct();
	level.bomb_squad["frag_grenade_short_mp"].model = "projectile_m67fraggrenade_bombsquad";
	level.bomb_squad["frag_grenade_short_mp"].tag = "tag_weapon";
	level.bomb_squad["semtex_mp"] = addstruct();
	level.bomb_squad["semtex_mp"].model = "weapon_semtex_grenade_iw6_bombsquad";
	level.bomb_squad["semtex_mp"].tag = "tag_origin";
	level.bomb_squad["mortar_shell_mp"] = addstruct();
	level.bomb_squad["mortar_shell_mp"].model = "weapon_canister_bomb_bombsquad";
	level.bomb_squad["mortar_shell_mp"].tag = "tag_weapon";
	level.bomb_squad["thermobaric_grenade_mp"] = addstruct();
	level.bomb_squad["thermobaric_grenade_mp"].model = "weapon_thermobaric_grenade_bombsquad";
	level.bomb_squad["thermobaric_grenade_mp"].tag = "tag_weapon";
	level.bomb_squad["proximity_explosive_mp"] = addstruct();
	level.bomb_squad["proximity_explosive_mp"].model = "mp_proximity_explosive_bombsquad";
	level.bomb_squad["proximity_explosive_mp"].tag = "tag_origin";
}

//Function Number: 5
bombsquadwaiter_missilefire()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = maps\mp\_utility::func_8B6F();
		if(var_00.weapon_name == "iw6_mk32_mp")
		{
			var_00 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad","tag_weapon",self);
		}
	}
}

//Function Number: 6
createbombsquadmodel(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",(0,0,0));
	var_03 hide();
	wait(0.05);
	if(!isdefined(self))
	{
	}

	self.bombsquadmodel = var_03;
	var_03 thread bombsquadvisibilityupdater(param_02);
	var_03 setmodel(param_00);
	var_03 linkto(self,param_01,(0,0,0),(0,0,0));
	var_03 setcontents(0);
	common_scripts\utility::func_8B2A("death","trap_death");
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_03 delete();
}

//Function Number: 7
disablevisibilitycullingforclient(param_00)
{
	self setplanesplineid(param_00,6,1);
}

//Function Number: 8
enablevisibilitycullingforclient(param_00)
{
	self hudoutlineenableforclient(param_00);
}

//Function Number: 9
bombsquadvisibilityupdater(param_00)
{
	self endon("death");
	self endon("trap_death");
	if(!isdefined(param_00))
	{
	}

	var_01 = param_00.team;
	for(;;)
	{
		self hide();
		foreach(var_03 in level.players)
		{
			enablevisibilitycullingforclient(var_03);
			if(!var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				continue;
			}

			if(level.teambased)
			{
				if(var_03.team == "spectator" || var_03.team == var_01)
				{
					continue;
				}
			}
			else if(isdefined(param_00) && var_03 == param_00)
			{
				continue;
			}

			self showtoplayer(var_03);
			disablevisibilitycullingforclient(var_03);
		}

		level common_scripts\utility::func_8B2A("joined_team","player_spawned","changed_kit","update_bombsquad");
	}
}

//Function Number: 10
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.hits = 0;
		maps\mp\gametypes\_gamelogic::func_7049(var_00,0);
		var_00 thread onplayerspawned();
		var_00 thread bombsquadwaiter_missilefire();
		var_00 thread func_8D06();
		var_00 thread func_766D();
	}
}

//Function Number: 11
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.currentweaponatspawn = self getcurrentweapon();
		self.empendtime = 0;
		self.concussionendtime = 0;
		self.hits = 0;
		maps\mp\gametypes\_gamelogic::func_7049(self,0);
		if(!isdefined(self.trackingweaponname))
		{
			self.trackingweaponname = "";
			self.trackingweaponname = "none";
			self.trackingweaponshots = 0;
			self.trackingweaponkills = 0;
			self.trackingweaponhits = 0;
			self.trackingweaponheadshots = 0;
			self.trackingweapondeaths = 0;
		}

		if(!maps\mp\_utility::func_47BB())
		{
			thread func_8D37();
			thread func_8D33();
			thread watchweaponperkupdates();
			thread watchsniperboltactionkills();
		}

		thread func_8CF7();
		thread func_8D1C();
		if(!maps\mp\_utility::func_47BB())
		{
			thread maps\mp\gametypes\_class::func_8229();
		}

		thread func_79C4();
		self.lasthittime = [];
		self.droppeddeathweapon = undefined;
		self.tookweaponfrom = [];
		thread updatesavedlastweapon();
		thread monitormk32semtexlauncher();
		self.currentweaponatspawn = undefined;
		self.trophyremainingammo = undefined;
	}
}

//Function Number: 12
recordtogglescopestates()
{
	self.pers["toggleScopeStates"] = [];
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(var_02 == self.primaryweapon || var_02 == self.secondaryweapon)
		{
			var_03 = getweaponattachments(var_02);
			foreach(var_05 in var_03)
			{
				if(istogglescope(var_05))
				{
					self.pers["toggleScopeStates"][var_02] = self method_840D(var_02);
					break;
				}
			}
		}
	}
}

//Function Number: 13
updatetogglescopestate(param_00)
{
	if(isdefined(self.pers["toggleScopeStates"]) && isdefined(self.pers["toggleScopeStates"][param_00]))
	{
		self gethybridscopestate(param_00,self.pers["toggleScopeStates"][param_00]);
	}
}

//Function Number: 14
istogglescope(param_00)
{
	var_01 = undefined;
	if(param_00 == "thermalsniper")
	{
		var_01 = 0;
	}
	else if(param_00 == "dlcweap02scope")
	{
		var_01 = 1;
	}
	else
	{
		var_02 = maps\mp\_utility::attachmentmap_tobase(param_00);
		switch(var_02)
		{
			case "tracker":
			case "thermal":
			case "hybrid":
				var_01 = 1;
				break;

			default:
				var_01 = 0;
				break;
		}
	}

	return var_01;
}

//Function Number: 15
func_766D()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = undefined;
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getstance() != "prone")
		{
			continue;
		}

		if(maps\mp\_utility::getweaponclass(self getcurrentweapon()) != "weapon_sniper")
		{
			continue;
		}

		var_01 = anglestoforward(self.angles);
		if(!isdefined(var_00) || gettime() - var_00 > 2000)
		{
			playfx(level._effect["sniperDustLarge"],self.origin + (0,0,10) + var_01 * 50,var_01);
			var_00 = gettime();
			continue;
		}

		playfx(level._effect["sniperDustLargeSuppress"],self.origin + (0,0,10) + var_01 * 50,var_01);
	}
}

//Function Number: 16
func_8D26()
{
	maps\mp\_stinger::func_7C02();
}

//Function Number: 17
func_8CFC()
{
	maps\mp\_javelin::func_49E3();
}

//Function Number: 18
weaponperkudpate(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_00) && param_00 != "none")
	{
		param_00 = maps\mp\_utility::func_3A37(param_00);
		var_03 = maps\mp\_utility::weaponperkmap(param_00);
		if(isdefined(var_03) && !maps\mp\_utility::_hasperk(var_03))
		{
			maps\mp\_utility::func_3CFB(var_03,0);
		}
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		param_01 = maps\mp\_utility::func_3A37(param_01);
		var_04 = maps\mp\_utility::weaponperkmap(param_01);
		if(isdefined(var_04) && !isdefined(var_03) || var_04 != var_03 && maps\mp\_utility::_hasperk(var_04) && !isdefined(param_02) || !common_scripts\utility::array_contains(param_02,var_04))
		{
			maps\mp\_utility::_unsetperk(var_04);
		}
	}
}

//Function Number: 19
func_8DA0(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	if(isdefined(param_00) && param_00 != "none")
	{
		var_02 = getweaponattachments(param_00);
		if(isdefined(var_02) && var_02.size > 0)
		{
			var_04 = [];
			foreach(var_06 in var_02)
			{
				var_07 = maps\mp\_utility::func_FD0(var_06);
				if(!isdefined(var_07))
				{
					continue;
				}

				var_04[var_04.size] = var_07;
				if(!maps\mp\_utility::_hasperk(var_07))
				{
					maps\mp\_utility::func_3CFB(var_07,0);
				}
			}
		}
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		var_03 = getweaponattachments(param_01);
		if(isdefined(var_03) && var_03.size > 0)
		{
			foreach(var_0A in var_03)
			{
				var_07 = maps\mp\_utility::func_FD0(var_0A);
				if(!isdefined(var_07))
				{
					continue;
				}

				if((!isdefined(var_04) || !common_scripts\utility::array_contains(var_04,var_07)) && maps\mp\_utility::_hasperk(var_07))
				{
					maps\mp\_utility::_unsetperk(var_07);
				}
			}
		}
	}

	return var_04;
}

//Function Number: 20
watchweaponperkupdates()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = undefined;
	var_01 = self getcurrentweapon();
	var_02 = func_8DA0(var_01,var_00);
	weaponperkudpate(var_01,var_00,var_02);
	for(;;)
	{
		var_00 = var_01;
		common_scripts\utility::func_8B2A("weapon_change","giveLoadout");
		var_01 = self getcurrentweapon();
		var_02 = func_8DA0(var_01,var_00);
		weaponperkudpate(var_01,var_00,var_02);
	}
}

//Function Number: 21
lethalstowed_clear()
{
	self.loadoutperkequipmentstowedammo = undefined;
	self.loadoutperkequipmentstowed = undefined;
}

//Function Number: 22
hasunderbarrelweapon()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(weaponaltweaponname(var_03) != "none")
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 23
lethalstowed_updatelethalsonweaponchange()
{
	if(self.loadoutperkequipment != "specialty_null")
	{
		if(hasunderbarrelweapon())
		{
			self.loadoutperkequipmentstowedammo = self getweaponammoclip(self.loadoutperkequipment);
			self.loadoutperkequipmentstowed = self.loadoutperkequipment;
			self takeweapon(self.loadoutperkequipment);
			self.loadoutperkequipment = "specialty_null";
			maps\mp\_utility::giveperkequipment("specialty_null",0);
		}
	}

	if(isdefined(self.loadoutperkequipmentstowed) && !hasunderbarrelweapon())
	{
		maps\mp\_utility::giveperkequipment(self.loadoutperkequipmentstowed,1);
		self setweaponammoclip(self.loadoutperkequipmentstowed,self.loadoutperkequipmentstowedammo);
		self.loadoutperkequipment = self.loadoutperkequipmentstowed;
		lethalstowed_clear();
	}
}

//Function Number: 24
func_8D33()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	childthread watchstartweaponchange();
	self.lastdroppableweapon = self.currentweaponatspawn;
	self.hitsthismag = [];
	var_00 = self getcurrentweapon();
	if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00]))
	{
		self.hitsthismag[var_00] = weaponclipsize(var_00);
	}

	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			continue;
		}

		if(var_00 == "briefcase_bomb_mp" || var_00 == "briefcase_bomb_defuse_mp")
		{
			continue;
		}

		lethalstowed_updatelethalsonweaponchange();
		if(maps\mp\_utility::func_48F7(var_00))
		{
			if((maps\mp\_utility::isjuggernaut() || maps\mp\killstreaks\_killstreaks::isminigun(var_00) || self getcurrentweapon() == "venomxgun_mp") && !maps\mp\killstreaks\_killstreaks::isairdropmarker(var_00))
			{
				if(isdefined(self.changingweapon))
				{
					waittillframeend;
					self.changingweapon = undefined;
				}
			}

			continue;
		}

		var_01 = strtok(var_00,"_");
		if(var_01[0] == "alt")
		{
			var_02 = getsubstr(var_00,4);
			var_00 = var_02;
			var_01 = strtok(var_00,"_");
		}
		else if(var_01[0] != "iw5" && var_01[0] != "iw6")
		{
			var_00 = var_01[0];
		}

		if(var_00 != "none" && var_01[0] != "iw5" && var_01[0] != "iw6")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00 + "_mp"]))
			{
				self.hitsthismag[var_00 + "_mp"] = weaponclipsize(var_00 + "_mp");
			}
		}
		else if(var_00 != "none" && var_01[0] == "iw5" || var_01[0] == "iw6")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00]))
			{
				self.hitsthismag[var_00] = weaponclipsize(var_00);
			}
		}

		self.changingweapon = undefined;
		if(var_01[0] == "iw5" || var_01[0] == "iw6")
		{
			self.lastdroppableweapon = var_00;
			continue;
		}

		if(var_00 != "none" && func_5124(var_00 + "_mp"))
		{
			self.lastdroppableweapon = var_00 + "_mp";
		}
	}
}

//Function Number: 25
watchsniperboltactionkills()
{
	self endon("death");
	self endon("disconnect");
	thread watchsniperboltactionkills_ondeath();
	if(!isdefined(self.pers["recoilReduceKills"]))
	{
		self.pers["recoilReduceKills"] = 0;
	}

	self setclientomnvar("weap_sniper_display_state",self.pers["recoilReduceKills"]);
	for(;;)
	{
		self waittill("got_a_kill",var_00,var_01,var_02);
		if(isrecoilreducingweapon(var_01))
		{
			var_03 = self.pers["recoilReduceKills"] + 1;
			self.pers["recoilReduceKills"] = castint(min(var_03,4));
			self setclientomnvar("weap_sniper_display_state",self.pers["recoilReduceKills"]);
			if(var_03 <= 4)
			{
				stancerecoilupdate(self getstance());
			}
		}
	}
}

//Function Number: 26
watchsniperboltactionkills_ondeath()
{
	self notify("watchSniperBoltActionKills_onDeath");
	self endon("watchSniperBoltActionKills_onDeath");
	self endon("disconnect");
	self waittill("death");
	self.pers["recoilReduceKills"] = 0;
}

//Function Number: 27
isrecoilreducingweapon(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	var_01 = 0;
	if(issubstr(param_00,"l115a3scope") || issubstr(param_00,"l115a3vzscope") || issubstr(param_00,"usrscope") || issubstr(param_00,"usrvzscope"))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 28
getrecoilreductionvalue()
{
	if(!isdefined(self.pers["recoilReduceKills"]))
	{
		self.pers["recoilReduceKills"] = 0;
	}

	return self.pers["recoilReduceKills"] * 3;
}

//Function Number: 29
watchstartweaponchange()
{
	self endon("death");
	self endon("disconnect");
	self.changingweapon = undefined;
	for(;;)
	{
		self waittill("weapon_switch_started",var_00);
		thread func_5020(self getcurrentweapon());
		self.changingweapon = var_00;
		if(var_00 == "none" && isdefined(self.iscapturingcrate) && self.iscapturingcrate)
		{
			while(self.iscapturingcrate)
			{
				wait(0.05);
			}

			self.changingweapon = undefined;
		}
	}
}

//Function Number: 30
func_5020(param_00)
{
	self endon("weapon_switch_started");
	self endon("weapon_change");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(maps\mp\_utility::func_48F7(param_00))
	{
	}

	wait(1);
	self.changingweapon = undefined;
}

//Function Number: 31
ishackweapon(param_00)
{
	if(param_00 == "radar_mp" || param_00 == "airstrike_mp" || param_00 == "helicopter_mp")
	{
		return 1;
	}

	if(param_00 == "briefcase_bomb_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
func_5124(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(issubstr(param_00,"ac130"))
	{
		return 0;
	}

	if(issubstr(param_00,"uav"))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 0;
	}

	var_01 = weaponinventorytype(param_00);
	if(var_01 != "primary")
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
dropweaponfordeath(param_00,param_01)
{
	if(isdefined(level.blockweapondrops))
	{
	}

	if(isdefined(self.droppeddeathweapon))
	{
	}

	if(level.ingraceperiod)
	{
	}

	var_02 = self.lastdroppableweapon;
	if(!isdefined(var_02))
	{
	}

	if(var_02 == "none")
	{
	}

	if(!self hasweapon(var_02))
	{
	}

	if(maps\mp\_utility::isjuggernaut())
	{
	}

	if(isdefined(level.gamemodemaydropweapon) && !self [[ level.gamemodemaydropweapon ]](var_02))
	{
	}

	var_03 = strtok(var_02,"_");
	if(var_03[0] == "alt")
	{
		for(var_04 = 1;var_04 < var_03.size;var_04++)
		{
			if(var_04 > 1)
			{
				var_02 = var_02 + "_";
			}

			var_02 = var_02 + var_03[var_04];
		}
	}

	if(var_02 != "iw6_riotshield_mp")
	{
		if(!self anyammoforweaponmodes(var_02))
		{
		}

		var_05 = self getweaponammoclip(var_02,"right");
		var_06 = self getweaponammoclip(var_02,"left");
		if(!var_05 && !var_06)
		{
		}

		var_07 = self getweaponammostock(var_02);
		var_08 = weaponmaxammo(var_02);
		if(var_07 > var_08)
		{
			var_07 = var_08;
		}

		var_09 = self dropitem(var_02);
		if(!isdefined(var_09))
		{
		}

		var_09 itemweaponsetammo(var_05,var_07,var_06);
	}
	else
	{
		var_09 = self dropitem(var_03);
		if(!isdefined(var_09))
		{
		}

		var_09 itemweaponsetammo(1,1,0);
	}

	self.droppeddeathweapon = 1;
	var_09.owner = self;
	var_09.ownersattacker = param_00;
	var_09.targetname = "dropped_weapon";
	var_09 thread func_8D0E();
	var_09 thread deletepickupafterawhile();
}

//Function Number: 34
detachifattached(param_00,param_01)
{
	var_02 = self getattachsize();
	var_03 = 0;
	while(var_03 < var_02)
	{
		var_04 = self getattachmodelname(var_03);
		if(var_04 != param_00)
		{
			continue;
		}

		var_05 = self getattachtagname(var_03);
		self detach(param_00,var_05);
		if(var_05 != param_01)
		{
			var_02 = self getattachsize();
			for(var_03 = 0;var_03 < var_02;var_03++)
			{
				var_05 = self getattachtagname(var_03);
				if(var_05 != param_01)
				{
					continue;
				}

				param_00 = self getattachmodelname(var_03);
				self detach(param_00,var_05);
				break;
			}
		}

		return 1;
		var_04++;
	}

	return 0;
}

//Function Number: 35
deletepickupafterawhile()
{
	self endon("death");
	wait(60);
	if(!isdefined(self))
	{
	}

	self delete();
}

//Function Number: 36
getitemweaponname()
{
	var_00 = self.classname;
	var_01 = getsubstr(var_00,7);
	return var_01;
}

//Function Number: 37
func_8D0E()
{
	self endon("death");
	var_00 = getitemweaponname();
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		if(isdefined(var_02))
		{
			break;
		}
	}

	var_03 = var_02 getitemweaponname();
	if(isdefined(var_01.primaryweapon) && var_01.primaryweapon == var_03)
	{
		var_01.primaryweapon = var_00;
	}

	if(isdefined(var_01.secondaryweapon) && var_01.secondaryweapon == var_03)
	{
		var_01.secondaryweapon = var_00;
	}

	if(isdefined(var_01.tookweaponfrom[var_03]))
	{
		var_02.owner = var_01.tookweaponfrom[var_03];
		var_02.ownersattacker = var_01;
		var_01.tookweaponfrom[var_03] = undefined;
	}

	var_02.targetname = "dropped_weapon";
	var_02 thread func_8D0E();
	if(isdefined(self.ownersattacker) && self.ownersattacker == var_01)
	{
		var_01.tookweaponfrom[var_00] = self.owner;
	}

	var_01.tookweaponfrom[var_00] = undefined;
}

//Function Number: 38
func_49C8()
{
	var_00 = getitemweaponname();
	var_01 = weaponaltweaponname(var_00);
	for(var_02 = 1;var_01 != "none" && var_01 != var_00;var_02++)
	{
		self itemweaponsetammo(0,0,0,var_02);
		var_01 = weaponaltweaponname(var_01);
	}
}

//Function Number: 39
handlescavengerbagpickup(param_00)
{
	self endon("death");
	level endon("game_ended");
	self waittill("scavenger",var_01);
	var_01 notify("scavenger_pickup");
	func_6AC6(var_01);
	var_01 maps\mp\gametypes\_damagefeedback::hudicontype("scavenger");
}

//Function Number: 40
func_6AC6(param_00)
{
	var_01 = param_00 getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		if(!isthrowingknife(var_03))
		{
			continue;
		}

		var_04 = common_scripts\utility::func_803F(param_00 maps\mp\_utility::_hasperk("specialty_extra_deadly"),2,1);
		var_05 = param_00 getweaponammoclip(var_03);
		if(var_05 + 1 <= var_04)
		{
			param_00 setweaponammoclip(var_03,var_05 + 1);
		}
	}

	var_07 = param_00 getweaponslistprimaries();
	foreach(var_09 in var_07)
	{
		if(!maps\mp\_utility::iscacprimaryweapon(var_09) && !level.scavenger_secondary)
		{
			continue;
		}

		if(issubstr(var_09,"alt_") && issubstr(var_09,"_gl"))
		{
			continue;
		}

		if(maps\mp\_utility::getweaponclass(var_09) == "weapon_projectile")
		{
			continue;
		}

		if(var_09 == "venomxgun_mp")
		{
			continue;
		}

		var_0A = param_00 getweaponammostock(var_09);
		var_0B = weaponclipsize(var_09);
		param_00 setweaponammostock(var_09,var_0A + var_0B);
	}
}

//Function Number: 41
dropscavengerfordeath(param_00)
{
	if(level.ingraceperiod)
	{
	}

	if(!isdefined(param_00))
	{
	}

	if(param_00 == self)
	{
	}

	var_01 = self dropscavengerbag("scavenger_bag_mp");
	var_01 thread handlescavengerbagpickup(self);
	if(isdefined(level.bot_funcs["bots_add_scavenger_bag"]))
	{
		[[ level.bot_funcs["bots_add_scavenger_bag"] ]](var_01);
	}
}

//Function Number: 42
func_7219(param_00,param_01,param_02)
{
	maps\mp\gametypes\_gamelogic::func_7219(param_00,param_01,param_02);
}

//Function Number: 43
func_8D37(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	if(isai(self))
	{
	}

	for(;;)
	{
		self waittill("weapon_fired",var_01);
		var_01 = self getcurrentweapon();
		maps\mp\gametypes\_gamelogic::func_7049(self,1);
		self.lastshotfiredtime = gettime();
		if(!maps\mp\_utility::iscacprimaryweapon(var_01) && !maps\mp\_utility::func_4890(var_01))
		{
			continue;
		}

		if(isdefined(self.hitsthismag[var_01]))
		{
			thread func_86FD(var_01);
		}

		var_02 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
		var_03 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
		var_04 = clamp(castfloat(var_03) / castfloat(var_02),0,1) * 10000;
		if(!getactiveclientcount())
		{
			maps\mp\gametypes\_persistence::func_7B27("totalShots",var_02);
			maps\mp\gametypes\_persistence::func_7B27("accuracy",castint(var_04));
			maps\mp\gametypes\_persistence::func_7B27("misses",castint(var_02 - var_03));
		}

		if(isdefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime())
		{
			self.hits = 0;
		}

		var_05 = 1;
		func_7219(var_01,var_05,"shots");
		func_7219(var_01,self.hits,"hits");
		self.hits = 0;
	}
}

//Function Number: 44
func_86FD(param_00)
{
	if(!maps\mp\_utility::func_47BB())
	{
		func_86FE(param_00);
	}
}

//Function Number: 45
func_86FE(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("updateMagShots_" + param_00);
	self.hitsthismag[param_00]--;
	wait(0.05);
	self.hitsthismag[param_00] = weaponclipsize(param_00);
}

//Function Number: 46
func_1BA9(param_00)
{
	if(!maps\mp\_utility::func_47BB())
	{
		checkhitsthismag_regularmp(param_00);
	}
}

//Function Number: 47
checkhitsthismag_regularmp(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("updateMagShots_" + param_00);
	waittillframeend;
	if(isdefined(self.hitsthismag[param_00]) && self.hitsthismag[param_00] == 0)
	{
		var_01 = maps\mp\_utility::getweaponclass(param_00);
		maps\mp\gametypes\_missions::func_37A9(var_01);
		self.hitsthismag[param_00] = weaponclipsize(param_00);
	}
}

//Function Number: 48
checkhit(param_00,param_01)
{
	self endon("disconnect");
	if(maps\mp\_utility::func_4971(param_00,"alt_"))
	{
		var_02 = maps\mp\_utility::func_3C72(param_00);
		if(common_scripts\utility::array_contains(var_02,"shotgun") || common_scripts\utility::array_contains(var_02,"gl"))
		{
			self.hits = 1;
		}
		else
		{
			param_00 = getsubstr(param_00,4);
		}
	}

	if(!isprimaryweapon(param_00) && !issidearm(param_00))
	{
	}

	if(self meleebuttonpressed() && param_00 != "iw6_knifeonly_mp" && param_00 != "iw6_knifeonlyfast_mp")
	{
	}

	switch(weaponclass(param_00))
	{
		case "smg":
		case "mg":
		case "pistol":
		case "rifle":
		case "sniper":
			self.hits++;
			break;

		case "spread":
			self.hits = 1;
			break;

		default:
			break;
	}

	if(func_494E(param_00) || param_00 == "iw6_knifeonly_mp" || param_00 == "iw6_knifeonlyfast_mp")
	{
		thread maps\mp\gametypes\_gamelogic::func_8091(param_00,self.hits,"hits");
		self.hits = 0;
	}

	waittillframeend;
	if(isdefined(self.hitsthismag[param_00]))
	{
		thread func_1BA9(param_00);
	}

	if(!isdefined(self.lasthittime[param_00]))
	{
		self.lasthittime[param_00] = 0;
	}

	if(self.lasthittime[param_00] == gettime())
	{
	}

	self.lasthittime[param_00] = gettime();
	if(!getactiveclientcount())
	{
		var_03 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
		var_04 = maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;
		if(var_04 <= var_03)
		{
			maps\mp\gametypes\_persistence::func_7B27("hits",var_04);
			maps\mp\gametypes\_persistence::func_7B27("misses",castint(var_03 - var_04));
			var_05 = clamp(castfloat(var_04) / castfloat(var_03),0,1) * 10000;
			maps\mp\gametypes\_persistence::func_7B27("accuracy",castint(var_05));
		}
	}
}

//Function Number: 49
attackercandamageitem(param_00,param_01)
{
	return func_357F(param_01,param_00);
}

//Function Number: 50
func_357F(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	var_03 = param_01.team;
	var_04 = level.friendlyfire;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(var_04 != 0)
	{
		return 1;
	}

	if(param_01 == param_00)
	{
		return !maps\mp\_utility::func_47BB();
	}

	if(!isdefined(var_03))
	{
		return 1;
	}

	if(var_03 != param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 51
func_8CF7()
{
	self notify("watchGrenadeUsage");
	self endon("watchGrenadeUsage");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("faux_spawn");
	self.throwinggrenade = undefined;
	self.gotpullbacknotify = 0;
	if(maps\mp\_utility::func_3ADD("scr_deleteexplosivesonspawn",1) == 1)
	{
		if(isdefined(self.dont_delete_grenades_on_next_spawn))
		{
			self.dont_delete_grenades_on_next_spawn = undefined;
		}
		else
		{
			delete_all_grenades();
		}
	}
	else if(!isdefined(self.plantedlethalequip))
	{
		self.plantedlethalequip = [];
		self.plantedtacticalequip = [];
	}

	thread watchforthrowbacks();
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(!maps\mp\_utility::func_47BB())
		{
			func_7219(var_00,1,"shots");
		}

		maps\mp\gametypes\_gamelogic::func_7049(self,1);
		thread watchoffhandcancel();
		self.throwinggrenade = var_00;
		self.gotpullbacknotify = 1;
		if(var_00 == "c4_mp")
		{
			thread func_13F2();
		}

		begingrenadetracking();
		self.throwinggrenade = undefined;
	}
}

//Function Number: 52
begingrenadetracking()
{
	self endon("offhand_end");
	self endon("weapon_change");
	var_00 = gettime();
	var_01 = maps\mp\_utility::func_8B68();
	if(!isdefined(var_01))
	{
	}

	if(!isdefined(var_01.weapon_name))
	{
	}

	self.changingweapon = undefined;
	if(isdefined(level.bomb_squad[var_01.weapon_name]))
	{
		var_01 thread createbombsquadmodel(level.bomb_squad[var_01.weapon_name].model,level.bomb_squad[var_01.weapon_name].tag,self);
	}

	switch(var_01.weapon_name)
	{
		case "thermobaric_grenade_mp":
		case "frag_grenade_mp":
			if(gettime() - var_00 > 1000)
			{
				var_01.iscooked = 1;
			}
	
			var_01 thread maps\mp\gametypes\_shellshock::func_3DA7();
			var_01.originalowner = self;
			break;

		case "iw6_aliendlc43_mp":
		case "iw6_aliendlc22_mp":
		case "mortar_shell_mp":
			var_01 thread maps\mp\gametypes\_shellshock::func_3DA7();
			var_01.originalowner = self;
			break;

		case "aliensemtex_mp":
		case "semtex_mp":
			thread func_6D8E(var_01);
			break;

		case "c4_mp":
			thread c4used(var_01);
			break;

		case "proximity_explosive_mp":
			thread func_6227(var_01);
			break;

		case "flash_grenade_mp":
			var_02 = gettime() - var_00;
			var_01.ninebangticks = 1;
			if(var_02 > 1000)
			{
				var_01.iscooked = 1;
				var_01.ninebangticks = var_01.ninebangticks + min(castint(var_02 / 875),5);
			}
	
			var_01 thread ninebangexplodewaiter();
			break;

		case "smoke_grenadejugg_mp":
		case "smoke_grenade_mp":
			var_01 thread func_8D21();
			break;

		case "alientrophy_mp":
		case "trophy_mp":
			thread maps\mp\gametypes\_trophy_system::func_83D0(var_01);
			break;

		case "alienclaymore_mp":
		case "claymore_mp":
			thread claymoreused(var_01);
			break;

		case "alienbetty_mp":
		case "bouncingbetty_mp":
			thread func_525B(var_01,::func_78AE);
			break;

		case "motion_sensor_mp":
			thread func_525B(var_01,::func_78B0);
			break;

		case "throwingknifejugg_mp":
		case "throwingknife_mp":
			level thread throwingknifeused(self,var_01,var_01.weapon_name);
			break;
	}
}

//Function Number: 53
throwingknifeused(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_01 waittill("missile_stuck",var_03);
	param_01 endon("death");
	param_01 makeunusable();
	var_04 = spawn("trigger_radius",param_01.origin,0,64,64);
	var_04 enablelinkto();
	var_04 linkto(param_01);
	var_04.targetname = "dropped_knife";
	param_01.knife_trigger = var_04;
	param_01 thread func_8CF3();
	for(;;)
	{
		common_scripts\utility::func_8AFE();
		if(!isdefined(var_04))
		{
		}

		var_04 waittill("trigger",var_05);
		if(!isplayer(var_05) || !maps\mp\_utility::func_4945(var_05))
		{
			continue;
		}

		if(!var_05 hasweapon(param_02))
		{
			continue;
		}

		var_06 = var_05 getweaponammoclip(param_02);
		var_07 = var_05 maps\mp\_utility::_hasperk("specialty_extra_deadly");
		if(var_07 && var_06 == 2)
		{
			continue;
		}

		if(!var_07 && var_06 == 1)
		{
			continue;
		}

		var_05 setweaponammoclip(param_02,var_06 + 1);
		var_05 thread maps\mp\gametypes\_damagefeedback::hudicontype("throwingknife");
		param_01 delete();
		break;
	}
}

//Function Number: 54
func_8CF3()
{
	self waittill("death");
	if(isdefined(self.knife_trigger))
	{
		self.knife_trigger delete();
	}
}

//Function Number: 55
watchoffhandcancel()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("grenade_fire");
	self waittill("offhand_end");
	if(isdefined(self.changingweapon) && self.changingweapon != self getcurrentweapon())
	{
		self.changingweapon = undefined;
	}
}

//Function Number: 56
func_8D21()
{
	level endon("smokeTimesUp");
	var_00 = self.owner;
	var_00 endon("disconnect");
	self waittill("explode",var_01);
	var_02 = 128;
	var_03 = 8;
	level thread func_8B1A(var_03,var_02,var_01);
	for(;;)
	{
		if(!isdefined(var_00))
		{
			break;
		}

		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(level.teambased && var_05.team == var_00.team)
			{
				continue;
			}

			if(distancesquared(var_05.origin,var_01) < var_02 * var_02)
			{
				var_05.inplayersmokescreen = var_00;
				continue;
			}

			var_05.inplayersmokescreen = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 57
func_8B1A(param_00,param_01,param_02)
{
	maps\mp\gametypes\_hostmigration::func_8B0D(param_00);
	level notify("smokeTimesUp");
	waittillframeend;
	foreach(var_04 in level.players)
	{
		if(isdefined(var_04))
		{
			var_04.inplayersmokescreen = undefined;
		}
	}
}

//Function Number: 58
func_4EE2()
{
	var_00 = [];
	if(level.teambased)
	{
		if(isdefined(level.chopper) && level.chopper.team != self.team || isdefined(level.chopper.owner) && level.chopper.owner == self)
		{
			var_00[var_00.size] = level.chopper;
		}

		if(isdefined(level.littlebirds))
		{
			foreach(var_02 in level.littlebirds)
			{
				if(isdefined(var_02) && var_02.team != self.team || isdefined(var_02.owner) && var_02.owner == self)
				{
					var_00[var_00.size] = var_02;
				}
			}
		}

		if(isdefined(level.balldrones))
		{
			foreach(var_05 in level.balldrones)
			{
				if(isdefined(var_05) && var_05.team != self.team || isdefined(var_05.owner) && var_05.owner == self)
				{
					var_00[var_00.size] = var_05;
				}
			}
		}

		if(isdefined(level.harriers))
		{
			foreach(var_08 in level.harriers)
			{
				if(isdefined(var_08) && var_08.team != self.team || isdefined(var_08.owner) && var_08.owner == self)
				{
					var_00[var_00.size] = var_08;
				}
			}
		}
	}
	else
	{
		if(isdefined(level.chopper))
		{
			var_00[var_00.size] = level.chopper;
		}

		if(isdefined(level.littlebirds))
		{
			foreach(var_02 in level.littlebirds)
			{
				if(!isdefined(var_02))
				{
					continue;
				}

				var_00[var_00.size] = var_02;
			}
		}

		if(isdefined(level.balldrones))
		{
			foreach(var_05 in level.balldrones)
			{
				if(!isdefined(var_05))
				{
					continue;
				}

				var_00[var_00.size] = var_05;
			}
		}

		if(isdefined(level.harriers))
		{
			foreach(var_08 in level.harriers)
			{
				if(!isdefined(var_08))
				{
					continue;
				}

				var_00[var_00.size] = var_08;
			}
		}
	}

	return var_00;
}

//Function Number: 59
func_8D06()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = maps\mp\_utility::func_8B6F();
		if(issubstr(var_00.weapon_name,"gl_"))
		{
			var_00.primaryweapon = self getcurrentprimaryweapon();
			var_00 thread maps\mp\gametypes\_shellshock::func_3DA7();
		}

		switch(var_00.weapon_name)
		{
			case "stinger_mp":
			case "iw5_smaw_mp":
			case "at4_mp":
				level notify("stinger_fired",self,var_00,self.stingertarget);
				break;
	
			case "javelin_mp":
			case "lasedStrike_missile_mp":
			case "remote_mortar_missile_mp":
				level notify("stinger_fired",self,var_00,self.javelintarget);
				break;
	
			default:
				break;
		}

		switch(var_00.weapon_name)
		{
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
			case "lasedStrike_missile_mp":
			case "remote_mortar_missile_mp":
			case "iw6_panzerfaust3_mp":
			case "iw6_maaws_mp":
				var_00 thread maps\mp\gametypes\_shellshock::func_3DA7();
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 60
func_8CF9()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("hit_by_missile",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		if(!isdefined(var_00) || !isdefined(var_01))
		{
			continue;
		}

		if(level.teambased && self.team == var_00.team)
		{
			self cancelrocketcorpse(var_01,var_03,var_04,var_05,var_06,var_07);
			continue;
		}

		if(var_02 != "rpg_mp")
		{
			self cancelrocketcorpse(var_01,var_03,var_04,var_05,var_06,var_07);
			continue;
		}

		if(randomintrange(0,100) < 99)
		{
			self cancelrocketcorpse(var_01,var_03,var_04,var_05,var_06,var_07);
			continue;
		}

		var_08 = getdvarfloat("rocket_corpse_max_air_time",0.5);
		var_09 = getdvarfloat("rocket_corpse_view_offset_up",100);
		var_0A = getdvarfloat("rocket_corpse_view_offset_forward",35);
		self.isrocketcorpse = 1;
		self setcontents(0);
		var_0B = self setrocketcorpse(1);
		var_0C = var_0B / 1000;
		self.killcament = spawn("script_model",var_01.origin);
		self.killcament.angles = var_01.angles;
		self.killcament linkto(var_01);
		self.killcament setscriptmoverkillcam("rocket_corpse");
		self.killcament setcontents(0);
		self dodamage(1000,self.origin,var_00,var_01);
		self.body = self cloneplayer(var_0B);
		self.body.origin = var_01.origin;
		self.body.angles = var_01.angles;
		self.body.targetname = "player_corpse";
		self.body setcorpsefalling(0);
		self.body enablelinkto();
		self.body linkto(var_01);
		self.body setcontents(0);
		if(!isdefined(self.switching_teams))
		{
			thread maps\mp\gametypes\_deathicons::adddeathicon(self.body,self,self.team,5);
		}

		self playerhide();
		var_0D = vectornormalize(anglestoup(var_01.angles));
		var_0E = vectornormalize(anglestoforward(var_01.angles));
		var_0F = var_0E * var_09 + var_0D * var_0A;
		var_10 = var_01.origin + var_0F;
		var_11 = spawn("script_model",var_10);
		var_11 setmodel("tag_origin");
		var_11.angles = vectortoangles(var_01.origin - var_11.origin);
		var_11 linkto(var_01);
		var_11 setcontents(0);
		self cameralinkto(var_11,"tag_origin");
		if(var_08 > var_0C)
		{
			var_08 = var_0C;
		}

		var_12 = var_01 common_scripts\utility::func_8B7E("death",var_08);
		if(isdefined(var_12) && var_12 == "timeout" && isdefined(var_01))
		{
			var_01 detonate();
		}

		self notify("final_rocket_corpse_death");
		self.body unlink();
		self.body setcorpsefalling(1);
		self.body startragdoll();
		var_11 linkto(self.body);
		self.isrocketcorpse = undefined;
		self waittill("death_delay_finished");
		self cameraunlink();
		self.killcament delete();
		var_11 delete();
	}
}

//Function Number: 61
func_8D1C()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("sentry_placement_finished",var_00);
		thread maps\mp\_utility::func_6FDC(var_00,"tag_flash",65);
	}
}

//Function Number: 62
ninebangexplodewaiter()
{
	thread maps\mp\gametypes\_shellshock::func_2DE0();
	self endon("end_explode");
	self waittill("explode",var_00);
	thread func_2983(var_00,self.owner,self.ninebangticks);
	func_560C(var_00,self.owner,self.ninebangticks);
}

//Function Number: 63
func_560C(param_00,param_01,param_02)
{
	if(param_02 >= 5 || pitchercheck(param_01,param_02))
	{
		playsoundatpos(param_00,"weap_emp_explode");
		var_03 = getempdamageents(param_00,512,0);
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.owner) && !func_357F(param_01,var_05.owner))
			{
				continue;
			}

			var_05 notify("emp_damage",self.owner,8);
		}
	}
}

//Function Number: 64
pitchercheck(param_00,param_01)
{
	if(param_00 maps\mp\_utility::_hasperk("specialty_pitcher"))
	{
		if(param_01 >= 4)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
func_2983(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = level.weaponconfigs[self.weapon_name];
	wait(randomfloatrange(0.25,0.5));
	for(var_04 = 1;var_04 < param_02;var_04++)
	{
		var_05 = func_3B48(param_00,var_03.vfxradius);
		playsoundatpos(var_05,var_03.onexplodesfx);
		playfx(var_03.onexplodevfx,var_05);
		foreach(var_07 in level.players)
		{
			if(!maps\mp\_utility::func_4945(var_07) || var_07.sessionstate != "playing")
			{
				continue;
			}

			var_08 = var_07 geteye();
			var_09 = distancesquared(param_00,var_08);
			if(var_09 > var_03.radius_max_sq)
			{
				continue;
			}

			if(!bullettracepassed(param_00,var_08,0,var_07))
			{
				continue;
			}

			if(var_09 <= var_03.radius_min_sq)
			{
				var_0A = 1;
			}
			else
			{
				var_0A = 1 - var_09 - var_03.radius_min_sq / var_03.radius_max_sq - var_03.radius_min_sq;
			}

			var_0B = anglestoforward(var_07 getangles());
			var_0C = param_00 - var_08;
			var_0C = vectornormalize(var_0C);
			var_0D = 0.5 * 1 + vectordot(var_0B,var_0C);
			var_0E = 1;
			var_07 notify("flashbang",param_00,var_0A,var_0D,param_01,var_0E);
		}

		wait(randomfloatrange(0.25,0.5));
	}
}

//Function Number: 66
func_3B48(param_00,param_01)
{
	var_02 = (randomfloatrange(-1 * param_01,param_01),randomfloatrange(-1 * param_01,param_01),0);
	var_03 = param_00 + var_02;
	var_04 = bullettrace(param_00,var_03,0,self,0,0,0,0,0);
	if(var_04["fraction"] < 1)
	{
		var_03 = param_00 + var_04["fraction"] * var_02;
	}

	return var_03;
}

//Function Number: 67
func_13F2()
{
	self notify("beginC4Tracking");
	self endon("beginC4Tracking");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::func_8B2A("grenade_fire","weapon_change","offhand_end");
	self.changingweapon = undefined;
}

//Function Number: 68
watchforthrowbacks()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(self.gotpullbacknotify)
		{
			self.gotpullbacknotify = 0;
			continue;
		}

		if(!issubstr(var_01,"frag_") && !issubstr(var_01,"mortar_shell"))
		{
			continue;
		}

		var_00.threwback = 1;
		thread maps\mp\_utility::func_447B("throwbacks",1);
		var_00 thread maps\mp\gametypes\_shellshock::func_3DA7();
		var_00.originalowner = self;
	}
}

//Function Number: 69
c4used(param_00)
{
	if(!maps\mp\_utility::func_4945(self))
	{
		param_00 delete();
	}

	param_00 thread ondetonateexplosive();
	thread func_8CCF();
	thread func_8CCE();
	if(!self.plantedlethalequip.size)
	{
		thread func_8CCD();
	}

	param_00 setotherent(self);
	param_00.activated = 0;
	func_594C(param_00);
	param_00 thread maps\mp\gametypes\_shellshock::c4_earthquake();
	param_00 thread c4activate();
	param_00 thread c4damage();
	param_00 thread c4empdamage();
	param_00 thread func_8CD0();
	level thread monitordisownedequipment(self,param_00);
}

//Function Number: 70
func_54E0(param_00)
{
	if(!isdefined(param_00.lasttouchedplatform) || !isdefined(param_00.lasttouchedplatform.destroyexplosiveoncollision) || param_00.lasttouchedplatform.destroyexplosiveoncollision)
	{
		self notify("detonateExplosive");
	}
}

//Function Number: 71
func_8CD0()
{
	self endon("death");
	self waittill("missile_stuck",var_00);
	func_5016();
	func_5015();
	explosivehandlemovers(var_00);
}

//Function Number: 72
c4empdamage()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		equipmentempstunvfx();
		self.disabled = 1;
		self notify("disabled");
		wait(var_01);
		self.disabled = undefined;
		self notify("enabled");
	}
}

//Function Number: 73
func_6227(param_00)
{
	if(!maps\mp\_utility::func_4945(self))
	{
		param_00 delete();
	}

	param_00 waittill("missile_stuck",var_01);
	if(!maps\mp\_utility::func_4945(self))
	{
		param_00 delete();
	}

	if(!isdefined(param_00.owner.team))
	{
		param_00 delete();
	}

	var_02 = anglestoup(param_00.angles);
	param_00.origin = param_00.origin - var_02;
	var_03 = level.weaponconfigs[param_00.weapon_name];
	var_04 = spawn("script_model",param_00.origin + var_03.killcamoffset * var_02);
	var_04 setscriptmoverkillcam("explosive");
	var_04 linkto(param_00);
	param_00.killcament = var_04;
	param_00 explosivehandlemovers(var_01);
	param_00 func_5016();
	param_00 func_5015();
	func_594C(param_00);
	param_00 thread ondetonateexplosive();
	param_00 thread c4damage();
	param_00 thread proximityexplosiveempstun();
	param_00 thread func_6226(var_01);
	if(!maps\mp\_utility::func_47BB())
	{
		param_00 thread func_7004(self.team,20);
	}

	level thread monitordisownedequipment(self,param_00);
}

//Function Number: 74
func_6226(param_00)
{
	self endon("death");
	self endon("disabled");
	var_01 = level.weaponconfigs[self.weapon_name];
	wait(var_01.armingdelay);
	self playloopsound("ied_explo_beeps");
	thread doblinkinglight("tag_fx");
	var_02 = self.origin * (1,1,0);
	var_03 = var_01.detectionheight / 2;
	var_04 = self.origin[2] - var_03;
	var_02 = var_02 + (0,0,var_04);
	var_05 = spawn("trigger_radius",var_02,0,var_01.detectionradius,var_01.detectionheight);
	var_05.owner = self;
	if(isdefined(param_00))
	{
		var_05 enablelinkto();
		var_05 linkto(self);
	}

	self.damagearea = var_05;
	thread deleteondeath(var_05);
	var_06 = undefined;
	for(;;)
	{
		var_05 waittill("trigger",var_06);
		if(!isdefined(var_06))
		{
			continue;
		}

		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.owner))
			{
				if(var_06 == self.owner)
				{
					continue;
				}

				if(isdefined(var_06.owner) && var_06.owner == self.owner)
				{
					continue;
				}
			}

			if(!func_357F(self.owner,var_06,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_06 getentityvelocity()) < 10)
		{
			continue;
		}

		if(var_06 damageconetrace(self.origin,self) > 0)
		{
			break;
		}
	}

	self stoploopsound("ied_explo_beeps");
	self playsound("ied_warning");
	explosivetrigger(var_06,var_01.detectiongraceperiod,"proxExplosive");
	self notify("detonateExplosive");
}

//Function Number: 75
proximityexplosiveempstun()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		equipmentempstunvfx();
		self.disabled = 1;
		self notify("disabled");
		proximityexplosivecleanup();
		wait(var_01);
		if(isdefined(self))
		{
			self.disabled = undefined;
			self notify("enabled");
			var_02 = self getlinkedparent();
			thread func_6226(var_02);
		}
	}
}

//Function Number: 76
proximityexplosivecleanup()
{
	func_7C5B();
	if(isdefined(self.damagearea))
	{
		self.damagearea delete();
	}
}

//Function Number: 77
func_7004(param_00,param_01)
{
	self endon("death");
	wait(0.05);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::func_70E0(param_00,(0,0,param_01));
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::func_7099(self.owner,(0,0,param_01));
	}
}

//Function Number: 78
claymoreused(param_00)
{
	if(!isalive(self))
	{
		param_00 delete();
	}

	param_00 hide();
	param_00 common_scripts\utility::func_8B35(0.05,"missile_stuck");
	if(!isdefined(self) || !isalive(self))
	{
		param_00 delete();
	}

	var_01 = 60;
	var_02 = (0,0,4);
	var_03 = distancesquared(self.origin,param_00.origin);
	var_04 = distancesquared(self geteye(),param_00.origin);
	var_03 = var_03 + 600;
	var_05 = param_00 getlinkedparent();
	if(isdefined(var_05))
	{
		param_00 unlink();
	}

	if(var_03 < var_04)
	{
		if(var_01 * var_01 < distancesquared(param_00.origin,self.origin))
		{
			var_06 = bullettrace(self.origin,self.origin - (0,0,var_01),0,self);
			if(var_06["fraction"] == 1)
			{
				param_00 delete();
				self setweaponammostock(param_00.weapon_name,self getweaponammostock(param_00.weapon_name) + 1);
			}
			else
			{
				param_00.origin = var_06["position"];
				var_05 = var_06["entity"];
			}
		}
		else
		{
		}
	}
	else if(var_01 * var_01 < distancesquared(param_00.origin,self geteye()))
	{
		var_06 = bullettrace(self.origin,self.origin - (0,0,var_01),0,self);
		if(var_06["fraction"] == 1)
		{
			param_00 delete();
			self setweaponammostock(param_00.weapon_name,self getweaponammostock(param_00.weapon_name) + 1);
		}
		else
		{
			param_00.origin = var_06["position"];
			var_05 = var_06["entity"];
		}
	}
	else
	{
		var_02 = (0,0,-5);
		param_00.angles = param_00.angles + (0,180,0);
	}

	param_00.angles = param_00.angles * (0,1,1);
	param_00.origin = param_00.origin + var_02;
	param_00 explosivehandlemovers(var_05);
	param_00 show();
	param_00 func_5016();
	param_00 func_5015();
	func_594C(param_00);
	param_00 thread ondetonateexplosive();
	param_00 thread c4damage();
	param_00 thread c4empdamage();
	param_00 thread claymoredetonation(var_05);
	if(!maps\mp\_utility::func_47BB())
	{
		param_00 thread func_7004(self.pers["team"],20);
	}

	self.changingweapon = undefined;
	level thread monitordisownedequipment(self,param_00);
}

//Function Number: 79
func_2F97(param_00,param_01)
{
	if(!maps\mp\_utility::func_47BB())
	{
		self notify("equipmentWatchUse");
		self endon("spawned_player");
		self endon("disconnect");
		self endon("equipmentWatchUse");
		self.trigger setcursorhint("HINT_NOICON");
		switch(self.weapon_name)
		{
			case "c4_mp":
				self.trigger sethintstring(&"MP_PICKUP_C4");
				break;

			case "claymore_mp":
				self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
				break;

			case "bouncingbetty_mp":
				self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
				break;

			case "motion_sensor_mp":
				self.trigger sethintstring(&"MP_PICKUP_MOTION_SENSOR");
				break;

			case "proximity_explosive_mp":
				self.trigger sethintstring(&"MP_PICKUP_PROXIMITY_EXPLOSIVE");
				break;
		}

		self.trigger maps\mp\_utility::func_70BF(param_00);
		self.trigger thread maps\mp\_utility::func_573A(param_00);
		if(isdefined(param_01) && param_01)
		{
			thread func_874B();
		}

		for(;;)
		{
			self.trigger waittill("trigger",param_00);
			param_00 playlocalsound("scavenger_pack_pickup");
			if(isdefined(param_00.loadoutperkequipmentstowed) && param_00.loadoutperkequipmentstowed == self.weapon_name)
			{
				param_00.loadoutperkequipmentstowedammo++;
			}
			else
			{
				param_00 setweaponammostock(self.weapon_name,param_00 getweaponammostock(self.weapon_name) + 1);
			}

			deleteexplosive();
			self notify("death");
		}
	}
}

//Function Number: 80
func_874B()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self) && isdefined(self.trigger))
		{
			self.trigger.origin = self.origin + func_3AA5();
			if(isdefined(self.bombsquadmodel))
			{
				self.bombsquadmodel.origin = self.origin;
			}
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 81
claymoredetonation(param_00)
{
	self endon("death");
	var_01 = spawn("trigger_radius",self.origin + (0,0,0 - level.claymoredetonateradius),0,level.claymoredetonateradius,level.claymoredetonateradius * 2);
	if(isdefined(param_00))
	{
		var_01 enablelinkto();
		var_01 linkto(param_00);
	}

	thread deleteondeath(var_01);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(getdvarint("scr_claymoredebug") != 1)
		{
			if(isdefined(self.owner))
			{
				if(var_02 == self.owner)
				{
					continue;
				}

				if(isdefined(var_02.owner) && var_02.owner == self.owner)
				{
					continue;
				}
			}

			if(!func_357F(self.owner,var_02,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_02 getentityvelocity()) < 10)
		{
			continue;
		}

		var_03 = abs(var_02.origin[2] - self.origin[2]);
		if(var_03 > 128)
		{
			continue;
		}

		if(!var_02 func_749C(self))
		{
			continue;
		}

		if(var_02 damageconetrace(self.origin,self) > 0)
		{
			break;
		}
	}

	self playsound("claymore_activated");
	explosivetrigger(var_02,level.claymoredetectiongraceperiod,"claymore");
	if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
	{
		self.owner thread [[ level.leaderdialogonplayer_func ]]("claymore_destroyed",undefined,undefined,self.origin);
	}

	self notify("detonateExplosive");
}

//Function Number: 82
func_749C(param_00)
{
	if(isdefined(param_00.disabled))
	{
		return 0;
	}

	var_01 = self.origin + (0,0,32);
	var_02 = var_01 - param_00.origin;
	var_03 = anglestoforward(param_00.angles);
	var_04 = vectordot(var_02,var_03);
	if(var_04 < level.claymoredetectionmindist)
	{
		return 0;
	}

	var_02 = vectornormalize(var_02);
	var_05 = vectordot(var_02,var_03);
	return var_05 > level.claymoredetectiondot;
}

//Function Number: 83
deleteondeath(param_00)
{
	self waittill("death");
	wait(0.05);
	if(isdefined(param_00))
	{
		if(isdefined(param_00.trigger))
		{
			param_00.trigger delete();
		}

		param_00 delete();
	}
}

//Function Number: 84
c4activate()
{
	self endon("death");
	self waittill("missile_stuck",var_00);
	wait(0.05);
	self notify("activated");
	self.activated = 1;
}

//Function Number: 85
func_8CCD()
{
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.5)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			if(!self.plantedlethalequip.size)
			{
			}

			self notify("alt_detonate");
		}

		wait(0.05);
	}
}

//Function Number: 86
func_8CCF()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittillmatch("c4_mp","detonate");
		func_18F3();
	}
}

//Function Number: 87
func_8CCE()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("alt_detonate");
		var_00 = self getcurrentweapon();
		if(var_00 != "c4_mp")
		{
			func_18F3();
		}
	}
}

//Function Number: 88
func_18F3()
{
	foreach(var_01 in self.plantedlethalequip)
	{
		if(isdefined(var_01))
		{
			var_01 thread func_8ACE(0.1);
		}
	}

	self.plantedlethalequip = [];
	self notify("detonated");
}

//Function Number: 89
func_8ACE(param_00)
{
	self endon("death");
	wait(param_00);
	func_8BB5();
	self notify("detonateExplosive");
}

//Function Number: 90
c4damage()
{
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_00) && !isbot(var_00))
		{
			continue;
		}

		if(!func_357F(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "concussion_grenade_mp":
				case "smoke_grenade_mp":
				case "flash_grenade_mp":
					break;
			}
		}

		break;
	}

	if(level.c4explodethisframe)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
	}

	level.c4explodethisframe = 1;
	thread func_6608();
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(isdefined(var_08) && var_08 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	if(isdefined(var_00))
	{
		self.damagedby = var_00;
	}

	if(isplayer(var_00))
	{
		var_00 maps\mp\gametypes\_damagefeedback::func_86E0("c4");
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(self.owner))
		{
			var_0A = var_00.pers["team"];
			var_0B = self.owner.pers["team"];
			if(isdefined(var_0A) && isdefined(var_0B) && var_0A != var_0B)
			{
				var_00 notify("destroyed_equipment");
			}
		}
	}
	else if(isdefined(self.owner) && isdefined(var_00) && var_00 != self.owner)
	{
		var_00 notify("destroyed_equipment");
	}

	self notify("detonateExplosive",var_00);
}

//Function Number: 91
func_6608()
{
	wait(0.05);
	level.c4explodethisframe = 0;
}

//Function Number: 92
func_6AB1(param_00,param_01)
{
	for(var_02 = 0;var_02 < 60;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 93
func_8BB5()
{
	if(!isdefined(self.disabled))
	{
	}

	self waittill("enabled");
}

//Function Number: 94
c4detectiontrigger(param_00)
{
	self waittill("activated");
	var_01 = spawn("trigger_radius",self.origin - (0,0,128),0,512,256);
	var_01.detectid = "trigger" + gettime() + randomint(1000000);
	var_01.owner = self;
	var_01 thread func_26CC(level.otherteam[param_00]);
	self waittill("death");
	var_01 notify("end_detection");
	if(isdefined(var_01.bombsquadicon))
	{
		var_01.bombsquadicon destroy();
	}

	var_01 delete();
}

//Function Number: 95
claymoredetectiontrigger(param_00)
{
	var_01 = spawn("trigger_radius",self.origin - (0,0,128),0,512,256);
	var_01.detectid = "trigger" + gettime() + randomint(1000000);
	var_01.owner = self;
	var_01 thread func_26CC(level.otherteam[param_00]);
	self waittill("death");
	var_01 notify("end_detection");
	if(isdefined(var_01.bombsquadicon))
	{
		var_01.bombsquadicon destroy();
	}

	var_01 delete();
}

//Function Number: 96
func_26CC(param_00)
{
	self endon("end_detection");
	level endon("game_ended");
	while(!level.gameended)
	{
		self waittill("trigger",var_01);
		if(!var_01.detectexplosives)
		{
			continue;
		}

		if(level.teambased && var_01.team != param_00)
		{
			continue;
		}
		else if(!level.teambased && var_01 == self.owner.owner)
		{
			continue;
		}

		if(isdefined(var_01.bombsquadids[self.detectid]))
		{
			continue;
		}

		var_01 thread func_7512(self);
	}
}

//Function Number: 97
monitordisownedequipment(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	param_00 common_scripts\utility::func_8B2A("joined_team","joined_spectators","disconnect");
	param_01 deleteexplosive();
}

//Function Number: 98
func_594C(param_00)
{
	if(self.plantedlethalequip.size)
	{
		self.plantedlethalequip = common_scripts\utility::array_removeundefined(self.plantedlethalequip);
		if(self.plantedlethalequip.size >= level.maxperplayerexplosives)
		{
			self.plantedlethalequip[0] notify("detonateExplosive");
		}
	}

	self.plantedlethalequip[self.plantedlethalequip.size] = param_00;
	var_01 = param_00 getentitynumber();
	level.mines[var_01] = param_00;
	level notify("mine_planted");
}

//Function Number: 99
func_597C(param_00)
{
	if(self.plantedtacticalequip.size)
	{
		self.plantedtacticalequip = common_scripts\utility::array_removeundefined(self.plantedtacticalequip);
		if(self.plantedtacticalequip.size >= level.maxperplayerexplosives)
		{
			self.plantedtacticalequip[0] notify("detonateExplosive");
		}
	}

	self.plantedtacticalequip[self.plantedtacticalequip.size] = param_00;
	var_01 = param_00 getentitynumber();
	level.mines[var_01] = param_00;
	level notify("mine_planted");
}

//Function Number: 100
disableplantedequipmentuse()
{
	if(isdefined(self.plantedlethalequip) && self.plantedlethalequip.size > 0)
	{
		foreach(var_01 in self.plantedlethalequip)
		{
			if(isdefined(var_01.trigger) && isdefined(var_01.owner))
			{
				var_01.trigger disableplayeruse(var_01.owner);
			}
		}
	}

	if(isdefined(self.plantedtacticalequip) && self.plantedtacticalequip.size > 0)
	{
		foreach(var_01 in self.plantedtacticalequip)
		{
			if(isdefined(var_01.trigger) && isdefined(var_01.owner))
			{
				var_01.trigger disableplayeruse(var_01.owner);
			}
		}
	}
}

//Function Number: 101
cleanupequipment(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		level.mines[param_00] = undefined;
	}

	if(isdefined(param_01))
	{
		param_01 delete();
	}

	if(isdefined(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_03))
	{
		param_03 delete();
	}
}

//Function Number: 102
deleteexplosive()
{
	if(isdefined(self))
	{
		var_00 = self getentitynumber();
		var_01 = self.killcament;
		var_02 = self.trigger;
		var_03 = self.sensor;
		cleanupequipment(var_00,var_01,var_02,var_03);
		self notify("deleted_equipment");
		self delete();
	}
}

//Function Number: 103
ondetonateexplosive()
{
	self endon("death");
	level endon("game_ended");
	thread cleanupexplosivesondeath();
	self waittill("detonateExplosive");
	self detonate(self.owner);
}

//Function Number: 104
cleanupexplosivesondeath()
{
	self endon("deleted_equipment");
	level endon("game_ended");
	var_00 = self getentitynumber();
	var_01 = self.killcament;
	var_02 = self.trigger;
	var_03 = self.sensor;
	self waittill("death");
	cleanupequipment(var_00,var_01,var_02,var_03);
}

//Function Number: 105
func_3AA5()
{
	var_00 = anglestoup(self.angles);
	return 10 * var_00;
}

//Function Number: 106
func_5016()
{
	if(maps\mp\_utility::func_4945(self.owner))
	{
		self setotherent(self.owner);
		self.trigger = spawn("script_origin",self.origin + func_3AA5());
		self.trigger.owner = self;
		thread func_2F97(self.owner,1);
	}
}

//Function Number: 107
func_5015(param_00)
{
	common_scripts\utility::func_5009(self.owner.team);
	if(!isdefined(param_00) || !param_00)
	{
		self makeentitynomeleetarget();
	}

	if(issentient(self))
	{
		self setthreatbiasgroup("DogsDontAttack");
	}
}

//Function Number: 108
explosivehandlemovers(param_00,param_01)
{
	var_02 = addstruct();
	var_02.linkparent = param_00;
	var_02.deathoverridecallback = ::func_54E0;
	var_02.endonstring = "death";
	if(!isdefined(param_01) || !param_01)
	{
		var_02.invalidparentoverridecallback = ::maps\mp\_movers::moving_platform_empty_func;
	}

	thread maps\mp\_movers::func_3F25(var_02);
}

//Function Number: 109
explosivetrigger(param_00,param_01,param_02)
{
	if(isplayer(param_00) && param_00 maps\mp\_utility::_hasperk("specialty_delaymine"))
	{
		param_00 notify("triggeredExpl",param_02);
		param_01 = level.delayminetime;
	}

	wait(param_01);
}

//Function Number: 110
func_71EC()
{
	self.bombsquadids = [];
	if(self.detectexplosives && !self.bombsquadicons.size)
	{
		for(var_00 = 0;var_00 < 4;var_00++)
		{
			self.bombsquadicons[var_00] = newclienthudelem(self);
			self.bombsquadicons[var_00].x = 0;
			self.bombsquadicons[var_00].y = 0;
			self.bombsquadicons[var_00].z = 0;
			self.bombsquadicons[var_00].alpha = 0;
			self.bombsquadicons[var_00].archived = 1;
			self.bombsquadicons[var_00] setmaterial("waypoint_bombsquad",14,14);
			self.bombsquadicons[var_00] setwaypoint(0,0);
			self.bombsquadicons[var_00].detectid = "";
		}
	}

	if(!self.detectexplosives)
	{
		for(var_00 = 0;var_00 < self.bombsquadicons.size;var_00++)
		{
			self.bombsquadicons[var_00] destroy();
		}

		self.bombsquadicons = [];
	}
}

//Function Number: 111
func_7512(param_00)
{
	var_01 = param_00.detectid;
	var_02 = -1;
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_04 = self.bombsquadicons[var_03].detectid;
		if(var_04 == var_01)
		{
		}

		if(var_04 == "")
		{
			var_02 = var_03;
		}
	}

	if(var_02 < 0)
	{
	}

	self.bombsquadids[var_01] = 1;
	self.bombsquadicons[var_02].x = param_00.origin[0];
	self.bombsquadicons[var_02].y = param_00.origin[1];
	self.bombsquadicons[var_02].z = param_00.origin[2] + 24 + 128;
	self.bombsquadicons[var_02] fadeovertime(0.25);
	self.bombsquadicons[var_02].alpha = 1;
	self.bombsquadicons[var_02].detectid = param_00.detectid;
	while(isalive(self) && isdefined(param_00) && self istouching(param_00))
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
	}

	self.bombsquadicons[var_02].detectid = "";
	self.bombsquadicons[var_02] fadeovertime(0.25);
	self.bombsquadicons[var_02].alpha = 0;
	self.bombsquadids[var_01] = undefined;
}

//Function Number: 112
func_3A70(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = param_01 * param_01;
	var_06 = level.players;
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		if(!isalive(var_06[var_07]) || var_06[var_07].sessionstate != "playing")
		{
			continue;
		}

		var_08 = maps\mp\_utility::func_3847(var_06[var_07]);
		var_09 = distancesquared(param_00,var_08);
		if(var_09 < var_05 && !param_02 || func_8DA4(param_00,var_08,param_03,var_06[var_07]))
		{
			var_04[var_04.size] = maps\mp\_utility::get_damageable_player(var_06[var_07],var_08);
		}
	}

	var_0A = getentarray("grenade","classname");
	for(var_07 = 0;var_07 < var_0A.size;var_07++)
	{
		var_0B = maps\mp\_utility::func_3844(var_0A[var_07]);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_8DA4(param_00,var_0B,param_03,var_0A[var_07]))
		{
			var_04[var_04.size] = maps\mp\_utility::func_3843(var_0A[var_07],var_0B);
		}
	}

	var_0C = getentarray("destructible","targetname");
	for(var_07 = 0;var_07 < var_0C.size;var_07++)
	{
		var_0B = var_0C[var_07].origin;
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_8DA4(param_00,var_0B,param_03,var_0C[var_07]))
		{
			var_0D = addstruct();
			var_0D.isplayer = 0;
			var_0D.isadestructable = 0;
			var_0D.entity = var_0C[var_07];
			var_0D.damagecenter = var_0B;
			var_04[var_04.size] = var_0D;
		}
	}

	var_0E = getentarray("destructable","targetname");
	for(var_07 = 0;var_07 < var_0E.size;var_07++)
	{
		var_0B = var_0E[var_07].origin;
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_8DA4(param_00,var_0B,param_03,var_0E[var_07]))
		{
			var_0D = addstruct();
			var_0D.isplayer = 0;
			var_0D.isadestructable = 1;
			var_0D.entity = var_0E[var_07];
			var_0D.damagecenter = var_0B;
			var_04[var_04.size] = var_0D;
		}
	}

	var_0F = getentarray("misc_turret","classname");
	foreach(var_11 in var_0F)
	{
		var_0B = var_11.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_8DA4(param_00,var_0B,param_03,var_11))
		{
			switch(var_11.model)
			{
				case "vehicle_ugv_talon_gun_mp":
				case "mp_remote_turret":
				case "mp_scramble_turret":
				case "mp_sam_turret":
				case "sentry_minigun_weak":
					var_04[var_04.size] = maps\mp\_utility::func_3848(var_11,var_0B);
					break;
			}
		}
	}

	var_13 = getentarray("script_model","classname");
	foreach(var_15 in var_13)
	{
		if(var_15.model != "projectile_bouncing_betty_grenade" && var_15.model != "ims_scorpion_body")
		{
			continue;
		}

		var_0B = var_15.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_8DA4(param_00,var_0B,param_03,var_15))
		{
			var_04[var_04.size] = maps\mp\_utility::get_damageable_mine(var_15,var_0B);
		}
	}

	return var_04;
}

//Function Number: 113
getempdamageents(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = param_01 * param_01;
	level.mines = common_scripts\utility::array_removeundefined(level.mines);
	foreach(var_07 in level.mines)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	var_09 = getentarray("misc_turret","classname");
	foreach(var_07 in var_09)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.uplinks)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.remote_uav)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.balldrones)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.placedims)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.players)
	{
		if(empcandamage(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	return var_04;
}

//Function Number: 114
empcandamage(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00.origin;
	var_06 = distancesquared(param_01,var_05);
	return var_06 < param_02 && !param_03 || func_8DA4(param_01,var_05,param_04,param_00);
}

//Function Number: 115
func_8DA4(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = param_01 - param_00;
	if(lengthsquared(var_05) < param_02 * param_02)
	{
		return 1;
	}

	var_06 = vectornormalize(var_05);
	var_04 = param_00 + (var_06[0] * param_02,var_06[1] * param_02,var_06[2] * param_02);
	var_07 = bullettrace(var_04,param_01,0,param_03);
	if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0)
	{
		thread func_2429(param_00,".dmg");
		if(isdefined(param_03))
		{
			thread func_2429(param_01,"." + param_03.classname);
		}
		else
		{
			thread func_2429(param_01,".undefined");
		}

		if(var_07["fraction"] == 1)
		{
			thread func_2422(var_04,param_01,(1,1,1));
		}
		else
		{
			thread func_2422(var_04,var_07["position"],(1,0.9,0.8));
			thread func_2422(var_07["position"],param_01,(1,0.4,0.3));
		}
	}

	return var_07["fraction"] == 1;
}

//Function Number: 116
func_2306(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self.isplayer)
	{
		self.damageorigin = param_05;
		self.entity thread [[ level.callbackplayerdamage ]](param_00,param_01,param_02,0,param_03,param_04,param_05,param_06,"none",0);
	}

	if(self.isadestructable && param_04 == "artillery_mp" || param_04 == "claymore_mp" || param_04 == "stealth_bomb_mp" || param_04 == "alienclaymore_mp")
	{
	}

	self.entity notify("damage",param_02,param_01,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,param_04);
}

//Function Number: 117
func_2422(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < 600;var_03++)
	{
		wait(0.05);
	}
}

//Function Number: 118
debugcircle(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 16;
	}

	var_04 = 360 / param_03;
	var_05 = [];
	for(var_06 = 0;var_06 < param_03;var_06++)
	{
		var_07 = var_04 * var_06;
		var_08 = cos(var_07) * param_01;
		var_09 = sin(var_07) * param_01;
		var_0A = param_00[0] + var_08;
		var_0B = param_00[1] + var_09;
		var_0C = param_00[2];
		var_05[var_05.size] = (var_0A,var_0B,var_0C);
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_0D = var_05[var_06];
		if(var_06 + 1 >= var_05.size)
		{
			var_0E = var_05[0];
		}
		else
		{
			var_0E = var_05[var_06 + 1];
		}

		thread func_2422(var_0D,var_0E,param_02);
	}
}

//Function Number: 119
func_2429(param_00,param_01)
{
	for(var_02 = 0;var_02 < 600;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 120
onweapondamage(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	switch(param_01)
	{
		case "concussion_grenade_mp":
			if(!isdefined(param_00))
			{
			}
			else if(param_02 == "MOD_IMPACT")
			{
			}
	
			var_05 = 1;
			if(isdefined(param_00.owner) && param_00.owner == param_04)
			{
				var_05 = 0;
			}
	
			var_06 = 512;
			var_07 = 1 - distance(self.origin,param_00.origin) / var_06;
			if(var_07 < 0)
			{
				var_07 = 0;
			}
	
			var_08 = 2 + 4 * var_07;
			var_08 = maps\mp\perks\_perkfunctions::applystunresistence(var_08);
			wait(0.05);
			param_04 notify("stun_hit");
			self notify("concussed",param_04);
			if(param_04 != self)
			{
				param_04 maps\mp\gametypes\_missions::func_61CE("ch_alittleconcussed");
			}
	
			self shellshock("concussion_grenade_mp",var_08);
			self.concussionendtime = gettime() + var_08 * 1000;
			if(var_05)
			{
				param_04 thread maps\mp\gametypes\_damagefeedback::func_86E0("stun");
			}
			break;

		case "weapon_cobra_mk19_mp":
			break;

		default:
			maps\mp\gametypes\_shellshock::func_73FE(param_02,param_03);
			break;
	}
}

//Function Number: 121
isprimaryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "smg":
		case "mg":
		case "pistol":
		case "rifle":
		case "sniper":
		case "rocketlauncher":
		case "spread":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 122
isbulletweapon(param_00)
{
	if(param_00 == "none" || func_494E(param_00) || isknifeonly(param_00))
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "smg":
		case "mg":
		case "pistol":
		case "rifle":
		case "sniper":
		case "spread":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 123
isknifeonly(param_00)
{
	return issubstr(param_00,"knifeonly");
}

//Function Number: 124
func_4871(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "altmode";
}

//Function Number: 125
func_48E7(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "item";
}

//Function Number: 126
func_494E(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weapontype(param_00) == "riotshield";
}

//Function Number: 127
isoffhandweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "offhand";
}

//Function Number: 128
issidearm(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	return weaponclass(param_00) == "pistol";
}

//Function Number: 129
func_48D0(param_00)
{
	var_01 = weaponclass(param_00);
	var_02 = weaponinventorytype(param_00);
	if(var_01 != "grenade")
	{
		return 0;
	}

	if(var_02 != "offhand")
	{
		return 0;
	}

	return 1;
}

//Function Number: 130
isthrowingknife(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return issubstr(param_00,"throwingknife");
}

//Function Number: 131
isrocketlauncher(param_00)
{
	return param_00 == "iw6_panzerfaust3_mp" || param_00 == "iw6_maaws_mp";
}

//Function Number: 132
updatesavedlastweapon()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.currentweaponatspawn;
	if(isdefined(self.saved_lastweaponhack))
	{
		var_00 = self.saved_lastweaponhack;
	}

	self.saved_lastweapon = var_00;
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_01 == "none")
		{
			self.saved_lastweapon = var_00;
			continue;
		}

		var_02 = weaponinventorytype(var_01);
		if(var_02 != "primary" && var_02 != "altmode")
		{
			self.saved_lastweapon = var_00;
			continue;
		}

		func_8707();
		self.saved_lastweapon = var_00;
		var_00 = var_01;
	}
}

//Function Number: 133
empplayer(param_00)
{
	self endon("disconnect");
	self endon("death");
	thread clearempondeath();
}

//Function Number: 134
clearempondeath()
{
	self endon("disconnect");
	self waittill("death");
}

//Function Number: 135
func_3C7B()
{
	var_00 = 1000;
	self.weaponlist = self getweaponslistprimaries();
	if(self.weaponlist.size)
	{
		foreach(var_02 in self.weaponlist)
		{
			var_03 = func_3C83(var_02);
			if(var_03 == 0)
			{
				continue;
			}

			if(var_03 < var_00)
			{
				var_00 = var_03;
			}
		}
	}
	else
	{
		var_00 = 8;
	}

	var_00 = func_1C99(var_00);
	return var_00;
}

//Function Number: 136
func_3C83(param_00)
{
	var_01 = undefined;
	var_02 = maps\mp\_utility::func_3A37(param_00);
	if(maps\mp\_utility::func_47BB())
	{
		var_01 = castfloat(tablelookup("mp/alien/mode_string_tables/alien_statstable.csv",4,var_02,8));
	}
	else
	{
		var_01 = castfloat(tablelookup("mp/statstable.csv",4,var_02,8));
	}

	return var_01;
}

//Function Number: 137
func_1C99(param_00)
{
	return clamp(param_00,0,11);
}

//Function Number: 138
func_8707()
{
	var_00 = undefined;
	self.weaponlist = self getweaponslistprimaries();
	if(!self.weaponlist.size)
	{
		var_00 = 8;
	}
	else
	{
		var_01 = self getcurrentweapon();
		var_02 = weaponinventorytype(var_01);
		if(var_02 != "primary" && var_02 != "altmode")
		{
			if(isdefined(self.saved_lastweapon))
			{
				var_01 = self.saved_lastweapon;
			}
			else
			{
				var_01 = undefined;
			}
		}

		if(!isdefined(var_01) || !self hasweapon(var_01))
		{
			var_00 = func_3C7B();
		}
		else
		{
			var_00 = func_3C83(var_01);
			var_00 = func_1C99(var_00);
		}
	}

	var_03 = var_00 / 10;
	self.weaponspeed = var_03;
	if(!isdefined(self.combatspeedscalar))
	{
		self.combatspeedscalar = 1;
	}

	self setmovespeedscale(var_03 * self.movespeedscaler * self.combatspeedscalar);
}

//Function Number: 139
func_79C4()
{
	if(!isplayer(self))
	{
	}

	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self notifyonplayercommand("adjustedStance","+stance");
	self notifyonplayercommand("adjustedStance","+goStand");
	if(!level.console && !isai(self))
	{
		self notifyonplayercommand("adjustedStance","+togglecrouch");
		self notifyonplayercommand("adjustedStance","toggleprone");
		self notifyonplayercommand("adjustedStance","+movedown");
		self notifyonplayercommand("adjustedStance","-movedown");
		self notifyonplayercommand("adjustedStance","+prone");
		self notifyonplayercommand("adjustedStance","-prone");
	}

	for(;;)
	{
		common_scripts\utility::func_8B2A("adjustedStance","sprint_begin","weapon_change");
		wait(0.5);
		if(isdefined(self.onhelisniper) && self.onhelisniper)
		{
			continue;
		}

		var_00 = self getstance();
		stancerecoilupdate(var_00);
	}
}

//Function Number: 140
stancerecoilupdate(param_00)
{
	var_01 = self getcurrentprimaryweapon();
	var_02 = 0;
	if(isrecoilreducingweapon(var_01))
	{
		var_02 = getrecoilreductionvalue();
	}

	if(param_00 == "prone")
	{
		var_03 = maps\mp\_utility::getweaponclass(var_01);
		if(var_03 == "weapon_lmg")
		{
			maps\mp\_utility::func_70B1(0,40);
		}

		if(var_03 == "weapon_sniper")
		{
			if(issubstr(var_01,"barrelbored"))
			{
				maps\mp\_utility::func_70B1(0,20 + var_02);
			}

			maps\mp\_utility::func_70B1(0,40 + var_02);
		}

		maps\mp\_utility::func_70B1();
	}

	if(param_00 == "crouch")
	{
		var_03 = maps\mp\_utility::getweaponclass(var_01);
		if(var_03 == "weapon_lmg")
		{
			maps\mp\_utility::func_70B1(0,10);
		}

		if(var_03 == "weapon_sniper")
		{
			if(issubstr(var_01,"barrelbored"))
			{
				maps\mp\_utility::func_70B1(0,10 + var_02);
			}

			maps\mp\_utility::func_70B1(0,20 + var_02);
		}

		maps\mp\_utility::func_70B1();
	}

	if(var_02 > 0)
	{
		maps\mp\_utility::func_70B1(0,var_02);
	}

	maps\mp\_utility::func_70B1();
}

//Function Number: 141
func_186C(param_00)
{
	var_01 = maps\mp\_utility::getattachmentlistbasenames();
	var_01 = common_scripts\utility::alphabetize(var_01);
	var_02 = 149;
	var_03 = [];
	var_04 = "mp/statstable.csv";
	var_05 = getdvar("g_gametype");
	if(var_05 == "aliens")
	{
		var_04 = "mp/alien/mode_string_tables/alien_statstable.csv";
	}

	for(var_06 = 0;var_06 <= var_02;var_06++)
	{
		var_07 = tablelookup(var_04,0,var_06,4);
		if(var_07 == "")
		{
			continue;
		}

		var_08 = var_07 + "_mp";
		if(!issubstr(tablelookup(var_04,0,var_06,2),"weapon_"))
		{
			continue;
		}

		if(weaponinventorytype(var_08) != "primary")
		{
			continue;
		}

		var_09 = addstruct();
		var_09.basename = var_07;
		var_09.assetname = var_08;
		var_09.variants = [];
		var_09.variants[0] = var_08;
		var_0A = [];
		for(var_0B = 0;var_0B < 6;var_0B++)
		{
			var_0C = tablelookup(var_04,0,var_06,var_0B + 11);
			if(param_00)
			{
				switch(var_0C)
				{
					case "xmags":
					case "rof":
					case "fmj":
						break;
				}
			}

			if(var_0C == "")
			{
				break;
			}

			var_0A[var_0C] = 1;
		}

		var_0D = [];
		foreach(var_0C in var_01)
		{
			if(!isdefined(var_0A[var_0C]))
			{
				continue;
			}

			var_09.variants[var_09.variants.size] = var_07 + "_" + var_0C + "_mp";
			var_0D[var_0D.size] = var_0C;
		}

		for(var_10 = 0;var_10 < var_0D.size - 1;var_10++)
		{
			var_11 = tablelookuprownum("mp/attachmentCombos.csv",0,var_0D[var_10]);
			for(var_12 = var_10 + 1;var_12 < var_0D.size;var_12++)
			{
				if(tablelookup("mp/attachmentCombos.csv",0,var_0D[var_12],var_11) == "no")
				{
					continue;
				}

				var_09.variants[var_09.variants.size] = var_07 + "_" + var_0D[var_10] + "_" + var_0D[var_12] + "_mp";
			}
		}

		var_03[var_07] = var_09;
	}

	return var_03;
}

//Function Number: 142
monitormk32semtexlauncher()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	for(;;)
	{
		var_00 = maps\mp\_utility::func_8B68();
		if(isdefined(var_00.weapon_name) && var_00.weapon_name == "iw6_mk32_mp")
		{
			func_6D8E(var_00);
		}
	}
}

//Function Number: 143
func_6D8E(param_00)
{
	if(!isdefined(param_00))
	{
	}

	if(!isdefined(param_00.weapon_name))
	{
	}

	if(!issubstr(param_00.weapon_name,"semtex") && param_00.weapon_name != "iw6_mk32_mp")
	{
	}

	param_00.originalowner = self;
	param_00 waittill("missile_stuck",var_01);
	param_00 thread maps\mp\gametypes\_shellshock::func_3DA7();
	if(isplayer(var_01) || isbot(var_01))
	{
		if(!isdefined(self))
		{
			param_00.stuckenemyentity = var_01;
			var_01.stuckbygrenade = param_00;
		}
		else if(level.teambased && isdefined(var_01.team) && var_01.team == self.team)
		{
			param_00.isstuck = "friendly";
		}
		else
		{
			param_00.isstuck = "enemy";
			param_00.stuckenemyentity = var_01;
			if(isplayer(var_01))
			{
				var_01 maps\mp\gametypes\_hud_message::func_5F9A("semtex_stuck",self);
			}

			thread maps\mp\gametypes\_hud_message::func_794C("stuck_semtex",100);
			var_01.stuckbygrenade = param_00;
		}
	}

	param_00 explosivehandlemovers(undefined);
}

//Function Number: 144
func_84F2()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		thread func_84FC(var_00);
	}
}

//Function Number: 145
func_84FC(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("weapon_change","none");
	self waittill("turret_deactivate");
	param_00 notify("weapon_change",param_00 getcurrentweapon());
}

//Function Number: 146
func_78AE(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,randomfloat(360),0);
	}

	var_04 = level.weaponconfigs[param_02];
	var_05 = spawn("script_model",param_00);
	var_05.angles = param_03;
	var_05 setmodel(var_04.model);
	var_05.owner = param_01;
	var_05 setotherent(param_01);
	var_05.weapon_name = param_02;
	var_05.config = var_04;
	var_05.killcamoffset = (0,0,4);
	var_05.killcament = spawn("script_model",var_05.origin + var_05.killcamoffset);
	var_05.killcament setscriptmoverkillcam("explosive");
	param_01 func_594C(var_05);
	var_05 thread createbombsquadmodel(var_04.bombsquadmodel,"tag_origin",param_01);
	if(isdefined(var_04.mine_beacon))
	{
		var_05 thread doblinkinglight("tag_fx",var_04.mine_beacon["friendly"],var_04.mine_beacon["enemy"]);
	}

	if(!maps\mp\_utility::func_47BB())
	{
		var_05 thread func_7004(param_01.pers["team"],var_04.headiconoffset);
	}

	var_06 = undefined;
	if(self != level)
	{
		var_06 = self getlinkedparent();
	}

	var_05 explosivehandlemovers(var_06);
	var_05 thread mineproximitytrigger(var_06);
	var_05 thread maps\mp\gametypes\_shellshock::func_3DA7();
	var_05 func_5015(1);
	if(maps\mp\_utility::func_47BB() && issentient(var_05))
	{
		var_05 setthreatbiasgroup("deployable_ammo");
		var_05.threatbias = -10000;
	}

	var_05 thread func_524D();
	level thread monitordisownedequipment(param_01,var_05);
	return var_05;
}

//Function Number: 147
func_78B0(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,randomfloat(360),0);
	}

	var_04 = level.weaponconfigs[param_02];
	var_05 = spawn("script_model",param_00);
	var_05.angles = param_03;
	var_05 setmodel(var_04.model);
	var_05.owner = param_01;
	var_05 setotherent(param_01);
	var_05.weapon_name = param_02;
	var_05.config = var_04;
	param_01 func_597C(var_05);
	var_05 thread createbombsquadmodel(var_04.bombsquadmodel,"tag_origin",param_01);
	var_05 thread func_7004(param_01.pers["team"],var_04.headiconoffset);
	var_06 = undefined;
	if(self != level)
	{
		var_06 = self getlinkedparent();
	}

	var_05 explosivehandlemovers(var_06,1);
	var_05 thread mineproximitytrigger(var_06);
	var_05 thread maps\mp\gametypes\_shellshock::func_3DA7();
	var_05 thread motionsensorempdamage();
	var_05 func_5015(0);
	var_05 thread func_5259();
	level thread monitordisownedequipment(param_01,var_05);
	return var_05;
}

//Function Number: 148
minedamagemonitor()
{
	self endon("mine_triggered");
	self endon("mine_selfdestruct");
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(maps\mp\_utility::func_47BB() && is_hive_explosion(var_00,var_04))
		{
			break;
		}

		if(!isplayer(var_00) && !isbot(var_00))
		{
			continue;
		}

		if(isdefined(var_09) && isendstr(var_09,"betty_mp"))
		{
			continue;
		}

		if(!func_357F(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "concussion_grenade_mp":
				case "smoke_grenadejugg_mp":
				case "smoke_grenade_mp":
				case "flash_grenade_mp":
					break;
			}
		}

		break;
	}

	self notify("mine_destroyed");
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(isdefined(var_08) && var_08 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	if(isdefined(var_00))
	{
		self.damagedby = var_00;
	}

	if(isplayer(var_00))
	{
		var_00 maps\mp\gametypes\_damagefeedback::func_86E0("bouncing_betty");
	}

	if(!maps\mp\_utility::func_47BB())
	{
		if(level.teambased)
		{
			if(isdefined(var_00) && isdefined(var_00.pers["team"]) && isdefined(self.owner) && isdefined(self.owner.pers["team"]))
			{
				if(var_00.pers["team"] != self.owner.pers["team"])
				{
					var_00 notify("destroyed_equipment");
				}
			}
		}
		else if(isdefined(self.owner) && isdefined(var_00) && var_00 != self.owner)
		{
			var_00 notify("destroyed_equipment");
		}
	}

	self notify("detonateExplosive",var_00);
}

//Function Number: 149
is_hive_explosion(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_00.classname))
	{
		return 0;
	}

	return param_00.classname == "scriptable" && param_01 == "MOD_EXPLOSIVE";
}

//Function Number: 150
mineproximitytrigger(param_00)
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self endon("disabled");
	var_01 = self.config;
	wait(var_01.armtime);
	if(isdefined(var_01.mine_beacon))
	{
		thread doblinkinglight("tag_fx",var_01.mine_beacon["friendly"],var_01.mine_beacon["enemy"]);
	}

	var_02 = spawn("trigger_radius",self.origin,0,level.minedetectionradius,level.minedetectionheight);
	var_02.owner = self;
	thread func_5249(var_02);
	if(isdefined(param_00))
	{
		var_02 enablelinkto();
		var_02 linkto(param_00);
	}

	self.damagearea = var_02;
	var_03 = undefined;
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(!isdefined(var_03))
		{
			continue;
		}

		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.owner))
			{
				if(var_03 == self.owner)
				{
					continue;
				}

				if(isdefined(var_03.owner) && var_03.owner == self.owner)
				{
					continue;
				}
			}

			if(!func_357F(self.owner,var_03,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_03 getentityvelocity()) < 10)
		{
			continue;
		}

		if(var_03 damageconetrace(self.origin,self) > 0)
		{
			break;
		}
	}

	self notify("mine_triggered");
	self playsound(self.config.ontriggeredsfx);
	explosivetrigger(var_03,level.minedetectiongraceperiod,"mine");
	self thread [[ self.config.ontriggeredfunc ]]();
}

//Function Number: 151
func_5249(param_00)
{
	common_scripts\utility::func_8B2A("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 152
motionsensorempdamage()
{
	self endon("mine_triggered");
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		equipmentempstunvfx();
		func_7C5B();
		if(isdefined(self.damagearea))
		{
			self.damagearea delete();
		}

		self.disabled = 1;
		self notify("disabled");
		wait(var_01);
		if(isdefined(self))
		{
			self.disabled = undefined;
			self notify("enabled");
			var_02 = self getlinkedparent();
			thread mineproximitytrigger(var_02);
		}
	}
}

//Function Number: 153
func_5256()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("death");
	wait(level.mineselfdestructtime + randomfloat(0.4));
	self notify("mine_selfdestruct");
	self notify("detonateExplosive");
}

//Function Number: 154
func_5241()
{
	self playsound(self.config.onlaunchsfx);
	playfx(level.mine_launch,self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_00 = self.origin + (0,0,64);
	self moveto(var_00,0.7,0,0.65);
	self.killcament moveto(var_00 + self.killcamoffset,0.7,0,0.65);
	self rotatevelocity((0,750,32),0.7,0,0.65);
	thread func_6049();
	wait(0.65);
	self notify("detonateExplosive");
}

//Function Number: 155
func_524D()
{
	self endon("death");
	level endon("game_ended");
	self waittill("detonateExplosive",var_00);
	if(!isdefined(self) || !isdefined(self.owner))
	{
	}

	if(!isdefined(var_00))
	{
		var_00 = self.owner;
	}

	self playsound(self.config.onexplodesfx);
	var_01 = self gettagorigin("tag_fx");
	playfx(level.mine_explode,var_01);
	self notify("explode",var_01);
	wait(0.05);
	if(!isdefined(self) || !isdefined(self.owner))
	{
	}

	self hide();
	self entityradiusdamage(self.origin,level.minedamageradius,level.minedamagemax,level.minedamagemin,var_00,"MOD_EXPLOSIVE",self.weapon_name);
	if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
	{
		self.owner thread [[ level.leaderdialogonplayer_func ]]("mine_destroyed",undefined,undefined,self.origin);
	}

	wait(0.2);
	deleteexplosive();
}

//Function Number: 156
func_5258()
{
	self playsound(self.config.onlaunchsfx);
	playfx(self.config.launchvfx,self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	self hidepart("tag_sensor");
	func_7C5B();
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 setmodel(self.config.model);
	var_00 hidepart("tag_base");
	var_00.config = self.config;
	self.sensor = var_00;
	var_01 = self.origin + (0,0,self.config.launchheight);
	var_02 = self.config.launchtime;
	var_03 = self.config.launchtime + 0.1;
	var_00 moveto(var_01,var_03,0,var_02);
	var_00 rotatevelocity((0,1100,32),var_03,0,var_02);
	var_00 thread func_6049();
	wait(var_02);
	self notify("detonateExplosive");
}

//Function Number: 157
func_5259()
{
	self endon("death");
	level endon("game_ended");
	self waittill("detonateExplosive",var_00);
	if(!isdefined(self) || !isdefined(self.owner))
	{
	}

	if(!isdefined(var_00))
	{
		var_00 = self.owner;
	}

	self playsound(self.config.onexplodesfx);
	var_01 = undefined;
	if(isdefined(self.sensor))
	{
		var_01 = self.sensor gettagorigin("tag_sensor");
	}
	else
	{
		var_01 = self gettagorigin("tag_origin");
	}

	playfx(self.config.onexplodevfx,var_01);
	common_scripts\utility::func_8AFE();
	if(!isdefined(self) || !isdefined(self.owner))
	{
	}

	if(isdefined(self.sensor))
	{
		self.sensor delete();
	}
	else
	{
		self hidepart("tag_sensor");
	}

	self.owner thread maps\mp\gametypes\_damagefeedback::func_86E0("hitmotionsensor");
	var_02 = [];
	foreach(var_04 in level.characters)
	{
		if(var_04.team == self.owner.team)
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_04))
		{
			continue;
		}

		if(var_04 maps\mp\_utility::_hasperk("specialty_heartbreaker"))
		{
			continue;
		}

		if(distance2d(self.origin,var_04.origin) < 300)
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_07 in var_02)
	{
		thread markplayer(var_07,self.owner);
		level thread sensorscreeneffects(var_07,self.owner);
	}

	if(var_02.size > 0)
	{
		self.owner maps\mp\gametypes\_missions::func_61CE("ch_motiondetected",var_02.size);
		self.owner thread maps\mp\gametypes\_gamelogic::func_8091("motion_sensor",1,"hits");
	}

	if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
	{
		self.owner thread [[ level.leaderdialogonplayer_func ]]("mine_destroyed",undefined,undefined,self.origin);
	}

	wait(0.2);
	deleteexplosive();
}

//Function Number: 158
markplayer(param_00,param_01)
{
	if(param_00 == param_01)
	{
	}

	param_00 endon("disconnect");
	var_02 = undefined;
	if(level.teambased)
	{
		var_02 = maps\mp\_utility::func_5A45(param_00,"orange",param_01.team,0,"equipment");
	}
	else
	{
		var_02 = maps\mp\_utility::func_5A44(param_00,"orange",param_01,0,"equipment");
	}

	param_00 thread maps\mp\gametypes\_damagefeedback::func_86E0("hitmotionsensor");
	param_00.motionsensormarkedby = param_01;
	param_00 common_scripts\utility::func_8B35(self.config.markedduration,"death");
	param_00.motionsensormarkedby = undefined;
	maps\mp\_utility::func_5A40(var_02,param_00);
}

//Function Number: 159
sensorscreeneffects(param_00,param_01)
{
	if(param_00 == param_01)
	{
	}

	if(isai(param_00))
	{
	}

	var_02 = "coup_sunblind";
	param_00 setclientomnvar("ui_hud_shake",1);
	param_00 visionsetnakedforplayer(var_02,0.05);
	wait(0.05);
	param_00 visionsetnakedforplayer(var_02,0);
	param_00 visionsetnakedforplayer("",0.5);
}

//Function Number: 160
func_5408(param_00)
{
	if(isdefined(level.assists_disabled))
	{
	}

	self.taggedassist = 1;
	if(isdefined(param_00))
	{
		thread maps\mp\gametypes\_gamescore::processassist(param_00);
	}

	maps\mp\gametypes\_gamescore::func_3D00("assist",self,undefined,1);
	thread maps\mp\gametypes\_rank::giverankxp("assist");
}

//Function Number: 161
func_6049()
{
	if(isdefined(self.config.mine_spin))
	{
		self endon("death");
		var_00 = gettime() + 1000;
		while(gettime() < var_00)
		{
			wait(0.05);
			playfxontag(self.config.mine_spin,self,"tag_fx_spin1");
			playfxontag(self.config.mine_spin,self,"tag_fx_spin3");
			wait(0.05);
			playfxontag(self.config.mine_spin,self,"tag_fx_spin2");
			playfxontag(self.config.mine_spin,self,"tag_fx_spin4");
		}
	}
}

//Function Number: 162
func_5242(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06[0] = (1,0,0);
	var_06[1] = (0,1,0);
	if(param_01[2] < param_05)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	var_08 = (param_00[0],param_00[1],param_05);
	var_09 = (param_01[0],param_01[1],param_05);
	thread debugcircle(var_08,level.minedamageradius,var_06[var_07],32);
	var_0A = distancesquared(param_00,param_01);
	if(var_0A > param_02)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	thread func_2422(var_08,var_09,var_06[var_07]);
}

//Function Number: 163
func_5244(param_00,param_01)
{
	if(isplayer(param_01) && isalive(param_01) && param_01.sessionstate == "playing")
	{
		var_02 = param_01 maps\mp\_utility::func_3C02();
	}
	else if(var_02.classname == "misc_turret")
	{
		var_02 = var_02.origin + (0,0,32);
	}
	else
	{
		var_02 = var_02.origin;
	}

	var_03 = 0;
	var_04 = param_00.origin[2] + var_03 + level.minedamagehalfheight;
	var_05 = param_00.origin[2] + var_03 - level.minedamagehalfheight;
	if(var_02[2] > var_04 || var_02[2] < var_05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 164
func_525B(param_00,param_01)
{
	if(!isalive(self))
	{
		param_00 delete();
	}

	maps\mp\gametypes\_gamelogic::func_7049(self,1);
	param_00 thread minethrown(self,param_00.weapon_name,param_01);
}

//Function Number: 165
minethrown(param_00,param_01,param_02)
{
	self.owner = param_00;
	self waittill("missile_stuck",var_03);
	if(!isdefined(param_00))
	{
	}

	var_04 = bullettrace(self.origin + (0,0,4),self.origin - (0,0,4),0,self);
	var_05 = var_04["position"];
	if(var_04["fraction"] == 1)
	{
		var_05 = getgroundposition(self.origin,12,0,32);
		var_04["normal"] = var_04["normal"] * -1;
	}

	var_06 = vectornormalize(var_04["normal"]);
	var_07 = vectortoangles(var_06);
	var_07 = var_07 + (90,0,0);
	var_08 = [[ param_02 ]](var_05,param_00,param_01,var_07);
	var_08 func_5016();
	var_08 thread minedamagemonitor();
	self delete();
}

//Function Number: 166
delete_all_grenades()
{
	if(isdefined(self.plantedlethalequip))
	{
		foreach(var_01 in self.plantedlethalequip)
		{
			var_01 deleteexplosive();
		}
	}

	if(isdefined(self.plantedtacticalequip))
	{
		foreach(var_01 in self.plantedtacticalequip)
		{
			var_01 deleteexplosive();
		}
	}

	if(isdefined(self))
	{
		self.plantedlethalequip = [];
		self.plantedtacticalequip = [];
	}
}

//Function Number: 167
func_8255(param_00)
{
	param_00 delete_all_grenades();
	if(isdefined(self.plantedlethalequip))
	{
		param_00.plantedlethalequip = common_scripts\utility::array_removeundefined(self.plantedlethalequip);
	}

	if(isdefined(self.plantedtacticalequip))
	{
		param_00.plantedtacticalequip = common_scripts\utility::array_removeundefined(self.plantedtacticalequip);
	}

	if(isdefined(param_00.plantedlethalequip))
	{
		foreach(var_02 in param_00.plantedlethalequip)
		{
			var_02.owner = param_00;
			var_02 thread func_2F97(param_00);
		}
	}

	if(isdefined(param_00.plantedtacticalequip))
	{
		foreach(var_02 in param_00.plantedtacticalequip)
		{
			var_02.owner = param_00;
			var_02 thread func_2F97(param_00);
		}
	}

	self.plantedlethalequip = [];
	self.plantedtacticalequip = [];
	self.dont_delete_grenades_on_next_spawn = 1;
	self.dont_delete_mines_on_next_spawn = 1;
}

//Function Number: 168
doblinkinglight(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = common_scripts\utility::func_3AB9("weap_blink_friend");
	}

	if(!isdefined(param_02))
	{
		param_02 = common_scripts\utility::func_3AB9("weap_blink_enemy");
	}

	self.blinkinglightfx["friendly"] = param_01;
	self.blinkinglightfx["enemy"] = param_02;
	self.blinkinglighttag = param_00;
	thread func_86CF(param_01,param_02,param_00);
	self waittill("death");
	func_7C5B();
}

//Function Number: 169
func_86CF(param_00,param_01,param_02)
{
	self endon("death");
	self endon("carried");
	self endon("emp_damage");
	var_03 = ::checkteam;
	if(!level.teambased)
	{
		var_03 = ::checkplayer;
	}

	var_04 = randomfloatrange(0.05,0.25);
	wait(var_04);
	childthread func_5946(param_00,param_01,param_02,var_03);
	foreach(var_06 in level.players)
	{
		if(isdefined(var_06))
		{
			if(self.owner [[ var_03 ]](var_06))
			{
				playfxontagforclients(param_00,self,param_02,var_06);
			}
			else
			{
				playfxontagforclients(param_01,self,param_02,var_06);
			}

			wait(0.05);
		}
	}
}

//Function Number: 170
func_5946(param_00,param_01,param_02,param_03)
{
	self endon("death");
	level endon("game_ended");
	self endon("emp_damage");
	for(;;)
	{
		level waittill("joined_team",var_04);
		if(self.owner [[ param_03 ]](var_04))
		{
			playfxontagforclients(param_00,self,param_02,var_04);
			continue;
		}

		playfxontagforclients(param_01,self,param_02,var_04);
	}
}

//Function Number: 171
func_7C5B()
{
	if(isalive(self) && isdefined(self.blinkinglightfx))
	{
		stopfxontag(self.blinkinglightfx["friendly"],self,self.blinkinglighttag);
		stopfxontag(self.blinkinglightfx["enemy"],self,self.blinkinglighttag);
		self.blinkinglightfx = undefined;
		self.blinkinglighttag = undefined;
	}
}

//Function Number: 172
checkteam(param_00)
{
	return self.team == param_00.team;
}

//Function Number: 173
checkplayer(param_00)
{
	return self == param_00;
}

//Function Number: 174
equipmentdeathvfx()
{
	playfx(common_scripts\utility::func_3AB9("equipment_sparks"),self.origin);
	self playsound("sentry_explode");
}

//Function Number: 175
equipmentdeletevfx()
{
	playfx(common_scripts\utility::func_3AB9("equipment_explode_big"),self.origin);
	playfx(common_scripts\utility::func_3AB9("equipment_smoke"),self.origin);
	self playsound("mp_killstreak_disappear");
}

//Function Number: 176
equipmentempstunvfx()
{
	playfxontag(common_scripts\utility::func_3AB9("emp_stun"),self,"tag_origin");
}