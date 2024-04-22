/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _atlas_suv.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 343 ms
 * Timestamp: 4/22/2024 2:04:20 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("atlas_suv",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_atlas_suv","vehicle_atlas_suv_dstrypv");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_civ_ai_explo_lrg_runner","Tag_death_fx","car_explode",undefined,undefined,undefined,0);
	if(param_02 == "script_vehicle_atlas_suv_physics_explode")
	{
		maps\_vehicle::build_radiusdamage((0,0,53),256,300,20,1,0);
	}

	maps\_vehicle::build_drive(%sf_suv_driving_idle_forward,%sf_suv_driving_idle_backward,10);
	maps\_vehicle::build_deathquake(1,1.6,500);
	maps\_vehicle::build_life(750);
	maps\_vehicle::build_team("axis");
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/tread_dust_default");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_unload_groups(::unload_groups);
}

//Function Number: 2
init_local()
{
	maps\_utility::ent_flag_init("lrear_window_open");
	maps\_utility::ent_flag_init("rrear_window_open");
	maps\_utility::ent_flag_init("rear_window_open");
	thread clear_anim_on_death();
	soundscripts\_snd::snd_message("atlas_van_explode",level.player_pitbull);
	if(!isdefined(self.script_allow_rider_deaths))
	{
		self.script_allow_rider_deaths = 1;
	}

	if(!isdefined(self.script_allow_driver_death))
	{
		self.script_allow_driver_death = 1;
	}
}

//Function Number: 3
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_getoutanim = %atlas_suv_dismount_frontl_door;
	param_00[1].vehicle_getoutanim = %atlas_suv_dismount_frontr_door;
	param_00[2].vehicle_getoutanim = %atlas_suv_dismount_backl_door;
	param_00[3].vehicle_getoutanim = %atlas_suv_dismount_backr_door;
	return param_00;
}

//Function Number: 4
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 9;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[0].idle = %atlas_suv_idle_frontl;
	var_00[0].getout = %atlas_suv_dismount_frontl;
	var_00[0].death = %sf_suv_lrear_death;
	var_00[0].death_no_ragdoll = 1;
	var_00[0].death_flop_dir = (0,2500,0);
	var_00[0].min_unload_frac_to_flop = 0.55;
	var_00[1].sittag = "tag_passenger";
	var_00[1].idle = %atlas_suv_idle_frontr;
	var_00[1].getout = %atlas_suv_dismount_frontr;
	var_00[1].death = %sf_suv_rrear_death;
	var_00[1].death_no_ragdoll = 1;
	var_00[1].death_flop_dir = (0,-2500,0);
	var_00[1].min_unload_frac_to_flop = 0.55;
	var_00[2].sittag = "tag_guy0";
	var_00[2].idle = %atlas_suv_idle_backl;
	var_00[2].getout = %atlas_suv_dismount_backl;
	var_00[2].death = %sf_suv_lrear_death;
	var_00[2].death_no_ragdoll = 1;
	var_00[2].rider_func = ::atlas_suv_rider_think;
	var_00[2].death_flop_dir = (0,2500,0);
	var_00[2].min_unload_frac_to_flop = 0.6;
	var_00[3].sittag = "tag_guy1";
	var_00[3].idle = %atlas_suv_idle_backr;
	var_00[3].getout = %atlas_suv_dismount_backr;
	var_00[3].death = %sf_suv_rrear_death;
	var_00[3].death_no_ragdoll = 1;
	var_00[3].rider_func = ::atlas_suv_rider_think;
	var_00[3].death_flop_dir = (0,-2500,0);
	var_00[3].min_unload_frac_to_flop = 0.6;
	var_00[4].sittag = "tag_guy2";
	var_00[4].idle = %suburban_idle_backr;
	var_00[4].death = %sf_suv_rear_death;
	var_00[4].death_no_ragdoll = 1;
	var_00[4].rider_func = ::atlas_suv_rider_think;
	var_00[4].customunloadfunc = ::do_nothing;
	var_00[4].death_flop_dir = (0,-2500,0);
	return var_00;
}

//Function Number: 5
unload_groups()
{
	var_00 = [];
	var_00["passengers"] = [];
	var_00["all"] = [];
	var_01 = "passengers";
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00[var_01][var_00[var_01].size] = 4;
	var_01 = "all";
	var_00[var_01][var_00[var_01].size] = 0;
	var_00[var_01][var_00[var_01].size] = 1;
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00[var_01][var_00[var_01].size] = 4;
	var_00["default"] = var_00["all"];
	return var_00;
}

//Function Number: 6
do_nothing(param_00,param_01)
{
}

//Function Number: 7
setup_rider_anims(param_00)
{
	self.rider_anims = [];
	if(param_00 == "tag_guy0")
	{
		self.rider_anims["idle"] = %sf_suv_lrear_inside_idle;
		self.rider_anims["popout"] = %sf_suv_lrear_popout;
		self.rider_anims["aim_2"] = %sf_suv_lrear_idle_aim_2;
		self.rider_anims["aim_4"] = %sf_suv_lrear_idle_aim_4;
		self.rider_anims["aim_5"] = %sf_suv_lrear_idle_aim_5;
		self.rider_anims["aim_6"] = %sf_suv_lrear_idle_aim_6;
		self.rider_anims["aim_8"] = %sf_suv_lrear_idle_aim_8;
		self.rider_anims["popin"] = %sf_suv_lrear_popin;
		self.rider_anims["react"] = %sf_suv_lrear_react;
		self.rider_anims["death"] = %sf_suv_lrear_death;
		self.rider_anims["fire_1"] = %sf_suv_lrear_fire_1;
		self.rider_anims["fire_2"] = %sf_suv_lrear_fire_2;
		self.rider_anims["fire_3"] = %sf_suv_lrear_fire_3;
		self.rider_anims["fire_4"] = %sf_suv_lrear_fire_4;
		self.rider_anims["fire_5"] = %sf_suv_lrear_fire_5;
		return;
	}

	if(param_00 == "tag_guy1")
	{
		self.rider_anims["idle"] = %sf_suv_rrear_inside_idle;
		self.rider_anims["popout"] = %sf_suv_rrear_popout;
		self.rider_anims["aim_2"] = %sf_suv_rrear_idle_aim_2;
		self.rider_anims["aim_4"] = %sf_suv_rrear_idle_aim_4;
		self.rider_anims["aim_5"] = %sf_suv_rrear_idle_aim_5;
		self.rider_anims["aim_6"] = %sf_suv_rrear_idle_aim_6;
		self.rider_anims["aim_8"] = %sf_suv_rrear_idle_aim_8;
		self.rider_anims["popin"] = %sf_suv_rrear_popin;
		self.rider_anims["react"] = %sf_suv_rrear_react;
		self.rider_anims["death"] = %sf_suv_rrear_death;
		self.rider_anims["fire_1"] = %sf_suv_rrear_fire_1;
		self.rider_anims["fire_2"] = %sf_suv_rrear_fire_2;
		self.rider_anims["fire_3"] = %sf_suv_rrear_fire_3;
		self.rider_anims["fire_4"] = %sf_suv_rrear_fire_4;
		self.rider_anims["fire_5"] = %sf_suv_rrear_fire_5;
		return;
	}

	if(param_00 == "tag_guy2")
	{
		self.rider_anims["idle"] = %sf_suv_rear_inside_idle;
		self.rider_anims["popout"] = %sf_suv_rear_popout;
		self.rider_anims["aim_2"] = %sf_suv_rear_idle_aim_2;
		self.rider_anims["aim_4"] = %sf_suv_rear_idle_aim_4;
		self.rider_anims["aim_5"] = %sf_suv_rear_idle_aim_5;
		self.rider_anims["aim_6"] = %sf_suv_rear_idle_aim_6;
		self.rider_anims["aim_8"] = %sf_suv_rear_idle_aim_8;
		self.rider_anims["react"] = %sf_suv_rear_react;
		self.rider_anims["death"] = %sf_suv_rear_death;
		self.rider_anims["fire_1"] = %sf_suv_rear_fire_1;
		self.rider_anims["fire_2"] = %sf_suv_rear_fire_2;
		self.rider_anims["fire_3"] = %sf_suv_rear_fire_3;
		self.rider_anims["fire_4"] = %sf_suv_rear_fire_4;
		self.rider_anims["fire_5"] = %sf_suv_rear_fire_5;
		return;
	}

	if(param_00 == "tag_driver")
	{
		self.rider_anims["death"] = %sf_suv_lrear_death;
		return;
	}

	if(param_00 == "tag_passenger")
	{
		self.rider_anims["death"] = %sf_suv_rrear_death;
		return;
	}
}

//Function Number: 8
atlas_suv_rider_think()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.vehicle_position))
	{
		return;
	}

	if(!isdefined(self.ridingvehicle))
	{
		return;
	}

	atlas_suv_rider_no_react();
	var_00 = self.ridingvehicle;
	var_01 = maps\_vehicle_aianim::anim_pos(var_00,self.vehicle_position);
	setup_rider_anims(var_01.sittag);
	self setanimknoball(%atlas_suv,%root,1,0);
	thread rider_think_loop(var_00,var_01.sittag);
}

//Function Number: 9
enable_react_on_unload()
{
	self endon("death");
	self waittill("unload");
	if(isdefined(self) && isalive(self))
	{
		atlas_suv_rider_react();
	}
}

//Function Number: 10
atlas_suv_rider_no_react()
{
	thread enable_react_on_unload();
	self.grenadeawareness = 0;
	maps\_utility::disable_surprise();
	self.allowpain = 0;
	self.flashbangimmunity = 1;
	self.disablebulletwhizbyreaction = 1;
}

//Function Number: 11
atlas_suv_rider_react()
{
	self.grenadeawareness = 1;
	maps\_utility::enable_surprise();
	self.allowpain = 1;
	self.flashbangimmunity = 0;
	self.disablebulletwhizbyreaction = undefined;
}

//Function Number: 12
rider_think_loop(param_00,param_01)
{
	self endon("death");
	self endon("jumpedout");
	self endon("jumping_out");
	for(;;)
	{
		thread play_idle_anim();
		var_02 = find_threat(param_01);
		play_combat_state(param_00,param_01,var_02);
	}
}

//Function Number: 13
find_threat(param_00)
{
	var_01 = self.enemy;
	for(;;)
	{
		if(isdefined(self.enemy))
		{
			var_01 = self.enemy;
			var_02 = var_01 geteye() - self geteye();
			var_03 = vectornormalize(var_02);
			var_04 = anglestoforward(self.angles);
			var_05 = vectordot(var_03,var_04);
			if(var_05 > 0.707 && param_00 == "tag_guy2")
			{
				break;
			}

			if(var_05 < 0)
			{
				var_06 = anglestoright(self.angles);
				var_07 = vectordot(var_03,var_06);
				if(var_07 < 0 && param_00 == "tag_guy0")
				{
					break;
				}

				if(var_07 > 0 && param_00 == "tag_guy1")
				{
					break;
				}
			}
		}

		wait(0.1);
	}

	return var_01;
}

//Function Number: 14
play_idle_anim()
{
	self endon("stop_idle_loop");
	self endon("death");
	self endon("jumpedout");
	self endon("jumping_out");
	var_00 = self.ridingvehicle;
	var_01 = maps\_vehicle_aianim::anim_pos(var_00,self.vehicle_position);
	for(;;)
	{
		self notify("newanim");
		var_00 maps\_vehicle_aianim::animontag(self,var_01.sittag,self.rider_anims["idle"]);
	}
}

//Function Number: 15
play_combat_state(param_00,param_01,param_02)
{
	self endon("death");
	self notify("stop_idle_loop");
	self notify("newanim");
	thread open_window(param_00,param_01);
	param_00 maps\_vehicle_aianim::animontag(self,param_01,self.rider_anims["popout"]);
	if(isdefined(param_02))
	{
		play_aim_anim(param_01,param_02);
	}

	self clearanim(%atlas_suv_aiming,0.2);
	if(isdefined(self.rider_anims["popin"]))
	{
		param_00 maps\_vehicle_aianim::animontag(self,param_01,self.rider_anims["popin"]);
	}
}

//Function Number: 16
custom_aim_notetracks(param_00)
{
	self endon("killanimscript");
	for(;;)
	{
		self waittill(param_00,var_01);
		if(isdefined(var_01))
		{
			animscripts\notetracks::handlenotetrack(var_01,param_00);
		}
	}
}

//Function Number: 17
custom_aim_animscript()
{
	self endon("killanimscript");
	self clearanim(%atlas_suv_actions,0.2);
	self setanim(%atlas_suv_aiming,1,0,1);
	var_00 = "combat_aim";
	thread custom_aim_notetracks(var_00);
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(self.animscript_sittag == "tag_guy0")
	{
		var_01 = 90;
		var_02 = 180;
		var_03 = 135;
	}
	else if(self.animscript_sittag == "tag_guy1")
	{
		var_01 = 0;
		var_02 = 90;
		var_03 = 45;
	}
	else if(self.animscript_sittag == "tag_guy2")
	{
		var_01 = 45;
		var_02 = 135;
		var_03 = 90;
	}

	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	for(;;)
	{
		if(!isdefined(self.animscript_target))
		{
			self notify("kill_aim_anim");
		}

		if(isdefined(self.animscript_target))
		{
			var_07 = self.animscript_target geteye() - self geteye();
			var_08 = vectornormalize(var_07);
			var_09 = anglestoforward(self.angles);
			var_0A = vectordot(var_08,var_09);
			if(self.animscript_sittag == "tag_guy2")
			{
				if(var_0A < 0)
				{
					self notify("kill_aim_anim");
				}
			}
			else if(var_0A > 0)
			{
				self notify("kill_aim_anim");
			}

			var_0B = anglestoright(self.angles);
			var_0C = vectordot(var_08,var_0B);
			var_0D = acos(var_0C);
			var_0D = angleclamp180(var_0D);
			var_0D = clamp(var_0D,var_01,var_02);
			if(self.animscript_sittag == "tag_guy1")
			{
				var_0D = 90 - var_0D;
			}
			else if(self.animscript_sittag == "tag_guy2")
			{
				var_0D = 180 - var_0D;
			}

			var_0D = var_0D - var_03;
			var_04 = var_0D / 45;
		}

		var_0E = var_04 - var_05;
		var_0E = clamp(var_0E,-0.1,0.1);
		var_04 = var_05 + var_0E;
		var_05 = var_04;
		if(var_04 < 0)
		{
			var_0F = var_04 * -1;
			var_10 = 1 - var_0F;
			var_11 = 0;
		}
		else
		{
			var_11 = var_04;
			var_10 = 1 - var_11;
			var_0F = 0;
		}

		var_0F = clamp(var_0F,0,1);
		var_10 = clamp(var_10,0,1);
		var_11 = clamp(var_11,0,1);
		update_anim_weight(self.rider_anims["aim_4"],var_0F);
		update_anim_weight(self.rider_anims["aim_5"],var_10);
		update_anim_weight(self.rider_anims["aim_6"],var_11);
		if(isdefined(var_06) && var_06 > 0)
		{
			var_06 = var_06 - 0.05;
		}
		else
		{
			var_12 = ["fire_1","fire_2","fire_3","fire_4","fire_5"];
			var_13 = var_12[randomint(var_12.size)];
			var_14 = self.rider_anims[var_13];
			if(isdefined(var_14))
			{
				var_06 = getanimlength(var_14);
				var_06 = var_06 + randomfloatrange(0,2);
				self setflaggedanimknobrestart(var_00,var_14,1,0,1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 18
open_window(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(param_01 == "tag_guy0")
	{
		var_02 = "lrear_window_open";
		var_03 = %sf_suv_lrear_window_open;
	}
	else if(param_01 == "tag_guy1")
	{
		var_02 = "rrear_window_open";
		var_03 = %sf_suv_rrear_window_open;
	}
	else if(param_01 == "tag_guy2")
	{
		var_02 = "rear_window_open";
		var_03 = %sf_suv_rear_window_open;
	}

	if(isdefined(var_02))
	{
		if(!param_00 maps\_utility::ent_flag(var_02))
		{
			param_00 setanim(var_03,1,0,1);
			param_00 maps\_utility::ent_flag_set(var_02);
		}
	}
}

//Function Number: 19
update_anim_weight(param_00,param_01)
{
	self setanim(param_00,param_01,0,1);
}

//Function Number: 20
play_aim_anim(param_00,param_01)
{
	thread notify_kill_aim_anim(param_01);
	self.animscript_sittag = param_00;
	self.animscript_target = param_01;
	self animcustom(::custom_aim_animscript);
	wait(0.05);
	self waittill("kill_aim_anim");
	self notify("killanimscript");
}

//Function Number: 21
notify_on_death(param_00)
{
	self endon("kill_aim_anim");
	param_00 waittill("death");
	wait(0.2);
	self notify("kill_aim_anim");
}

//Function Number: 22
notify_kill_aim_anim(param_00)
{
	self endon("death");
	self endon("kill_aim_anim");
	if(!isdefined(param_00))
	{
		self notify("kill_aim_anim");
	}

	thread notify_on_death(param_00);
}

//Function Number: 23
clear_anim_on_death()
{
	self waittill("death_finished");
	self clearanim(%root,0);
}