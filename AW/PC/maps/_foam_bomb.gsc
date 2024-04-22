/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _foam_bomb.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 226 ms
 * Timestamp: 4/22/2024 2:21:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	precacheitem("foam_bomb");
	precachemodel("weapon_c4");
	precachemodel("weapon_c4_obj");
	level.player thread place_foam_bomb();
	level.player.grenadetimers["foam_bomb"] = 5;
	thread handle_foam_behavior();
	level.c4_weaponname = "foam_bomb";
	level.spawnedfoamglobs = undefined;
}

//Function Number: 2
playc4effects()
{
	self endon("death");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("c4_light_blink"),self,"tag_fx");
}

//Function Number: 3
place_foam_bomb()
{
	self endon("death");
	var_00 = getentarray("foam_bomb_location","targetname");
	foreach(var_02 in var_00)
	{
		var_02 monitor_place_foam_bomb();
	}
}

//Function Number: 4
monitor_place_foam_bomb()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("weapon_c4_obj");
	var_00.angles = self.angles;
	var_00 makeusable();
	var_00 sethintstring("Press ^3 &&1 ^7to Plant Foam");
	var_00 waittill("trigger");
	level.player giveweapon("foam_bomb");
	level.player setactionslot(2,"weapon","foam_bomb");
	var_00 setmodel("weapon_c4");
	var_00 playc4effects();
	level.player thread handle_detonator();
	level.player waittill("detonate");
	var_00 detonate_foam_grenade();
}

//Function Number: 5
handle_detonator()
{
	var_00 = undefined;
	if(!isdefined(self.old_weapon))
	{
		self.old_weapon = self getcurrentweapon();
	}

	var_01 = self getweaponslistall();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] != level.c4_weaponname)
		{
			continue;
		}

		var_00 = var_01[var_02];
	}

	if(!isdefined(var_00))
	{
		self giveweapon(level.c4_weaponname);
		self setweaponammoclip(level.c4_weaponname,0);
		self setactionslot(2,"weapon",level.c4_weaponname);
	}

	setsaveddvar("actionSlotsHide",1);
	self disableweaponswitch();
	self disableoffhandweapons();
	self disableweaponpickup();
	self allowmelee(0);
	self switchtoweapon(level.c4_weaponname);
	self waittill("detonate");
	wait(0.15);
	self enableweaponswitch();
	self enableoffhandweapons();
	self enableweaponpickup();
	self allowmelee(1);
	self switchtoweapon(self.old_weapon);
	self takeweapon(level.c4_weaponname);
	self waittill("weapon_change");
	wait(1);
	setsaveddvar("actionSlotsHide",0);
}

//Function Number: 6
handle_foam_behavior()
{
	level endon("missionfailed");
}

//Function Number: 7
delete_auto()
{
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 8
detonate_foam_grenade(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.edge = common_scripts\utility::spawn_tag_origin();
	var_01.origin = var_01.origin + (0,0,5);
	var_02 = create_foam_matrix(param_00);
	if(isdefined(level.spawnedfoamglobs))
	{
		common_scripts\utility::array_thread(level.spawnedfoamglobs,::delete_auto);
	}

	level.spawnedfoamglobs = [];
	var_02 = sortbydistance(var_02,var_01.origin);
	level notify("foam_bomb_begin");
	var_01 soundscripts\_snd::snd_message("aud_detonate_foam_grenade");
	var_03 = 1;
	var_04 = 1;
	var_05 = undefined;
	level notify("foam_bomb_complete");
}

//Function Number: 9
expand_foam(param_00,param_01,param_02)
{
	var_03 = randomintrange(50,55);
	var_04 = distance(param_00,self.origin);
	var_05 = var_04 / var_03;
	var_06 = undefined;
	if(var_05 <= 0)
	{
		var_05 = 0.1;
	}

	self.neighbors = 0;
	foreach(var_08 in level.foambombfoams)
	{
		if(distance(self.origin,var_08) < 32)
		{
			self.neighbors++;
		}
	}

	var_06 = spawn("script_model",param_00 + (0,0,-18));
	var_06 moveto(self.origin,var_05,var_05 / 10,var_05 / 2);
	level.spawnedfoamglobs[level.spawnedfoamglobs.size] = var_06;
	wait(var_05);
	level notify("new_foam_glob",self.layer,self.ring,self);
	while(isdefined(self.layer))
	{
		level waittill("new_foam_glob",var_0A,var_0B);
		if((isdefined(var_06) && self.layer < var_0A - 1 && self.ring < var_0B - 1 && self.neighbors > 16) || isgroundfoam(self,var_0B))
		{
			var_06 delete();
			break;
		}

		wait 0.05;
	}
}

//Function Number: 10
isgroundfoam(param_00,param_01)
{
	if(isdefined(param_00) && param_00.layer == 1 && param_00.ring < param_01 - 1 && param_00.neighbors > 8)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
debug_foam_tag()
{
	self endon("death");
	wait 0.05;
}

//Function Number: 12
create_foam_matrix(param_00)
{
	var_01 = 960;
	if(param_00 != 1 && param_00 < 1)
	{
		var_01 = 960 * param_00;
	}
	else if(param_00 > 1)
	{
		var_01 = 960 * param_00 * 0.01;
	}

	var_02 = [];
	var_03 = spawnstruct();
	var_03.origin = self.origin;
	var_02[var_02.size] = var_03;
	var_04 = common_scripts\utility::spawn_tag_origin();
	level.foambombfoams = [var_03.origin];
	var_05 = 16;
	var_06 = 20;
	var_04.angles = (0,randomfloatrange(-180,180),0);
	for(var_07 = 0;var_07 < 16;var_07++)
	{
		var_08 = 0;
		var_09 = 0;
		var_0A = 1;
		var_0B = 0;
		var_0C = var_01 / 8 - var_01 * 0.01 * var_07;
		while(var_08 < var_0C)
		{
			var_0D = var_06 * var_0A * 2 * 3.141593;
			var_0E = 25.2;
			var_0F = 360 * var_0E / var_0D;
			for(var_10 = 0;var_10 < 360;var_10 = var_10 + var_0F)
			{
				var_04.angles = var_04.angles + (0,var_10,0);
				var_11 = var_04.origin + anglestoforward(var_04.angles) * var_06 * var_0A;
				var_12 = bullettrace(var_04.origin,var_11,0,undefined,0);
				if(var_12["fraction"] >= 1 && isvalidfoamspace(var_11))
				{
					var_03 = spawnstruct();
					var_03.origin = var_12["position"];
					if(var_0A > 1)
					{
						var_03.origin = var_03.origin + (randomfloatrange(-6,6),randomfloatrange(-6,6),randomfloatrange(-6,6));
					}

					level.foambombfoams[level.foambombfoams.size] = var_03.origin;
					var_08++;
					if(var_08 < var_0C * 0.4)
					{
						var_03.delete_ok = 1;
					}

					var_03.ring = var_0A;
					var_03.layer = var_07;
					var_02[var_02.size] = var_03;
					if(var_02.size > var_01)
					{
						return var_02;
					}

					level notify("new_foam_layer",var_07);
				}

				if(var_09 > 300)
				{
					wait 0.05;
					var_09 = 0;
					continue;
				}

				var_09++;
			}

			var_0A++;
		}

		if(bullettracepassed(var_04.origin,var_04.origin + (0,0,var_05),0,undefined,0))
		{
			var_04.origin = var_04.origin + (0,0,var_05);
		}
	}

	return var_02;
}

//Function Number: 13
isvalidfoamspace(param_00)
{
	return 1;
}