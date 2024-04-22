/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_ending.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 184 ms
 * Timestamp: 4/22/2024 2:29:10 AM
*******************************************************************/

//Function Number: 1
se_irons_react_to_gunfire(param_00)
{
	var_01 = (0,0,0);
	var_02 = 2;
	var_03 = 6;
	for(;;)
	{
		level.player waittill("weapon_fired");
		if(common_scripts\utility::flag("flag_se_irons_end_start"))
		{
			return;
		}

		var_04 = getdvarfloat("cg_fov");
		var_05 = level.player worldpointtoscreenpos(level.irons.origin,var_04);
		if(isdefined(var_05))
		{
			param_00 notify("ender");
			if(var_05[0] > var_01[0])
			{
				param_00 maps\_anim::anim_single_solo(level.irons,"irons_end_look_l");
			}
			else
			{
				param_00 maps\_anim::anim_single_solo(level.irons,"irons_end_look_r");
			}

			if(common_scripts\utility::flag("flag_se_irons_end_start"))
			{
				return;
			}

			param_00 thread maps\_anim::anim_loop_solo(level.irons,"irons_end_idle","ender");
			wait(randomfloatrange(var_02,var_03));
		}
	}
}

//Function Number: 2
anim_first_frame_with_finale_gameplay(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	maps\_anim::anim_first_frame(param_00,param_01);
	if(1)
	{
		maps\_anim::anim_first_frame_solo(param_02,param_01);
		var_07 = getanimlength(param_02 maps\_utility::getanim(param_01));
		param_02 maps\_anim::anim_set_time([param_02],param_01,6.8333 / var_07);
	}

	var_06 = create_pivot(param_02,"tag_origin",0);
	var_08 = gettime() + 34700;
	wait(13.3333);
	level.player notifyonplayercommand("trigger_pulled","+attack");
	thread allow_fake_shooting(param_02,param_03,7.0666);
	move_pivot_process(var_06,param_02,"TAG_WEAPON_LEFT",level.irons,"TAG_EYE",param_01,32.1333,1,param_04);
	if(1)
	{
		while(gettime() < var_08)
		{
			wait 0.05;
		}

		param_03 hide();
		param_05 show();
		param_02 hide();
		param_04 show();
	}
}

//Function Number: 3
allow_fake_shooting(param_00,param_01,param_02)
{
	level.player endon("end_fake_shooting");
	var_03 = gettime() + param_02 * 1000;
	var_04 = "tag_rail_master_on";
	var_05 = 0;
	for(;;)
	{
		level.player waittill("trigger_pulled");
		var_06 = param_01 gettagorigin(var_04);
		var_07 = anglestoforward(param_01 gettagangles(var_04));
		var_08 = var_06 + var_07 * 50;
		var_09 = bullettrace(var_06,var_08,1,param_01,1,1);
		if(gettime() > var_03)
		{
			soundscripts\_snd_playsound::snd_play_2d("wpn_dryfire_pistol_plr");
			var_05++;
			if(var_05 > 4)
			{
				return;
			}

			continue;
		}

		if(isdefined(var_09["entity"]) && var_09["entity"] == level.irons)
		{
			soundscripts\_snd_playsound::snd_play_2d("wpn_dryfire_pistol_plr");
			continue;
		}

		magicbullet("iw5_titan45_sp",var_06,var_08,level.player);
		playfxontag(common_scripts\utility::getfx("titan45_muzzle"),param_01,var_04);
		level.player playrumbleonentity("pistol_fire");
		if(0)
		{
			var_0A = param_00 maps\_utility::getanim("irons_reveal_fire_add");
			param_00 setanim(var_0A,1,0.05);
			wait(getanimlength(var_0A));
			var_0B = 0.05;
			param_00 setanim(var_0A,0,var_0B);
			wait(var_0B);
		}
		else
		{
			var_0A = param_01 maps\_utility::getanim("irons_reveal_fire_add");
			wait(getanimlength(var_0A));
		}
	}
}

//Function Number: 4
anim_single_with_gameplay(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	foreach(var_07 in param_00)
	{
		if(var_07.animname == "world_body_damaged")
		{
			var_05 = var_07;
		}

		if(var_07.animname == "pistol")
		{
			var_03 = var_07;
		}
	}

	if(1)
	{
		var_04 = maps\_anim::anim_spawn_model(var_05.model,var_05.animname,param_01);
		var_04.animname = var_05.animname;
		var_04 useanimtree(level.scr_animtree[var_04.animname]);
		var_05 hide();
		var_02 = maps\_anim::anim_spawn_model(var_03.model,var_03.animname,param_01);
		var_02.animname = var_03.animname;
		var_02 useanimtree(level.scr_animtree[var_03.animname]);
		var_09 = (11.6,0,3.7);
		var_02 linkto(var_04,"TAG_WEAPON_RIGHT",var_09,(0,0,0));
		var_03 hide();
	}
	else
	{
		var_04 = var_05;
		var_02 = var_03;
	}

	if(0)
	{
		param_00 = common_scripts\utility::array_remove(param_00,var_03);
		var_02 linkto(var_04,"TAG_WEAPON_RIGHT",(0,0,0),(0,0,0));
	}

	thread anim_first_frame_with_finale_gameplay(param_00,param_01,var_04,var_02,var_05,var_03);
	if(1)
	{
		thread maps\_anim::anim_single_solo(var_04,param_01);
	}

	maps\_anim::anim_single(param_00,param_01);
	if(0)
	{
		var_02 unlink();
	}
}

//Function Number: 5
create_pivot(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = spawn("script_origin",(0,0,0));
	var_03.origin = param_00 gettagorigin(param_01);
	if(param_02)
	{
		var_03.angles = param_00 gettagangles(param_01);
	}

	param_00 unlink();
	param_00 linkto(var_03);
	return var_03;
}

//Function Number: 6
set_pivot_pos(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	param_00 unlink();
	param_01.origin = param_00 gettagorigin(param_02);
	if(param_03)
	{
		param_01.angles = param_00 gettagangles(param_02);
	}

	param_00 linkto(param_01);
	return param_01;
}

//Function Number: 7
move_pivot_process(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	param_00 endon("death");
	param_03 endon("death");
	param_01 endon("death");
	set_pivot_pos(param_01,param_00,"J_Shoulder_RI");
	var_09 = param_00.angles;
	var_0A = param_00.origin;
	var_0B = param_01 maps\_utility::getanim(param_05);
	var_0C = param_06 / getanimlength(var_0B);
	var_0D = param_07 / getanimlength(var_0B);
	param_01.return_to_position = 0;
	thread check_on_target_process(param_03,param_04,param_01,param_02,2.5);
	var_0E = (0,0,0);
	var_0F = (0,0,0);
	var_10 = 1;
	for(;;)
	{
		if(param_01.return_to_position)
		{
			var_11 = 0.5;
			param_00 rotateto(var_09,var_11,0.025,0.025);
			var_0E = (0,0,0);
			wait(var_11 * 2);
			param_01.return_to_position = 0;
			break;
		}
		else
		{
			var_12 = 0;
			var_13 = randomfloatrange(0.4,1.2);
			var_14 = level.player getnormalizedcameramovements();
			if(abs(var_14[0]) > 0.01 && abs(var_14[1]) > 0.01)
			{
				var_0E = var_0E - (0,var_14[1] * var_13,var_14[0] * var_13);
				var_12 = 1;
			}

			if(var_12)
			{
				var_15 = var_0E[2];
				var_16 = var_0E[1];
				if(var_16 > 7)
				{
					var_16 = 7;
				}

				if(var_16 < -7)
				{
					var_16 = -7;
				}

				if(var_15 > 4)
				{
					var_15 = 4;
				}

				if(var_15 < -4)
				{
					var_15 = -4;
				}

				var_0E = (var_0E[0],var_16,var_15);
			}

			if(!var_12)
			{
				var_15 = var_0E[2] - 1 * common_scripts\utility::sign(var_0E[2]);
				var_16 = var_0E[1] - 1 * common_scripts\utility::sign(var_0E[1]);
				if(abs(var_15) <= 1)
				{
					var_15 = 0;
				}

				if(abs(var_16) <= 1)
				{
					var_16 = 0;
				}

				var_0E = (var_0E[0],var_16,var_15);
			}

			var_17 = "";
			if(var_12)
			{
				var_18 = undefined;
				var_19 = undefined;
				if(1)
				{
					var_1A = sqrt(squared(var_0E[2]) + squared(var_0E[1]));
					var_1B = undefined;
					if(var_1A > 4)
					{
						var_1B = 1;
					}
					else
					{
						var_1B = var_1A / 4;
					}

					var_1C = gettime() * 0.001 * 10;
					var_19 = var_1B * perlinnoise2d(0,var_1C,2,2,1) * 7;
					var_18 = var_1B * perlinnoise2d(10,var_1C,2,2,1) * 4;
				}
				else if((abs(var_14[1]) > 0.01 && abs(var_14[1]) < 0.5) || abs(var_14[0]) > 0.01 && abs(var_14[0]) < 0.5)
				{
					var_1C = gettime() * 0.001 * 10;
					var_19 = perlinnoise2d(0,var_1C,2,2,1) * 7;
					var_18 = perlinnoise2d(10,var_1C,2,2,1) * 4;
					var_18 = var_18 * abs(var_14[0]) + 0.2;
					var_19 = var_19 * abs(var_14[1]) + 0.2;
				}

				var_0E = (var_0E[0],var_0E[1] + var_18,var_0E[2] + var_19);
			}

			var_1D = param_01 getanimtime(var_0B);
			if(var_1D >= var_0C)
			{
				var_10 = 1 - var_1D - var_0C / var_0D;
				if(var_10 < 0)
				{
					var_10 = 0;
				}

				level.player notify("end_fake_shooting");
			}

			var_0F = combineangles(var_09,var_0E);
			var_0F = angles_clamp_180(var_0F);
			var_1E = var_09 * 1 - var_10 + var_0F * var_10;
			param_00 rotateto(var_1E,0.05,0.025,0.025);
			if(var_10 == 0)
			{
				break;
			}
		}

		wait 0.05;
		var_1F = 0;
	}

	wait 0.05;
	param_01.angles = param_08.angles;
	param_01.origin = param_08.origin;
}

//Function Number: 8
angles_clamp_180(param_00)
{
	return (angleclamp180(param_00[0]),angleclamp180(param_00[1]),angleclamp180(param_00[2]));
}

//Function Number: 9
check_on_target_process(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_02 endon("death");
	var_05 = 1;
	for(;;)
	{
		var_06 = getdvarfloat("cg_fov");
		var_07 = 0;
		var_08 = param_00 gettagorigin(param_01);
		var_09 = param_02 gettagorigin(param_03);
		var_0A = var_08 + anglestoright(level.player getplayerangles()) * param_04;
		if(var_05)
		{
			var_0B = level.player worldpointtoscreenpos(var_08,var_06);
			var_0C = level.player worldpointtoscreenpos(var_09,var_06);
			var_0D = level.player worldpointtoscreenpos(var_0A,var_06);
			if(isdefined(var_0B) && isdefined(var_0C) && isdefined(var_0D))
			{
				var_0E = distance2dsquared((var_0B[0],var_0B[1],0),(var_0C[0],var_0C[1],0));
				var_0F = distance2dsquared((var_0B[0],var_0B[1],0),(var_0D[0],var_0D[1],0));
				if(var_0E < var_0F)
				{
					var_07 = 1;
				}
			}
		}
		else
		{
			var_0E = distancesquared(var_09,var_08);
			if(var_0E < squared(param_04))
			{
				var_07 = 1;
			}
		}

		if(level.player buttonpressed("BUTTON_LTRIG") || level.player buttonpressed("BUTTON_X"))
		{
			if(var_07)
			{
				param_02.return_to_position = 1;
				return;
			}
		}

		wait 0.05;
	}
}

//Function Number: 10
player_input_ending_aim_button_off()
{
	var_00 = level.player getnormalizedcameramovements();
	if(isdefined(var_00) && length2d(var_00) > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
player_input_ending_shoot_button_off()
{
	if(isdefined(level.player.finale_trigger_pulled) && level.player.finale_trigger_pulled)
	{
		return 1;
	}

	return 0;
}