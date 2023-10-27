/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\kung_fu_mode_dragon.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 1596 ms
 * Timestamp: 10/27/2023 12:04:29 AM
*******************************************************************/

//Function Number: 1
setup_kung_fu_dragon_powers()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\powers\coop_powers::func_D787("power_shuriken_dragon",::set_dragon_shuriken_power,::unset_dragon_shuriken_power,::use_dragon_shuriken,undefined,undefined,undefined);
	level._effect["dragon_symbol"] = loadfx("vfx/iw7/levels/cp_disco/vfx_kungfu_seal_dragon_ground.vfx");
}

//Function Number: 2
set_dragon_shuriken_power(param_00)
{
	self notify("stop_shuriken_watcher");
	self.shuriken_charged = undefined;
	thread dragon_shuriken_throw_listener(param_00);
	thread dragon_shuriken_pullback_listener(param_00);
}

//Function Number: 3
get_shuriken_weapon_proj()
{
	var_00 = self.kung_fu_progression.active_discipline;
	switch(var_00)
	{
		case "dragon":
			return "iw7_shuriken_dragon_proj";

		case "tiger":
			return "iw7_shuriken_tiger_proj";

		case "snake":
			return "iw7_shuriken_snake_proj";

		case "crane":
			return "iw7_shuriken_crane_proj";

		default:
			break;
	}
}

//Function Number: 4
get_shuriken_grenade_weapon()
{
	var_00 = self.kung_fu_progression.active_discipline;
	switch(var_00)
	{
		case "dragon":
			return "iw7_shuriken_zm_dragon";

		case "tiger":
			return "iw7_shuriken_zm_tiger";

		case "snake":
			return "iw7_shuriken_zm_snake";

		case "crane":
			return "iw7_shuriken_zm_crane";

		default:
			break;
	}
}

//Function Number: 5
dragon_shuriken_throw_listener(param_00)
{
	self endon("disconnect");
	self endon("last_stand");
	self endon("stop_shuriken_watcher");
	var_01 = get_shuriken_weapon_proj();
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = get_shuriken_grenade_weapon();
	if(!isdefined(var_02))
	{
		return;
	}

	for(;;)
	{
		self waittill("grenade_fire",var_03,var_04,var_05);
		if(var_04 != var_02)
		{
			continue;
		}

		self setscriptablepartstate("shuriken","inactive");
		while(isdefined(var_03) && distance2dsquared(var_03.origin,self.origin) <= 8100)
		{
			wait(0.05);
		}

		if(!isdefined(var_03))
		{
			thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(scripts\cp\maps\cp_disco\kung_fu_mode::getrbabilitycost());
			continue;
		}

		scripts\cp\powers\coop_powers::func_D728();
		if(scripts\common\utility::istrue(self.shuriken_charged))
		{
			self.shuriken_charged = undefined;
			throw_charged_shuriken(param_00,var_03,var_01);
			continue;
		}

		var_06 = sortbydistance(level.spawned_enemies,var_03.origin);
		var_07 = [];
		var_08 = var_03.origin;
		var_09 = self getplayerangles();
		var_0A = anglestoforward(var_03.angles);
		var_0B = vectornormalize(var_0A) * 100 + var_08;
		var_0C = 10;
		var_0D = var_0C * -1;
		var_0D = var_0D + var_0C;
		var_0E = var_08 + anglestoforward(var_09 + (var_0D / 10,var_0D,0)) * 45;
		magicbullet(var_01,var_08,var_0E,self);
		var_0D = var_0D + var_0C;
		var_03 delete();
		thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(scripts\cp\maps\cp_disco\kung_fu_mode::getrbabilitycost());
		scripts\cp\powers\coop_powers::func_D72E();
	}
}

//Function Number: 6
dragon_shuriken_pullback_listener(param_00)
{
	self endon("watch_for_kung_fu_timeout");
	self endon("disconnect");
	self endon("last_stand");
	self endon("stop_shuriken_watcher");
	var_01 = get_shuriken_grenade_weapon();
	if(!isdefined(var_01))
	{
		return;
	}

	for(;;)
	{
		self waittill("grenade_pullback",var_02);
		if(var_02 != var_01)
		{
			return;
		}

		thread dragon_shuriken_switch_listener();
		thread charge_shuriken(2);
	}
}

//Function Number: 7
charge_shuriken(param_00)
{
	self endon("grenade_fire");
	self endon("offhand_end");
	self endon("put_shuriken_away");
	wait(param_00);
	self.shuriken_charged = 1;
	set_charged_scriptable_state();
}

//Function Number: 8
dragon_shuriken_switch_listener()
{
	self endon("watch_for_kung_fu_timeout");
	self endon("disconnect");
	self endon("last_stand");
	self endon("stop_shuriken_watcher");
	self endon("grenade_fire");
	self notifyonplayercommand("put_shuriken_away","+weapnext");
	self waittill("put_shuriken_away",var_00);
	self.shuriken_charged = undefined;
	self setscriptablepartstate("shuriken","inactive");
}

//Function Number: 9
set_charged_scriptable_state()
{
	var_00 = self.kung_fu_progression.active_discipline;
	switch(var_00)
	{
		case "dragon":
			self setscriptablepartstate("shuriken","dragon_active");
			break;

		case "tiger":
			self setscriptablepartstate("shuriken","tiger_active");
			break;

		case "snake":
			self setscriptablepartstate("shuriken","snake_active");
			break;

		case "crane":
			self setscriptablepartstate("shuriken","crane_active");
			break;

		default:
			break;
	}
}

//Function Number: 10
unset_dragon_shuriken_power(param_00)
{
}

//Function Number: 11
use_dragon_shuriken(param_00)
{
}

//Function Number: 12
throw_charged_shuriken(param_00,param_01,param_02)
{
	var_03 = sortbydistance(level.spawned_enemies,param_01.origin);
	var_04 = [];
	var_05 = param_01.origin;
	if(!isdefined(param_02))
	{
		param_02 = "iw7_shuriken_dragon_proj";
	}

	thread scripts\common\utility::play_sound_in_space("kungfu_shuriken_split",var_05);
	foreach(var_07 in var_03)
	{
		if(scripts\common\utility::func_13D90(self.origin,self getplayerangles(),var_07.origin,0.9))
		{
			var_04[var_04.size] = var_07;
		}
	}

	if(var_04.size == 0)
	{
		var_09 = self getplayerangles();
		var_0A = anglestoforward(param_01.angles);
		var_0B = vectornormalize(var_0A) * 100 + var_05;
		var_0C = 10;
		var_0D = var_0C * -1;
		for(var_0E = 0;var_0E < 3;var_0E++)
		{
			var_0F = var_05 + anglestoforward(var_09 + (var_0D / 10,var_0D,0)) * 45;
			magicbullet(param_02,var_05,var_0F,self);
			var_0D = var_0D + var_0C;
		}
	}
	else
	{
		var_0E = 0;
		foreach(var_07 in var_04)
		{
			if(var_0E == 3)
			{
				break;
			}
			else
			{
				var_0E++;
			}

			magicbullet(param_02,var_05,var_07 gettagorigin("j_mainroot") + (0,0,10),self);
		}
	}

	param_01 delete();
	scripts\cp\powers\coop_powers::func_D72E();
	thread scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(scripts\cp\maps\cp_disco\kung_fu_mode::getrbabilitycost());
}

//Function Number: 13
use_dragon_shuriken_power(param_00)
{
}

//Function Number: 14
dragon_super_use(param_00)
{
	self.dragon_super = 1;
	var_01 = scripts\cp\_utility::getvalidtakeweapon();
	var_02 = "dragon";
	if(isdefined(self.kung_fu_progression.active_discipline))
	{
		var_01 = level.kung_fu_upgrades[var_02].melee_weapon;
	}

	scripts\cp\powers\coop_powers::func_D728();
	scripts\common\utility::func_1C53(0);
	self playgestureviewmodel("ges_dragon_melee_super",undefined,1);
	thread stay_in_kung_fu_till_gesture_done("ges_dragon_melee_super");
	thread play_dragon_hand_fx();
	wait(0.5);
	var_03 = self.origin + (0,0,60);
	var_04 = self getplayerangles();
	var_05 = anglestoforward(var_04);
	var_06 = vectornormalize(var_05) * 100 + self.origin;
	var_05 = vectornormalize(var_05) * 3000 + var_03;
	var_07 = spawn("script_model",var_06);
	var_07.angles = var_04 + (0,-90,0);
	var_07 setmodel("tag_origin_dragon_super");
	var_07.var_222 = self;
	var_07.spiral_center = self.origin;
	var_07 thread move_dragon(var_05,var_02,var_01);
	var_07 thread dragon_super_damage(self,15,var_01);
}

//Function Number: 15
stay_in_kung_fu_till_gesture_done(param_00)
{
	self endon("disconnect");
	self.kung_fu_shield = 1;
	var_01 = 500;
	if(self.chi_meter_amount - var_01 <= 0)
	{
		self.kung_fu_exit_delay = 1;
	}

	var_02 = self method_8443(param_00);
	wait(var_02);
	scripts\common\utility::func_1C53(1);
	self.dragon_super = undefined;
	self.kung_fu_exit_delay = 0;
	self.kung_fu_shield = undefined;
	scripts\cp\powers\coop_powers::func_D72E();
}

//Function Number: 16
play_dragon_hand_fx()
{
	self setscriptablepartstate("kung_fu_super_fx","dragon");
	wait(2);
	self setscriptablepartstate("kung_fu_super_fx","off");
}

//Function Number: 17
move_dragon(param_00,param_01,param_02)
{
	self moveto(self.origin + (0,0,50),0.25);
	self waittill("movedone");
	thread dragon_time_out(10);
	follow_dragon_path(param_01,param_02);
	thread scripts\common\utility::play_sound_in_space("kungfu_dragon_proj_off",self.origin);
	self setscriptablepartstate("tag","off",1);
	self delete();
}

//Function Number: 18
move_dragon_forward()
{
	self endon("dragon_time_out");
	var_00 = 100;
	for(;;)
	{
		var_01 = anglestoforward(self.angles);
		var_01 = vectornormalize(var_01);
		var_01 = var_01 * var_00;
		self moveto(self.origin + var_01,0.1);
		self waittill("movedone");
	}
}

//Function Number: 19
aim_dragon()
{
	self endon("dragon_time_out");
	for(;;)
	{
		var_00 = scripts\cp\_agent_utils::func_7DB0("axis");
		if(var_00.size > 0)
		{
			var_01 = scripts\common\utility::func_782F(self.origin,var_00,undefined,24,500,1);
			var_02 = anglestoforward(self.angles);
			while(isalive(var_01[0]))
			{
				var_03 = var_01[0] method_8428(self.origin,var_01[0].origin);
				level thread debug_show_path(var_03);
				var_04 = var_01[0].origin + (0,0,60) - self.origin + (0,0,60);
				var_05 = vectortoangles(var_04);
				self rotateto(var_05,0.1);
				wait(0.1);
			}
		}

		wait(0.1);
	}
}

//Function Number: 20
follow_dragon_path(param_00,param_01)
{
	self endon("dragon_time_out");
	var_02 = -25536;
	for(;;)
	{
		var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_04 = [];
		foreach(var_06 in var_03)
		{
			if(isdefined(var_06.agent_type) && var_06.agent_type != "ratking")
			{
				var_04 = scripts\common\utility::array_add(var_04,var_06);
			}
		}

		var_03 = var_04;
		var_03 = [];
		if(var_03.size > 0)
		{
			var_08 = scripts\common\utility::func_782F(self.origin,var_03,undefined,24,1500,1);
			if(var_08.size > 0)
			{
				var_09 = anglestoforward(self.angles);
				var_0A = var_08[0];
				self.var_10C = var_0A;
				clean_up_spiral();
				while(isalive(var_0A))
				{
					var_0B = distancesquared(self.origin,var_0A.origin);
					if(var_0B < var_02)
					{
						var_0C = var_0A.origin + (0,0,60) - self.origin + (0,0,60);
						var_0D = vectortoangles(var_0C);
						self rotateto(var_0D,0.1);
						var_0E = length(var_0C);
						var_0C = vectornormalize(var_0C) * var_0E + 100;
						self moveto(self.origin + var_0C + (0,0,60),0.25);
						self waittill("movedone");
						if(isalive(var_0A))
						{
							dragon_kill_guy(var_0A,self.var_222,param_01);
						}

						continue;
					}

					var_0F = getclosestpointonnavmesh(self.origin);
					var_10 = var_0A method_8428(var_0F,var_0A.origin,1,1);
					var_10 = [];
					move_along_path_new(var_10,var_0A);
					wait(0.1);
				}
			}
			else
			{
				thread idle_spiral();
			}
		}
		else
		{
			thread idle_spiral();
		}

		wait(0.1);
	}
}

//Function Number: 21
clean_up_spiral()
{
	self.on_spiral_path = 0;
	if(isdefined(self.spin_org))
	{
		self.spin_org delete();
	}

	self notify("found_enemy");
}

//Function Number: 22
idle_spiral()
{
	self endon("found_enemy");
	self endon("death");
	wait(0.25);
	if(!scripts\common\utility::istrue(self.on_spiral_path))
	{
		move_along_spiral_path();
	}
}

//Function Number: 23
move_along_spiral_path(param_00)
{
	self endon("found_enemy");
	self endon("death");
	self endon("got_new_path");
	spin_linked_ent();
}

//Function Number: 24
spin_linked_ent()
{
	self endon("found_enemy");
	self endon("death");
	var_00 = self.spiral_center;
	self.on_spiral_path = 1;
	self.spin_org = spawn("script_origin",var_00);
	self linkto(self.spin_org);
	self.spin_org rotateyaw(-100000,300);
	for(;;)
	{
		self.spin_org movez(75,2);
		self.spin_org waittill("movedone");
		self.spin_org movez(-75,2);
		self.spin_org waittill("movedone");
	}
}

//Function Number: 25
move_along_path_new(param_00,param_01)
{
	self endon("death");
	self endon("got_new_path");
	var_02 = 100;
	var_03 = var_02 * var_02;
	if(param_00.size > 0)
	{
		var_04 = 0;
		var_05 = param_00[var_04];
		var_06 = 0;
		while(distancesquared(self.origin,var_05) < var_03)
		{
			if(isdefined(param_00[var_04 + 1]))
			{
				var_04++;
				var_05 = param_00[var_04];
				continue;
			}

			var_06 = 1;
			break;
		}

		if(!var_06)
		{
			thread turn_towards_target(var_05);
		}
	}
	else if(isalive(param_01))
	{
		var_05 = param_01.origin + (0,0,60);
		thread turn_towards_target(var_05);
	}

	thread func_BC29();
}

//Function Number: 26
func_BC29()
{
	var_00 = 500;
	var_01 = anglestoforward(self.angles);
	var_01 = vectornormalize(var_01) * var_00;
	var_02 = self.origin + var_01;
	var_02 = getclosestpointonnavmesh(var_02);
	self moveto(var_02 + (0,0,60),1);
}

//Function Number: 27
turn_towards_target(param_00)
{
	var_01 = 360;
	var_02 = param_00 - self.origin + (0,0,60);
	var_03 = vectortoangles(var_02);
	var_04 = anglesdelta(self.angles,var_03) * 2;
	if(var_04 == 0)
	{
		return;
	}

	var_05 = var_04 / var_01;
	var_05 = abs(var_05);
	self rotateto(var_03,var_05);
	var_06 = anglestoforward(var_03);
	var_06 = vectornormalize(var_06) * 100;
	var_07 = self.origin + var_06;
}

//Function Number: 28
debug_show_path(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(isdefined(param_00[var_01 + 1]))
		{
		}
	}
}

//Function Number: 29
dragon_time_out(param_00)
{
	wait(param_00);
	self notify("dragon_time_out");
}

//Function Number: 30
dragon_super_damage(param_00,param_01,param_02)
{
	self endon("death");
	self notify("dragon_time_out");
	var_03 = 0.1;
	var_04 = 22500;
	while(!isdefined(self.spin_org))
	{
		wait(0.1);
	}

	var_05 = self.spin_org;
	while(param_01 > 0 && isdefined(var_05))
	{
		var_06 = level.spawned_enemies;
		foreach(var_08 in var_06)
		{
			if(distancesquared(self.spiral_center,var_08.origin) < var_04)
			{
				dragon_kill_guy(var_08,param_00,param_02);
			}
		}

		param_01 = param_01 - var_03;
		wait(var_03);
	}
}

//Function Number: 31
dragon_kill_guy(param_00,param_01,param_02)
{
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	if(isdefined(param_01))
	{
		param_00 dodamage(param_00.health + 1000,param_00.origin,param_01,param_01,"MOD_UNKNOWN",param_02);
		return;
	}

	param_00 dodamage(param_00.health + 1000,param_00.origin,level.players[0],level.players[0],"MOD_UNKNOWN",param_02);
}