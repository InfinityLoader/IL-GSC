/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_equipment.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 141 ms
 * Timestamp: 10/27/2023 2:25:20 AM
*******************************************************************/

//Function Number: 1
func_2788()
{
	self endon("spawned_player");
	self endon("disconnect");
	self.trophyarray = [];
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "trophy" || var_01 == "trophy_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			var_00 hide();
			var_00 waittill("missile_stuck");
			var_02 = 40;
			if(var_02 * var_02 < distancesquared(var_00.origin,self.origin))
			{
				var_03 = bullettrace(self.origin,self.origin - (0,0,var_02),0,self);
				if(var_03["fraction"] == 1)
				{
					var_00 delete();
					self setweaponammostock("trophy_mp",self getweaponammostock("trophy_mp") + 1);
					continue;
				}

				var_00.origin = var_03["position"];
			}

			var_00 show();
			self.trophyarray = common_scripts\utility::array_removeundefined(self.trophyarray);
			if(self.trophyarray.size >= level.maxperplayerexplosives)
			{
				self.trophyarray[0] detonate();
			}

			var_04 = spawn("script_model",var_00.origin);
			var_04 setmodel("mp_trophy_system");
			var_04 thread maps\mp\gametypes\_weapons::createbombsquadmodel("mp_trophy_system_bombsquad","tag_origin",level.otherteam[self.team],self);
			var_04.angles = var_00.angles;
			self.trophyarray[self.trophyarray.size] = var_04;
			var_04.owner = self;
			var_04.team = self.team;
			var_04.weaponname = var_01;
			if(isdefined(self.trophyremainingammo) && self.trophyremainingammo > 0)
			{
				var_04.ammo = self.trophyremainingammo;
			}
			else
			{
				var_04.ammo = 2;
			}

			var_04.trigger = spawn("script_origin",var_04.origin);
			var_04 thread trophydamage(self);
			var_04 thread func_2797(self);
			var_04 thread trophydisconnectwaiter(self);
			var_04 thread trophyplayerspawnwaiter(self);
			var_04 thread trophyuselistener(self);
			var_04 thread maps\mp\gametypes\_weapons::func_2790();
			if(level.teambased)
			{
				var_04 maps\mp\_entityheadicons::setteamheadicon(var_04.team,(0,0,65));
			}
			else
			{
				var_04 maps\mp\_entityheadicons::setplayerheadicon(var_04.owner,(0,0,65));
			}

			wait 0.05;
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
	}
}

//Function Number: 2
trophyuselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self.trigger setcursorhint("HINT_NOICON");
	self.trigger sethintstring(&"MP_PICKUP_TROPHY");
	self.trigger maps\mp\_utility::setselfusable(param_00);
	self.trigger thread maps\mp\_utility::notusableforjoiningplayers(param_00);
	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		param_00 playlocalsound("scavenger_pack_pickup");
		if(!param_00 maps\mp\_utility::isjuggernaut())
		{
			param_00 maps\mp\_utility::giveperk("trophy_mp",0);
			param_00.trophyremainingammo = self.ammo;
		}

		self.trigger delete();
		self delete();
		self notify("death");
	}
}

//Function Number: 3
trophyplayerspawnwaiter(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("spawned");
	thread trophybreak();
}

//Function Number: 4
trophydisconnectwaiter(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	thread trophybreak();
}

//Function Number: 5
func_2797(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	var_01 = self.origin;
	for(;;)
	{
		if(!isdefined(level.grenades) || level.grenades.size < 1 && level.missiles.size < 1 || isdefined(self.disabled))
		{
			wait 0.05;
			continue;
		}

		var_02 = maps\mp\_utility::func_279B(level.grenades,level.missiles);
		foreach(var_04 in var_02)
		{
			wait 0.05;
			if(!isdefined(var_04))
			{
				continue;
			}

			if(var_04 == self)
			{
				continue;
			}

			if(isdefined(var_04.weaponname))
			{
				switch(var_04.weaponname)
				{
					case "claymore_mp":
						break;
				}
			}

			switch(var_04.model)
			{
				case "mp_trophy_system":
				case "weapon_radar":
				case "weapon_parabolic_knife":
				case "weapon_jammer":
					break;
			}

			if(!isdefined(var_04.owner))
			{
				var_04.owner = getmissileowner(var_04);
			}

			if(isdefined(var_04.owner) && level.teambased && var_04.owner.team == param_00.team)
			{
				continue;
			}

			if(isdefined(var_04.owner) && var_04.owner == param_00)
			{
				continue;
			}

			var_05 = distancesquared(var_04.origin,self.origin);
			if(var_05 < 147456)
			{
				if(bullettracepassed(var_04.origin,self.origin,0,self))
				{
					playfx(level.sentry_fire,self.origin + (0,0,32),var_04.origin - self.origin,anglestoup(self.angles));
					self playsound("trophy_detect_projectile");
					if(isdefined(var_04.classname) && var_04.classname == "rocket" && isdefined(var_04.type) && var_04.type == "remote" || var_04.type == "remote_mortar")
					{
						if(isdefined(var_04.type) && var_04.type == "remote")
						{
							level thread maps\mp\gametypes\_missions::vehiclekilled(var_04.owner,param_00,undefined,param_00,undefined,"MOD_EXPLOSIVE","trophy_mp");
							level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_predator_missile",param_00);
							param_00 thread maps\mp\gametypes\_rank::func_2AB3("kill",100,"trophy_mp","MOD_EXPLOSIVE");
							param_00 notify("destroyed_killstreak","trophy_mp");
						}

						if(isdefined(level.chopper_fx["explode"]["medium"]))
						{
							playfx(level.chopper_fx["explode"]["medium"],var_04.origin);
						}

						if(isdefined(level.barrelexpsound))
						{
							var_04 playsound(level.barrelexpsound);
						}
					}

					param_00 thread projectileexplode(var_04,self);
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_noboomforyou");
					self.ammo--;
					if(self.ammo <= 0)
					{
						thread trophybreak();
					}
				}
			}
		}
	}
}

//Function Number: 6
projectileexplode(param_00,param_01)
{
	self endon("death");
	var_02 = param_00.origin;
	var_03 = param_00.model;
	var_04 = param_00.angles;
	if(var_03 == "weapon_light_marker")
	{
		playfx(level.empgrenadeexplode,var_02,anglestoforward(var_04),anglestoup(var_04));
		param_01 thread trophybreak();
		param_00 delete();
		return;
	}

	param_00 delete();
	param_01 playsound("trophy_fire");
	playfx(level.mine_explode,var_02,anglestoforward(var_04),anglestoup(var_04));
	radiusdamage(var_02,128,105,10,self,"MOD_EXPLOSIVE","trophy_mp");
}

//Function Number: 7
trophydamage(param_00)
{
	self endon("death");
	param_00 endon("death");
	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = 100;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02))
		{
			continue;
		}

		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_02))
		{
			continue;
		}

		if(isdefined(var_0A))
		{
			switch(var_0A)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(var_05 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		if(isdefined(var_09) && var_09 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		if(isdefined(var_0A) && var_0A == "emp_grenade_mp")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		self.damagetaken = self.damagetaken + var_01;
		if(isplayer(var_02))
		{
			var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("trophy");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			if(isdefined(param_00) && var_02 != param_00)
			{
				var_02 notify("destroyed_explosive");
			}

			thread trophybreak();
		}
	}
}

//Function Number: 8
trophybreak()
{
	playfxontag(common_scripts\utility::func_539("sentry_explode_mp"),self,"tag_origin");
	playfxontag(common_scripts\utility::func_539("sentry_smoke_mp"),self,"tag_origin");
	self playsound("sentry_explode");
	self notify("death");
	var_00 = self.origin;
	self.trigger makeunusable();
	wait 3;
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 9
createkilltriggers()
{
	switch(level.script)
	{
		case "mp_dome":
			createkilltrigger((65.2303,284.217,-307.954),20,64);
			createkilltrigger((550.941,1778.53,-108.78),120,64);
			break;

		case "mp_hardhat":
			createkilltrigger((916.224,-1911.95,332.625),230,64);
			createkilltrigger((78.2076,800.055,498.384),120,32);
			createkilltrigger((165.7,-208.641,408.544),90,64);
			createkilltrigger((647.502,-619.168,318.386),70,64);
			createkilltrigger((1353.14,1379.13,500.502),100,64);
			break;

		case "mp_paris":
			createkilltrigger((442.346,-895.006,128.819),14,32);
			createkilltrigger((277.62,-972.828,129.303),32,64);
			createkilltrigger((1717.79,549.294,144.871),20,32);
			createkilltrigger((130.734,2027.64,95.1856),32,64);
			createkilltrigger((-2077.26,602.075,646.415),300,64);
			break;

		case "mp_plaza2":
			createkilltrigger((-1355.79,-56.389,952.179),50,32);
			createkilltrigger((-1354.92,147.436,914.707),40,32);
			createkilltrigger((-266.038,976.432,761.29),30,32);
			createkilltrigger((189.786,-472.274,738.957),60,40);
			createkilltrigger((652.957,-398.834,687.308),60,40);
			createkilltrigger((480.709,-1961.1,742.611),110,40);
			createkilltrigger((-990.873,-140.348,905.785),45,64);
			createkilltrigger((-1215.71,-140.041,905.785),45,64);
			createkilltrigger((-485.723,559.951,801.125),50,64);
			createkilltrigger((-350.711,559.951,801.125),50,64);
			createkilltrigger((369.49,912.654,798.966),200,64);
			createkilltrigger((-738.525,1698.84,796.122),100,200);
			break;

		case "mp_seatown":
			createkilltrigger((-1965.25,-862.286,273.747),100,120);
			createkilltrigger((-583.448,582.223,375.4),20,64);
			createkilltrigger((-1400.83,1367.31,391.082),200,100);
			break;

		case "mp_lambeth":
			createkilltrigger((202.69,1447.83,-85.4053),100,64);
			createkilltrigger((1487.4,1713.4,-141.171),20,120);
			createkilltrigger((1375.03,2067.73,3.36294),20,64);
			createkilltrigger((333.856,2020.39,14.2658),32,64);
			break;

		case "mp_alpha":
			createkilltrigger((-768,1277.92,162.01),8,40);
			createkilltrigger((-768,1151.35,162.01),8,40);
			createkilltrigger((-768,1024.97,162.01),8,40);
			createkilltrigger((-768,896.526,162.01),8,40);
			createkilltrigger((-115.306,-423.98,188.944),50,72);
			break;

		case "mp_underground":
			createkilltrigger((975.678,1727.09,-121.848),20,72);
			createkilltrigger((273.891,1933.97,-97.8215),12,72);
			createkilltrigger((-44.8348,1878.63,-108.455),30,64);
			createkilltrigger((-287.736,3014.45,60.6556),300,200);
			break;

		case "mp_bootleg":
			createkilltrigger((-1353.36,33.4733,49.2629),60,32);
			createkilltrigger((-1360.71,-37.7305,49.2629),60,32);
			createkilltrigger((-1553.97,-744.555,113.469),14,64);
			createkilltrigger((52.7655,-257.007,-48.4873),40,64);
			createkilltrigger((-952.634,1634.85,-68.327),50,64);
			createkilltrigger((-894.218,1518.04,-68.327),55,64);
			createkilltrigger((44.5985,-1871.56,226.461),200,64);
			createkilltrigger((-1476.79,-730.554,87.178),30,64);
			createkilltrigger((-1336.19,141.716,61.0992),70,64);
			break;

		case "mp_radar":
			createkilltrigger((-4213.97,2374.97,1287.35),120,64);
			createkilltrigger((-4340.14,3693.87,1299.49),120,64);
			createkilltrigger((-4832.37,4363.34,1365.7),120,64);
			createkilltrigger((-3837.91,1665.4,1256),68,64);
			createkilltrigger((-3841.18,1537.42,1267.05),68,64);
			createkilltrigger((-6917.44,4752.67,1498.9),200,64);
			createkilltrigger((-5801.42,3119.02,1638.7),300,300);
			break;

		case "mp_mogadishu":
			createkilltrigger((-87.1578,483.38,152.515),24,64);
			createkilltrigger((-140.927,129.438,84.5235),16,64);
			createkilltrigger((1514.97,2500.66,171.984),32,32);
			createkilltrigger((238.065,249.291,75.904),100,64);
			createkilltrigger((564.572,1132.1,65.043),12,64);
			createkilltrigger((-32.8942,297.377,88.8334),52,64);
			createkilltrigger((219.136,1207.01,121.441),130,64);
			createkilltrigger((722.165,1210.59,73.5508),150,64);
			createkilltrigger((98.2886,-869.883,138.138),100,64);
			break;

		case "mp_carbon":
			createkilltrigger((-1933.36,-4337.14,3890.75),14,90);
			createkilltrigger((-2676.72,-3496.48,3694.44),14,14);
			createkilltrigger((-3377.57,-4567.52,3785.84),40,80);
			break;

		case "mp_bravo":
			createkilltrigger((878.518,-539.478,1171.53),14,64);
			createkilltrigger((-1275.65,984.295,1394.08),200,64);
			break;

		case "mp_interchange":
			createkilltrigger((-712.089,1183.13,192.016),100,64);
			break;

		case "mp_exchange":
			createkilltrigger((76.163,-1513.53,265.376),600,64);
			createkilltrigger((-1078.77,-1040.27,196.185),250,64);
			createkilltrigger((1705.31,1012.04,238.247),40,64);
			createkilltrigger((1706.24,881.525,238.247),40,64);
			createkilltrigger((918.001,-1387.3,192.754),40,64);
			createkilltrigger((1039.45,-1420.39,192.754),40,64);
			createkilltrigger((-270.995,-691.246,184.239),40,64);
			createkilltrigger((-511.649,-1104.71,169.967),40,64);
			createkilltrigger((-841.228,-522.82,147.096),50,64);
			createkilltrigger((445.223,1552.75,234.433),40,64);
			createkilltrigger((261.291,814.016,204.573),50,64);
			break;
	}
}

//Function Number: 10
createkilltrigger(param_00,param_01,param_02)
{
	thread maps\mp\_utility::killtrigger(param_00,param_01,param_02);
}