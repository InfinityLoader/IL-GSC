/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_na45.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 186 ms
 * Timestamp: 4/22/2024 2:16:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["primer_light"] = loadfx("vfx/lights/light_beacon_m990_spike");
	level._effect["na45_explosion"] = loadfx("vfx/explosion/frag_grenade_default");
	level._effect["na45_explosion_body"] = loadfx("vfx/explosion/frag_grenade_default_nodecal");
	thread monitor_na45_use();
}

//Function Number: 2
is_na45(param_00)
{
	if(issubstr(param_00,"m990") || issubstr(param_00,"dlcgun10loot0"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
monitor_na45_use()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	childthread reset_shot_on_reload();
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(is_na45(var_00))
		{
			self.bullethitcallback = ::m990_hit;
		}
		else
		{
			self.bullethitcallback = undefined;
		}

		self waittill("weapon_change");
	}
}

//Function Number: 4
transfer_primer_to_corpse(param_00,param_01)
{
	self endon("primer_deleted");
	param_00 waittill("death");
	var_02 = param_00 getcorpseentity();
	if(isdefined(var_02))
	{
		if(isdefined(param_01))
		{
			self.primer linkto(var_02,param_01);
		}
		else
		{
			self.primer linkto(var_02);
		}

		self.primer thread show_primer_fx(self);
	}
}

//Function Number: 5
m990_hit(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!is_na45(param_00))
	{
		return;
	}

	if(self getcurrentweapon() != param_00)
	{
		return;
	}

	var_06 = get_current_shot();
	if(var_06 == "primer")
	{
		if(isdefined(self.primer))
		{
			delete_primer();
		}

		self.primer = common_scripts\utility::spawn_tag_origin();
		if(isdefined(param_03) && isplayer(param_03) || isagent(param_03))
		{
			self.primer.origin = param_01 + param_04;
			self.primer.angles = vectortoangles(param_04 * -1);
		}
		else
		{
			self.primer.origin = param_01;
			self.primer.angles = vectortoangles(param_02);
		}

		self.primer show();
		self.primer thread show_primer_fx(self);
		if(isdefined(param_03))
		{
			var_07 = param_03;
			if(isplayer(param_03) || isagent(param_03))
			{
				if(isalive(param_03))
				{
					thread transfer_primer_to_corpse(param_03,param_05);
				}
				else
				{
					var_08 = param_03 getcorpseentity();
					if(isdefined(var_08))
					{
						var_07 = var_08;
					}
				}

				self.primer.onbody = 1;
			}

			if(isdefined(param_05))
			{
				self.primer linkto(var_07,param_05);
			}
			else
			{
				self.primer linkto(var_07);
			}
		}

		thread cleanup_primer();
		return;
	}

	if(isdefined(self.primer))
	{
		if(distance(param_01,self.primer.origin) <= 64)
		{
			if(isdefined(self.primer.onbody))
			{
				playfx(common_scripts\utility::getfx("na45_explosion_body"),self.primer.origin,anglestoforward(self.primer.angles));
			}
			else
			{
				playfx(common_scripts\utility::getfx("na45_explosion"),self.primer.origin,anglestoforward(self.primer.angles));
			}

			playsoundatpos(self.origin,"wpn_na45_exp");
			param_00 = self getcurrentweapon();
			var_09 = 256;
			var_0A = 130;
			var_0B = 15;
			if(issubstr(param_00,"m990loot2"))
			{
				var_0B = 30;
			}

			if(issubstr(param_00,"m990loot5"))
			{
				var_0A = 100;
				var_09 = 196;
			}

			if(issubstr(param_00,"m990loot8"))
			{
				var_0A = 100;
			}

			if(issubstr(param_00,"m990loot9") || issubstr(param_00,"dlcgun10loot0"))
			{
				var_0B = 30;
				var_0A = 150;
				var_09 = 300;
			}

			physicsexplosionsphere(self.primer.origin,256,32,1);
			radiusdamage(self.primer.origin,var_09,var_0A,var_0B,self,"MOD_EXPLOSIVE",param_00);
		}

		delete_primer();
	}
}

//Function Number: 6
reset_shot_on_reload()
{
	for(;;)
	{
		self waittill("reload_start");
		var_00 = self getcurrentweapon();
		if(!is_na45(var_00))
		{
			self waittill("weapon_change");
			continue;
		}

		cleanup_primer_reload();
	}
}

//Function Number: 7
cleanup_primer()
{
	self endon("primer_deleted");
	common_scripts\utility::waittill_any("death","disconnect","faux_spawn");
	if(isdefined(self) && isdefined(self.primer))
	{
		thread delete_primer();
	}
}

//Function Number: 8
cleanup_primer_reload()
{
	self endon("primer_deleted");
	if(isdefined(self) && isdefined(self.primer))
	{
		thread delete_primer();
	}
}

//Function Number: 9
get_current_shot()
{
	var_00 = self getcurrentweaponclipammo();
	if(var_00 % 2 == 1)
	{
		return "primer";
	}

	return "catalyst";
}

//Function Number: 10
show_primer_fx(param_00)
{
	self endon("death");
	wait(0.1);
	playfxontagforclients(common_scripts\utility::getfx("primer_light"),self,"TAG_ORIGIN",param_00);
}

//Function Number: 11
delete_primer()
{
	self notify("primer_deleted");
	stopfxontag(common_scripts\utility::getfx("primer_light"),self.primer,"TAG_ORIGIN");
	self.primer delete();
	self.primer = undefined;
}

//Function Number: 12
draw_distance_line(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,0,0);
	}

	while(param_02 > 0)
	{
		param_02 = param_02 - 0.05;
		wait(0.05);
	}
}