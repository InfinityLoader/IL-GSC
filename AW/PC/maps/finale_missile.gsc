/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_missile.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 207 ms
 * Timestamp: 4/22/2024 2:29:22 AM
*******************************************************************/

//Function Number: 1
setup_complete_missile_prefab(param_00,param_01)
{
	var_02 = [];
	setup_main_missile(param_00,param_01);
	for(var_03 = 1;var_03 <= 6;var_03++)
	{
		var_04 = "side_missile_breakable_0" + var_03;
		var_05 = getentarray(var_04,"targetname");
		var_06 = setup_side_missile_prefab(var_05,param_01);
		var_02[var_02.size] = var_06;
	}

	wait 0.05;
	foreach(var_06 in var_02)
	{
		var_06 linkto(param_00,"missile");
	}

	thread custom_health_think(param_01,param_00);
}

//Function Number: 2
setup_complete_missile_not_prefab(param_00,param_01)
{
	setup_main_missile(param_00);
	var_02 = getentarray("side_missile_01","targetname");
	foreach(var_04 in var_02)
	{
		var_04 setmodel("fin_side_missile_02");
		var_04 attach_or_link("fin_side_missile_white_panel_top_r_01","dyna_White_panel_top_R_01");
		var_04 attach_or_link("fin_side_missile_white_panel_top_l_01","dyna_White_panel_top_L_01");
		var_04 attach_or_link("fin_side_missile_white_panel_bottom_r_01","dyna_White_panel_bottom_R_01");
		var_04 attach_or_link("fin_side_missile_white_panel_bottom_l_01","dyna_White_panel_bottom_L_01");
		var_04 attach_or_link("fin_side_missile_engine_nozzel_piece_01","dyna_Engine_nozzel_piece_01");
		var_04 attach_or_link("fin_side_missile_engine_nozzel_piece_02","dyna_Engine_nozzel_piece_02");
		var_04 attach_or_link("fin_side_missile_engine_brace_piece_01","dyna_Engine_brace_piece_01");
		var_04 attach_or_link("fin_side_missile_side_box_piece_r_01","dyna_Black_R_side_box_piece_01");
		var_04 attach_or_link("fin_side_missile_side_box_piece_l_01","dyna_Black_L_side_box_piece_02");
		var_04 linkto(param_00,"missile");
		var_05 = undefined;
		thread clip_missle_damage_think(var_05,4000,param_01);
	}
}

//Function Number: 3
clip_missle_damage_think(param_00,param_01,param_02)
{
	param_00 setcandamage(1);
	param_00.maxhealth = param_01;
	param_00 setnormalhealth(param_00.maxhealth);
	var_03 = param_00.maxhealth * 0.5;
	var_04 = 0;
	var_05 = 0;
	while(param_00.health > 0)
	{
		param_00 waittill("damage",var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F);
		if(param_00.health < var_03)
		{
			if(isdefined(param_00.assigned_model_b) && param_00.assigned_model_b != param_00.assigned_parent && !var_04)
			{
				playfx(common_scripts\utility::getfx("fin_rocket_silo_explosion"),var_09);
				soundscripts\_snd::snd_message("aud_fin_rocket_damage_vfx");
				param_00.assigned_model_b hide();
				var_04 = 1;
			}
		}

		if(isdefined(param_02))
		{
			param_02 dodamage(1,var_09,var_07,var_07,var_0A,var_0F);
		}

		if(param_00.health < 0)
		{
			if(isdefined(param_00.assigned_model) && param_00.assigned_model != param_00.assigned_parent && !var_05)
			{
				param_00.assigned_model hide();
				playfx(common_scripts\utility::getfx("fin_rocket_silo_explosion"),var_09);
				soundscripts\_snd::snd_message("aud_fin_rocket_damage_vfx");
				var_05 = 1;
				if(param_00.classname == "script_brushmodel")
				{
					param_00 notsolid();
					return;
				}
			}

			param_00 setnormalhealth(99999);
		}

		wait 0.05;
	}
}

//Function Number: 4
setup_side_missile(param_00)
{
	param_00 attach_or_link("fin_side_missile_white_panel_top_r_01","dyna_White_panel_top_R_01");
	param_00 attach_or_link("fin_side_missile_white_panel_top_l_01","dyna_White_panel_top_L_01");
	param_00 attach_or_link("fin_side_missile_white_panel_bottom_r_01","dyna_White_panel_bottom_R_01");
	param_00 attach_or_link("fin_side_missile_white_panel_bottom_l_01","dyna_White_panel_bottom_L_01");
	param_00 attach_or_link("fin_side_missile_engine_nozzel_piece_01","dyna_Engine_nozzel_piece_01");
	param_00 attach_or_link("fin_side_missile_engine_nozzel_piece_02","dyna_Engine_nozzel_piece_02");
	param_00 attach_or_link("fin_side_missile_engine_brace_piece_01","dyna_Engine_brace_piece_01");
	param_00 attach_or_link("fin_side_missile_side_box_piece_r_01","dyna_Black_R_side_box_piece_01");
	param_00 attach_or_link("fin_side_missile_side_box_piece_l_01","dyna_Black_L_side_box_piece_02");
}

//Function Number: 5
attach_or_link(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_02)
	{
		self attach(param_00,param_01);
		return;
	}

	var_03 = self gettagorigin(param_01);
	var_04 = spawn("script_model",var_03);
	var_05 = self gettagangles(param_01);
	var_04.angles = var_05;
	var_04.target = self.targetname;
}

//Function Number: 6
setup_main_missile(param_00,param_01)
{
	if(isdefined(param_01))
	{
		param_01 setcandamage(1);
		param_01.maxhealth = 40000;
		param_01 setnormalhealth(param_01.maxhealth);
		param_01.healthcustom = 20;
		param_01.count_swarm = 0;
		param_01.count_rocket = 0;
		param_01.count_bullet = 0;
	}

	param_00.animname = "missile_main";
	param_00 maps\_utility::assign_animtree();
	var_02 = getentarray(param_00.targetname,"target");
	foreach(var_04 in var_02)
	{
		var_04 linkto(param_00,"missile");
		thread clip_missle_damage_think(var_04,9999999,param_01);
	}

	thread clip_missle_damage_think(param_00,9999999,param_01);
}

//Function Number: 7
setup_side_missile_prefab(param_00,param_01)
{
	var_02 = undefined;
	var_03 = [];
	var_04 = [];
	foreach(var_06 in param_00)
	{
		if(var_06.classname == "script_brushmodel")
		{
			var_03[var_03.size] = var_06;
		}
	}

	foreach(var_06 in param_00)
	{
		if(var_06.classname == "script_model")
		{
			var_04[var_04.size] = var_06;
		}

		if(var_06.model == "fin_side_missile_02")
		{
			var_02 = var_06;
		}
	}

	foreach(var_0B in var_03)
	{
		foreach(var_0D in var_04)
		{
			if(isdefined(var_0B.script_noteworthy) && var_0B.script_noteworthy == var_0D.model)
			{
				var_0B.assigned_model = var_0D;
				var_0D.assigned_brush = var_0B;
			}

			if(isdefined(var_0B.script_parameters) && var_0B.script_parameters == var_0D.model)
			{
				var_0B.assigned_model_b = var_0D;
				var_0D.assigned_brush = var_0B;
			}
		}
	}

	foreach(var_0B in var_03)
	{
		var_0B.assigned_parent = var_02;
		var_11 = 4000;
		if(var_0B.assigned_model == var_02)
		{
			var_11 = 99999999;
		}

		thread clip_missle_damage_think(var_0B,var_11,param_01);
	}

	foreach(var_0D in var_04)
	{
		if(!isdefined(var_0D.assigned_brush))
		{
			var_0D.assigned_model = var_0D;
			var_11 = 4000;
			if(var_0D.assigned_model == var_02)
			{
				var_11 = 99999999;
			}

			thread clip_missle_damage_think(var_0D,var_11,param_01);
		}

		if(var_0D != var_02)
		{
			var_0D.assigned_parent = var_02;
			var_0D linkto(var_02);
		}
	}

	return var_02;
}

//Function Number: 8
fx_engine_off(param_00,param_01)
{
	if(param_00 == 0)
	{
		soundscripts\_snd::snd_message("missile_large_thrusters_off");
		playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue_idle"),param_01,"missile");
		stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue"),param_01,"missile");
		return;
	}

	soundscripts\_snd::snd_message("missile_small_thrusters_off");
	var_02 = "TAG_ATTACH" + param_00;
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),param_01,var_02);
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),param_01,var_02);
}

//Function Number: 9
fx_engine_on(param_00,param_01)
{
	if(param_00 == 0)
	{
		stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue_idle"),param_01,"missile");
		playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_blue"),param_01,"missile");
		return;
	}

	var_02 = "TAG_ATTACH" + param_00;
	stopfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml_idle"),param_01,var_02);
	playfxontag(common_scripts\utility::getfx("fin_rocket_thruster_sml"),param_01,var_02);
}

//Function Number: 10
custom_regen_think(param_00,param_01)
{
	param_00 endon("fakedamage");
	param_00 endon("death");
	param_01 endon("death");
	if(common_scripts\utility::flag("flag_missile_failed") || common_scripts\utility::flag("flag_missile_damaged"))
	{
		return;
	}

	if(0)
	{
		return;
	}

	var_02 = gettime() + 1000;
	while(gettime() < var_02)
	{
		wait 0.05;
	}

	while(param_00.healthcustom < 20)
	{
		if(common_scripts\utility::flag("flag_missile_failed") || common_scripts\utility::flag("flag_missile_damaged"))
		{
			return;
		}

		param_00.healthcustom = param_00.healthcustom + 0.05;
		if(0)
		{
			while(param_00.tag_current > 0 && param_00.healthcustom > param_00.tag_shutdown_hp_threshold_array[param_00.tag_current])
			{
				var_03 = param_00.tag_shutdown_order_array[param_00.tag_current];
				if(isdefined(var_03))
				{
					fx_engine_on(var_03,param_01);
				}

				param_00.tag_current--;
			}
		}

		wait 0.05;
	}

	param_00.healthcustom = 20;
}

//Function Number: 11
restore_thrusters_all(param_00,param_01)
{
	while(param_01.tag_current >= 0)
	{
		var_02 = param_01.tag_shutdown_order_array[param_01.tag_current];
		if(isdefined(var_02))
		{
			fx_engine_on(var_02,param_00);
			wait 0.05;
		}

		param_01.tag_current--;
	}
}

//Function Number: 12
custom_health_think(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	var_02 = 0;
	param_00.tag_shutdown_order_array = [4,3,5,2,6,1,0];
	var_03 = 20 / param_00.tag_shutdown_order_array.size - 1;
	param_00.tag_shutdown_hp_threshold_array = [var_03 * 6,var_03 * 5,var_03 * 4,var_03 * 3,var_03 * 2,var_03 * 1,0];
	param_00.tag_current = 0;
	for(;;)
	{
		param_00 waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		if(gettime() == var_02)
		{
			continue;
		}

		var_02 = gettime();
		var_0E = 0;
		if(var_0D == "playermech_rocket_projectile" || var_0D == "playermech_rocket_swarm_finale")
		{
			param_00.count_swarm++;
			var_0E = 0.5;
		}
		else if(var_0D == "playermech_rocket_finale")
		{
			param_00.count_rocket++;
			var_0E = 4;
		}
		else
		{
			param_00.count_bullet++;
			var_0E = 0.1428571;
		}

		param_00.healthcustom = param_00.healthcustom - var_0E;
		param_00 notify("fakedamage");
		while(param_00.tag_current < param_00.tag_shutdown_hp_threshold_array.size && param_00.healthcustom < param_00.tag_shutdown_hp_threshold_array[param_00.tag_current])
		{
			var_0F = param_00.tag_shutdown_order_array[param_00.tag_current];
			if(isdefined(var_0F))
			{
				fx_engine_off(var_0F,param_01);
			}

			param_00.tag_current++;
		}

		if(param_00.healthcustom < 0)
		{
			param_00 kill();
			continue;
		}

		thread custom_regen_think(param_00,param_01);
	}
}