/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_trident.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 176 ms
 * Timestamp: 4/22/2024 2:13:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.onzombiespawnfuncs))
	{
		level.onzombiespawnfuncs = [];
	}

	level.onzombiespawnfuncs[level.onzombiespawnfuncs.size] = ::onzombiespawn;
	level._effect["trident_trail_green"] = loadfx("vfx/trail/trail_trident_green");
	level._effect["trident_trail_purple"] = loadfx("vfx/trail/trail_trident_purple");
	level.trident = spawnstruct();
	level.trident.attractorstrength = 1000;
	level.trident.attractordist = 300;
	level.trident.name = "iw5_tridentzm_mp";
	level.trident.maxdist = 5000;
	level.trident.movespeed = 1300;
	level.trident.startoffset = (30,0,0);
	level.trident.hipfireangles = (2,2,0);
	level.trident.damage = 1200;
	level.trident.lifetime = 2500;
	level.trident.impulseradius = 30;
	level.trident.impulseforce = 10;
	level.trident.smartdot = 0.75;
	level.trident.smartdist = 1500;
	level.trident.penetratecount = 5;
	level.trident.trailfxlist = common_scripts\utility::array_randomize(["trident_trail_green","trident_trail_purple"]);
	level.trident.trailfxindex = 0;
	level.trident.sqsmartdot = 0.8;
	if(level.currentgen)
	{
		level.trident.lifetime = 1750;
	}

	level.modifyweapondamage[level.trident.name] = ::tridentmodifydamage;
}

//Function Number: 2
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self notify("onPlayerSpawnTrident");
	self endon("onPlayerSpawnTrident");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		var_02 = getweaponbasename(var_01);
		if(var_02 != level.trident.name)
		{
			continue;
		}

		var_00 delete();
		thread firetrident();
	}
}

//Function Number: 3
tridentmodifydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(level.trident.damage);
}

//Function Number: 4
onzombiespawn()
{
	self endon("death");
	for(;;)
	{
		waittillframeend;
		self.prevorigin = self.origin;
		wait 0.05;
	}
}

//Function Number: 5
addattractor()
{
	var_00 = missile_createattractorent(self,level.tridentdata.attractorstrength,level.tridentdata.attractordist,undefined,undefined,(0,0,35));
	self waittill("death");
	missile_deleteattractor(var_00);
}

//Function Number: 6
firetrident()
{
	var_00 = self playerads();
	var_01 = self getplayerangles();
	var_02 = (var_01[0],var_01[1],0);
	var_03 = randomfloatrange(-1,1) * 1 - var_00;
	var_04 = randomfloatrange(-1,1) * 1 - var_00;
	var_05 = var_02 + (level.trident.hipfireangles[0] * var_03,level.trident.hipfireangles[1] * var_04,0);
	var_06 = anglestoforward(var_05);
	var_07 = self getvieworigin();
	var_08 = var_07 + self getvelocity() * 0.05 + rotatevector(level.trident.startoffset,var_02);
	var_09 = tridentgetprojectileent(var_08,self.angles);
	var_0A = level.trident.maxdist / level.trident.movespeed;
	var_09 moveto(var_07 + var_06 * level.trident.maxdist,var_0A);
	var_0B = var_07;
	var_0C = var_08 + level.trident.movespeed * 0.05 * var_06;
	var_0D = self;
	var_0E = undefined;
	var_0F = level.trident.penetratecount;
	var_10 = gettime() + level.trident.lifetime;
	while(gettime() < var_10)
	{
		for(;;)
		{
			var_11 = bullettrace(var_0B,var_0C,1,var_0D,0,1,0,0,1,0,0);
			if(isdefined(var_11["glass"]))
			{
				destroyglass(var_11["glass"],var_06);
				continue;
			}

			if(var_11["fraction"] < 1)
			{
				var_12 = 1;
				var_13 = var_11["normal"];
				var_14 = var_11["position"] + var_13;
				var_15 = var_11["entity"];
				var_16 = 0;
				if(isdefined(var_15))
				{
					tridentdamageent(var_15,var_14,var_06,var_11["hitLoc"]);
					var_16 = isagent(var_15);
				}

				if(var_16)
				{
					if(var_0F > 0)
					{
						var_0D = var_15;
						var_0B = var_14;
						var_0F--;
						continue;
					}
				}
				else
				{
					var_0F = 0;
				}

				var_09.origin = var_14;
				var_17 = vectordot(var_13,var_06);
				var_06 = -2 * var_17 * var_13 + var_06;
				if(var_12)
				{
					var_18 = var_06;
					var_19 = level.trident.smartdot;
					var_1A = var_19;
					var_1B = undefined;
					var_1C = level.characters;
					if(isdefined(level.bossozstage1) && isdefined(level.bossozstage1.damagecallback))
					{
						var_1C[var_1C.size] = level.bossozstage1;
					}

					var_1D = [level.ammodrone,level.ammodrone2];
					foreach(var_1F in var_1D)
					{
						if(!isdefined(var_1F))
						{
							continue;
						}

						var_1C[var_1C.size] = var_1F;
					}

					foreach(var_22 in var_1C)
					{
						if(isplayer(var_22))
						{
							continue;
						}

						if(!isalive(var_22))
						{
							continue;
						}

						if(isdefined(var_22.team) && var_22.team == self.team)
						{
							continue;
						}

						if(isdefined(var_0E) && var_0E == var_22)
						{
							continue;
						}

						var_23 = var_22.origin;
						if(isdefined(var_22.agent_type) && var_22.agent_type == "zombie_dog")
						{
							var_23 = var_23 + (0,0,15);
						}
						else if(var_22 maps\mp\agents\humanoid\_humanoid_util::iscrawling())
						{
							var_23 = var_23 + (0,0,5);
						}
						else
						{
							var_23 = var_23 + (0,0,40);
						}

						var_24 = (0,0,0);
						if(isdefined(var_22.prevorigin))
						{
							var_24 = var_22.origin - var_22.prevorigin * 20;
						}

						if(distance(var_23,var_14) > level.trident.smartdist)
						{
							continue;
						}

						var_25 = calculateintersectdirection(var_23,var_24,var_14,level.trident.movespeed);
						var_17 = vectordot(var_18,var_25);
						if(var_17 > var_1A)
						{
							var_26 = bullettrace(var_14,var_23,0,var_0D,0,0,0,0,0,0,0);
							if(var_26["fraction"] >= 1 || isdefined(var_26["entity"]) && var_26["entity"] == var_22)
							{
								var_1A = var_17;
								var_06 = var_25;
								var_1B = var_22;
							}
						}
					}

					var_0E = var_1B;
				}

				var_09 playsound("wpn_trident_bounce_snap");
				var_0A = level.trident.maxdist / level.trident.movespeed;
				var_09 moveto(var_09.origin + var_06 * level.trident.maxdist,var_0A);
			}

			break;
		}

		wait 0.05;
		if(!isdefined(self))
		{
			break;
		}

		var_0B = var_09.origin;
		var_0C = var_0B + level.trident.movespeed * 0.05 * var_06;
	}

	tridentreleaseprojectileent(var_09);
}

//Function Number: 7
calculateintersectdirection(param_00,param_01,param_02,param_03)
{
	var_04 = vectornormalize(param_00 - param_02);
	var_05 = vectordot(var_04,param_01);
	var_06 = var_04 * var_05;
	var_07 = param_01 - var_06;
	var_08 = length(var_07);
	var_09 = var_07;
	if(var_08 <= param_03)
	{
		var_0A = var_04 * sqrt(param_03 * param_03 - var_08 * var_08);
		var_09 = var_0A + var_07;
	}

	var_09 = vectornormalize(var_09);
	return var_09;
}

//Function Number: 8
tridentdamageent(param_00,param_01,param_02,param_03)
{
	if(!isalive(param_00))
	{
		return;
	}

	if(isplayer(param_00))
	{
		return;
	}

	if(isagent(param_00))
	{
		param_00.ragdollimmediately = 1;
		param_00 dodamage(level.trident.damage,param_01,self,self,"MOD_PROJECTILE",level.trident.name,param_03);
		param_00.ragdollimmediately = 0;
		level thread tridentphysicsexplosion(param_01);
		return;
	}

	param_00 dodamage(level.trident.damage,param_01,self,self,"MOD_PROJECTILE",level.trident.name);
}

//Function Number: 9
tridentphysicsexplosion(param_00)
{
	wait(0.1);
	physicsexplosionsphere(param_00,level.trident.impulseradius,0,level.trident.impulseforce,0);
}

//Function Number: 10
tridentgetprojectileent(param_00,param_01)
{
	var_02 = undefined;
	var_03 = getentarray("trident_projectile","targetname");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.inuse) || !var_05.inuse)
		{
			var_02 = var_05;
			var_02 dontinterpolate();
			var_02 show();
			break;
		}
	}

	if(!isdefined(var_02))
	{
		var_02 = spawn("script_model",param_00);
		var_02.targetname = "trident_projectile";
	}

	var_02 setmodel("tag_origin");
	var_02 setcontents(0);
	var_02.origin = param_00;
	var_02.angles = param_01;
	if(!isdefined(self.tridentfx))
	{
		self.tridentfx = level.trident.trailfxlist[level.trident.trailfxindex % level.trident.trailfxlist.size];
		level.trident.trailfxindex++;
	}

	var_02.fxname = self.tridentfx;
	var_02.fxtag = "tag_origin";
	playfxontag(common_scripts\utility::getfx(var_02.fxname),var_02,var_02.fxtag);
	var_02 playloopsound("wpn_trident_prj_loop");
	var_02.inuse = 1;
	return var_02;
}

//Function Number: 11
tridentreleaseprojectileent(param_00)
{
	param_00 setmodel("tag_origin");
	param_00 notify("released");
	stopfxontag(common_scripts\utility::getfx(param_00.fxname),param_00,param_00.fxtag);
	param_00 stoploopsound("wpn_trident_prj_loop");
	wait(1);
	param_00.inuse = 0;
}