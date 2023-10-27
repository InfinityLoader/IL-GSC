/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_vehicle_missile.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 134 ms
 * Timestamp: 10/27/2023 2:02:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("cobrapilot_surface_to_air_missiles_enabled") == "")
	{
		setdvar("cobrapilot_surface_to_air_missiles_enabled","1");
	}

	tryreload();
	thread firemissile();
	thread turret_think();
	thread detachall_on_death();
}

//Function Number: 2
detachall_on_death()
{
	self waittill("death");
	self detachall();
}

//Function Number: 3
turret_think()
{
	self endon("death");
	if(!isdefined(self.script_turret))
	{
		return;
	}

	if(self.script_turret == 0)
	{
		return;
	}

	self.attackradius = 30000;
	if(isdefined(self.radius))
	{
		self.attackradius = self.radius;
	}

	while(!isdefined(level.cobrapilot_difficulty))
	{
		wait(0.05);
	}

	var_00 = 1;
	if(level.cobrapilot_difficulty == "easy")
	{
		var_00 = 0.5;
	}
	else if(level.cobrapilot_difficulty == "medium")
	{
		var_00 = 1.7;
	}
	else if(level.cobrapilot_difficulty == "hard")
	{
		var_00 = 1;
	}
	else if(level.cobrapilot_difficulty == "insane")
	{
		var_00 = 1.5;
	}

	self.attackradius = self.attackradius * var_00;
	if(getdvar("cobrapilot_debug") == "1")
	{
		iprintln("surface-to-air missile range difficultyScaler = " + var_00);
	}

	for(;;)
	{
		wait(2 + randomfloat(1));
		var_01 = undefined;
		var_01 = maps\_helicopter_globals::getenemytarget(self.attackradius,undefined,0,1);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = var_01.origin;
		if(isdefined(var_01.script_targetoffset_z))
		{
			var_02 = var_02 + (0,0,var_01.script_targetoffset_z);
		}

		self setturrettargetvec(var_02);
		level thread turret_rotate_timeout(self,5);
		self waittill("turret_rotate_stopped");
		self clearturrettarget();
		if(distance(self.origin,var_01.origin) > self.attackradius)
		{
			continue;
		}

		var_03 = 0;
		var_03 = sighttracepassed(self.origin,var_01.origin + (0,0,150),0,self);
		if(!var_03)
		{
			continue;
		}

		if(getdvar("cobrapilot_surface_to_air_missiles_enabled") == "1")
		{
			self notify("shoot_target",var_01);
			self waittill("missile_fired",var_04);
			if(isdefined(var_04))
			{
				if(level.cobrapilot_difficulty == "hard")
				{
					wait(1 + randomfloat(2));
					continue;
				}
				else if(level.cobrapilot_difficulty == "insane")
				{
					continue;
				}
				else
				{
					var_04 waittill("death");
				}
			}

			continue;
		}
	}
}

//Function Number: 4
turret_rotate_timeout(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("turret_rotate_stopped");
	wait(param_01);
	param_00 notify("turret_rotate_stopped");
}

//Function Number: 5
within_attack_range(param_00)
{
	var_01 = distance((self.origin[0],self.origin[1],0),(param_00.origin[0],param_00.origin[1],0));
	var_02 = param_00.origin[2] - self.origin[2];
	if(var_02 <= 750)
	{
		return 0;
	}

	var_03 = var_02 * 2.5;
	if(var_01 <= self.attackradius + var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
firemissile()
{
	self endon("death");
	for(;;)
	{
		self waittill("shoot_target",var_00);
		var_01 = undefined;
		if(!isdefined(var_00.script_targetoffset_z))
		{
			var_00.script_targetoffset_z = 0;
		}

		var_02 = (0,0,var_00.script_targetoffset_z);
		var_01 = self fireweapon(self.missiletags[self.missilelaunchnexttag],var_00,var_02);
		if(getdvar("cobrapilot_debug") == "1")
		{
			level thread draw_missile_target_line(var_01,var_00,var_02);
		}

		if(!isdefined(var_00.incomming_missiles))
		{
			var_00.incomming_missiles = [];
		}

		var_00.incomming_missiles = common_scripts\utility::array_add(var_00.incomming_missiles,var_01);
		thread maps\_helicopter_globals::missile_deathwait(var_01,var_00);
		self detach(self.missilemodel,self.missiletags[self.missilelaunchnexttag]);
		self.missilelaunchnexttag++;
		self.missileammo--;
		var_00 notify("incomming_missile",var_01);
		tryreload();
		wait(0.05);
		self notify("missile_fired",var_01);
	}
}

//Function Number: 7
draw_missile_target_line(param_00,param_01,param_02)
{
	param_00 endon("death");
	wait(0.05);
}

//Function Number: 8
tryreload()
{
	if(!isdefined(self.missileammo))
	{
		self.missileammo = 0;
	}

	if(!isdefined(self.missilelaunchnexttag))
	{
		self.missilelaunchnexttag = 0;
	}

	if(self.missileammo > 0)
	{
		return;
	}

	for(var_00 = 0;var_00 < self.missiletags.size;var_00++)
	{
		self attach(self.missilemodel,self.missiletags[var_00]);
	}

	self.missileammo = self.missiletags.size;
	self.missilelaunchnexttag = 0;
}