/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_mgturret.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 1194 ms
 * Timestamp: 10/27/2023 1:24:58 AM
*******************************************************************/

//Function Number: 1
init_mgturretsettings()
{
	level.var_5211["easy"]["convergenceTime"] = 2.5;
	level.var_5211["easy"]["suppressionTime"] = 3;
	level.var_5211["easy"]["accuracy"] = 0.38;
	level.var_5211["easy"]["aiSpread"] = 2;
	level.var_5211["easy"]["playerSpread"] = 0.5;
	level.var_5211["medium"]["convergenceTime"] = 1.5;
	level.var_5211["medium"]["suppressionTime"] = 3;
	level.var_5211["medium"]["accuracy"] = 0.38;
	level.var_5211["medium"]["aiSpread"] = 2;
	level.var_5211["medium"]["playerSpread"] = 0.5;
	level.var_5211["hard"]["convergenceTime"] = 0.8;
	level.var_5211["hard"]["suppressionTime"] = 3;
	level.var_5211["hard"]["accuracy"] = 0.38;
	level.var_5211["hard"]["aiSpread"] = 2;
	level.var_5211["hard"]["playerSpread"] = 0.5;
	level.var_5211["fu"]["convergenceTime"] = 0.4;
	level.var_5211["fu"]["suppressionTime"] = 3;
	level.var_5211["fu"]["accuracy"] = 0.38;
	level.var_5211["fu"]["aiSpread"] = 2;
	level.var_5211["fu"]["playerSpread"] = 0.5;
}

//Function Number: 2
func_4FDD()
{
	if(getdvar("mg42") == "")
	{
		setdvar("mgTurret","off");
	}

	level.magic_distance = 24;
	var_00 = getentarray("turretInfo","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] delete();
	}
}

//Function Number: 3
func_60A2()
{
	self detach("weapon_mg42_carry","tag_origin");
	self endon("death");
	self.goalradius = level.var_2497;
	if(isdefined(self.target))
	{
		var_00 = getnode(self.target,"targetname");
		if(isdefined(var_00))
		{
			if(isdefined(var_00.radius))
			{
				self.goalradius = var_00.radius;
			}

			self setgoalnode(var_00);
		}
	}

	while(!isdefined(self.node))
	{
		wait(0.05);
	}

	var_01 = undefined;
	if(isdefined(self.target))
	{
		var_00 = getnode(self.target,"targetname");
		var_01 = var_00;
	}

	if(!isdefined(var_01))
	{
		var_01 = self.node;
	}

	if(!isdefined(var_01))
	{
	}

	if(var_01.type != "Turret")
	{
	}

	var_02 = func_3C20();
	var_02[self.node.origin + ""] = undefined;
	if(isdefined(var_02[var_01.origin + ""]))
	{
	}

	var_03 = var_01.turret;
	if(isdefined(var_03.reserved))
	{
	}

	reserve_turret(var_03);
	if(var_03.issetup)
	{
		func_4D43(var_03);
	}
	else
	{
		run_to_new_spot_and_setup_gun(var_03);
	}

	maps\_mg_penetration::func_3E14(var_01.turret);
}

//Function Number: 4
func_51FD()
{
	self waittill("trigger");
	level notify(self.targetname);
	level.var_51FD[self.targetname] = 1;
	self delete();
}

//Function Number: 5
mgturret_auto(param_00)
{
	param_00 waittill("trigger");
	var_01 = getaiarray("bad_guys");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].var_6C1F) && param_00.var_6C1F == var_01[var_02].var_6C1F)
		{
			var_01[var_02] notify("auto_ai");
		}
	}

	var_03 = getspawnerarray();
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		if(isdefined(var_03[var_02].var_6C1F) && param_00.var_6C1F == var_03[var_02].var_6C1F)
		{
			var_03[var_02].ai_mode = "auto_ai";
		}
	}

	maps\_spawner::kill_trigger(param_00);
}

//Function Number: 6
mg42_suppressionfire(param_00)
{
	self endon("death");
	self endon("stop_suppressionFire");
	if(!isdefined(self.var_7D63))
	{
		self.var_7D63 = 1;
	}

	for(;;)
	{
		while(self.var_7D63)
		{
			self settargetentity(param_00[randomint(param_00.size)]);
			wait(2 + randomfloat(2));
		}

		self cleartargetentity();
		while(!self.var_7D63)
		{
			wait(1);
		}
	}
}

//Function Number: 7
func_5090(param_00)
{
	var_01 = self.origin;
	self waittill("auto_ai");
	param_00 notify("stopfiring");
	param_00 setmode("auto_ai");
	param_00 settargetentity(level.player);
}

//Function Number: 8
burst_fire_settings(param_00)
{
	if(param_00 == "delay")
	{
		return 0.2;
	}

	if(param_00 == "delay_range")
	{
		return 0.5;
	}

	if(param_00 == "burst")
	{
		return 0.5;
	}

	return 1.5;
}

//Function Number: 9
func_18B3()
{
	self endon("death");
	self endon("stop_burst_fire_unmanned");
	if(isdefined(self.script_delay_min))
	{
		var_00 = self.script_delay_min;
	}
	else
	{
		var_00 = burst_fire_settings("delay");
	}

	if(isdefined(self.script_delay_max))
	{
		var_01 = self.script_delay_max - var_00;
	}
	else
	{
		var_01 = burst_fire_settings("delay_range");
	}

	if(isdefined(self.var_6B5D))
	{
		var_02 = self.var_6B5D;
	}
	else
	{
		var_02 = burst_fire_settings("burst");
	}

	if(isdefined(self.var_6B5C))
	{
		var_03 = self.var_6B5C - var_02;
	}
	else
	{
		var_03 = burst_fire_settings("burst_range");
	}

	var_04 = gettime();
	var_05 = "start";
	if(isdefined(self.var_73F6))
	{
		thread func_8506();
	}

	for(;;)
	{
		var_06 = var_04 - gettime() * 0.001;
		if(self isfiringturret() && var_06 <= 0)
		{
			if(var_05 != "fire")
			{
				var_05 = "fire";
				thread doshoot();
			}

			var_06 = var_02 + randomfloat(var_03);
			thread func_8539(var_06);
			self waittill("turretstatechange");
			var_06 = var_00 + randomfloat(var_01);
			var_04 = gettime() + int(var_06 * 1000);
			continue;
		}

		if(var_05 != "aim")
		{
			var_05 = "aim";
		}

		thread func_8539(var_06);
		self waittill("turretstatechange");
	}
}

//Function Number: 10
doshoot()
{
	self endon("death");
	self endon("turretstatechange");
	for(;;)
	{
		self shootturret();
		wait(0.1);
	}
}

//Function Number: 11
func_8506()
{
	self endon("death");
	self endon("stop_burst_fire_unmanned");
	if(isdefined(self.var_73F8))
	{
		self.var_73F9 = 1;
	}

	for(;;)
	{
		self waittill("turret_fire");
		playfxontag(self.var_73F6,self,"tag_origin");
		if(isdefined(self.var_73F9) && self.var_73F9)
		{
			thread func_8507();
		}
	}
}

//Function Number: 12
func_8507()
{
	self endon("death");
	self.var_73F9 = 0;
	var_00 = self gettagorigin("tag_origin");
	var_01 = common_scripts\utility::drop_to_ground(var_00,-30);
	var_02 = var_00[2] - var_01[2];
	var_03 = var_02 / 300;
	wait(var_03);
	level thread common_scripts\utility::func_5D1F(self.var_73F8,var_01);
	wait(1);
	self.var_73F9 = 1;
}

//Function Number: 13
func_8539(param_00)
{
	if(param_00 <= 0)
	{
	}

	self endon("turretstatechange");
	wait(param_00);
	if(isdefined(self))
	{
		self notify("turretstatechange");
	}
}

//Function Number: 14
func_6327(param_00)
{
	self endon("death");
	self notify("stop random_spread");
	self endon("stop random_spread");
	self endon("stopfiring");
	self settargetentity(param_00);
	for(;;)
	{
		if(isplayer(param_00))
		{
			param_00.origin = self.var_508F getorigin();
		}
		else
		{
			param_00.origin = self.var_508F.origin;
		}

		param_00.origin = param_00.origin + (20 - randomfloat(40),20 - randomfloat(40),20 - randomfloat(60));
		wait(0.2);
	}
}

//Function Number: 15
func_51F5(param_00)
{
	self notify("stop_using_built_in_burst_fire");
	self endon("stop_using_built_in_burst_fire");
	param_00 stopfiring();
	for(;;)
	{
		param_00 waittill("startfiring");
		thread func_18B1(param_00);
		param_00 startfiring();
		param_00 waittill("stopfiring");
		param_00 stopfiring();
	}
}

//Function Number: 16
func_18B1(param_00,param_01)
{
	param_00 endon("stopfiring");
	self endon("stop_using_built_in_burst_fire");
	if(isdefined(param_00.script_delay_min))
	{
		var_02 = param_00.script_delay_min;
	}
	else
	{
		var_02 = burst_fire_settings("delay");
	}

	if(isdefined(param_00.script_delay_max))
	{
		var_03 = param_00.script_delay_max - var_02;
	}
	else
	{
		var_03 = burst_fire_settings("delay_range");
	}

	if(isdefined(param_00.var_6B5D))
	{
		var_04 = param_00.var_6B5D;
	}
	else
	{
		var_04 = burst_fire_settings("burst");
	}

	if(isdefined(param_00.var_6B5C))
	{
		var_05 = param_00.var_6B5C - var_04;
	}
	else
	{
		var_05 = burst_fire_settings("burst_range");
	}

	for(;;)
	{
		param_00 startfiring();
		if(isdefined(param_01))
		{
			param_00 thread func_6327(param_01);
		}

		wait(var_04 + randomfloat(var_05));
		param_00 stopfiring();
		wait(var_02 + randomfloat(var_03));
	}
}

//Function Number: 17
_spawner_mg42_think()
{
	if(!isdefined(self.var_33A5))
	{
		self.var_33A5 = 0;
	}

	if(!isdefined(self.targetname))
	{
	}

	var_00 = getnode(self.targetname,"target");
	if(!isdefined(var_00))
	{
	}

	if(!isdefined(var_00.var_6C1E))
	{
	}

	if(!isdefined(var_00.var_51F4))
	{
		var_00.var_51F4 = 1;
	}

	self.var_6C1E = var_00.var_6C1E;
	var_01 = 1;
	for(;;)
	{
		if(var_01)
		{
			var_01 = 0;
			if(isdefined(var_00.targetname) || self.var_33A5)
			{
				self waittill("get new user");
			}
		}

		if(!var_00.var_51F4)
		{
			var_00 waittill("enable mg42");
			var_00.var_51F4 = 1;
		}

		var_02 = [];
		var_03 = getaiarray();
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = 1;
			if(isdefined(var_03[var_04].var_6C1E) && var_03[var_04].var_6C1E == self.var_6C1E)
			{
				var_05 = 0;
			}

			if(isdefined(var_03[var_04].var_87AC))
			{
				var_05 = 1;
			}

			if(var_05)
			{
				var_02[var_02.size] = var_03[var_04];
			}
		}

		if(var_02.size)
		{
			var_03 = maps\_utility::func_3808(var_00.origin,undefined,var_02);
		}
		else
		{
			var_03 = maps\_utility::func_3807(var_00.origin,undefined);
		}

		var_02 = undefined;
		if(isdefined(var_03))
		{
			var_03 notify("stop_going_to_node");
			var_03 thread maps\_spawner::go_to_node(var_00);
			var_03 waittill("death");
			continue;
		}

		self waittill("get new user");
	}
}

//Function Number: 18
mg42_think()
{
	if(!isdefined(self.ai_mode))
	{
		self.ai_mode = "manual_ai";
	}

	var_00 = getnode(self.target,"targetname");
	if(!isdefined(var_00))
	{
	}

	var_01 = getent(var_00.target,"targetname");
	var_01.var_59DA = var_00.origin;
	if(isdefined(var_01.target))
	{
		if(!isdefined(level.var_51FD) || !isdefined(level.var_51FD[var_01.target]))
		{
			level.var_51FD[var_01.target] = 0;
			getent(var_01.target,"targetname") thread func_51FD();
		}

		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	for(;;)
	{
		if(self.count == 0)
		{
		}

		var_03 = undefined;
		while(!isdefined(var_03))
		{
			var_03 = self dospawn();
			wait(1);
		}

		var_03 thread mg42_gunner_think(var_01,var_02,self.ai_mode);
		var_03 thread func_51F5(var_01);
		var_03 waittill("death");
		if(isdefined(self.script_delay))
		{
			wait(self.script_delay);
			continue;
		}

		if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
		{
			wait(self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min));
			continue;
		}

		wait(1);
	}
}

//Function Number: 19
func_4AEB(param_00,param_01,param_02,param_03)
{
	param_00 waittill(param_01);
	if(isdefined(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_03))
	{
		param_03 delete();
	}
}

//Function Number: 20
mg42_gunner_think(param_00,param_01,param_02)
{
	self endon("death");
	if(param_02 == "manual_ai")
	{
		for(;;)
		{
			thread mg42_gunner_manual_think(param_00,param_01);
			self waittill("auto_ai");
			func_546E(param_00,"auto_ai");
			self waittill("manual_ai");
		}
	}

	for(;;)
	{
		func_546E(param_00,"auto_ai",level.player);
		self waittill("manual_ai");
		thread mg42_gunner_manual_think(param_00,param_01);
		self waittill("auto_ai");
	}
}

//Function Number: 21
func_5EF2()
{
	if(!isdefined(level.var_5DB9))
	{
		return 0;
	}

	if(level.player getstance() == "prone")
	{
		return 1;
	}

	if(level.var_5DBA == "cow" && level.player getstance() == "crouch")
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
func_79C2()
{
	if(level.player getstance() == "prone")
	{
		return (0,0,5);
	}
	else if(level.player getstance() == "crouch")
	{
		return (0,0,25);
	}

	return (0,0,50);
}

//Function Number: 23
mg42_gunner_manual_think(param_00,param_01)
{
	self endon("death");
	self endon("auto_ai");
	self.pacifist = 1;
	self setgoalpos(param_00.var_59DA);
	self.goalradius = level.magic_distance;
	self waittill("goal");
	if(param_01)
	{
		if(!level.var_51FD[param_00.target])
		{
			level waittill(param_00.target);
		}
	}

	self.pacifist = 0;
	param_00 setmode("auto_ai");
	param_00 cleartargetentity();
	var_02 = spawn("script_origin",(0,0,0));
	var_03 = spawn("script_model",(0,0,0));
	var_03.scale = 3;
	if(getdvar("mg42") != "off")
	{
		var_03 setmodel("temp");
	}

	var_03 thread func_8037(param_00,var_02);
	level thread func_4AEB(self,"death",var_02,var_03);
	level thread func_4AEB(self,"auto_ai",var_02,var_03);
	param_00.var_5F45 = 0;
	var_04 = 0;
	var_05 = getentarray("mg42_target","targetname");
	if(var_05.size > 0)
	{
		var_06 = 1;
		var_07 = var_05[randomint(var_05.size)].origin;
		thread func_7426(var_05);
		func_546E(param_00);
		self.target_entity = var_02;
		param_00 setmode("manual_ai");
		param_00 settargetentity(var_02);
		param_00 notify("startfiring");
		var_08 = 15;
		var_09 = 0.08;
		var_0A = 0.05;
		var_02.origin = var_05[randomint(var_05.size)].origin;
		var_0B = 0;
		while(!isdefined(level.var_5DB9))
		{
			var_07 = var_02.origin;
			if(distance(var_07,var_05[self.var_3DFF].origin) > var_08)
			{
				var_0C = vectornormalize(var_05[self.var_3DFF].origin - var_07);
				var_0C = var_0C * var_08;
				var_07 = var_07 + var_0C;
			}
			else
			{
				self notify("next_target");
			}

			var_02.origin = var_07;
			wait(0.1);
		}

		for(;;)
		{
			for(var_0D = 0;var_0D < 1;var_0D = var_0D + var_0A)
			{
				var_02.origin = var_07 * 1 - var_0D + level.player getorigin() + func_79C2() * var_0D;
				if(func_5EF2())
				{
					var_0D = 2;
				}

				wait(var_09);
			}

			var_0E = level.player getorigin();
			while(!func_5EF2())
			{
				var_02.origin = level.player getorigin();
				var_0F = var_02.origin - var_0E;
				var_02.origin = var_02.origin + var_0F + func_79C2();
				var_0E = level.player getorigin();
				wait(0.1);
			}

			if(func_5EF2())
			{
				var_0B = gettime() + 1500 + randomfloat(4000);
				while(func_5EF2() && isdefined(level.var_5DB9.target) && gettime() < var_0B)
				{
					var_10 = getentarray(level.var_5DB9.target,"targetname");
					var_10 = var_10[randomint(var_10.size)];
					var_02.origin = var_10.origin + (randomfloat(30) - 15,randomfloat(30) - 15,randomfloat(40) - 60);
					wait(0.1);
				}
			}

			self notify("next_target");
			while(func_5EF2())
			{
				var_07 = var_02.origin;
				if(distance(var_07,var_05[self.var_3DFF].origin) > var_08)
				{
					var_0C = vectornormalize(var_05[self.var_3DFF].origin - var_07);
					var_0C = var_0C * var_08;
					var_07 = var_07 + var_0C;
				}
				else
				{
					self notify("next_target");
				}

				var_02.origin = var_07;
				wait(0.1);
			}
		}
	}

	for(;;)
	{
		func_546E(param_00);
		while(!isdefined(level.var_5DB9))
		{
			if(!param_00.var_5F45)
			{
				param_00 settargetentity(level.player);
				param_00.var_5F45 = 1;
				var_03.var_7F3E = level.player;
			}

			wait(0.2);
		}

		param_00 setmode("manual_ai");
		func_546E(param_00);
		param_00 notify("startfiring");
		var_0B = gettime() + 1500 + randomfloat(4000);
		while(var_0B > gettime())
		{
			if(isdefined(level.var_5DB9))
			{
				var_10 = getentarray(level.var_5DB9.target,"targetname");
				var_10 = var_10[randomint(var_10.size)];
				var_02.origin = var_10.origin + (randomfloat(30) - 15,randomfloat(30) - 15,randomfloat(40) - 60);
				param_00 settargetentity(var_02);
				var_03.var_7F3E = var_02;
				wait(randomfloat(1));
				continue;
			}

			break;
		}

		param_00 notify("stopfiring");
		func_546E(param_00);
		if(param_00.var_5F45)
		{
			param_00 setmode("auto_ai");
			param_00 cleartargetentity();
			param_00.var_5F45 = 0;
			var_03.var_7F3E = var_03;
			var_03.origin = (0,0,0);
		}

		while(isdefined(level.var_5DB9))
		{
			wait(0.2);
		}

		wait(0.75 + randomfloat(0.2));
	}
}

//Function Number: 24
func_7426(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = [];
		for(var_02 = 0;var_02 < param_00.size;var_02++)
		{
			var_01[var_02] = 0;
		}

		for(var_02 = 0;var_02 < param_00.size;var_02++)
		{
			self.var_3DFF = randomint(param_00.size);
			self waittill("next_target");
			while(var_01[self.var_3DFF])
			{
				self.var_3DFF++;
				if(self.var_3DFF >= param_00.size)
				{
					self.var_3DFF = 0;
				}
			}

			var_01[self.var_3DFF] = 1;
		}
	}
}

//Function Number: 25
func_546E(param_00,param_01,param_02)
{
	self setgoalpos(param_00.var_59DA);
	self.goalradius = level.magic_distance;
	self waittill("goal");
	if(isdefined(param_01) && param_01 == "auto_ai")
	{
		param_00 setmode("auto_ai");
		if(isdefined(param_02))
		{
			param_00 settargetentity(param_02);
		}
		else
		{
			param_00 cleartargetentity();
		}
	}

	self useturret(param_00);
}

//Function Number: 26
func_8037(param_00,param_01)
{
	if(getdvar("mg42") == "off")
	{
	}

	self.var_7F3E = self;
	for(;;)
	{
		self.origin = param_01.origin;
		wait(0.1);
	}
}

//Function Number: 27
func_8514(param_00)
{
	var_01 = getent(param_00.auto_mg42_target,"targetname");
	var_02 = 0.5;
	if(isdefined(var_01.var_6CE3))
	{
		var_02 = var_01.var_6CE3;
	}

	var_03 = 2;
	if(isdefined(var_01.var_6CE2))
	{
		var_02 = var_01.var_6CE2;
	}

	for(;;)
	{
		var_01 waittill("turret_deactivate");
		wait(var_02 + randomfloat(var_03 - var_02));
		while(!isturretactive(var_01))
		{
			func_84DC(param_00,var_01);
			wait(1);
		}
	}
}

//Function Number: 28
func_84DC(param_00,param_01)
{
	var_02 = getaiarray();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] isingoal(param_00.origin) && var_02[var_03] canuseturret(param_01))
		{
			var_04 = var_02[var_03].keepclaimednodeifvalid;
			var_02[var_03].keepclaimednodeifvalid = 0;
			if(!var_02[var_03] usecovernode(param_00))
			{
				var_02[var_03].keepclaimednodeifvalid = var_04;
			}
		}
	}
}

//Function Number: 29
func_701B()
{
	init_mgturretsettings();
	var_00 = getentarray("misc_turret","code_classname");
	var_01 = maps\_utility::func_3A7F();
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].var_6CA5))
		{
			switch(var_00[var_02].var_6CA5)
			{
				case "easy":
					var_01 = "easy";
					break;

				case "medium":
					var_01 = "medium";
					break;

				case "hard":
					var_01 = "hard";
					break;

				case "fu":
					var_01 = "fu";
					break;

				default:
					break;
			}
		}

		mg42_setdifficulty(var_00[var_02],var_01);
	}
}

//Function Number: 30
mg42_setdifficulty(param_00,param_01)
{
	param_00.convergencetime = level.var_5211[param_01]["convergenceTime"];
	param_00.var_7D6B = level.var_5211[param_01]["suppressionTime"];
	param_00.accuracy = level.var_5211[param_01]["accuracy"];
	param_00.var_AAC = level.var_5211[param_01]["aiSpread"];
	param_00.var_5FDD = level.var_5211[param_01]["playerSpread"];
}

//Function Number: 31
func_51FB(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.88;
	}

	self endon("death");
	self notify("stop_mg42_target_drones");
	self endon("stop_mg42_target_drones");
	self.var_2B18 = 0;
	if(!isdefined(self.var_6BBA))
	{
		self.var_6BBA = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self setmode("manual_ai");
	var_03 = maps\_utility::func_3A7F();
	if(!isdefined(level.var_2B22))
	{
		var_04 = 1;
	}
	else
	{
		var_04 = 0;
	}

	for(;;)
	{
		if(var_04)
		{
			if(isdefined(self.drones_targets_sets_to_default))
			{
				self setmode(self.defaultonmode);
			}
			else if(param_00)
			{
				self setmode("auto_nonai");
			}
			else
			{
				self setmode("auto_ai");
			}

			level waittill("new_drone");
		}

		if(!isdefined(self.var_58B8))
		{
			self.var_58B8 = self.convergencetime;
		}

		self.convergencetime = 2;
		if(!param_00)
		{
			var_05 = self getturretowner();
			if(!isalive(var_05) || isplayer(var_05))
			{
				wait(0.05);
				continue;
			}
			else
			{
				param_01 = var_05.team;
			}
		}
		else
		{
			var_05 = undefined;
		}

		if(param_01 == "allies")
		{
			var_06 = "axis";
		}
		else
		{
			var_06 = "allies";
		}

		while(level.var_2B22[var_06].var_4C6E)
		{
			common_scripts\utility::lock("mg42_drones");
			if(!level.var_2B22[var_06].var_4C6E)
			{
				common_scripts\utility::unlock("mg42_drones");
				break;
			}

			var_07 = func_37EB(var_06,param_02);
			common_scripts\utility::unlock("mg42_drones");
			if(!isdefined(self.var_6BBA) || !self.var_6BBA)
			{
				wait(0.05);
				break;
			}

			if(!isdefined(var_07))
			{
				wait(0.05);
				break;
			}

			if(isdefined(self.anim_wait_func))
			{
				[[ self.anim_wait_func ]]();
			}

			if(param_00)
			{
				self setmode("manual");
			}
			else
			{
				self setmode("manual_ai");
			}

			self settargetentity(var_07,(0,0,32));
			func_2B0D(var_07,1,param_02);
			self cleartargetentity();
			self stopfiring();
			if(!param_00 && !isdefined(self getturretowner()) && self getturretowner() == var_05)
			{
				break;
			}
		}

		self.convergencetime = self.var_58B8;
		self.var_58B8 = undefined;
		self cleartargetentity();
		self stopfiring();
		if(level.var_2B22[var_06].var_4C6E)
		{
			var_04 = 0;
			continue;
		}

		var_04 = 1;
	}
}

//Function Number: 32
func_2B0D(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	var_03 = gettime() + param_01 * 1000;
	var_04 = 0;
	while(var_03 > gettime() || var_04)
	{
		common_scripts\utility::lock("mg42_drones_target_trace");
		var_05 = self getturrettarget(1);
		if(!bullettracepassed(self gettagorigin("tag_flash"),param_00.origin + (0,0,40),0,param_00))
		{
			common_scripts\utility::unlock("mg42_drones_target_trace");
			break;
		}
		else if(isdefined(var_05) && distance(var_05.origin,self.origin) < distance(self.origin,param_00.origin))
		{
			common_scripts\utility::unlock("mg42_drones_target_trace");
			break;
		}

		if(!var_04)
		{
			self startfiring();
			var_04 = 1;
		}

		common_scripts\utility::func_85C4("mg42_drones_target_trace");
	}

	self stopfiring();
	maps\_utility::func_7CFF(level.var_2B22[param_00.team],1);
}

//Function Number: 33
func_37EB(param_00,param_01)
{
	if(level.var_2B22[param_00].var_4C6E < 1)
	{
	}

	var_02 = undefined;
	var_03 = anglestoforward(self.angles);
	for(var_04 = 0;var_04 < level.var_2B22[param_00].var_4C6E;var_04++)
	{
		if(!isdefined(level.var_2B22[param_00].var_ED8[var_04]))
		{
			continue;
		}

		var_05 = vectortoangles(level.var_2B22[param_00].var_ED8[var_04].origin - self.origin);
		var_06 = anglestoforward(var_05);
		if(vectordot(var_03,var_06) < param_01)
		{
			continue;
		}

		var_02 = level.var_2B22[param_00].var_ED8[var_04];
		if(!bullettracepassed(self gettagorigin("tag_flash"),var_02 getcentroid(),0,var_02))
		{
			var_02 = undefined;
			continue;
		}

		break;
	}

	var_07 = self getturrettarget(1);
	if(!isdefined(self.prefers_drones))
	{
		if(isdefined(var_02) && isdefined(var_07) && distancesquared(self.origin,var_07.origin) < distancesquared(self.origin,var_02.origin))
		{
			var_02 = undefined;
		}
	}

	return var_02;
}

//Function Number: 34
saw_mgturretlink(param_00)
{
	var_01 = getentarray("misc_turret","code_classname");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(isdefined(var_01[var_03].targetname))
		{
			continue;
		}

		if(isdefined(var_01[var_03].var_49B0))
		{
			continue;
		}

		var_02[var_01[var_03].origin + ""] = var_01[var_03];
	}

	if(!var_02.size)
	{
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_05.type == "Path")
		{
			continue;
		}

		if(var_05.type == "Begin")
		{
			continue;
		}

		if(var_05.type == "End")
		{
			continue;
		}

		var_06 = anglestoforward((0,var_05.angles[1],0));
		foreach(var_0B, var_08 in var_02)
		{
			if(distance(var_05.origin,var_08.origin) > 50)
			{
				continue;
			}

			var_09 = anglestoforward((0,var_08.angles[1],0));
			var_0A = vectordot(var_06,var_09);
			if(var_0A < 0.9)
			{
				continue;
			}

			var_05.turretinfo = spawn("script_origin",var_08.origin);
			var_05.turretinfo.angles = var_08.angles;
			var_05.turretinfo.node = var_05;
			var_05.turretinfo.leftarc = 45;
			var_05.turretinfo.rightarc = 45;
			var_05.turretinfo.toparc = 15;
			var_05.turretinfo.bottomarc = 15;
			if(isdefined(var_08.leftarc))
			{
				var_05.turretinfo.leftarc = min(var_08.leftarc,45);
			}

			if(isdefined(var_08.rightarc))
			{
				var_05.turretinfo.rightarc = min(var_08.rightarc,45);
			}

			if(isdefined(var_08.toparc))
			{
				var_05.turretinfo.toparc = min(var_08.toparc,15);
			}

			if(isdefined(var_08.bottomarc))
			{
				var_05.turretinfo.bottomarc = min(var_08.bottomarc,15);
			}

			var_02[var_0B] = undefined;
			var_08 delete();
		}
	}
}

//Function Number: 35
func_11B1(param_00)
{
	var_01 = getentarray("misc_turret","code_classname");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!isdefined(var_01[var_03].targetname) || tolower(var_01[var_03].targetname) != "auto_mgturret")
		{
			continue;
		}

		if(!isdefined(var_01[var_03].var_30F7))
		{
			continue;
		}

		if(!isdefined(var_01[var_03].var_6B92))
		{
			var_02[var_01[var_03].origin + ""] = var_01[var_03];
		}
	}

	if(!var_02.size)
	{
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_05.type == "Path")
		{
			continue;
		}

		if(var_05.type == "Begin")
		{
			continue;
		}

		if(var_05.type == "End")
		{
			continue;
		}

		var_06 = anglestoforward((0,var_05.angles[1],0));
		var_07 = getarraykeys(var_02);
		for(var_03 = 0;var_03 < var_07.size;var_03++)
		{
			var_08 = var_02[var_07[var_03]];
			if(distance(var_05.origin,var_08.origin) > 70)
			{
				continue;
			}

			var_09 = anglestoforward((0,var_08.angles[1],0));
			var_0A = vectordot(var_06,var_09);
			if(var_0A < 0.9)
			{
				continue;
			}

			var_05.turret = var_08;
			var_08.node = var_05;
			var_08.issetup = 1;
			var_02[var_07[var_03]] = undefined;
		}
	}

	param_00 = undefined;
}

//Function Number: 36
save_turret_sharing_info()
{
	self.shared_turrets = [];
	self.shared_turrets["connected"] = [];
	self.shared_turrets["ambush"] = [];
	if(!isdefined(self.var_30F7))
	{
	}

	level.var_73D7[self.var_30F7] = self;
	if(isdefined(self.var_6CE4))
	{
		var_00 = strtok(self.var_6CE4," ");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			self.shared_turrets["connected"][var_00[var_01]] = 1;
		}
	}

	if(isdefined(self.var_6CE1))
	{
		var_00 = strtok(self.var_6CE1," ");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			self.shared_turrets["ambush"][var_00[var_01]] = 1;
		}
	}
}

//Function Number: 37
func_665B()
{
	self notify("gun_placed_again");
	self endon("gun_placed_again");
	self waittill("restore_default_drop_pitch");
	wait(1);
	self restoredefaultdroppitch();
}

//Function Number: 38
dropturret()
{
	thread func_2B62();
}

//Function Number: 39
func_2B62()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00.origin = self gettagorigin(level.var_60A3);
	var_00.angles = self gettagangles(level.var_60A3);
	var_00 setmodel(self.var_852D);
	var_01 = anglestoforward(self.angles);
	var_01 = var_01 * 100;
	var_00 movegravity(var_01,0.5);
	self detach(self.var_852D,level.var_60A3);
	self.var_852D = undefined;
	wait(0.7);
	var_00 delete();
}

//Function Number: 40
func_8524()
{
	self endon("kill_turret_detach_thread");
	self endon("dropped_gun");
	self waittill("death");
	if(!isdefined(self))
	{
	}

	dropturret();
}

//Function Number: 41
func_8525()
{
	self endon("death");
	self endon("kill_turret_detach_thread");
	self waittill("dropped_gun");
	self detach(self.var_852D,level.var_60A3);
}

//Function Number: 42
func_665C()
{
	self.run_overrideanim = undefined;
	common_scripts\utility::set_all_exceptions(::animscripts/init::empty);
}

//Function Number: 43
func_665F()
{
	self waittill("turret_deactivate");
	self restoredefaultdroppitch();
}

//Function Number: 44
func_8675(param_00)
{
	self endon("death");
	self endon("end_mg_behavior");
	self endon("stop_updating_enemy_target_pos");
	for(;;)
	{
		self waittill("saw_enemy");
		param_00.origin = self.var_4BFE;
	}
}

//Function Number: 45
func_545D(param_00,param_01)
{
	self endon("death");
	self endon("end_mg_behavior");
	self endon("stop_updating_enemy_target_pos");
	var_02 = self.turret.origin + (0,0,16);
	var_03 = param_01.origin + (0,0,16);
	for(;;)
	{
		wait(0.05);
		if(sighttracepassed(param_00.origin,var_03,0,undefined))
		{
			continue;
		}

		var_04 = vectortoangles(var_02 - param_00.origin);
		var_05 = anglestoforward(var_04);
		var_05 = var_05 * 8;
		param_00.origin = param_00.origin + var_05;
	}
}

//Function Number: 46
func_640A(param_00)
{
	self endon("death");
	self endon("end_mg_behavior");
	self endon("stop_updating_enemy_target_pos");
	param_00.var_17BA = [];
	for(;;)
	{
		param_00.var_17BA[param_00.var_17BA.size] = self.origin + (0,0,50);
		wait(0.35);
	}
}

//Function Number: 47
aim_turret_at_ambush_point_or_visible_enemy(param_00,param_01)
{
	if(!isalive(self.current_enemy) && self cansee(self.current_enemy))
	{
		param_01.origin = self.var_4BFE;
	}

	var_02 = anglestoforward(param_00.angles);
	for(var_03 = param_01.var_17BA.size - 3;var_03 >= 0;var_03--)
	{
		var_04 = param_01.var_17BA[var_03];
		var_05 = vectornormalize(var_04 - param_00.origin);
		var_06 = vectordot(var_02,var_05);
		if(var_06 < 0.75)
		{
			continue;
		}

		param_01.origin = var_04;
		if(sighttracepassed(param_00.origin,var_04,0,undefined))
		{
			continue;
		}

		break;
	}
}

//Function Number: 48
func_3259(param_00)
{
	var_01 = get_portable_mg_spot(param_00);
	var_02 = var_01["spot"];
	var_03 = var_01["type"];
	if(!isdefined(var_02))
	{
	}

	reserve_turret(var_02);
	thread func_8675(param_00);
	thread func_545D(param_00,var_02);
	if(var_03 == "ambush")
	{
		thread func_640A(param_00);
	}

	if(var_02.issetup)
	{
		func_4D43(var_02);
	}
	else
	{
		func_5BF7(var_02);
		run_to_new_spot_and_setup_gun(var_02);
	}

	self notify("stop_updating_enemy_target_pos");
	if(var_03 == "ambush")
	{
		aim_turret_at_ambush_point_or_visible_enemy(var_02,param_00);
	}

	var_02 settargetentity(param_00);
}

//Function Number: 49
func_7654(param_00)
{
	param_00 setmode("manual");
	wait(0.5);
	param_00 setmode("manual_ai");
}

//Function Number: 50
func_4D43(param_00)
{
	self stopuseturret();
	animscripts/shared::placeweaponon(self.primaryweapon,"none");
	var_01 = get_turret_setup_anim(param_00);
	var_02 = getstartorigin(param_00.origin,param_00.angles,var_01);
	self setruntopos(var_02);
	self waittill("runto_arrived");
	func_879D(param_00);
}

//Function Number: 51
func_5BF7(param_00)
{
	self stopuseturret();
	self.turret hide_turret();
}

//Function Number: 52
get_turret_setup_anim(param_00)
{
	var_01 = [];
	var_01["saw_bipod_stand"] = level.var_5201["bipod_stand_setup"];
	var_01["saw_bipod_crouch"] = level.var_5201["bipod_crouch_setup"];
	var_01["saw_bipod_prone"] = level.var_5201["bipod_prone_setup"];
	return var_01[param_00.weaponinfo];
}

//Function Number: 53
run_to_new_spot_and_setup_gun(param_00)
{
	var_01 = self.health;
	param_00 endon("turret_deactivate");
	self.var_51F3 = param_00;
	self endon("death");
	self endon("dropped_gun");
	var_02 = get_turret_setup_anim(param_00);
	self.var_852D = "weapon_mg42_carry";
	self notify("kill_get_gun_back_on_killanimscript_thread");
	animscripts/shared::placeweaponon(self.weapon,"none");
	if(self isbadguy())
	{
		self.health = 1;
	}

	self.run_overrideanim = %saw_gunner_run_fast;
	self.crouchrun_combatanim = %saw_gunner_run_fast;
	self attach(self.var_852D,level.var_60A3);
	thread func_8524();
	var_03 = getstartorigin(param_00.origin,param_00.angles,var_02);
	self setruntopos(var_03);
	wait(0.05);
	common_scripts\utility::set_all_exceptions(::animscripts/combat::func_3045);
	common_scripts\utility::clear_exception("move");
	common_scripts\utility::func_6EB3("cover_crouch",::func_429A);
	while(distance(self.origin,var_03) > 16)
	{
		self setruntopos(var_03);
		wait(0.05);
	}

	self notify("kill_turret_detach_thread");
	if(self isbadguy())
	{
		self.health = var_01;
	}

	if(soundexists("weapon_setup"))
	{
		thread common_scripts\utility::func_5D1F("weapon_setup");
	}

	self animscripted("setup_done",param_00.origin,param_00.angles,var_02);
	func_665C();
	self waittillmatch("end","setup_done");
	param_00 notify("restore_default_drop_pitch");
	param_00 func_7500();
	animscripts/shared::placeweaponon(self.primaryweapon,"right");
	func_879D(param_00);
	self detach(self.var_852D,level.var_60A3);
	common_scripts\utility::set_all_exceptions(::animscripts/init::empty);
	self notify("bcs_portable_turret_setup");
}

//Function Number: 54
func_5463()
{
	self setruntopos(self.var_69A6);
}

//Function Number: 55
func_429A()
{
	self endon("killanimscript");
	self waittill("death");
}

//Function Number: 56
func_87E2()
{
	if(!isdefined(self.turret))
	{
		return 0;
	}

	return self.turret.owner == self;
}

//Function Number: 57
func_851C()
{
	if(!func_87E2())
	{
		common_scripts\utility::clear_exception("move");
	}

	var_00 = find_connected_turrets("connected");
	var_01 = var_00["spots"];
	if(!var_01.size)
	{
		common_scripts\utility::clear_exception("move");
	}

	var_02 = self.node;
	if(!isdefined(var_02) || !maps\_utility::func_4803(var_01,var_02))
	{
		var_03 = func_3C20();
		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			var_02 = common_scripts\utility::func_6306(var_01);
			if(isdefined(var_03[var_02.origin + ""]))
			{
			}
		}
	}

	var_05 = var_02.turret;
	if(isdefined(var_05.reserved))
	{
	}

	reserve_turret(var_05);
	if(var_05.issetup)
	{
		func_4D43(var_05);
	}
	else
	{
		run_to_new_spot_and_setup_gun(var_05);
	}

	maps\_mg_penetration::func_3E14(var_02.turret);
}

//Function Number: 58
func_879D(param_00)
{
	var_01 = self useturret(param_00);
	if(var_01)
	{
		common_scripts\utility::func_6EB3("move",::func_851C);
		self.turret = param_00;
		thread func_51F5(param_00);
		param_00 setmode("manual_ai");
		param_00 thread func_665F();
		self.turret = param_00;
		param_00.owner = self;
		return 1;
	}

	param_00 restoredefaultdroppitch();
	return 0;
}

//Function Number: 59
get_portable_mg_spot(param_00)
{
	var_01 = [];
	var_01[var_01.size] = ::find_different_way_to_attack_last_seen_position;
	var_01[var_01.size] = ::func_326D;
	var_01 = common_scripts\utility::array_randomize(var_01);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = [[ var_01[var_02] ]](param_00);
		if(!isdefined(var_03["spots"]))
		{
			continue;
		}

		var_03["spot"] = common_scripts\utility::func_6306(var_03["spots"]);
		return var_03;
	}
}

//Function Number: 60
func_3C20()
{
	var_00 = [];
	var_01 = getaiarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].node))
		{
			continue;
		}

		var_00[var_01[var_02].node.origin + ""] = 1;
	}

	return var_00;
}

//Function Number: 61
find_connected_turrets(param_00)
{
	var_01 = level.var_73D7;
	var_02 = [];
	var_03 = getarraykeys(var_01);
	var_04 = func_3C20();
	var_04[self.node.origin + ""] = undefined;
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		if(var_01[var_06] == self.turret)
		{
			continue;
		}

		var_07 = getarraykeys(self.turret.shared_turrets[param_00]);
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			if(var_01[var_06].var_30F7 + "" != var_07[var_08])
			{
				continue;
			}

			if(isdefined(var_01[var_06].reserved))
			{
				continue;
			}

			if(isdefined(var_04[var_01[var_06].node.origin + ""]))
			{
				continue;
			}

			if(distance(self.goalpos,var_01[var_06].origin) > self.goalradius)
			{
				continue;
			}

			var_02[var_02.size] = var_01[var_06];
		}
	}

	var_09 = [];
	var_09["type"] = param_00;
	var_09["spots"] = var_02;
	return var_09;
}

//Function Number: 62
func_326D(param_00)
{
	return find_connected_turrets("ambush");
}

//Function Number: 63
find_different_way_to_attack_last_seen_position(param_00)
{
	var_01 = find_connected_turrets("connected");
	var_02 = var_01["spots"];
	if(!var_02.size)
	{
	}

	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		if(!common_scripts\utility::func_8E18(var_02[var_04].origin,var_02[var_04].angles,param_00.origin,0.75))
		{
			continue;
		}

		if(!sighttracepassed(param_00.origin,var_02[var_04].origin + (0,0,16),0,undefined))
		{
			continue;
		}

		var_03[var_03.size] = var_02[var_04];
	}

	var_01["spots"] = var_03;
	return var_01;
}

//Function Number: 64
func_60A4()
{
	save_turret_sharing_info();
	var_00 = 1;
	self.issetup = 1;
	self.reserved = undefined;
	if(isdefined(self.var_49B0))
	{
	}

	if(self.spawnflags & var_00)
	{
	}

	hide_turret();
}

//Function Number: 65
hide_turret()
{
	self notify("stop_checking_for_flanking");
	self.issetup = 0;
	self hide();
	self.var_76BA = 0;
	self makeunusable();
	self setdefaultdroppitch(0);
	thread func_665B();
}

//Function Number: 66
func_7500()
{
	self show();
	self.var_76BA = 1;
	self makeusable();
	self.issetup = 1;
	thread func_7C3A();
}

//Function Number: 67
func_7C3A()
{
	self endon("stop_checking_for_flanking");
	self waittill("turret_deactivate");
	if(isalive(self.owner))
	{
		self.owner notify("end_mg_behavior");
	}
}

//Function Number: 68
func_84EE(param_00)
{
	var_01 = param_00 getturretowner();
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01 == self;
}

//Function Number: 69
end_turret_reservation(param_00)
{
	func_8BAA(param_00);
	param_00.reserved = undefined;
}

//Function Number: 70
func_8BAA(param_00)
{
	param_00 endon("turret_deactivate");
	self endon("death");
	self waittill("end_mg_behavior");
}

//Function Number: 71
reserve_turret(param_00)
{
	param_00.reserved = self;
	thread end_turret_reservation(param_00);
}