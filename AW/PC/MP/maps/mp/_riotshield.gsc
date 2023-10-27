/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_riotshield.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 548 ms
 * Timestamp: 10/27/2023 1:49:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.riot_shield_names = [];
	level.riot_shield_names[level.riot_shield_names.size] = "riotshield_mp";
	level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6_mp";
	level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot0_mp";
	level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot1_mp";
	level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot2_mp";
	level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot3_mp";
	level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldjugg_mp";
	precacheanims();
	level.riot_shield_collision = getent("riot_shield_collision","targetname");
	level._effect["riot_shield_shock_fx"] = loadfx("vfx/explosion/riotshield_stun");
	level._effect["riot_shield_deploy_smoke"] = loadfx("vfx/smoke/riotshield_deploy_smoke");
	level._effect["riot_shield_deploy_lights"] = loadfx("vfx/lights/riotshield_deploy_lights");
}

//Function Number: 2
precacheanims()
{
	precachempanim("npc_deployable_riotshield_stand_deploy");
	precachempanim("npc_deployable_riotshield_stand_destroyed");
	precachempanim("npc_deployable_riotshield_stand_shot");
	precachempanim("npc_deployable_riotshield_stand_shot_back");
	precachempanim("npc_deployable_riotshield_stand_melee_front");
	precachempanim("npc_deployable_riotshield_stand_melee_back");
}

//Function Number: 3
hasriotshield()
{
	return isdefined(self.frontshieldmodel) || isdefined(self.backshieldmodel);
}

//Function Number: 4
hasriotshieldequipped()
{
	return isdefined(self.frontshieldmodel);
}

//Function Number: 5
weaponisriotshield(param_00)
{
	if(!isdefined(level.riot_shield_names))
	{
		return 0;
	}

	var_01 = getweaponbasename(param_00);
	if(!isdefined(var_01))
	{
		var_01 = param_00;
	}

	foreach(var_03 in level.riot_shield_names)
	{
		if(var_03 == var_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
weaponisshockplantriotshield(param_00)
{
	if(!weaponisriotshield(param_00))
	{
		return 0;
	}

	return issubstr(param_00,"shockplant");
}

//Function Number: 7
getotherriotshieldname(param_00)
{
	var_01 = 0;
	var_02 = self getweaponslistprimaries();
	foreach(var_04 in var_02)
	{
		if(weaponisriotshield(var_04))
		{
			if(var_04 == param_00 && !var_01)
			{
				var_01 = 1;
				continue;
			}

			return var_04;
		}
	}

	return undefined;
}

//Function Number: 8
updatefrontandbackshields(param_00)
{
	self.frontshieldmodel = undefined;
	self.backshieldmodel = undefined;
	if(!isdefined(param_00))
	{
		param_00 = self getcurrentprimaryweapon();
	}

	if(weaponisriotshield(param_00))
	{
		self.frontshieldmodel = getweaponmodel(param_00);
	}

	var_01 = getotherriotshieldname(param_00);
	if(isdefined(var_01))
	{
		self.backshieldmodel = getweaponmodel(var_01);
	}

	self refreshshieldmodels(param_00);
}

//Function Number: 9
riotshield_clear()
{
	self.frontshieldmodel = undefined;
	self.backshieldmodel = undefined;
}

//Function Number: 10
entisstucktoshield()
{
	if(!self islinked())
	{
		return 0;
	}

	var_00 = self getlinkedtagname();
	if(!isdefined(var_00))
	{
		return 0;
	}

	switch(var_00)
	{
		case "tag_shield_back":
		case "tag_weapon_left":
		case "tag_inhand":
			break;
	}
}

//Function Number: 11
watchriotshielduse()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	thread trackriotshield();
	for(;;)
	{
		self waittill("raise_riotshield");
		thread startriotshielddeploy();
	}
}

//Function Number: 12
riotshield_watch_for_change_weapon()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("riotshield_change_weapon");
	var_00 = undefined;
	self waittill("weapon_change",var_00);
	self notify("riotshield_change_weapon",var_00);
}

//Function Number: 13
riotshield_watch_for_start_change_weapon()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("riotshield_change_weapon");
	var_00 = undefined;
	for(;;)
	{
		self waittill("weapon_switch_started",var_00);
		if(self isonladder())
		{
			thread riotshield_watch_for_ladder_early_exit();
			break;
		}

		if(isdefined(self.frontshieldmodel) && isdefined(self.backshieldmodel))
		{
			wait(0.5);
			break;
		}
	}

	self notify("riotshield_change_weapon",var_00);
}

//Function Number: 14
riotshield_watch_for_ladder_early_exit()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("weapon_change");
	while(self isonladder())
	{
		wait 0.05;
	}

	self notify("riotshield_change_weapon",self getcurrentprimaryweapon());
}

//Function Number: 15
riotshield_watch_for_exo_shield_pullback()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("riotshield_change_weapon");
	var_00 = undefined;
	var_01 = maps\mp\_exo_shield::get_exo_shield_weapon();
	self waittillmatch(var_01,"grenade_pullback");
	while(!isdefined(self.exo_shield_on) || !self.exo_shield_on)
	{
		wait 0.05;
	}

	self notify("riotshield_change_weapon",var_01);
}

//Function Number: 16
riotshield_watch_for_exo_shield_release()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("riotshield_change_weapon");
	if(!isdefined(self.exo_shield_on) || !self.exo_shield_on)
	{
		return;
	}

	var_00 = undefined;
	var_01 = maps\mp\_exo_shield::get_exo_shield_weapon();
	self waittillmatch(var_01,"battery_discharge_end");
	while(isdefined(self.exo_shield_on) && self.exo_shield_on)
	{
		wait 0.05;
	}

	self notify("riotshield_change_weapon",self getcurrentweapon());
}

//Function Number: 17
watchriotshieldloadout()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("track_riot_shield");
	self waittill("applyLoadout");
	updatefrontandbackshields(self getcurrentweapon());
}

//Function Number: 18
trackriotshield()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self notify("track_riot_shield");
	self endon("track_riot_shield");
	updatefrontandbackshields(self.currentweaponatspawn);
	thread watchriotshieldloadout();
	self.lastnonshieldweapon = "none";
	for(;;)
	{
		thread watchriotshieldpickup();
		var_00 = self getcurrentweapon();
		if(isdefined(self.exo_shield_on) && self.exo_shield_on)
		{
			var_00 = maps\mp\_exo_shield::get_exo_shield_weapon();
		}

		thread riotshield_watch_for_change_weapon();
		thread riotshield_watch_for_start_change_weapon();
		thread riotshield_watch_for_exo_shield_pullback();
		thread riotshield_watch_for_exo_shield_release();
		self waittill("riotshield_change_weapon",var_01);
		if(weaponisriotshield(var_01))
		{
			if(hasriotshield())
			{
				if(isdefined(self.riotshieldtakeweapon))
				{
					self takeweapon(self.riotshieldtakeweapon);
					self.riotshieldtakeweapon = undefined;
				}
			}

			if(isvalidnonshieldweapon(var_00))
			{
				self.lastnonshieldweapon = var_00;
			}
		}

		updateriotshieldattachfornewweapon(var_01);
	}
}

//Function Number: 19
updateriotshieldattachfornewweapon(param_00)
{
	if(self ismantling() && param_00 == "none")
	{
		return;
	}

	updatefrontandbackshields(param_00);
}

//Function Number: 20
watchriotshieldpickup()
{
	self endon("death");
	self endon("disconnect");
	self endon("track_riot_shield");
	self notify("watch_riotshield_pickup");
	self endon("watch_riotshield_pickup");
	self waittill("pickup_riotshield");
	self endon("weapon_change");
	wait(0.5);
	updateriotshieldattachfornewweapon(self getcurrentweapon());
}

//Function Number: 21
isvalidnonshieldweapon(param_00)
{
	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(maps\mp\gametypes\_class::isvalidequipment(param_00,1) || maps\mp\gametypes\_class::isvalidequipment(param_00,0))
	{
		return 0;
	}

	if(weaponisriotshield(param_00))
	{
		return 0;
	}

	if(weaponclass(param_00) == "ball")
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
startriotshielddeploy()
{
	thread watchriotshielddeploy();
}

//Function Number: 23
handleriotshieldshockplant()
{
	var_00 = self.riotshieldentity;
	var_01 = 10;
	var_02 = 50;
	var_03 = 150;
	var_04 = var_03 * var_03;
	var_05 = self.riotshieldentity.origin + (0,0,-25);
	self radiusdamage(var_05,var_03,var_02,var_01,self,"MOD_EXPLOSIVE");
	playfx(level._effect["riot_shield_shock_fx"],var_05,anglestoforward(self.riotshieldentity.angles + (-90,0,0)));
	foreach(var_07 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_07) && !isalliedsentient(var_07,self))
		{
			if(distancesquared(var_05,var_07.origin) < var_04)
			{
				var_07 shellshock("concussion_grenade_mp",1);
			}
		}
	}
}

//Function Number: 24
watchriotshielddeploy()
{
	self endon("death");
	self endon("disconnect");
	self notify("start_riotshield_deploy");
	self endon("start_riotshield_deploy");
	self waittill("startdeploy_riotshield");
	self playsound("wpn_riot_shield_plant_mech");
	self waittill("deploy_riotshield",var_00);
	if(isdefined(self.riotshieldentity))
	{
		self.riotshieldentity thread damagethendestroyriotshield();
		wait 0.05;
	}

	var_01 = self getcurrentweapon();
	self setweaponmodelvariant(var_01,0);
	var_02 = weaponisshockplantriotshield(var_01);
	self playsound("wpn_riot_shield_plant_punch");
	if(var_02)
	{
		self playsound("wpn_riot_shield_blast_punch");
	}

	var_03 = 0;
	if(var_00)
	{
		var_04 = self canplaceriotshield();
		if(var_04["result"] && riotshielddistancetest(var_04["origin"]))
		{
			var_05 = 28;
			var_06 = spawnriotshieldcover(var_04["origin"] + (0,0,var_05),var_04["angles"]);
			var_07 = spawnriotshieldcollision(var_04["origin"] + (0,0,var_05),var_04["angles"],var_06);
			var_08 = deployriotshield(self,var_06);
			var_09 = self getweaponslistprimaries();
			self.riotshieldretrievetrigger = var_08;
			self.riotshieldentity = var_06;
			self.riotshieldcollisionentity = var_07;
			if(var_02)
			{
				thread handleriotshieldshockplant();
			}
			else
			{
				playfxontag(common_scripts\utility::getfx("riot_shield_deploy_smoke"),var_06,"tag_weapon");
			}

			var_06 scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_deploy");
			thread spawnshieldlights(var_06);
			var_0A = 0;
			if(self.lastnonshieldweapon != "none" && self hasweapon(self.lastnonshieldweapon))
			{
				self switchtoweaponimmediate(self.lastnonshieldweapon);
			}
			else if(var_09.size > 0)
			{
				self switchtoweaponimmediate(var_09[0]);
			}
			else
			{
				var_0A = 1;
			}

			if(!self hasweapon("iw5_combatknife_mp"))
			{
				self giveweapon("iw5_combatknife_mp");
				self.riotshieldtakeweapon = "iw5_combatknife_mp";
			}

			if(var_0A)
			{
				self switchtoweaponimmediate("iw5_combatknife_mp");
			}

			var_0B = spawnstruct();
			var_0B.deathoverridecallback = ::damagethendestroyriotshield;
			var_06 thread maps\mp\_movers::handle_moving_platforms(var_0B);
			thread watchdeployedriotshieldents();
			thread deleteshieldontriggerdeath(self.riotshieldretrievetrigger);
			thread deleteshieldontriggerpickup(self.riotshieldretrievetrigger,self.riotshieldentity);
			thread deleteshieldonplayerdeathordisconnect(var_06);
			if(isdefined(var_04["entity"]))
			{
				thread deleteshieldongrounddelete(var_04["entity"]);
			}

			self.riotshieldentity thread watchdeployedriotshielddamage();
			level notify("riotshield_planted",self);
		}
		else
		{
			var_03 = 1;
			var_0C = weaponclipsize(var_01);
			self setweaponammoclip(var_01,var_0C);
		}
	}
	else
	{
		var_03 = 1;
	}

	if(var_03)
	{
		self setriotshieldfailhint();
	}
}

//Function Number: 25
spawnshieldlights(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	wait(0.6);
	playfxontag(common_scripts\utility::getfx("riot_shield_deploy_lights"),param_00,"tag_weapon");
}

//Function Number: 26
riotshielddistancetest(param_00)
{
	var_01 = getdvarfloat("riotshield_deploy_limit_radius");
	var_01 = var_01 * var_01;
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.riotshieldentity))
		{
			var_04 = distancesquared(var_03.riotshieldentity.origin,param_00);
			if(var_01 > var_04)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 27
spawnriotshieldcover(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.targetname = "riotshield_mp";
	var_02.angles = param_01;
	var_03 = undefined;
	var_04 = self getcurrentprimaryweapon();
	if(weaponisriotshield(var_04))
	{
		var_03 = getweaponmodel(var_04);
	}

	if(!isdefined(var_03))
	{
		var_03 = "npc_deployable_riot_shield_base";
	}

	var_02 setmodel(var_03);
	var_02.owner = self;
	var_02.team = self.team;
	return var_02;
}

//Function Number: 28
spawnriotshieldcollision(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00,1);
	var_03.targetname = "riotshield_coll_mp";
	var_03.angles = param_01;
	var_03 setmodel("tag_origin");
	var_03.owner = self;
	var_03.team = self.team;
	var_03 clonebrushmodeltoscriptmodel(level.riot_shield_collision);
	var_03 disconnectpaths();
	var_03 sethighjumpresetallowed(0);
	return var_03;
}

//Function Number: 29
watchdeployedriotshieldents()
{
	self waittill("destroy_riotshield");
	if(isdefined(self.riotshieldretrievetrigger))
	{
		self.riotshieldretrievetrigger delete();
	}

	if(isdefined(self.riotshieldcollisionentity))
	{
		self.riotshieldcollisionentity connectpaths();
		self.riotshieldcollisionentity delete();
	}

	if(isdefined(self.riotshieldentity))
	{
		self.riotshieldentity delete();
	}
}

//Function Number: 30
deleteshieldontriggerpickup(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 waittill("trigger",var_02);
	handlepickupdeployedriotshields(var_02,param_01);
	self notify("destroy_riotshield");
}

//Function Number: 31
deleteshieldontriggerdeath(param_00)
{
	level endon("game_ended");
	param_00 waittill("death");
	self notify("destroy_riotshield");
}

//Function Number: 32
deleteshieldonplayerdeathordisconnect(param_00)
{
	param_00 endon("death");
	param_00 endon("damageThenDestroyRiotshield");
	common_scripts\utility::waittill_any("death","disconnect","remove_planted_weapons");
	param_00 thread damagethendestroyriotshield();
}

//Function Number: 33
deleteshieldongrounddelete(param_00)
{
	level endon("game_ended");
	param_00 common_scripts\utility::waittill_any("death","hidingLightingState");
	self notify("destroy_riotshield");
}

//Function Number: 34
watchdeployedriotshielddamage()
{
	self endon("death");
	var_00 = getdvarint("riotshield_deployed_health");
	self.damagetaken = 0;
	var_01 = 0;
	for(;;)
	{
		self.maxhealth = 100000;
		self.health = self.maxhealth;
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isplayer(var_03))
		{
			if(level.teambased && var_03.team == self.owner.team && var_03 != self.owner)
			{
				continue;
			}
		}

		var_0C = 0;
		var_0D = 0;
		if(maps\mp\_utility::ismeleemod(var_06))
		{
			var_0C = 1;
			var_02 = var_02 * getdvarfloat("riotshield_melee_damage_scale");
		}
		else if(var_06 == "MOD_PISTOL_BULLET" || var_06 == "MOD_RIFLE_BULLET")
		{
			var_0D = 1;
			var_02 = var_02 * getdvarfloat("riotshield_bullet_damage_scale");
		}
		else if(var_06 == "MOD_GRENADE" || var_06 == "MOD_GRENADE_SPLASH" || var_06 == "MOD_EXPLOSIVE" || var_06 == "MOD_EXPLOSIVE_SPLASH" || var_06 == "MOD_PROJECTILE" || var_06 == "MOD_PROJECTILE_SPLASH")
		{
			var_02 = var_02 * getdvarfloat("riotshield_explosive_damage_scale");
		}
		else if(var_06 == "MOD_IMPACT")
		{
			var_02 = var_02 * getdvarfloat("riotshield_projectile_damage_scale");
		}
		else if(var_06 == "MOD_CRUSH")
		{
			var_02 = var_00;
		}

		self.damagetaken = self.damagetaken + var_02;
		if(self.damagetaken >= var_00)
		{
			thread damagethendestroyriotshield(var_03,var_0B);
			break;
		}
		else if((var_0C || var_0D) && gettime() >= var_01)
		{
			var_01 = gettime() + 500;
			var_0E = 0;
			var_0F = anglestoforward(self.angles);
			if(vectordot(var_04,var_0F) > 0)
			{
				var_0E = 1;
			}

			if(var_0C)
			{
				if(var_0E)
				{
					self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_melee_back");
				}
				else
				{
					self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_melee_front");
				}
			}
			else if(var_0E)
			{
				self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_shot_back");
			}
			else
			{
				self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_shot");
			}
		}
	}
}

//Function Number: 35
damagethendestroyriotshield(param_00,param_01)
{
	self notify("damageThenDestroyRiotshield");
	self endon("death");
	if(isdefined(self.owner.riotshieldretrievetrigger))
	{
		self.owner.riotshieldretrievetrigger delete();
	}

	if(isdefined(self.owner.riotshieldcollisionentity))
	{
		self.owner.riotshieldcollisionentity connectpaths();
		self.owner.riotshieldcollisionentity delete();
	}

	self.owner.riotshieldentity = undefined;
	self notsolid();
	self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_destroyed");
	wait(getdvarfloat("riotshield_destroyed_cleanup_time"));
	self delete();
}

//Function Number: 36
watchriotshieldstuckentitydeath(param_00,param_01)
{
	param_00 endon("death");
	common_scripts\utility::waittill_any("damageThenDestroyRiotshield","death","disconnect","weapon_change","deploy_riotshield");
	param_00 detonate(param_01);
}