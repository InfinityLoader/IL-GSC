/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3616.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 19 ms
 * Timestamp: 10/27/2023 12:30:56 AM
*******************************************************************/

//Function Number: 1
func_DE0F()
{
	precachemodel("misc_exterior_oxygen_barrel_large");
	precachemodel("misc_exterior_oxygen_barrel_large_zerog");
	precachemodel("vfx_debris_oxygen_barrel_large_top");
	precachemodel("vfx_debris_oxygen_barrel_large_bottom");
	level._effect["barrel_flame_top"] = loadfx("vfx/iw7/levels/moon/scripted/scriptables/oxygen_tank/vfx_oxygen_tank_spewing_flames.vfx");
	level._effect["barrel_flame_small"] = loadfx("vfx/iw7/prop/vfx_dest_barrel_fire_sm.vfx");
	level._effect["barrel_explosion"] = loadfx("vfx/iw7/core/expl/vfx_red_barrel_oxygen_01.vfx");
	level._effect["barrel_explosion_zerog"] = loadfx("vfx/iw7/prop/vfx_misc_exterior_oxygenbarrel_large_zerog.vfx");
	level._effect["barrel_fire"] = loadfx("vfx/iw7/prop/vfx_dest_barrel_fire.vfx");
	var_00 = getentarray("phys_barrel_destructible","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_DE0C();
	}
}

//Function Number: 2
func_DE0C()
{
	self endon("barrel_death");
	self endon("barrel_delete");
	lib_0E1D::func_2840("red",120,350,9100,15000,80,28);
	thread func_DE0D();
	var_00 = 3;
	var_01 = 0;
	var_02 = 120;
	for(;;)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
		if(isdefined(var_04) && isai(var_04))
		{
			continue;
		}

		if(isdefined(var_04) && isdefined(var_04.var_9D62))
		{
			continue;
		}

		if(isdefined(var_0C) && scripts\common\utility::func_13C07(var_0C) == "sniper")
		{
			var_03 = 999999;
			var_00 = 0;
		}

		var_02 = int(var_02 - var_03);
		if(var_02 <= 0 && !isdefined(self.var_C528))
		{
			var_02 = 50;
		}

		if(var_02 <= 0)
		{
			break;
		}

		self.var_2836 = var_02;
		if(var_02 <= 50)
		{
			if(!var_01)
			{
				if(soundexists("o2_barrel_fire"))
				{
					thread scripts\common\utility::func_CD7F("o2_barrel_fire");
				}

				playfxontag(scripts\common\utility::getfx("barrel_fire"),self,"misc_exterior_oxygen_barrel_large");
				playfxontag(scripts\common\utility::getfx("barrel_flame_top"),self,"tag_valve");
				var_01 = 1;
				self.var_C528 = 1;
			}

			var_0D = var_02 / 50;
			var_00 = var_00 * var_0D;
			thread lib_0E1D::func_2835(var_00);
		}

		if(isdefined(var_05))
		{
			var_0E = length(var_05);
			if(var_0E > 20)
			{
				var_0F = vectornormalize(var_05);
				var_10 = 20;
				if(isdefined(var_07) && var_07 == "MOD_IMPACT")
				{
					var_10 = 3;
				}

				var_05 = var_0F * var_10;
			}

			self physicslaunchserver(var_06,var_05 * 1000);
		}

		if(!isdefined(var_07))
		{
			continue;
		}

		var_11 = strtok(var_07,"_");
		if(!scripts\common\utility::func_2286(var_11,"BULLET"))
		{
			continue;
		}

		var_12 = scripts\common\utility::spawn_tag_origin(var_06);
		var_13 = vectornormalize(self.origin - var_06);
		var_14 = vectortoangles(var_13 * -1);
		var_12.angles = scripts\common\utility::func_6EE1(var_14);
		var_12 linkto(self);
		if(soundexists("o2_barrel_hiss_loop"))
		{
			var_12 thread scripts\common\utility::func_CD7F("o2_barrel_hiss_loop");
		}

		playfxontag(scripts\common\utility::getfx("barrel_flame_small"),var_12,"tag_origin");
		self.var_109DB = scripts\common\utility::array_add(self.var_109DB,var_12);
	}

	while(isdefined(self.var_5945))
	{
		scripts\common\utility::func_136F7();
	}

	self notify("barrel_death");
}

//Function Number: 3
func_DE0D()
{
	self endon("barrel_delete");
	self waittill("barrel_death");
	physicsexplosionsphere(self.origin,self.var_CAF6,0,2);
	thread scripts\sp\_detonategrenades::func_DBDB(self.origin + (0,0,25),0.2);
	earthquake(0.5,0.8,self.origin,700);
	thread scripts\sp\_utility::func_54EF(self.origin);
	thread lib_0E1D::func_2831(350,self.origin);
	var_00 = 0.3;
	var_01 = sortbydistance(level.var_CAF7,self.origin);
	foreach(var_03 in var_01)
	{
		if(var_03 == self)
		{
			continue;
		}

		var_04 = distance(self.origin,var_03.origin);
		if(var_04 > self.var_CAF6)
		{
			continue;
		}

		var_05 = self.var_CAF6 - var_04;
		var_06 = var_05 / self.var_CAF6;
		var_07 = var_00 * var_06;
		if(var_04 <= self.var_CAF6)
		{
			var_03 thread lib_0E1D::func_2837(self.origin,var_04,var_07);
		}

		if(var_04 <= 340)
		{
			var_03 thread func_DE0E(self.origin,var_04,var_07);
		}
	}

	var_09 = scripts\sp\_utility::func_81FF();
	foreach(var_0B in var_09)
	{
		var_0C = 400;
		var_0D = 370;
		if(isdefined(var_0B.var_EEDE) && var_0B.var_EEDE == "allies")
		{
			continue;
		}

		var_0E = distance(self.origin,var_0B.origin);
		var_0E = 0;
		if(var_0E <= 25000)
		{
			var_06 = var_0E / 250 * 100;
			var_0C = var_0C - var_06 * var_0D;
			if(getdvarint("barrel_debug"))
			{
				iprintln("BARREL DID " + var_0C + " TO VEH");
			}

			var_0B dodamage(var_0C,self.origin,self,self,"MOD_EXPLOSIVE");
		}
	}

	var_10 = function_0072("axis");
	foreach(var_12 in var_10)
	{
		var_0C = 400;
		var_0D = 370;
		if(!isdefined(var_12.var_111A4))
		{
			continue;
		}

		if(var_12.var_111A4 == "C6")
		{
			var_0C = var_0C + 20;
		}

		var_13 = distance(self.origin,var_12.origin);
		if(var_13 <= 250)
		{
			var_06 = var_13 / 250;
			var_0C = var_0C - var_06 * var_0D;
			if(getdvarint("barrel_debug"))
			{
				iprintln("BARREL DID " + var_0C + " TO AI");
			}

			var_12 dodamage(var_0C,self.origin,self,self,"MOD_EXPLOSIVE");
		}
	}

	var_15 = distance(self.origin,level.player.origin);
	if(var_15 <= 350)
	{
		var_06 = var_15 / 350;
		var_0D = 420;
		var_0C = 420 - var_06 * var_0D;
		if(getdvarint("barrel_debug"))
		{
			iprintln("BARREL DID " + var_0C + " TO PLAYER");
		}

		if(!level.player scripts\sp\_utility::func_65DB("player_retract_shield_active"))
		{
			level.player dodamage(var_0C,self.origin,self,self,"MOD_EXPLOSIVE");
		}
	}

	radiusdamage(self.origin,2,1,0,self);
	scripts\common\utility::func_136F7();
	if(soundexists("o2_barrel_explode"))
	{
		thread scripts\common\utility::play_sound_in_space("o2_barrel_explode",self.origin);
	}

	if(level.player scripts\sp\_utility::func_65DF("zero_gravity") && level.player scripts\sp\_utility::func_65DB("zero_gravity"))
	{
		playfx(scripts\common\utility::getfx("barrel_explosion_zerog"),self.origin);
	}
	else
	{
		playfx(scripts\common\utility::getfx("barrel_explosion"),self.origin);
	}

	foreach(var_17 in self.var_109DB)
	{
		killfxontag(scripts\common\utility::getfx("barrel_flame_small"),var_17,"tag_origin");
		scripts\common\utility::func_136F7();
		if(isdefined(var_17))
		{
			var_17 delete();
		}
	}

	killfxontag(scripts\common\utility::getfx("barrel_fire"),self,"misc_exterior_oxygen_barrel_large");
	killfxontag(scripts\common\utility::getfx("barrel_flame_top"),self,"tag_valve");
	scripts\common\utility::func_136F7();
	if(isdefined(self))
	{
		self hide();
		thread func_50B2(5);
	}
}

//Function Number: 4
func_50B2(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 5
func_DE0E(param_00,param_01,param_02)
{
	self endon("barrel_death");
	self endon("barrel_delete");
	wait(param_02);
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_C528))
	{
		return;
	}

	var_03 = 95;
	var_04 = 340;
	if(param_01 <= 90)
	{
		var_05 = 20;
		var_06 = 90 - param_01 / var_04;
		var_07 = 70 + var_06 * var_05;
	}
	else
	{
		var_06 = var_07 - var_03 / var_07;
		var_07 = var_07 * var_04;
	}

	self notify("damage",var_07);
}