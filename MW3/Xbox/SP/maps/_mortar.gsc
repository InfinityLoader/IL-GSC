/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_mortar.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 44
 * Decompile Time: 740 ms
 * Timestamp: 10/27/2023 2:34:29 AM
*******************************************************************/

//Function Number: 1
main()
{
}

//Function Number: 2
func_3C11()
{
	var_00 = getentarray("mortar","targetname");
	var_01 = -1;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_00[var_02] func_3C4A();
	}

	if(!isdefined(level.var_3C12))
	{
		common_scripts\utility::error("level.mortar not defined. define in level script");
	}

	level waittill("start_mortars");
	for(;;)
	{
		wait 1 + randomfloat(2);
		var_03 = randomint(var_00.size);
		for(var_02 = 0;var_02 < var_00.size;var_02++)
		{
			var_04 = var_02 + var_03 % var_00.size;
			var_05 = distance(level.player getorigin(),var_00[var_04].origin);
			var_06 = undefined;
			if(isdefined(level.var_3C13))
			{
				var_06 = distance(level.var_3C13.origin,var_00[var_04].origin);
			}
			else
			{
				var_06 = 360;
			}

			if(var_05 < 1600 && var_05 > 400 && var_06 > 350 && var_04 != var_01)
			{
				var_00[var_04] activate_mortar(400,300,25,undefined,undefined,undefined,0);
				var_01 = var_04;
				if(var_05 < 500)
				{
					maps\_shellshock::main(4);
				}

				break;
			}
		}
	}
}

//Function Number: 3
railyard_style(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_00))
	{
		param_00 = 7;
	}

	if(!isdefined(param_01))
	{
		param_01 = 2200;
	}

	if(!isdefined(param_02))
	{
		param_02 = 300;
	}

	if(!isdefined(level.istopbarrage))
	{
		level.istopbarrage = 0;
	}

	if(!isdefined(param_09))
	{
		param_09 = 0;
	}

	var_0B = getentarray("mortar","targetname");
	var_0C = -1;
	for(var_0D = 0;var_0D < var_0B.size;var_0D++)
	{
		if(isdefined(var_0B[var_0D].target) && param_09 == 0)
		{
			var_0B[var_0D] func_3C4A();
		}
	}

	if(!isdefined(level.var_3C12))
	{
		common_scripts\utility::error("level.mortar not defined. define in level script");
	}

	if(isdefined(level.var_3C16))
	{
		level waittill(level.var_3C16);
	}

	for(;;)
	{
		if(level.istopbarrage != 0)
		{
			wait 1;
		}

		while(level.istopbarrage == 0)
		{
			if(isdefined(param_0A))
			{
				wait param_0A + randomfloat(param_00) + randomfloat(param_00);
			}
			else
			{
				wait randomfloat(param_00) + randomfloat(param_00);
			}

			var_0E = randomint(var_0B.size);
			for(var_0D = 0;var_0D < var_0B.size;var_0D++)
			{
				var_0F = var_0D + var_0E % var_0B.size;
				var_10 = distance(level.player getorigin(),var_0B[var_0F].origin);
				if(var_10 < param_01 && var_10 > param_02 && var_0F != var_0C)
				{
					var_0B[var_0F] activate_mortar(param_03,param_04,param_05,param_06,param_07,param_08,0);
					var_0C = var_0F;
					break;
				}
			}
		}
	}
}

//Function Number: 4
func_3C17()
{
	var_00 = [];
	var_01 = [];
	level.mortars = [];
	var_02 = getentarray("script_model","classname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(var_02[var_03].var_3C19))
		{
			if(!isdefined(level.mortars[var_02[var_03].var_3C19]))
			{
				level.mortars[var_02[var_03].var_3C19] = [];
			}

			var_04 = spawnstruct();
			var_04.origin = var_02[var_03].origin;
			var_04.angles = var_02[var_03].angles;
			if(isdefined(var_02[var_03].targetname))
			{
				var_04.targetname = var_02[var_03].targetname;
			}

			if(isdefined(var_02[var_03].target))
			{
				var_04.target = var_02[var_03].target;
			}

			level.mortars[var_02[var_03].var_3C19][level.mortars[var_02[var_03].var_3C19].size] = var_04;
			var_02[var_03] delete();
		}
	}

	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_00[var_03] hide();
		var_00[var_03].var_3C1A = 0;
	}

	if(!isdefined(level.var_3C12))
	{
		level.var_3C12 = loadfx("explosions/artilleryExp_dirt_brown");
	}

	var_05 = common_scripts\utility::array_combine(getentarray("trigger_multiple","classname"),getentarray("trigger_radius","classname"));
	for(var_03 = 0;var_03 < var_05.size;var_03++)
	{
		if(isdefined(var_05[var_03].var_3C19))
		{
			if(!isdefined(level.mortars[var_05[var_03].var_3C19]))
			{
				level.mortars[var_05[var_03].var_3C19] = [];
			}

			var_01[var_01.size] = var_05[var_03];
		}
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_01[var_03].var_3C1B = 0;
		var_01[var_03] thread script_mortargroup_mortar_group();
	}

	var_06 = undefined;
	for(;;)
	{
		level waittill("mortarzone",var_07);
		if(isdefined(var_06))
		{
			var_06 notify("wait again");
		}

		level.var_3C1C = var_07.var_3C19;
		var_07 thread func_3C1D();
		var_06 = var_07;
	}
}

//Function Number: 5
func_3C1D()
{
	var_00 = [];
	var_01 = gettime();
	var_02 = 0;
	if(isdefined(self.script_timer))
	{
		level notify("timed barrage");
		var_01 = gettime() + self.script_timer * 1000;
		var_02 = 1;
	}

	if(isdefined(self.script_radius))
	{
		var_03 = self.script_radius;
	}
	else
	{
		var_03 = 0;
	}

	if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
	{
		var_04 = 1;
	}
	else
	{
		var_04 = 0;
	}

	var_05 = 0;
	var_06 = 2;
	var_07 = 4;
	var_08 = 0;
	while((level.mortars[self.var_3C19].size > 0 && level.var_3C1C == self.var_3C19) || var_02)
	{
		if(var_04)
		{
			wait randomfloat(self.script_delay_max - self.script_delay_min) + self.script_delay_min;
		}
		else if(var_08)
		{
			if(var_05 < var_07)
			{
				wait randomfloat(0.5);
				var_05++;
			}
			else
			{
				var_05 = 0;
				var_07 = 2 + randomint(4);
				var_08 = 0;
				continue;
			}
		}
		else if(var_05 < var_06)
		{
			var_09 = randomfloat(2) + 1;
			wait var_09;
			var_05++;
		}
		else
		{
			var_06 = 0;
			var_0A = 1;
			var_07 = randomint(2) + 3;
			continue;
		}

		var_0A = [];
		var_0B = randomint(level.mortars[self.var_3C19].size);
		if(randomint(100) < 75)
		{
			var_0C = anglestoforward(level.player.angles);
			var_0D = [];
			for(var_0E = 0;var_0E < level.mortars[self.var_3C19].size;var_0E++)
			{
				if(var_03 > 0 && distance(level.player.origin,level.mortars[self.var_3C19][var_0E].origin) > var_03)
				{
					continue;
				}

				if(func_3C1F(level.mortars[self.var_3C19][var_0E],var_00))
				{
					continue;
				}

				var_0F = vectornormalize(level.mortars[self.var_3C19][var_0E].origin - level.player.origin);
				if(vectordot(var_0C,var_0F) > 0.3)
				{
					var_0D[var_0D.size] = var_0E;
				}
			}

			if(var_0D.size > 0)
			{
				var_0B = var_0D[randomint(var_0D.size)];
			}
		}

		if(var_00.size > 3)
		{
			var_00 = [];
		}

		var_00[var_00.size] = level.mortars[self.var_3C19][var_0B];
		level.mortars[self.var_3C19][var_0B] thread func_3C20();
		if(var_02 && gettime() > var_01)
		{
			if(isdefined(self.target))
			{
				var_10 = getent(self.target,"targetname");
				if(isdefined(var_10))
				{
					var_10 notify("trigger");
					level notify("timed barrage finished");
				}
			}

			break;
		}
	}
}

//Function Number: 6
func_3C1F(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
func_3C20()
{
	if(isdefined(self.targetname) && isdefined(level.mortarthread[self.targetname]))
	{
		level thread [[ level.mortarthread[self.targetname] ]](self);
	}
	else
	{
		thread activate_mortar(undefined,undefined,undefined,undefined,undefined,undefined,1);
	}

	self waittill("mortar");
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00))
		{
			var_00 notify("trigger");
		}
	}
}

//Function Number: 8
script_mortargroup_mortar_group()
{
	for(;;)
	{
		self waittill("trigger");
		if(isdefined(level.var_3C1C) && level.var_3C1C == self.var_3C19)
		{
			continue;
		}

		level notify("mortarzone",self);
		self waittill("wait again");
	}
}

//Function Number: 9
func_3C23()
{
	level.var_3C24 = getentarray("mortartrigger","targetname");
	level.mortars = getentarray("script_origin","classname");
	for(var_00 = 0;var_00 < level.mortars.size;var_00++)
	{
		if(isdefined(level.mortars[var_00].var_3C19))
		{
			level.mortars[var_00] func_3C4A();
		}
	}

	level.var_3C25 = -1;
	if(!isdefined(level.var_3C12))
	{
		common_scripts\utility::error("level.mortar not defined. define in level script");
	}

	for(var_00 = 0;var_00 < level.var_3C24.size;var_00++)
	{
		thread func_3C26(var_00);
	}
}

//Function Number: 10
func_3C26(param_00)
{
	var_01 = getentarray(level.var_3C24[param_00].target,"targetname");
	for(;;)
	{
		if(level.player istouching(level.var_3C24[param_00]))
		{
			var_02 = randomint(var_01.size);
			while(var_02 == level.var_3C25)
			{
				var_02 = randomint(var_01.size);
				wait 0.1;
			}

			var_01[var_02] activate_mortar(undefined,undefined,undefined,undefined,undefined,undefined,0);
			level.var_3C25 = var_02;
		}

		wait randomfloat(3) + randomfloat(4);
	}
}

//Function Number: 11
bunker_style_mortar()
{
	var_00 = [];
	var_01 = undefined;
	var_02 = [];
	var_03 = common_scripts\utility::getstructarray("mortar_bunker","targetname");
	var_04 = getentarray("mortar_bunker","targetname");
	if(isdefined(var_04) && var_04.size > 0)
	{
		var_01 = maps\_utility::array_merge(var_03,var_04);
	}
	else
	{
		var_01 = var_03;
	}

	for(var_05 = 0;var_05 < var_01.size;var_05++)
	{
		if(!isdefined(var_01[var_05].var_3C19))
		{
			continue;
		}

		var_06 = -1;
		var_07 = int(var_01[var_05].var_3C19);
		for(var_08 = 0;var_08 < var_00.size;var_08++)
		{
			if(var_07 != var_02[var_08])
			{
				continue;
			}

			var_06 = var_08;
			break;
		}

		if(var_06 == -1)
		{
			var_00[var_00.size] = [];
			var_02[var_02.size] = var_07;
			var_06 = var_00.size - 1;
		}

		var_00[var_06][var_00[var_06].size] = var_01[var_05];
	}

	for(var_05 = 0;var_05 < var_00.size;var_05++)
	{
		thread func_3C28(var_00[var_05],var_03);
	}

	wait 0.05;
	common_scripts\utility::array_thread(getentarray("mortar_on","targetname"),::func_3C48,"on");
	common_scripts\utility::array_thread(getentarray("mortar_off","targetname"),::func_3C48,"off");
}

//Function Number: 12
func_3C28(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(isdefined(level.var_3C29))
	{
		var_02 = level.var_3C29;
	}
	else
	{
		var_02 = 4;
	}

	if(isdefined(level.var_3C2A))
	{
		var_03 = level.var_3C2A;
	}
	else
	{
		var_03 = 6;
	}

	var_04 = int(param_00[0].var_3C19);
	for(;;)
	{
		level waittill("start_mortars " + var_04);
		thread bunker_style_mortar_activate(param_00,var_02,var_03,var_04,param_01);
	}
}

//Function Number: 13
bunker_style_mortar_activate(param_00,param_01,param_02,param_03,param_04)
{
	level endon("start_mortars " + param_03);
	level endon("stop_mortars " + param_03);
	for(;;)
	{
		wait 0.05;
		var_05 = maps\_utility::getclosest(level.player.origin,param_04);
		if(!isdefined(level.mortarnoincomingsound))
		{
			common_scripts\utility::play_sound_in_space("mortar_incoming_bunker",var_05.origin);
		}

		var_05 = maps\_utility::getclosest(level.player.origin,param_04);
		thread common_scripts\utility::play_sound_in_space("exp_artillery_underground",var_05.origin);
		common_scripts\utility::array_thread(param_00,::bunker_style_mortar_explode);
		if(!isdefined(level.mortarnoquake))
		{
			if(common_scripts\utility::cointoss())
			{
				earthquake(0.2,1.5,var_05.origin,1250);
			}
			else
			{
				earthquake(0.35,2.75,var_05.origin,1250);
			}
		}

		level notify("mortar_hit");
		wait randomfloatrange(param_01,param_02);
		param_00 = common_scripts\utility::array_removeundefined(param_00);
	}
}

//Function Number: 14
bunker_style_mortar_explode(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(level.var_3C2F) && mortar_within_player_fov(level.var_3C2F) == 0)
	{
		return;
	}

	if(isdefined(level.var_195B))
	{
		var_02 = level.var_195B;
	}
	else
	{
		var_02 = 1024;
	}

	var_03 = var_02 * var_02;
	var_04 = distancesquared(level.player.origin,self.origin);
	if(var_04 > var_03)
	{
		return;
	}

	if(isdefined(self.classname) && self.classname == "trigger_radius")
	{
		if(!level.player istouching(self) && distance(level.player.origin,self.origin) < level.var_3C30)
		{
			radiusdamage(self.origin,self.radius,500,500);
			self delete();
			return;
		}

		return;
	}

	playfx(level._effect["mortar"][self.script_fxid],self.origin);
	if(var_04 < 262144)
	{
		thread common_scripts\utility::play_sound_in_space("emt_single_ceiling_debris",self.origin);
	}
}

//Function Number: 15
func_3C31()
{
	var_00 = [];
	var_01 = [];
	var_02 = maps\_utility::getstructarray_delete("mortar","targetname");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isdefined(var_02[var_03].var_3C19))
		{
			continue;
		}

		var_04 = -1;
		var_05 = int(var_02[var_03].var_3C19);
		for(var_06 = 0;var_06 < var_00.size;var_06++)
		{
			if(var_05 != var_01[var_06])
			{
				continue;
			}

			var_04 = var_06;
			break;
		}

		if(var_04 == -1)
		{
			var_00[var_00.size] = [];
			var_01[var_01.size] = var_05;
			var_04 = var_00.size - 1;
		}

		var_00[var_04][var_00[var_04].size] = var_02[var_03];
	}

	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		thread bog_style_mortar_think(var_00[var_03]);
	}

	wait 0.05;
	common_scripts\utility::array_thread(getentarray("mortar_on","targetname"),::func_3C42,"on");
	common_scripts\utility::array_thread(getentarray("mortar_off","targetname"),::func_3C42,"off");
}

//Function Number: 16
bog_style_mortar_think(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(isdefined(level.var_3C29))
	{
		var_02 = level.var_3C29;
	}
	else
	{
		var_02 = 0.5;
	}

	if(isdefined(level.var_3C2A))
	{
		var_03 = level.var_3C2A;
	}
	else
	{
		var_03 = 3;
	}

	param_01 = int(param_00[0].var_3C19);
	for(;;)
	{
		level waittill("start_mortars " + param_01);
		level thread func_3C34(param_00,param_01,var_02,var_03);
		if(isdefined(level.bogmortarsgoonce))
		{
			return;
		}
	}
}

//Function Number: 17
func_3C34(param_00,param_01,param_02,param_03)
{
	level endon("start_mortars " + param_01);
	level endon("stop_mortars " + param_01);
	if(isdefined(level.var_195B))
	{
		var_04 = level.var_195B;
	}
	else
	{
		var_04 = 300;
	}

	var_05 = spawn("trigger_radius",(0,0,0),0,var_04,256);
	thread bog_style_mortar_cleanup(var_05,param_01);
	for(;;)
	{
		for(;;)
		{
			wait 0.05;
			var_06 = randomint(param_00.size);
			if(isdefined(param_00[var_06].var_3C35))
			{
				continue;
			}

			var_07 = distance(level.player.origin,param_00[var_06].origin);
			if(var_07 < var_04)
			{
				continue;
			}

			if(isdefined(level.var_3C36) && level.var_3C36.size > 0)
			{
				var_05.origin = param_00[var_06].origin;
				if(func_3C3B(level.var_3C36,var_05))
				{
					continue;
				}
			}

			if(!isdefined(level.nomaxmortardist) && var_07 > 1000)
			{
				continue;
			}

			if(isdefined(level.mortar_max_dist) && var_07 > level.mortar_max_dist)
			{
				continue;
			}

			if(isdefined(level.var_3C2F) && param_00[var_06] mortar_within_player_fov(level.var_3C2F) == 0)
			{
				continue;
			}

			break;
		}

		if(isdefined(level.nomortars) && level.nomortars == 1)
		{
			return;
		}

		param_00[var_06] thread func_3C3E();
		wait param_02 + randomfloat(param_03 - param_02);
	}
}

//Function Number: 18
bog_style_mortar_cleanup(param_00,param_01)
{
	level waittill("stop_mortars " + param_01);
	param_00 delete();
}

//Function Number: 19
func_3C3B(param_00,param_01)
{
	foreach(var_03 in level.var_3C36)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 istouching(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
mortar_within_player_fov(param_00)
{
	var_01 = level.player geteye();
	var_02 = (0,0,0);
	if(isdefined(level.playermortarfovoffset))
	{
		var_02 = level.playermortarfovoffset;
	}

	var_03 = maps\_utility::within_fov(var_01,level.player getplayerangles() + var_02,self.origin,param_00);
	return var_03;
}

//Function Number: 21
func_3C3E(param_00,param_01)
{
	if(!isdefined(level.var_3C3F))
	{
		level.var_3C3F = 250;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	thread func_3C41();
	if(!param_00)
	{
		common_scripts\utility::play_sound_in_space(level.scr_sound["mortar"]["incomming"]);
	}

	if(isdefined(param_01))
	{
		thread common_scripts\utility::play_sound_in_space(param_01);
	}
	else
	{
		thread common_scripts\utility::play_sound_in_space(level.scr_sound["mortar"][self.script_fxid]);
	}

	setplayerignoreradiusdamage(1);
	radiusdamage(self.origin,level.var_3C3F,150,50);
	setplayerignoreradiusdamage(0);
	playfx(level._effect["mortar"][self.script_fxid],self.origin);
	if(isdefined(level.var_3C40))
	{
		earthquake(0.3,1,level.player.origin,2000);
	}

	if(getdvarint("bog_camerashake") > 0)
	{
		if(level.player getcurrentweapon() == "dragunov" && level.player playerads() > 0.8)
		{
			return;
		}

		earthquake(0.25,0.75,self.origin,1250);
	}
}

//Function Number: 22
func_3C41()
{
	self.var_3C35 = 1;
	wait 3 + randomfloat(2);
	self.var_3C35 = undefined;
}

//Function Number: 23
func_3C42(param_00)
{
	self waittill("trigger");
	if(param_00 == "on")
	{
		func_3C43(self.var_3C19);
		return;
	}

	if(param_00 == "off")
	{
		bog_style_mortar_off(self.var_3C19);
	}
}

//Function Number: 24
func_3C43(param_00)
{
	level notify("start_mortars " + param_00);
}

//Function Number: 25
bog_style_mortar_off(param_00)
{
	level notify("stop_mortars " + param_00);
}

//Function Number: 26
func_3C45(param_00)
{
	if(!isdefined(level.var_3C30))
	{
		level.var_3C30 = 512;
	}

	if(!isdefined(level.var_3C2F))
	{
		level.var_3C2F = cos(35);
	}

	level notify("start_mortars " + param_00);
}

//Function Number: 27
func_3C46(param_00)
{
	level waittill("mortar_hit");
	level notify("stop_mortars " + param_00);
}

//Function Number: 28
func_3C47(param_00)
{
	level notify("stop_mortars " + param_00);
}

//Function Number: 29
func_3C48(param_00)
{
	self waittill("trigger");
	if(param_00 == "on")
	{
		func_3C45(self.var_3C19);
		return;
	}

	if(param_00 == "off")
	{
		func_3C46(self.var_3C19);
	}
}

//Function Number: 30
func_3C49()
{
	level endon("stop falling mortars");
	func_3C4A();
	wait randomfloat(0.5) + randomfloat(0.5);
	for(;;)
	{
		if(distance(level.player getorigin(),self.origin) < 600)
		{
			activate_mortar(undefined,undefined,undefined,undefined,undefined,undefined,0);
			break;
		}

		wait 1;
	}

	wait 7 + randomfloat(20);
	for(;;)
	{
		if(distance(level.player getorigin(),self.origin) < 1200 && distance(level.player getorigin(),self.origin) > 400)
		{
			activate_mortar(undefined,undefined,undefined,undefined,undefined,undefined,0);
			wait 3 + randomfloat(14);
		}

		wait 1;
	}
}

//Function Number: 31
func_3C4A()
{
	self.var_3C1A = 0;
	if(isdefined(self.target))
	{
		self.var_3C4B = getentarray(self.target,"targetname");
		self.var_3C1A = 1;
	}
	else
	{
	}

	if(!isdefined(self.var_3C4B))
	{
	}

	if(isdefined(self.var_3C4C))
	{
		if(isdefined(self.var_3C4C))
		{
			self.var_3C4D = getent(self.var_3C4C,"targetname");
		}
		else if(isdefined(self.var_3C4B) && isdefined(self.var_3C4B[0].target))
		{
			self.var_3C4D = getent(self.var_3C4B[0].target,"targetname");
		}

		if(isdefined(self.var_3C4D))
		{
			self.var_3C4D hide();
			return;
		}

		return;
	}

	if(isdefined(self.var_3C1A))
	{
		if(isdefined(self.var_3C4B) && isdefined(self.var_3C4B[0].target))
		{
			self.var_3C4D = getent(self.var_3C4B[0].target,"targetname");
		}

		if(isdefined(self.var_3C4D))
		{
			self.var_3C4D hide();
			return;
		}
	}
}

//Function Number: 32
activate_mortar(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_3C53(undefined,param_06);
	level notify("mortar");
	self notify("mortar");
	if(!isdefined(param_00))
	{
		param_00 = 256;
	}

	if(!isdefined(param_01))
	{
		param_01 = 400;
	}

	if(!isdefined(param_02))
	{
		param_02 = 25;
	}

	radiusdamage(self.origin,param_00,param_01,param_02);
	if(isdefined(self.var_3C1A) && self.var_3C1A == 1 && isdefined(self.var_3C4B))
	{
		for(var_07 = 0;var_07 < self.var_3C4B.size;var_07++)
		{
			if(isdefined(self.var_3C4B[var_07]))
			{
				self.var_3C4B[var_07] delete();
			}
		}
	}

	if(isdefined(self.var_3C4D))
	{
		self.var_3C4D show();
	}

	self.var_3C1A = 0;
	func_3C4F(self.origin,param_03,param_04,param_05,undefined,param_06);
}

//Function Number: 33
func_3C4F(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.15;
	}

	if(!isdefined(param_02))
	{
		param_02 = 2;
	}

	if(!isdefined(param_03))
	{
		param_03 = 850;
	}

	thread func_3C51(param_05);
	if(isdefined(param_04))
	{
		playfx(param_04,param_00);
	}
	else
	{
		playfx(level.var_3C12,param_00);
	}

	earthquake(param_01,param_02,param_00,param_03);
	if(level.script != "burnville")
	{
		return;
	}

	if(isdefined(level.var_3C50))
	{
		return;
	}

	if(distance(level.player.origin,param_00) > 300)
	{
		return;
	}

	if(level.script == "carchase" || level.script == "breakout")
	{
		return;
	}

	level.var_3C50 = 1;
	level notify("shell shock player",param_02 * 4);
	maps\_shellshock::main(param_02 * 4);
}

//Function Number: 34
func_3C51(param_00)
{
	if(!isdefined(level.var_3C52))
	{
		level.var_3C52 = -1;
	}

	for(var_01 = randomint(3) + 1;var_01 == level.var_3C52;var_01 = randomint(3) + 1)
	{
	}

	level.var_3C52 = var_01;
	if(!param_00)
	{
		self playsound("mortar_explosion" + var_01);
		return;
	}

	common_scripts\utility::play_sound_in_space("mortar_explosion" + var_01,self.origin);
}

//Function Number: 35
func_3C53(param_00,param_01)
{
	var_02 = gettime();
	if(!isdefined(level.var_3C54))
	{
		level.var_3C54 = var_02;
	}
	else if(var_02 - level.var_3C54 < 1000)
	{
		wait 1;
		return;
	}
	else
	{
		level.var_3C54 = var_02;
	}

	if(!isdefined(param_00))
	{
		param_00 = randomint(3) + 1;
	}

	if(param_00 == 1)
	{
		if(param_01)
		{
			thread common_scripts\utility::play_sound_in_space("mortar_incoming1",self.origin);
		}
		else
		{
			self playsound("mortar_incoming1");
		}

		wait 0.8200001;
		return;
	}

	if(param_00 == 2)
	{
		if(param_01)
		{
			thread common_scripts\utility::play_sound_in_space("mortar_incoming2",self.origin);
		}
		else
		{
			self playsound("mortar_incoming2");
		}

		wait 0.42;
		return;
	}

	if(param_01)
	{
		thread common_scripts\utility::play_sound_in_space("mortar_incoming3",self.origin);
	}
	else
	{
		self playsound("mortar_incoming3");
	}

	wait 1.3;
}

//Function Number: 36
func_3C55()
{
	level.var_3C56 = [];
	level._explosion_iminrange = [];
	level.var_3C58 = [];
	level._explosion_idamagemax = [];
	level.var_3C5A = [];
	level._explosion_fquakepower = [];
	level.var_3C5C = [];
	level.var_3C5D = [];
}

//Function Number: 37
generic_style_setradius(param_00,param_01,param_02)
{
	level._explosion_iminrange[param_00] = param_01;
	level.var_3C56[param_00] = param_02;
}

//Function Number: 38
generic_style_setdamage(param_00,param_01,param_02,param_03)
{
	level.var_3C58[param_00] = param_01;
	level.var_3C5A[param_00] = param_02;
	level._explosion_idamagemax[param_00] = param_03;
}

//Function Number: 39
generic_style_setquake(param_00,param_01,param_02,param_03)
{
	level._explosion_fquakepower[param_00] = param_01;
	level.var_3C5C[param_00] = param_02;
	level.var_3C5D[param_00] = param_03;
}

//Function Number: 40
func_3C61(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = -1;
	var_08 = param_05;
	var_09 = param_04;
	generic_style_setradius(param_00,300,2200);
	if(!isdefined(param_01))
	{
		param_01 = 7;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(isdefined(level.explosion_stopnotify) && isdefined(level.explosion_stopnotify[param_00]))
	{
		level endon(level.explosion_stopnotify[param_00]);
	}

	if(!isdefined(level.bstopbarrage) || !isdefined(level.bstopbarrage[param_00]))
	{
		level.bstopbarrage[param_00] = 0;
	}

	var_0A = getentarray(param_00,"targetname");
	for(var_0B = 0;var_0B < var_0A.size;var_0B++)
	{
		if(isdefined(var_0A[var_0B].target) && !param_06)
		{
			var_0A[var_0B] func_3C4A();
		}
	}

	if(isdefined(level.var_3C64) && isdefined(level.var_3C64[param_00]))
	{
		level waittill(level.var_3C64[param_00]);
	}

	for(;;)
	{
		while(!level.bstopbarrage[param_00])
		{
			for(var_0C = 0;var_0C < param_02;var_0C++)
			{
				if(!isdefined(param_05))
				{
					var_08 = level.var_3C56[param_00];
				}

				if(!isdefined(param_04))
				{
					var_09 = level._explosion_iminrange[param_00];
				}

				var_0D = randomint(var_0A.size);
				for(var_0B = 0;var_0B < var_0A.size;var_0B++)
				{
					var_0E = var_0B + var_0D % var_0A.size;
					var_0F = distance(level.player getorigin(),var_0A[var_0E].origin);
					if(var_0F < var_08 && var_0F > var_09 && var_0E != var_07)
					{
						var_0A[var_0E].iminrange = var_09;
						var_0A[var_0E] explosion_activate(param_00);
						var_07 = var_0E;
						break;
					}
				}

				var_07 = -1;
				if(isdefined(level.explosion_delay) && isdefined(level.explosion_delay[param_00]))
				{
					wait level.explosion_delay[param_00];
					continue;
				}

				wait randomfloat(param_01) + randomfloat(param_01);
			}

			if(isdefined(level.explosion_barrage_delay) && isdefined(level.explosion_barrage_delay[param_00]))
			{
				wait level.explosion_barrage_delay[param_00];
				continue;
			}

			wait randomfloat(param_03) + randomfloat(param_03);
		}

		wait 0.05;
	}
}

//Function Number: 41
explosion_activate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	generic_style_setdamage(param_00,256,25,400);
	generic_style_setquake(param_00,0.15,2,850);
	if(!isdefined(param_01))
	{
		param_01 = level.var_3C58[param_00];
	}

	if(!isdefined(param_02))
	{
		param_02 = level.var_3C5A[param_00];
	}

	if(!isdefined(param_03))
	{
		param_03 = level._explosion_idamagemax[param_00];
	}

	if(!isdefined(param_04))
	{
		param_04 = level._explosion_fquakepower[param_00];
	}

	if(!isdefined(param_05))
	{
		param_05 = level.var_3C5C[param_00];
	}

	if(!isdefined(param_06))
	{
		param_06 = level.var_3C5D[param_00];
	}

	func_3C6D(param_00);
	level notify("explosion",param_00);
	var_07 = 1;
	var_08 = undefined;
	var_09 = self;
	if(isdefined(self.iminrange) && distance(level.player.origin,self.origin) < self.iminrange)
	{
		var_0A = getentarray(param_00,"targetname");
		for(var_0B = 0;var_0B < var_0A.size;var_0B++)
		{
			var_0C = distance(level.player getorigin(),var_0A[var_0B].origin);
			if(var_0C > self.iminrange)
			{
				if(!isdefined(var_08) || var_0C < var_08)
				{
					var_08 = var_0C;
					var_09 = var_0A[var_0B];
				}
			}
		}

		if(!isdefined(var_08))
		{
			var_07 = 0;
		}
	}

	if(var_07)
	{
		radiusdamage(var_09.origin,param_01,param_03,param_02);
	}

	if(isdefined(var_09.var_3C1A) && var_09.var_3C1A == 1 && isdefined(var_09.var_3C4B))
	{
		for(var_0D = 0;var_0D < var_09.var_3C4B.size;var_0D++)
		{
			if(isdefined(var_09.var_3C4B[var_0D]))
			{
				var_09.var_3C4B[var_0D] delete();
			}
		}
	}

	if(isdefined(var_09.var_3C4D))
	{
		var_09.var_3C4D show();
	}

	var_09.var_3C1A = 0;
	var_09 explosion_boom(param_00,param_04,param_05,param_06);
}

//Function Number: 42
explosion_boom(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.15;
	}

	if(!isdefined(param_02))
	{
		param_02 = 2;
	}

	if(!isdefined(param_03))
	{
		param_03 = 850;
	}

	func_3C6A(param_00);
	var_04 = self.origin;
	playfx(level._effect[param_00],var_04);
	earthquake(param_01,param_02,var_04,param_03);
	if(distance(level.player.origin,var_04) > 300)
	{
		return;
	}

	if(level.script == "carchase" || level.script == "breakout")
	{
		return;
	}

	level.var_3C50 = 1;
	level notify("shell shock player",param_02 * 4);
	maps\_shellshock::main(param_02 * 4);
}

//Function Number: 43
func_3C6A(param_00)
{
	if(!isdefined(level.var_3C6B))
	{
		level.var_3C6B = 0;
	}

	for(var_01 = randomint(3) + 1;var_01 == level.var_3C6B;var_01 = randomint(3) + 1)
	{
	}

	level.var_3C6B = var_01;
	if(level._effecttype[param_00] == "mortar")
	{
		switch(var_01)
		{
			case 1:
				self playsound("mortar_explosion1");
				break;

			case 2:
				self playsound("mortar_explosion2");
				break;

			case 3:
				self playsound("mortar_explosion3");
				break;
		}

		return;
	}

	if(level._effecttype[param_00] == "artillery")
	{
		switch(var_01)
		{
			case 1:
				self playsound("mortar_explosion4");
				break;

			case 2:
				self playsound("mortar_explosion5");
				break;

			case 3:
				self playsound("mortar_explosion1");
				break;
		}

		return;
	}

	if(level._effecttype[param_00] == "bomb")
	{
		switch(var_01)
		{
			case 1:
				self playsound("mortar_explosion1");
				break;

			case 2:
				self playsound("mortar_explosion4");
				break;

			case 3:
				self playsound("mortar_explosion5");
				break;
		}

		return;
	}
}

//Function Number: 44
func_3C6D(param_00,param_01)
{
	if(!isdefined(level.var_3C6E))
	{
		level.var_3C6E = -1;
	}

	for(param_01 = randomint(4) + 1;param_01 == level.var_3C6E;param_01 = randomint(4) + 1)
	{
	}

	level.var_3C6E = param_01;
	if(level._effecttype[param_00] == "mortar")
	{
		switch(param_01)
		{
			case 1:
				self playsound("mortar_incoming1");
				wait 0.8200001;
				break;

			case 2:
				self playsound("mortar_incoming2");
				wait 0.42;
				break;

			case 3:
				self playsound("mortar_incoming3");
				wait 1.3;
				break;

			default:
				wait 1.75;
				break;
		}

		return;
	}

	if(level._effecttype[param_00] == "artillery")
	{
		switch(param_01)
		{
			case 1:
				self playsound("mortar_incoming4");
				wait 0.8200001;
				break;

			case 2:
				self playsound("mortar_incoming4_new");
				wait 0.42;
				break;

			case 3:
				self playsound("mortar_incoming1_new");
				wait 1.3;
				break;

			default:
				wait 1.75;
				break;
		}

		return;
	}

	if(level._effecttype[param_00] == "bomb")
	{
		switch(param_01)
		{
			case 1:
				self playsound("mortar_incoming2_new");
				wait 1.75;
				break;

			case 2:
				self playsound("mortar_incoming3_new");
				wait 1.75;
				break;

			case 3:
				self playsound("mortar_incoming4_new");
				wait 1.75;
				break;

			default:
				wait 1.75;
				break;
		}

		return;
	}
}