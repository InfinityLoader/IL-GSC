/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_bumpercars.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 292 ms
 * Timestamp: 10/27/2023 12:07:56 AM
*******************************************************************/

//Function Number: 1
init_bumper_cars()
{
	var_00 = getentarray("bumper_car","targetname");
	if(!var_00.size)
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(var_02.origin == (4113.9,184.9,112))
		{
			var_02.var_6B89 = 1;
		}
		else
		{
			var_02.var_6B89 = 0;
		}

		var_02.var_5764 = getent(var_02.target,"targetname");
		var_02.var_5764 enablelinkto();
		var_02.var_5764 linkto(var_02);
		var_02.var_7541 = scripts\common\utility::getstruct(var_02.target,"targetname");
		var_02.var_DDAA = scripts\common\utility::getstruct(var_02.var_7541.target,"targetname");
		var_02.var_380B = 0;
		var_02.var_7541.origin = (var_02.var_7541.origin[0],var_02.var_7541.origin[1],var_02.origin[2]);
		var_02.var_DDAA.origin = (var_02.var_DDAA.origin[0],var_02.var_DDAA.origin[1],var_02.origin[2]);
		scripts\common\utility::func_136F7();
	}

	level waittill("moon_bumpercars power_on");
	var_04 = getent("bumpercar_clip","targetname");
	var_04 connectpaths();
	var_04 notsolid();
	foreach(var_06, var_02 in var_00)
	{
		var_02.name = "car_" + var_06;
		var_02 thread func_A631();
		scripts\common\utility::func_136F7();
	}

	level.var_3261 = scripts\common\utility::getstructarray("bumpercar_impact","targetname");
	for(;;)
	{
		var_00 = scripts\common\utility::array_randomize(var_00);
		foreach(var_06, var_02 in var_00)
		{
			var_02 func_1594(var_06);
		}
	}
}

//Function Number: 2
func_1594(param_00)
{
	var_01 = scripts\common\trace::func_48B1();
	var_02 = [self];
	if(!isdefined(self.var_10E19))
	{
		self.var_10E19 = "rear";
		self.var_380B = 0;
	}

	var_03 = 1.75;
	if(self.var_6B89)
	{
		var_03 = 1.2;
	}

	wait(randomfloatrange(1,3));
	if(self.var_10E19 == "fwd")
	{
		for(;;)
		{
			var_04 = function_0288(self.origin + (0,0,60),self.var_7541.origin + (0,0,60),32,var_01,var_02,"physicsquery_all");
			if(var_04.size == 0)
			{
				break;
			}

			var_05 = 0;
			for(var_06 = 0;var_06 < var_04.size;var_06++)
			{
				if(!isdefined(var_04[var_06]["entity"]))
				{
					continue;
				}

				if(isplayer(var_04[var_06]["entity"]) && scripts\cp\_laststand::player_in_laststand(var_04[var_06]["entity"]) || scripts\common\utility::istrue(var_04[var_06]["entity"].var_9F28))
				{
					var_05 = 1;
				}
			}

			if(var_05)
			{
				return;
			}
			else
			{
				break;
			}

			wait(0.1);
		}

		if(self.var_6B89)
		{
			self playsoundonmovingent("trap_bumper_car_mvmt_short");
		}
		else
		{
			self playsoundonmovingent("trap_bumper_car_mvmt_long");
		}

		self setscriptablepartstate("bumpercar","moving");
		wait(0.3);
		self playsound("trap_bumper_car_lights");
		self setscriptablepartstate("lights","lights_on");
		wait(0.35);
		self setscriptablepartstate("lights","lights_off");
		wait(0.35);
		self playsound("trap_bumper_car_lights");
		self setscriptablepartstate("lights","lights_on");
		wait(0.35);
		self setscriptablepartstate("lights","lights_off");
		wait(0.4);
		self setscriptablepartstate("lights","lights_on");
		self playsound("trap_bumper_car_lights");
		wait(0.4);
		self setscriptablepartstate("lights","lights_off");
		wait(0.5);
		self setscriptablepartstate("lights","lights_on");
		self.var_380B = 1;
		self moveto(self.var_7541.origin,var_03);
		self.var_10E19 = "rear";
	}
	else
	{
		for(;;)
		{
			var_04 = function_0288(self.origin + (0,0,60),self.var_DDAA.origin + (0,0,60),32,var_01,var_02,"physicsquery_all");
			if(var_04.size == 0)
			{
				break;
			}

			var_05 = 0;
			for(var_06 = 0;var_06 < var_04.size;var_06++)
			{
				if(!isdefined(var_04[var_06]["entity"]))
				{
					continue;
				}

				if(isplayer(var_04[var_06]["entity"]) && scripts\cp\_laststand::player_in_laststand(var_04[var_06]["entity"]) || scripts\common\utility::istrue(var_04[var_06]["entity"].var_9F28))
				{
					var_05 = 1;
				}
			}

			if(var_05)
			{
				return;
			}
			else
			{
				break;
			}

			wait(0.1);
		}

		if(self.var_6B89)
		{
			self playsoundonmovingent("trap_bumper_car_mvmt_short");
		}
		else
		{
			self playsoundonmovingent("trap_bumper_car_mvmt_long");
		}

		self setscriptablepartstate("bumpercar","moving");
		wait(0.05);
		self playsound("trap_bumper_car_lights");
		self setscriptablepartstate("lights","lights_on");
		wait(0.35);
		self setscriptablepartstate("lights","lights_off");
		wait(0.35);
		self playsound("trap_bumper_car_lights");
		self setscriptablepartstate("lights","lights_on");
		wait(0.35);
		self setscriptablepartstate("lights","lights_off");
		wait(0.4);
		self playsound("trap_bumper_car_lights");
		self setscriptablepartstate("lights","lights_on");
		wait(0.4);
		self setscriptablepartstate("lights","lights_off");
		wait(0.5);
		self setscriptablepartstate("lights","lights_on");
		self.var_380B = 1;
		self moveto(self.var_DDAA.origin,var_03);
		self.var_10E19 = "fwd";
	}

	if(isdefined(self.var_BE63))
	{
		destroynavobstacle(self.var_BE63);
	}

	self waittill("movedone");
	wait(0.1);
	self.var_380B = 0;
	self.var_BE63 = function_027A(self.origin,(56,32,32),self.angles);
	var_07 = scripts\common\utility::getclosest(self.origin,level.var_3261,128);
	if(isdefined(var_07))
	{
		playfx(level._effect["bumpercar_impact"],var_07.origin,anglestoforward((0,270,0)),anglestoup((0,270,0)));
	}

	self setscriptablepartstate("bumpercar","impact");
	wait(0.15);
	self setscriptablepartstate("bumpercar","normal");
	self setscriptablepartstate("lights","lights_off");
}

//Function Number: 3
func_A631()
{
	for(;;)
	{
		self.var_5764 waittill("trigger",var_00);
		var_01 = getentarray("placed_transponder","script_noteworthy");
		foreach(var_03 in var_01)
		{
			if(var_00 == var_03)
			{
				if(isdefined(var_03.var_222) && var_03.var_222 scripts\cp\_utility::is_valid_player(1))
				{
					var_03.var_222 scripts\cp\_weapon::func_CC16(var_00.var_13C2E,1,var_00.origin);
				}

				var_03 notify("detonateExplosive");
			}
		}

		if(!self.var_380B || isdefined(var_00.flung))
		{
			continue;
		}

		if(!isplayer(var_00) && !scripts\cp\_utility::func_FF18(var_00))
		{
			continue;
		}

		if((isplayer(var_00) && !scripts\cp\_laststand::player_in_laststand(var_00)) || var_00.team == "allies")
		{
			var_00 thread func_DB09(self);
			continue;
		}

		var_00 thread func_6F32(self);
	}
}

//Function Number: 4
func_6F32(param_00)
{
	self endon("death");
	var_01 = 250;
	self playsound("bumpercars_fling_zombie");
	self.flung = 1;
	self.var_4C87 = 1;
	playfx(level._effect["blackhole_trap_death"],self.origin,anglestoforward((-90,0,0)),anglestoup((-90,0,0)));
	wait(0.05);
	wait(0.1);
	self playsound("trap_bumper_car_zombie_hit");
	self.disable_armor = 1;
	self.nocorpse = 1;
	var_02 = scripts\common\utility::func_782F(self.origin,level.players,undefined,4,var_01);
	foreach(var_04 in var_02)
	{
		var_04 thread scripts\cp\_vo::try_to_play_vo("trap_kill_rover","zmb_comment_vo","medium",5,0,0,1,25);
	}

	self dodamage(self.health + 1000,param_00.origin);
}

//Function Number: 5
func_DB09(param_00)
{
	self endon("death");
	self playsound("bumpercars_push_damage_plr");
	self.flung = 1;
	var_01 = sortbydistance(scripts\common\utility::getstructarray("bumper_car_throw_spots","targetname"),self.origin);
	self setorigin(var_01[0].origin,0);
	self setvelocity(vectornormalize(self.origin - param_00.origin) * 300 + (0,0,100));
	wait(0.1);
	if(isplayer(self) && !scripts\common\utility::istrue(self.isrewinding))
	{
		self dodamage(self.health + 100,param_00.origin);
	}

	wait(0.1);
	self.flung = undefined;
}