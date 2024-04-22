/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_line_gun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 173 ms
 * Timestamp: 4/22/2024 2:13:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.linegun = spawnstruct();
	level.linegun.name = "iw5_linegunzm_mp";
	level.linegun.damageweapon = "iw5_linegundamagezm_mp";
	level.linegun.maxdist = 5000;
	level.linegun.movespeed = 450;
	level.linegun.startoffset = (30,0,0);
	level.linegun.hipfireangles = (3,3,20);
	level.linegun.damage = 1200;
	level.linegun.debug = 0;
	level.linegun.debugduration = 1;
	level.linegun.startwidth = 200;
	level.linegun.widthrate = 0;
	level.linegun.widthratetime = 0;
	level.modifyweapondamage[level.linegun.name] = ::linegunmodifydamage;
	level.damageweapontoweapon[level.linegun.damageweapon] = level.linegun.name;
	level._effect["dlc_zombies_linegun_laser"] = loadfx("vfx/muzzleflash/dlc_zombies_linegun_laser");
	level._effect["dlc_zombie_line_gun_gib"] = loadfx("vfx/blood/dlc_zombie_line_gun_gib");
	level._effect["dlc_zombies_drone_death"] = loadfx("vfx/muzzleflash/dlc_zombies_drone_death");
}

//Function Number: 2
linegunmodifydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(level.linegun.damage);
}

//Function Number: 3
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self notify("onPlayerSpawnLineGUn");
	self endon("onPlayerSpawnLineGUn");
	for(;;)
	{
		self waittill("weapon_fired",var_00);
		var_01 = getweaponbasename(var_00);
		if(var_01 != level.linegun.name)
		{
			continue;
		}

		thread firelinegun();
	}
}

//Function Number: 4
firelinegun()
{
	var_00 = self playerads();
	var_01 = self getplayerangles();
	var_02 = (var_01[0],var_01[1],0);
	var_03 = randomfloatrange(-1,1) * 1 - var_00;
	var_04 = randomfloatrange(-1,1) * 1 - var_00;
	var_05 = var_02 + (level.linegun.hipfireangles[0] * var_03,level.linegun.hipfireangles[1] * var_04,0);
	var_06 = anglestoforward(var_01);
	var_07 = anglestoforward(var_05);
	var_08 = self getvieworigin();
	var_09 = var_08 + self getvelocity() * 0.05 + rotatevector(level.linegun.startoffset,var_02);
	var_0A = var_08 + var_07 * level.linegun.maxdist;
	var_0B = var_08;
	var_0C = undefined;
	var_0D = self;
	var_0E = 1;
	for(var_0F = 0;var_0F < 3;var_0F++)
	{
		var_0C = bullettrace(var_0B,var_0A,0,var_0D,0,0,0,0,var_0E,0,0);
		if(isdefined(var_0C["glass"]))
		{
			var_0E = 0;
			var_10 = distance(var_09,var_0C["position"]);
			var_11 = var_10 / level.linegun.movespeed;
			thread lineguntouchglass(var_0C["glass"],var_06,var_11);
			continue;
		}

		var_12 = var_0C["entity"];
		var_13 = isdefined(var_12) && maps\mp\zombies\_util::is_true(var_12.linegunignore);
		if(!var_13)
		{
			break;
		}

		var_0B = var_0C["position"];
		var_0D = var_12;
	}

	if(var_0C["fraction"] <= 0)
	{
		return;
	}

	var_0A = var_0C["position"];
	var_14 = distance(var_08,var_0A);
	var_15 = linegungetprojectileent(var_09,self.angles);
	var_16 = var_14 / level.linegun.movespeed;
	var_15 moveto(var_0A,var_16);
	var_17 = -1 * var_04 * level.linegun.hipfireangles[2];
	if(var_17 != 0)
	{
		var_15 rotatevelocity((0,0,var_17),var_16);
	}

	var_15 thread lineprojectiledamageupdate(self);
	var_15 waittill("movedone");
	level thread linegunreleaseprojectileent(var_15);
}

//Function Number: 5
lineguntouchglass(param_00,param_01,param_02)
{
	wait(param_02);
	if(!isglassdestroyed(param_00))
	{
		destroyglass(param_00,param_01);
	}
}

//Function Number: 6
lineprojectiledamageupdate(param_00)
{
	self endon("death");
	self endon("released");
	self.enemyimpactcount = 0;
	var_01 = gettime();
	var_02 = level.linegun.startwidth;
	for(;;)
	{
		var_03 = anglestoright(self.angles);
		if(level.linegun.widthrate > 0)
		{
			var_02 = gettime() - var_01 / 1000 * level.linegun.widthrate;
			var_02 = clamp(var_02,level.linegun.startwidth,level.linegun.widthratetime * level.linegun.widthrate);
		}

		linegundamage(self.origin,self.origin + var_03 * var_02,param_00);
		linegundamage(self.origin,self.origin - var_03 * var_02,param_00);
		wait 0.05;
	}
}

//Function Number: 7
linegundamage(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = [];
	foreach(var_06 in level.characters)
	{
		if(var_06 maps\mp\agents\humanoid\_humanoid_util::iscrawling())
		{
			var_06.linegunheight = 40;
		}
		else
		{
			var_06.linegunheight = 70;
		}

		var_06.linegungibfx = "dlc_zombie_line_gun_gib";
		var_04[var_04.size] = var_06;
	}

	var_08 = [level.ammodrone,level.ammodrone2];
	foreach(var_0A in var_08)
	{
		if(!isdefined(var_0A))
		{
			continue;
		}

		var_0A.linegunheight = 40;
		var_04[var_04.size] = var_0A;
	}

	foreach(var_0D in var_04)
	{
		if(isdefined(var_0D.team) && var_0D.team == param_02.team)
		{
			continue;
		}

		var_0E = maps\mp\zombies\_util::projecttoline(var_0D.origin,param_00,param_01);
		var_0F = var_0E[0];
		var_10 = var_0E[1];
		if(var_10 < 0 || var_10 > 1)
		{
			continue;
		}

		if(var_0F[2] < var_0D.origin[2])
		{
			continue;
		}

		if(var_0F[2] > var_0D.origin[2] + var_0D.linegunheight)
		{
			continue;
		}

		var_11 = (var_0D.origin[0],var_0D.origin[1],var_0F[2]);
		if(distancesquared(var_0F,var_11) > squared(level.linegun.movespeed / 20))
		{
			continue;
		}

		if(isdefined(var_0D.lastlinegundamagetime) && gettime() - var_0D.lastlinegundamagetime < 100)
		{
			continue;
		}

		var_0D.projecttolinepoint = var_0F;
		var_0D.projecttolinescale = var_10;
		var_03[var_03.size] = var_0D;
	}

	if(!var_03.size)
	{
		return;
	}

	var_13 = bullettrace(param_00,param_01,0,param_02);
	if(var_13["fraction"] <= 0)
	{
		return;
	}

	param_01 = var_13["position"];
	foreach(var_0D in var_03)
	{
		if(!isalive(var_0D))
		{
			continue;
		}

		if(var_0D.projecttolinescale > var_13["fraction"])
		{
			continue;
		}

		var_11 = (var_0D.origin[0],var_0D.origin[1],var_0D.projecttolinepoint[2]);
		if(level.linegun.debug)
		{
			var_15 = (1,0,0);
			var_16 = bullettrace(param_00,param_01,0,param_02);
			var_17 = var_16["entity"];
			if(isdefined(var_17) && var_17 == var_0D)
			{
				var_15 = (0,1,0);
			}
		}

		thread linegungibfx(var_0D,var_11);
		var_18 = linegundamagelocation(var_0D,var_11);
		var_0D dodamage(level.linegun.damage,var_11,param_02,param_02,"MOD_RIFLE_BULLET",level.linegun.damageweapon,var_18);
		param_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("linegun",var_0D);
		var_0D.lastlinegundamagetime = gettime();
		self.enemyimpactcount++;
		if(self.enemyimpactcount == 18)
		{
			param_02 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_LIMBO");
		}
	}
}

//Function Number: 8
linegungibfx(param_00,param_01)
{
	var_02 = param_00.linegungibfx;
	if(!isdefined(var_02))
	{
		return;
	}

	param_00 endon("detachLimb");
	waittillframeend;
	playfx(common_scripts\utility::getfx(var_02),param_01);
}

//Function Number: 9
linegundamagelocation(param_00,param_01)
{
	var_02 = param_01[2] - param_00.origin[2];
	if(var_02 < 32)
	{
		return common_scripts\utility::random(["right_leg_upper","left_leg_upper"]);
	}

	if(var_02 < 60)
	{
		return common_scripts\utility::random(["left_arm_upper","right_arm_upper"]);
	}

	return common_scripts\utility::random(["head","neck"]);
}

//Function Number: 10
linegungetprojectileent(param_00,param_01)
{
	var_02 = undefined;
	var_03 = getentarray("line_gun_projectile","targetname");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.inuse) || !var_05.inuse)
		{
			var_02 = var_05;
			var_02 dontinterpolate();
			break;
		}
	}

	if(!isdefined(var_02))
	{
		var_02 = spawn("script_model",param_00);
		var_02.targetname = "line_gun_projectile";
	}

	var_02 setmodel("tag_origin");
	var_02.origin = param_00;
	var_02.angles = param_01;
	var_02.fxname = "dlc_zombies_linegun_laser";
	var_02.fxtag = "tag_origin";
	playfxontag(common_scripts\utility::getfx(var_02.fxname),var_02,var_02.fxtag);
	var_02 playloopsound("wpn_linegun_beam_hi");
	var_02.inuse = 1;
	return var_02;
}

//Function Number: 11
linegunreleaseprojectileent(param_00)
{
	param_00 notify("released");
	killfxontag(common_scripts\utility::getfx(param_00.fxname),param_00,param_00.fxtag);
	playfxontag(common_scripts\utility::getfx("dlc_zombies_drone_death"),param_00,param_00.fxtag);
	param_00 stoploopsound("wpn_linegun_beam_hi");
	param_00 playsound("wpn_linegun_exp");
	wait(1);
	param_00.inuse = 0;
}