/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_player_high_jump.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 132 ms
 * Timestamp: 10/27/2023 2:00:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["boost_dust"] = loadfx("vfx/smoke/jetpack_exhaust");
	level._effect["boost_dust_impact_ground"] = loadfx("vfx/smoke/jetpack_ground_impact_runner");
	precacherumble("damage_light");
	precacherumble("damage_heavy");
}

//Function Number: 2
enable_high_jump()
{
	if(!isdefined(self.high_jump_enabled) || self.high_jump_enabled == 0)
	{
		self allowhighjump(1);
		thread apply_jump_fx();
		self.high_jump_enabled = 1;
		soundscripts\_snd::snd_message("boost_jump_enable");
		self.bg_falldamageminheight_old = getdvarint("bg_fallDamageMinHeight",200);
		self.bg_falldamagemaxheight_old = getdvarint("bg_fallDamageMaxHeight",350);
		setsaveddvar("bg_fallDamageMinHeight",getdvarint("bg_highJumpFallDamageMinHeight",490));
		setsaveddvar("bg_fallDamageMaxHeight",getdvarint("bg_highJumpFallDamageMaxHeight",640));
	}
}

//Function Number: 3
disable_high_jump()
{
	if(isdefined(self.high_jump_enabled) && self.high_jump_enabled)
	{
		self allowhighjump(0);
		self notify("disable_high_jump");
		self.high_jump_enabled = 0;
		soundscripts\_snd::snd_message("boost_jump_disable");
		setsaveddvar("bg_fallDamageMinHeight",self.bg_falldamageminheight_old);
		setsaveddvar("bg_fallDamageMaxHeight",self.bg_falldamagemaxheight_old);
	}
}

//Function Number: 4
enable_boost_jump()
{
	enable_high_jump();
	self allowboostjump(1);
	self.boost_jump_enabled = 1;
}

//Function Number: 5
disable_boost_jump()
{
	disable_high_jump();
	self allowboostjump(0);
	self.boost_jump_enabled = 0;
}

//Function Number: 6
apply_jump_fx()
{
	self endon("death");
	self endon("disable_high_jump");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = self ishighjumping();
	var_04 = 0.2;
	var_05 = 0;
	var_06 = 1;
	var_07 = 0;
	for(;;)
	{
		var_08 = self ishighjumping();
		if(isdefined(self.grapple) && self.grapple["connected"])
		{
			var_08 = 0;
		}

		if(var_08)
		{
			if(var_08 != var_03)
			{
				if(level.nextgen)
				{
					thread mb_on();
				}

				var_02 = 1;
				var_05 = 0;
				var_06 = 1;
				if(!isdefined(self.high_jump_enabled) || !self.high_jump_enabled)
				{
				}
			}

			if(isdefined(self.high_jump_enabled) && self.high_jump_enabled)
			{
				var_06 = var_06 && self jumpbuttonpressed();
				if(var_06 && !var_07)
				{
					playfx(common_scripts\utility::getfx("boost_dust"),self.origin,anglestoforward(self.angles + (-90,0,0)),anglestoup(self.angles));
					soundscripts\_snd::snd_message("boost_jump_player");
					maps\_sp_matchdata::register_boost_jump();
					earthquake(0.15,0.3,self.origin,300);
					level.player playrumbleonentity("damage_light");
					thread newhandlespawngroundimpact();
					var_07 = 1;
					var_05 = var_05 + 0.05;
				}
			}
		}

		if(!self isonground())
		{
			if(var_00 == 0)
			{
				var_01 = self.origin[2];
			}

			var_00++;
		}
		else
		{
			if(var_00 > 5 && isdefined(self.high_jump_enabled) || self.high_jump_enabled)
			{
				var_09 = var_01 - self.origin[2];
				if(var_07 == 1)
				{
					soundscripts\_snd::snd_message("boost_land_player",var_00);
					var_0A = var_09 / 500;
					var_0A = clamp(var_0A,0.2,0.4);
					earthquake(var_0A,0.6,self.origin,300);
					if(var_0A > 0.2)
					{
						level.player playrumbleonentity("damage_heavy");
					}
					else
					{
						level.player playrumbleonentity("damage_light");
					}

					self notify("player_boost_land");
					var_07 = 0;
				}
				else if(var_09 > 200)
				{
					soundscripts\_snd::snd_message("boost_land_player",var_00);
					var_0A = var_09 / 500;
					var_0A = clamp(var_0A,0.2,0.4);
					earthquake(var_0A,0.6,self.origin,300);
					level.player playrumbleonentity("damage_heavy");
				}
			}

			var_00 = 0;
		}

		var_03 = var_08;
		var_02 = 0;
		wait 0.05;
	}
}

//Function Number: 7
mb_on()
{
	if(level.nextgen)
	{
		var_00 = getdvar("r_mbenable");
		var_01 = getdvar("r_mbVelocityScalar");
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
		wait(0.5);
		setsaveddvar("r_mbenable",var_00);
		setsaveddvar("r_mbVelocityScalar",var_01);
	}
}

//Function Number: 8
mb_off()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 9
newhandlespawngroundimpact()
{
	var_00 = self.origin + (0,0,64);
	var_01 = self.origin - (0,0,150);
	var_02 = bullettrace(var_00,var_01,0,undefined);
	var_03 = common_scripts\utility::getfx("boost_dust_impact_ground");
	var_00 = var_02["position"];
	var_04 = vectortoangles(var_02["normal"]);
	var_04 = var_04 + (90,0,0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoup(var_04);
	playfx(var_03,var_00,var_06,var_05);
}