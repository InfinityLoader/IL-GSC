/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_trophy_system.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 264 ms
 * Timestamp: 10/27/2023 1:19:15 AM
*******************************************************************/

//Function Number: 1
func_83D0(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	if(self isonladder() || !self isonground())
	{
		func_6648(param_00.weapon_name);
		param_00 delete();
		return;
	}

	if(isdefined(self.onhelisniper) && self.onhelisniper)
	{
		param_00 delete();
		self.helisniper thread func_83C9(self);
		return;
	}

	param_00 hide();
	var_01 = self canplayerplacesentry(1,12);
	if(var_01["result"] && is_normal_upright(anglestoup(var_01["angles"])))
	{
		param_00.origin = var_01["origin"];
		param_00.angles = var_01["angles"];
	}
	else
	{
		param_00.origin = self.origin;
		param_00.angles = self.angles;
	}

	param_00 show();
	self playlocalsound("trophy_turret_plant_plr");
	self playsoundtoteam("trophy_turret_plant_npc","allies",self);
	self playsoundtoteam("trophy_turret_plant_npc","axis",self);
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("mp_trophy_system_iw6");
	var_02 thread maps\mp\gametypes\_weapons::createbombsquadmodel("mp_trophy_system_iw6_bombsquad","tag_origin",self);
	var_02.angles = param_00.angles;
	var_02.team = self.team;
	var_02.owner = self;
	var_02.istallforwaterchecks = 1;
	if(isdefined(self.trophyremainingammo) && self.trophyremainingammo > 0)
	{
		var_02.ammo = self.trophyremainingammo;
	}
	else if(maps\mp\_utility::func_47BB())
	{
		var_02.ammo = 5;
	}
	else
	{
		var_02.ammo = 2;
	}

	var_03 = 16;
	var_04 = anglestoup(var_02.angles);
	var_04 = var_03 * var_04;
	var_05 = var_02.origin + var_04;
	var_02.trigger = spawn("script_origin",var_05);
	var_02.trigger linkto(var_02);
	var_02 thread func_83CA(self);
	var_02 thread func_83D2();
	var_02 thread func_83C9(self);
	var_02 thread func_83CB(self);
	var_02 thread func_83CE(self);
	var_02 thread func_83D1(self);
	var_02 setotherent(self);
	var_02 maps\mp\gametypes\_weapons::func_5015(1);
	var_02 maps\mp\gametypes\_weapons::explosivehandlemovers(var_01["entity"],1);
	if(level.teambased)
	{
		var_02 maps\mp\_entityheadicons::func_70E0(self.team,(0,0,65));
	}
	else
	{
		var_02 maps\mp\_entityheadicons::func_7099(self,(0,0,65));
	}

	maps\mp\gametypes\_weapons::func_597C(var_02);
	var_02 thread func_5D43();
	if(isdefined(param_00))
	{
		common_scripts\utility::func_8AFE();
		param_00 delete();
	}

	if(maps\mp\_utility::func_47BB())
	{
		self takeweapon("alientrophy_mp");
	}
}

//Function Number: 2
func_83D1(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self.trigger setcursorhint("HINT_NOICON");
	self.trigger sethintstring(&"MP_PICKUP_TROPHY");
	self.trigger maps\mp\_utility::func_70BF(param_00);
	self.trigger thread maps\mp\_utility::func_573A(param_00);
	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		self stoploopsound();
		if(maps\mp\_utility::func_47BB())
		{
			var_01 = param_00 getweaponslistoffhands();
			var_02 = undefined;
			foreach(var_04 in var_01)
			{
				if(var_04 == "alienflare_mp" || var_04 == "alientrophy_mp" || var_04 == "alienthrowingknife_mp" || isdefined(level.trophy_use_pickupfunc) && [[ level.trophy_use_pickupfunc ]](var_04))
				{
					var_05 = param_00 getammocount(var_04);
					if(var_05 > 0)
					{
						param_00 maps\mp\_utility::setlowermessage("slots_full",&"ALIEN_COLLECTIBLES_TACTICAL_FULL",3);
						var_02 = 1;
						break;
					}
				}
			}

			if(!isdefined(var_02))
			{
				param_00 setoffhandsecondaryclass("flash");
				param_00 playlocalsound("scavenger_pack_pickup");
				param_00.trophyremainingammo = self.ammo;
				param_00 takeweapon("alientrophy_mp");
				param_00 maps\mp\_utility::_giveweapon("alientrophy_mp");
				self scriptmodelclearanim();
				maps\mp\gametypes\_weapons::deleteexplosive();
				self notify("death");
			}

			continue;
		}

		if(!param_00 maps\mp\_utility::isjuggernaut())
		{
			param_00 func_6648("trophy_mp");
			param_00.trophyremainingammo = self.ammo;
			self scriptmodelclearanim();
			maps\mp\gametypes\_weapons::deleteexplosive();
			self notify("death");
		}
	}
}

//Function Number: 3
func_83CE(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("spawned");
	self notify("detonateExplosive");
}

//Function Number: 4
func_83CB(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self notify("detonateExplosive");
}

//Function Number: 5
func_83C9(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	if(maps\mp\_utility::func_47BB() && self.model == "mp_weapon_alien_crate")
	{
		var_01 = self.origin;
	}
	else
	{
		var_01 = self gettagorigin("camera_jnt");
	}

	if(isdefined(self.cameraoffset))
	{
		self.cameraoffsetvector = (0,0,self.cameraoffset);
	}
	else
	{
		self.cameraoffsetvector = var_01 - self.origin;
	}

	var_02 = 65536;
	var_03 = 147456;
	self.killcament = spawn("script_model",var_01 + (0,0,5));
	self.killcament linkto(self);
	if(!isdefined(level.grenades))
	{
		level.grenades = [];
	}

	if(!isdefined(level.missiles))
	{
		level.missiles = [];
	}

	for(;;)
	{
		if(isdefined(self.disabled) || level.grenades.size < 1 && level.missiles.size < 1)
		{
			wait(0.05);
			continue;
		}

		var_04 = common_scripts\utility::array_combine(level.grenades,level.missiles);
		foreach(var_06 in var_04)
		{
			if(!isdefined(var_06))
			{
				continue;
			}

			if(var_06 == self)
			{
				continue;
			}

			if(isdefined(var_06.exploding))
			{
				continue;
			}

			if(isdefined(var_06.weapon_name))
			{
				switch(var_06.weapon_name)
				{
					case "odin_projectile_airdrop_mp":
					case "odin_projectile_smoke_mp":
					case "odin_projectile_marking_mp":
					case "odin_projectile_small_rod_mp":
					case "odin_projectile_large_rod_mp":
					case "deployable_weapon_crate_marker_mp":
					case "deployable_vest_marker_mp":
					case "airdrop_marker_mp":
					case "trophy_mp":
					case "throwingknifejugg_mp":
					case "throwingknife_mp":
					case "claymore_mp":
						break;
				}
			}

			if(!isdefined(var_06.owner))
			{
				var_06.owner = getmissileowner(var_06);
			}

			if(isdefined(var_06.owner) && !param_00 maps\mp\_utility::isenemy(var_06.owner))
			{
				continue;
			}

			if(isdefined(self.cameraoffsetvector))
			{
				var_01 = self.origin + self.cameraoffsetvector;
			}

			var_07 = distancesquared(var_06.origin,var_01);
			var_08 = func_83C6(var_06);
			if(var_07 < var_08)
			{
				var_09 = bullettrace(var_01,var_06.origin,0,self);
				if(var_09["fraction"] == 1 || isdefined(var_09["entity"]) && var_09["entity"] == var_06)
				{
					playfx(level.sentry_fire,var_01,var_06.origin - var_01,anglestoup(self.angles));
					self playsound("trophy_detect_projectile");
					if(func_83C7(var_06))
					{
						if(isdefined(var_06.type) && var_06.type == "remote")
						{
							level thread maps\mp\gametypes\_missions::func_4B3C(var_06.owner,param_00,undefined,param_00,undefined,"MOD_EXPLOSIVE","trophy_mp");
							level thread maps\mp\_utility::func_7FA0("callout_destroyed_predator_missile",param_00);
							param_00 thread maps\mp\gametypes\_rank::giverankxp("kill",100,"trophy_mp","MOD_EXPLOSIVE");
							param_00 notify("destroyed_killstreak","trophy_mp");
						}

						if(isdefined(level.chopper_fx["explode"]["medium"]))
						{
							playfx(level.chopper_fx["explode"]["medium"],var_06.origin);
						}

						if(isdefined(level.barrelexpsound))
						{
							var_06 playsound(level.barrelexpsound);
						}
					}

					param_00 thread projectileexplode(var_06,self);
					param_00 maps\mp\gametypes\_missions::func_61CE("ch_noboomforyou");
					if(!maps\mp\_utility::func_47BB())
					{
						param_00 thread maps\mp\gametypes\_gamelogic::func_8091("trophy_mp",1,"hits");
					}

					self.ammo--;
					if(self.ammo <= 0)
					{
						param_00.trophyremainingammo = undefined;
						self notify("detonateExplosive");
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 6
func_83C7(param_00)
{
	return isdefined(param_00.classname) && param_00.classname == "rocket" && isdefined(param_00.type) && param_00.type == "remote" || param_00.type == "remote_mortar";
}

//Function Number: 7
func_83C6(param_00)
{
	if(isdefined(param_00.weapon_name) && param_00.weapon_name == "switch_blade_child_mp")
	{
		return 1048576;
	}

	if(func_83C7(param_00))
	{
		return 147456;
	}

	if(isdefined(param_00.weapon_name) && param_00.weapon_name == "hind_missile_mp" || param_00.weapon_name == "hind_bomb_mp")
	{
		return 147456;
	}

	return 65536;
}

//Function Number: 8
projectileexplode(param_00,param_01)
{
	self endon("death");
	var_02 = param_00.origin;
	var_03 = param_00.model;
	var_04 = param_00.angles;
	param_00 stopsounds();
	param_00.exploding = 1;
	if(var_03 == "weapon_light_marker")
	{
		playfx(level.empgrenadeexplode,var_02,anglestoforward(var_04),anglestoup(var_04));
		param_01 notify("detonateExplosive");
		common_scripts\utility::func_8AFE();
		param_00 delete();
	}

	param_01 playsound("trophy_fire");
	playfx(level.mine_explode,var_02,anglestoforward(var_04),anglestoup(var_04));
	if(maps\mp\_utility::func_47BB())
	{
		param_01 radiusdamage(var_02,128,105,10,self,"MOD_EXPLOSIVE","alientrophy_mp");
	}
	else
	{
		param_01 radiusdamage(var_02,128,105,10,self,"MOD_EXPLOSIVE","trophy_mp");
	}

	common_scripts\utility::func_8AFE();
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 9
func_83CA(param_00)
{
	maps\mp\gametypes\_damage::func_537B(100,"trophy",::func_83CC,::func_83CD,0);
}

//Function Number: 10
func_83CD(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::handlemeleedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 11
func_83CC(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.owner) && param_00 != self.owner)
	{
		param_00 notify("destroyed_equipment");
	}

	self notify("detonateExplosive");
}

//Function Number: 12
func_83D2()
{
	level endon("game_ended");
	self waittill("detonateExplosive");
	self scriptmodelclearanim();
	self stoploopsound();
	maps\mp\gametypes\_weapons::equipmentdeathvfx();
	self notify("death");
	var_00 = self.origin;
	self.trigger makeunusable();
	self freeentitysentient();
	wait(3);
	if(isdefined(self))
	{
		if(isdefined(self.killcament))
		{
			self.killcament delete();
		}

		maps\mp\gametypes\_weapons::equipmentdeletevfx();
		maps\mp\gametypes\_weapons::deleteexplosive();
	}
}

//Function Number: 13
func_5D43()
{
	self endon("emp_damage");
	self endon("death");
	self scriptmodelplayanim("trophy_system_deploy");
	var_00 = getanimlength(%trophy_system_deploy);
	wait(var_00);
	self scriptmodelplayanim("trophy_system_idle");
	self playloopsound("trophy_turret_rotate_lp");
}

//Function Number: 14
func_6648(param_00)
{
	self playlocalsound("scavenger_pack_pickup");
	self setweaponammostock(param_00,self getweaponammostock(param_00) + 1);
}

//Function Number: 15
is_normal_upright(param_00)
{
	var_01 = (0,0,1);
	var_02 = 0.85;
	return vectordot(param_00,var_01) > var_02;
}