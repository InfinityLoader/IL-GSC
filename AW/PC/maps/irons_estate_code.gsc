/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 1264 ms
 * Timestamp: 4/22/2024 2:31:52 AM
*******************************************************************/

//Function Number: 1
spawn_player_checkpoint()
{
	var_00 = level.start_point + "_start";
	var_01 = common_scripts\utility::getstruct(var_00,"targetname");
	if(isdefined(var_01))
	{
		level.player setorigin(var_01.origin);
		if(isdefined(var_01.angles))
		{
			level.player setplayerangles(var_01.angles);
		}
		else
		{
			iprintlnbold("Your script_struct " + level.start_point + "_start has no angles! Set some.");
		}
	}
	else
	{
	}

	level.player maps\irons_estate_stealth::irons_estate_stealth_custom();
}

//Function Number: 2
spawn_allies()
{
	level.allies = [];
	if(level.start_point_scripted == "briefing")
	{
		level.allies[0] = spawn_ally("cormack_briefing");
		level.allies[0].animname = "cormack";
		level.allies[0] thread set_helmet_open();
		level.allies[1] = spawn_ally("ilana_briefing");
		level.allies[1].animname = "ilana";
		level.allies[2] = spawn_ally("knox_briefing");
		level.allies[2].animname = "knox";
		level.allies[2] thread set_helmet_open();
		return;
	}

	if(level.start_point_scripted == "intro" || level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" || level.start_point_scripted == "intel" || level.start_point_scripted == "infil_hangar" || level.start_point_scripted == "hangar" || level.start_point_scripted == "plant_tracker")
	{
		level.allies[0] = spawn_ally("cormack");
		level.allies[0].animname = "cormack";
		level.allies[0] thread set_helmet_open();
	}

	if(level.start_point_scripted == "intro" || level.start_point_scripted == "grapple" || level.start_point_scripted == "recon")
	{
		level.allies[1] = spawn_ally("ilana");
		level.allies[1].animname = "ilana";
	}

	if(level.start_point_scripted == "intro" || level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" || level.start_point_scripted == "infil")
	{
		level.allies[2] = spawn_ally("knox");
		level.allies[2].animname = "knox";
		level.allies[2] thread set_helmet_open();
	}
}

//Function Number: 3
spawn_ally(param_00,param_01)
{
	var_02 = undefined;
	if(!isdefined(param_01))
	{
		var_02 = level.start_point_scripted + "_" + param_00;
	}
	else
	{
		var_02 = param_01 + "_" + param_00;
	}

	var_03 = spawn_targetname_at_struct_targetname(param_00,var_02);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03 maps\_utility::make_hero();
	if(!isdefined(var_03.magic_bullet_shield))
	{
		var_03 maps\_utility::magic_bullet_shield();
	}

	var_03.grenadeammo = 0;
	var_03 pushplayer(1);
	var_03 pathabilityadd("grapple");
	return var_03;
}

//Function Number: 4
helmet_open(param_00)
{
	param_00 thread set_helmet_open();
}

//Function Number: 5
helmet_close(param_00)
{
	param_00 thread set_helmet_closed();
}

//Function Number: 6
set_helmet_open(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	self setanimknobrestart(%sentinel_halo_helmet_open,1,param_00);
	self.helmet_open = 1;
}

//Function Number: 7
set_helmet_closed(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	self setanimrestart(%sentinel_halo_helmet_close,1,param_00);
	self.helmet_open = 0;
}

//Function Number: 8
clear_additive_helmet_anim(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	self clearanim(%s1_halo_helmet,0);
}

//Function Number: 9
spawn_targetname_at_struct_targetname(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = common_scripts\utility::getstruct(param_01,"targetname");
	if(isdefined(var_02) && isdefined(var_03))
	{
		var_02.origin = var_03.origin;
		if(isdefined(var_03.angles))
		{
			var_02.angles = var_03.angles;
		}

		var_04 = var_02 maps\_utility::spawn_ai(1);
		return var_04;
	}

	if(isdefined(var_03))
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		iprintlnbold("Add a script struct called: " + param_01 + " to spawn him in the correct location.");
		var_04 teleport(level.player.origin,level.player.angles);
		return var_04;
	}

	iprintlnbold("failed to spawn " + param_01 + " at " + var_02);
	return undefined;
}

//Function Number: 10
handle_objective_marker(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 50;
	}

	var_04 = param_00 maps\_shg_utility::hint_button_trigger("x",param_03);
	common_scripts\utility::flag_wait(param_02);
	var_04 maps\_shg_utility::hint_button_clear();
}

//Function Number: 11
irons_estate_trigger_saves(param_00,param_01)
{
	level endon(param_00);
	common_scripts\utility::flag_wait(param_01);
	maps\_utility::autosave_stealth();
}

//Function Number: 12
corpse_cleanup()
{
	wait 0.05;
	var_00 = getcorpsearray();
	foreach(var_02 in var_00)
	{
		if(distancesquared(var_02.origin,level.player.origin) > 4000000)
		{
			var_02 delete();
		}
	}
}

//Function Number: 13
temp_dialogue(param_00,param_01,param_02)
{
	level notify("temp_dialogue",param_00,param_01,param_02);
	level endon("temp_dialogue");
	if(!isdefined(param_02))
	{
		param_02 = 4;
	}

	if(isdefined(level.tmp_subtitle))
	{
		level.tmp_subtitle destroy();
		level.tmp_subtitle = undefined;
	}

	level.tmp_subtitle = newhudelem();
	level.tmp_subtitle.x = 0;
	level.tmp_subtitle.y = -90;
	level.tmp_subtitle settext("^2" + param_00 + ": ^7" + param_01);
	level.tmp_subtitle.fontscale = 1.46;
	level.tmp_subtitle.alignx = "center";
	level.tmp_subtitle.aligny = "middle";
	level.tmp_subtitle.horzalign = "center";
	level.tmp_subtitle.vertalign = "bottom";
	level.tmp_subtitle.sort = 1;
	wait(param_02);
	thread temp_dialogue_fade();
}

//Function Number: 14
temp_dialogue_fade()
{
	level endon("temp_dialogue");
	var_00 = 1;
	while(var_00 > 0)
	{
		level.tmp_subtitle.alpha = var_00;
		wait(0.05);
		var_00 = var_00 - 0.1;
	}

	level.tmp_subtitle destroy();
}

//Function Number: 15
generic_enemy_vo_chatter(param_00)
{
	level endon(param_00);
	var_01 = [];
	var_01[0] = "ie_as1_sectorclear1";
	var_01[1] = "ie_as2_zeroactivity1";
	var_01[2] = "ie_as3_shiftchange";
	var_01[3] = "ie_as1_whatssitrep1";
	var_01[4] = "ie_as2_headingthere";
	var_01[5] = "ie_as3_barnesisoff";
	var_01[6] = "ie_as1_deltacheckingin";
	var_01[7] = "ie_as2_rodgersonhisway";
	var_01[8] = "ie_as3_statusgreen";
	var_01[9] = "ie_as1_sendingescort";
	var_01[10] = "ie_as2_rendesvousin10";
	var_01[11] = "ie_as1_cough1";
	var_01[12] = "ie_as1_cough2";
	var_01[13] = "ie_as1_throat1";
	var_01[14] = "ie_as1_throat2";
	var_01[15] = "ie_as2_cough1";
	var_01[16] = "ie_as2_cough2";
	var_01[17] = "ie_as2_throat1";
	var_01[18] = "ie_as2_throat2";
	var_01[19] = "ie_as3_cough1";
	var_01[20] = "ie_as3_cough2";
	var_01[21] = "ie_as3_throat1";
	var_01[22] = "ie_as3_throat2";
	level.enemy_vo_array_one_off = [];
	var_01[23] = "ie_as1_eastlawn";
	level.enemy_vo_array_one_off[0] = var_01[23];
	var_01[24] = "ie_as2_allsquiet";
	level.enemy_vo_array_one_off[1] = var_01[24];
	var_01[25] = "ie_as3_aircraft";
	level.enemy_vo_array_one_off[2] = var_01[25];
	var_01[26] = "ie_as1_partguests";
	level.enemy_vo_array_one_off[3] = var_01[26];
	level.enemy_vo_array_conversation_1 = [];
	level.enemy_vo_array_conversation_2 = [];
	var_01[27] = "ie_as3_stausofparty";
	level.enemy_vo_array_conversation_1[0] = var_01[27];
	level.enemy_vo_array_conversation_2[0] = "ie_as1_behaving";
	var_01[28] = "ie_as2_droneglitching";
	level.enemy_vo_array_conversation_1[1] = var_01[28];
	level.enemy_vo_array_conversation_2[1] = "ie_as1_onhisway";
	var_01[29] = "ie_as1_ironsassistant";
	level.enemy_vo_array_conversation_1[2] = var_01[29];
	level.enemy_vo_array_conversation_2[2] = "ie_as3_expectingher";
	var_01[30] = "ie_as3_southwestgate";
	level.enemy_vo_array_conversation_1[3] = var_01[30];
	level.enemy_vo_array_conversation_2[3] = "ie_as1_allclear1";
	var_02 = -1;
	var_03 = undefined;
	for(;;)
	{
		wait(0.05);
		var_04 = getaiarray("axis");
		foreach(var_06 in var_04)
		{
			if(isdefined(var_06.stop_generic_vo_chatter))
			{
				var_06 = common_scripts\utility::array_remove(var_04,var_06);
			}
		}

		var_04 = maps\_utility::remove_dead_from_array(var_04);
		if(var_04.size == 0)
		{
			return;
		}

		var_06 = maps\_utility::get_closest_living(level.player.origin,var_04);
		if(!isdefined(var_06.vo_chatter_death))
		{
			var_06 endon("death");
			var_06.vo_chatter_death = 1;
		}

		if(distancesquared(var_06.origin,level.player.origin) > 360000)
		{
			continue;
		}

		if(isdefined(level.last_enemy_chatter_vo))
		{
			var_08 = gettime() - level.last_enemy_chatter_vo;
			if(var_08 < 15000)
			{
				continue;
			}
		}

		if(common_scripts\utility::flag("_stealth_spotted"))
		{
			continue;
		}

		if(isdefined(var_06.alerted))
		{
			var_06.last_alert_time = gettime();
			continue;
		}

		if(var_06.alertlevel == "alert" || isdefined(var_06.event_type))
		{
			var_06.last_alert_time = gettime();
			continue;
		}

		if(var_06.alertlevel == "noncombat" || !isdefined(var_06.event_type || !isdefined(var_06.alerted)))
		{
			if(isdefined(var_06.last_alert_time))
			{
				var_08 = gettime() - var_06.last_alert_time;
				if(var_08 < 15000)
				{
					continue;
				}
			}
		}

		if(isdefined(var_06.isbeinggrappled))
		{
			continue;
		}

		var_09 = randomint(var_01.size);
		if(var_09 == var_02)
		{
			var_09++;
			if(var_09 >= var_01.size)
			{
				var_09 = 0;
			}
		}

		var_0A = var_01[var_09];
		if(!isdefined(var_06.animname))
		{
			var_06.animname = "generic";
		}

		thread check_vo_type(var_0A);
		level waittill("vo_type_defined",var_0B);
		if(var_0B == "one_off")
		{
			var_06 maps\_utility::play_sound_on_entity(var_0A);
			var_01 = common_scripts\utility::array_remove(var_01,var_0A);
		}
		else if(var_0B == "conversation")
		{
			var_06 maps\_utility::play_sound_on_entity(var_0A);
			var_01 = common_scripts\utility::array_remove(var_01,var_0A);
			var_06 maps\_utility::play_sound_on_entity(level.conversation_response);
		}
		else
		{
			var_06.saying_vo = 1;
			var_06 thread stop_generic_enemy_vo_chatter();
			var_06 maps\_utility::smart_dialogue(var_0A);
			var_06.saying_vo = undefined;
		}

		var_02 = var_09;
		var_03 = var_06;
		level.last_enemy_chatter_vo = gettime();
	}
}

//Function Number: 16
stop_generic_enemy_vo_chatter()
{
	self endon("death");
	while(isdefined(self.saying_vo))
	{
		if(isdefined(self.isbeinggrappled) || common_scripts\utility::flag("_stealth_spotted") || isdefined(self.alerted))
		{
			self notify("stop_sound");
			self stopsounds();
			break;
		}

		wait 0.05;
	}
}

//Function Number: 17
check_vo_type(param_00)
{
	wait 0.05;
	if(common_scripts\utility::array_contains(level.enemy_vo_array_one_off,param_00))
	{
		var_01 = "one_off";
		level notify("vo_type_defined",var_01);
		return;
	}

	if(common_scripts\utility::array_contains(level.enemy_vo_array_conversation_1,var_01))
	{
		level.conversation_index = undefined;
		level.conversation_response = undefined;
		for(var_02 = 0;var_02 < level.enemy_vo_array_conversation_1.size;var_02++)
		{
			if(level.enemy_vo_array_conversation_1[var_02] == param_00)
			{
				level.conversation_index = var_02;
				break;
			}
		}

		for(var_02 = 0;var_02 < level.enemy_vo_array_conversation_2.size;var_02++)
		{
			if(var_02 == level.conversation_index)
			{
				level.conversation_response = level.enemy_vo_array_conversation_2[var_02];
				break;
			}
		}

		var_01 = "conversation";
		level notify("vo_type_defined",var_01);
		return;
	}

	var_01 = "normal";
	level notify("vo_type_defined",var_01);
}

//Function Number: 18
enemy_callout_vo_setup(param_00)
{
	level.enemy_left = [];
	level.enemy_left[0] = spawnstruct();
	level.enemy_left[0].vo = "ie_" + param_00 + "_tangoleft1";
	level.enemy_left[0].vo_priority = 1;
	level.enemy_left[1] = spawnstruct();
	level.enemy_left[1].vo = "ie_" + param_00 + "_targetleft1";
	level.enemy_left[1].vo_priority = 1;
	level.civilian_left = [];
	level.civilian_left[0] = spawnstruct();
	level.civilian_left[0].vo = "ie_" + param_00 + "_civleft";
	level.civilian_left[0].vo_priority = 1;
	level.enemies_left[0] = spawnstruct();
	level.enemies_left[0].vo = "ie_" + param_00 + "_tangosleft1";
	level.enemies_left[0].vo_priority = 1;
	level.enemies_left[1] = spawnstruct();
	level.enemies_left[1].vo = "ie_" + param_00 + "_targetsleft1";
	level.enemies_left[1].vo_priority = 1;
	level.civilians_left = [];
	level.civilians_left[0] = spawnstruct();
	level.civilians_left[0].vo = "ie_" + param_00 + "_civsleft";
	level.civilians_left[0].vo_priority = 1;
	level.enemy_right = [];
	level.enemy_right[0] = spawnstruct();
	level.enemy_right[0].vo = "ie_" + param_00 + "_tangoright1";
	level.enemy_right[0].vo_priority = 1;
	level.enemy_right[1] = spawnstruct();
	level.enemy_right[1].vo = "ie_" + param_00 + "_targetright1";
	level.enemy_right[1].vo_priority = 1;
	level.civilian_right = [];
	level.civilian_right[0] = spawnstruct();
	level.civilian_right[0].vo = "ie_" + param_00 + "_civright";
	level.civilian_right[0].vo_priority = 1;
	level.enemies_right[0] = spawnstruct();
	level.enemies_right[0].vo = "ie_" + param_00 + "_tangosright1";
	level.enemies_right[0].vo_priority = 1;
	level.enemies_right[1] = spawnstruct();
	level.enemies_right[1].vo = "ie_" + param_00 + "_targetsright1";
	level.enemies_right[1].vo_priority = 1;
	level.civilians_right = [];
	level.civilians_right[0] = spawnstruct();
	level.civilians_right[0].vo = "ie_" + param_00 + "_civsright";
	level.civilians_right[0].vo_priority = 1;
	level.enemy_below = [];
	level.enemy_below[0] = spawnstruct();
	level.enemy_below[0].vo = "ie_" + param_00 + "_tangobelow1";
	level.enemy_below[0].vo_priority = 1;
	level.enemy_below[1] = spawnstruct();
	level.enemy_below[1].vo = "ie_" + param_00 + "_hostilebelow1";
	level.enemy_below[1].vo_priority = 1;
	level.civilian_below = [];
	level.civilian_below[0] = spawnstruct();
	level.civilian_below[0].vo = "ie_" + param_00 + "_civbelow";
	level.civilian_below[0].vo_priority = 1;
	level.enemies_below = [];
	level.enemies_below[0] = spawnstruct();
	level.enemies_below[0].vo = "ie_" + param_00 + "_tangosbelow1";
	level.enemies_below[0].vo_priority = 1;
	level.enemies_below[1] = spawnstruct();
	level.enemies_below[1].vo = "ie_" + param_00 + "_hostilesbelow1";
	level.enemies_below[1].vo_priority = 1;
	level.civilians_below = [];
	level.civilians_below[0] = spawnstruct();
	level.civilians_below[0].vo = "ie_" + param_00 + "_civsbelow";
	level.civilians_below[0].vo_priority = 1;
}

//Function Number: 19
enemy_callout_vo(param_00)
{
	level endon("poolyard_save");
	level endon("bedroom_start");
	enemy_callout_vo_setup(param_00);
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 15;
	var_06 = 10000;
	var_07 = 60;
	var_08 = undefined;
	var_09 = 0;
	for(;;)
	{
		for(;;)
		{
			wait(0.5);
			var_0A = getaiarray("axis");
			level.active_civilians = maps\_utility::remove_dead_from_array(level.active_civilians);
			var_0B = common_scripts\utility::array_combine(level.active_civilians,var_0A);
			var_0C = maps\_utility::get_closest_living(level.player.origin,var_0B,500);
			if(!isdefined(var_0C))
			{
				continue;
			}

			if(var_0C.classname == "actor_enemy_atlas_bodyguard_smg" || var_0C.classname == "actor_enemy_atlas_pmc_estate_smg")
			{
				var_0D = "enemy";
			}
			else
			{
				var_0D = "civilian";
			}

			if(isdefined(var_08) && var_0C == var_08)
			{
				continue;
			}

			if(isdefined(var_0C.isbeinggrappled))
			{
				continue;
			}

			if(!isdefined(level.play_ally_callout_vo))
			{
				continue;
			}

			if(!check_player_in_stop_enemy_callout_vo_volume())
			{
				continue;
			}

			if(level.player.grapple["grappling"] == 1)
			{
				continue;
			}

			if(isdefined(var_0C.alerted))
			{
				continue;
			}

			if(common_scripts\utility::flag("_stealth_spotted"))
			{
				continue;
			}

			if(player_can_see_ai_through_foliage(var_0C) && !isdefined(var_0C.hasbeencalledout))
			{
				var_09++;
				if(var_09 == 2)
				{
					if(var_0D == "enemy")
					{
						var_0C.hasbeencalledout = 1;
						var_0C thread entity_has_been_called_out_timer(var_07);
					}
					else if(isdefined(var_0C.script_aigroup))
					{
						var_0E = maps\_utility::get_ai_group_ai(var_0C.script_aigroup);
						foreach(var_10 in var_0E)
						{
							if(!isdefined(var_10.hasbeencalledout))
							{
								var_10.hasbeencalledout = 1;
								var_10 thread entity_has_been_called_out_timer(var_07);
							}
						}
					}
					else
					{
						var_0C.hasbeencalledout = 1;
						var_0C thread entity_has_been_called_out_timer(var_07);
					}

					var_09 = 0;
				}
				else
				{
					wait(0.5);
					continue;
				}
			}
			else
			{
				var_09 = 0;
			}

			if(isdefined(var_0C.hasbeencalledout))
			{
				continue;
			}

			var_12 = level.player.origin;
			var_13 = level.player.angles;
			var_14 = var_0C.origin;
			var_15 = vectornormalize(var_14 - var_12);
			var_16 = anglestoforward(var_13);
			var_17 = vectordot(var_16,var_15);
			var_18 = gettime();
			if(var_17 >= 0.77)
			{
				if(var_18 > var_01 + var_06)
				{
					var_19 = level.player.origin[2] - var_0C.origin[2];
					if(var_19 > 100)
					{
						if(var_0C.origin[2] > level.player.origin[2])
						{
							continue;
						}
						else
						{
							if(isdefined(var_0C.no_below_vo))
							{
								continue;
							}

							if(var_0D == "enemy")
							{
								var_1A = [];
								var_1A = common_scripts\utility::array_combine(var_1A,var_0A);
								var_1A = common_scripts\utility::array_remove(var_1A,var_0C);
								var_1B = level.enemy_below;
								var_1C = level.enemies_below;
							}
							else
							{
								var_20 = [];
								var_20 = common_scripts\utility::array_combine(var_20,level.active_civilians);
								var_20 = common_scripts\utility::array_remove(var_20,var_12);
								var_1B = level.civilian_below;
								var_1C = level.civilians_below;
							}

							var_1D = maps\_utility::get_closest_living(var_0C.origin,var_1A,500);
							if(isdefined(var_1D))
							{
								if(var_0D == "enemy")
								{
									var_1D.hasbeencalledout = 1;
									var_1D thread entity_has_been_called_out_timer(var_07);
								}
								else if(isdefined(var_0C.script_aigroup))
								{
									var_0E = maps\_utility::get_ai_group_ai(var_0C.script_aigroup);
									foreach(var_10 in var_0E)
									{
										if(!isdefined(var_10.hasbeencalledout))
										{
											var_10.hasbeencalledout = 1;
											var_10 thread entity_has_been_called_out_timer(var_07);
										}
									}
								}
								else
								{
									var_1D.hasbeencalledout = 1;
									var_1D thread entity_has_been_called_out_timer(var_07);
								}

								var_20 = var_1C[randomint(var_1C.size)];
							}
							else
							{
								var_20 = var_1B[randomint(var_1B.size)];
							}

							thread ally_vo_controller(var_20);
							var_0C.hasbeencalledout = 1;
							var_0C thread entity_has_been_called_out_timer(var_07);
						}
					}
					else
					{
						continue;
					}

					var_01 = var_18;
					wait(var_05);
					var_08 = var_0C;
					break;
				}
				else
				{
					continue;
				}
			}

			if(var_17 < -0.77)
			{
				continue;
			}

			var_21 = anglestoright(var_13);
			var_22 = vectordot(var_21,var_15);
			if(var_22 < 0)
			{
				if(var_18 > var_02 + var_06)
				{
					var_19 = level.player.origin[2] - var_0C.origin[2];
					if(var_19 > 100)
					{
						continue;
					}
					else
					{
						var_23 = level.player geteye();
						var_24 = var_0C gettagorigin("tag_eye");
						var_25 = bullettrace(var_23,var_24,1,level.player);
						var_26 = var_25["entity"];
						var_27 = isdefined(var_26) && var_26 == var_0C;
						if(var_27)
						{
							if(var_0D == "enemy")
							{
								var_1A = [];
								var_1A = common_scripts\utility::array_combine(var_1A,var_0A);
								var_1A = common_scripts\utility::array_remove(var_1A,var_0C);
								var_28 = level.enemy_left;
								var_29 = level.enemies_left;
							}
							else
							{
								var_20 = [];
								var_20 = common_scripts\utility::array_combine(var_20,level.active_civilians);
								var_20 = common_scripts\utility::array_remove(var_20,var_12);
								var_28 = level.civilian_left;
								var_29 = level.civilians_left;
							}

							var_1D = maps\_utility::get_closest_living(var_0C.origin,var_1A,500);
							if(isdefined(var_1D))
							{
								if(var_0D == "enemy")
								{
									var_1D.hasbeencalledout = 1;
									var_1D thread entity_has_been_called_out_timer(var_07);
								}
								else if(isdefined(var_0C.script_aigroup))
								{
									var_0E = maps\_utility::get_ai_group_ai(var_0C.script_aigroup);
									foreach(var_10 in var_0E)
									{
										if(!isdefined(var_10.hasbeencalledout))
										{
											var_10.hasbeencalledout = 1;
											var_10 thread entity_has_been_called_out_timer(var_07);
										}
									}
								}
								else
								{
									var_1D.hasbeencalledout = 1;
									var_1D thread entity_has_been_called_out_timer(var_07);
								}

								var_20 = var_29[randomint(var_29.size)];
							}
							else
							{
								var_20 = var_28[randomint(var_28.size)];
							}

							thread ally_vo_controller(var_20);
							if(!isdefined(var_0C.hasbeencalledout))
							{
								var_0C.hasbeencalledout = 1;
								var_0C thread entity_has_been_called_out_timer(var_07);
							}

							var_02 = var_18;
							wait(var_05);
							var_08 = var_0C;
							break;
						}
						else
						{
							continue;
						}
					}
				}
				else
				{
					continue;
				}

				continue;
			}

			if(var_18 > var_03 + var_06)
			{
				var_19 = level.player.origin[2] - var_0C.origin[2];
				if(var_19 > 100)
				{
					continue;
				}
				else
				{
					var_23 = level.player geteye();
					var_24 = var_0C gettagorigin("tag_eye");
					var_25 = bullettrace(var_23,var_24,1,level.player);
					var_26 = var_25["entity"];
					var_27 = isdefined(var_26) && var_26 == var_0C;
					if(var_27)
					{
						if(var_0D == "enemy")
						{
							var_1A = [];
							var_1A = common_scripts\utility::array_combine(var_1A,var_0A);
							var_1A = common_scripts\utility::array_remove(var_1A,var_0C);
							var_2C = level.enemy_right;
							var_2D = level.enemies_right;
						}
						else
						{
							var_20 = [];
							var_20 = common_scripts\utility::array_combine(var_20,level.active_civilians);
							var_20 = common_scripts\utility::array_remove(var_20,var_12);
							var_2C = level.civilian_right;
							var_2D = level.civilians_right;
						}

						var_1D = maps\_utility::get_closest_living(var_0C.origin,var_1A,500);
						if(isdefined(var_1D))
						{
							if(var_0D == "enemy")
							{
								var_1D.hasbeencalledout = 1;
								var_1D thread entity_has_been_called_out_timer(var_07);
							}
							else if(isdefined(var_0C.script_aigroup))
							{
								var_0E = maps\_utility::get_ai_group_ai(var_0C.script_aigroup);
								foreach(var_10 in var_0E)
								{
									if(!isdefined(var_10.hasbeencalledout))
									{
										var_10.hasbeencalledout = 1;
										var_10 thread entity_has_been_called_out_timer(var_07);
									}
								}
							}
							else
							{
								var_1D.hasbeencalledout = 1;
								var_1D thread entity_has_been_called_out_timer(var_07);
							}

							var_20 = var_2D[randomint(var_2D.size)];
						}
						else
						{
							var_20 = var_2C[randomint(var_2C.size)];
						}

						thread ally_vo_controller(var_20);
						if(!isdefined(var_0C.hasbeencalledout))
						{
							var_0C.hasbeencalledout = 1;
							var_0C thread entity_has_been_called_out_timer(var_07);
						}

						var_03 = var_18;
						wait(var_05);
						var_08 = var_0C;
						break;
					}
					else
					{
						continue;
					}
				}

				continue;
			}

			continue;
		}
	}
}

//Function Number: 20
entity_has_been_called_out_timer(param_00)
{
	self endon("death");
	wait(param_00);
	self.hasbeencalledout = undefined;
}

//Function Number: 21
player_can_see_ai_through_foliage(param_00,param_01)
{
	var_02 = gettime();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00.playerseesmetime) && param_00.playerseesmetime + param_01 >= var_02)
	{
		return param_00.playerseesme;
	}

	param_00.playerseesmetime = var_02;
	if(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,param_00.origin,0.766))
	{
		param_00.playerseesme = 0;
		return 0;
	}

	var_03 = level.player geteye();
	var_04 = param_00.origin;
	if(sighttracepassed(var_03,var_04,1,level.player,param_00,0))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	var_05 = param_00 geteye();
	if(sighttracepassed(var_03,var_05,1,level.player,param_00,0))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	var_06 = var_05 + var_04 * 0.5;
	if(sighttracepassed(var_03,var_06,1,level.player,param_00,0))
	{
		param_00.playerseesme = 1;
		return 1;
	}

	param_00.playerseesme = 0;
	return 0;
}

//Function Number: 22
check_player_in_stop_enemy_callout_vo_volume()
{
	var_00 = getentarray("stop_enemy_callout_vo","targetname");
	foreach(var_02 in var_00)
	{
		if(level.player istouching(var_02))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 23
clean_kill_vo_setup(param_00)
{
	level.clean_kill_vo = [];
	level.sloppy_kill_vo = [];
	if(param_00 == "iln")
	{
		level.clean_kill_vo[0] = spawnstruct();
		level.clean_kill_vo[0].vo = "ie_iln_goodkill1";
		level.clean_kill_vo[0].vo_priority = 2;
		level.clean_kill_vo[1] = spawnstruct();
		level.clean_kill_vo[1].vo = "ie_iln_cleankill1";
		level.clean_kill_vo[1].vo_priority = 2;
		level.sloppy_kill_vo[0] = spawnstruct();
		level.sloppy_kill_vo[0].vo = "ie_iln_close3";
		level.sloppy_kill_vo[0].vo_priority = 2;
		level.sloppy_kill_vo[1] = spawnstruct();
		level.sloppy_kill_vo[1].vo = "ie_iln_goodsave";
		level.sloppy_kill_vo[1].vo_priority = 2;
		return;
	}

	level.clean_kill_vo[0] = spawnstruct();
	level.clean_kill_vo[0].vo = "ie_nox_cleankill2";
	level.clean_kill_vo[0].vo_priority = 2;
	level.clean_kill_vo[1] = spawnstruct();
	level.clean_kill_vo[1].vo = "ie_nox_gooddrop";
	level.clean_kill_vo[1].vo_priority = 2;
	level.sloppy_kill_vo[0] = spawnstruct();
	level.sloppy_kill_vo[0].vo = "ie_nox_closeone2";
	level.sloppy_kill_vo[0].vo_priority = 2;
	level.sloppy_kill_vo[1] = spawnstruct();
	level.sloppy_kill_vo[1].vo = "ie_nox_nicecleanup";
	level.sloppy_kill_vo[1].vo_priority = 2;
}

//Function Number: 24
clean_kill_vo(param_00)
{
	level endon("emp_detonated");
	level endon("bedroom_end");
	clean_kill_vo_setup(param_00);
	var_01 = 20;
	for(;;)
	{
		common_scripts\utility::flag_wait_either("clean_kill","sloppy_kill");
		if(common_scripts\utility::flag("clean_kill"))
		{
			if(isdefined(level.clean_kill_vo))
			{
				var_02 = common_scripts\utility::random(level.clean_kill_vo);
				thread ally_vo_controller(var_02);
			}
		}
		else if(isdefined(level.sloppy_kill_vo))
		{
			var_02 = common_scripts\utility::random(level.sloppy_kill_vo);
			thread ally_vo_controller(var_02);
		}

		wait(var_01);
		common_scripts\utility::flag_clear("clean_kill");
		common_scripts\utility::flag_clear("sloppy_kill");
		wait 0.05;
	}
}

//Function Number: 25
watch_for_death()
{
	self waittill("death",var_00);
	if(isdefined(self) && isdefined(var_00))
	{
		var_01 = self geteye();
		var_02 = getaiarray("axis","neutral");
		var_02 = common_scripts\utility::get_array_of_closest(var_01,var_02,undefined,undefined,500,undefined);
		foreach(var_04 in var_02)
		{
			if(var_04.ignoreall)
			{
				continue;
			}

			if(var_04.team == "neutral" && !var_04 maps\irons_estate_stealth::witness_kill_valid(var_01))
			{
				continue;
			}

			var_04 notify("witness_kill",var_01);
		}
	}

	if((isdefined(self.script_parameters) && self.script_parameters == "exposed_group") || isdefined(self.script_noteworthy) && self.script_noteworthy == "exposed_group")
	{
		var_06 = maps\_stealth_shared_utilities::group_get_ai_in_group(self.script_stealthgroup);
		foreach(var_08 in var_06)
		{
			if(isdefined(var_08.script_parameters) && var_08.script_parameters == "exposed_group")
			{
				var_08.script_parameters = undefined;
			}
			else if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "exposed_group")
			{
				var_08.script_noteworthy = undefined;
			}

			var_08.was_in_exposed_group = 1;
		}

		if(!common_scripts\utility::flag("HINT_DECOY_STOP"))
		{
			common_scripts\utility::flag_set("HINT_DECOY_STOP");
			var_0A = undefined;
		}
	}

	if((isdefined(var_00) && var_00 == level.player) || isdefined(self.isbeinggrappled))
	{
		level.death_counter++;
		if(isdefined(self.was_in_exposed_group))
		{
			return;
		}

		wait(1);
		if(!common_scripts\utility::flag("someone_became_alert") && !common_scripts\utility::flag("_stealth_spotted") && check_enemies_for_alert() && !common_scripts\utility::flag("drones_investigating"))
		{
			if(isdefined(level.play_ally_callout_vo))
			{
				if(!common_scripts\utility::flag("clean_kill"))
				{
					common_scripts\utility::flag_set("clean_kill");
					return;
				}

				return;
			}

			return;
		}

		if((common_scripts\utility::flag("someone_became_alert") || common_scripts\utility::flag("_stealth_spotted")) && check_enemies_for_alert() && !common_scripts\utility::flag("drones_investigating"))
		{
			if(isdefined(level.play_ally_callout_vo))
			{
				if(!common_scripts\utility::flag("sloppy_kill"))
				{
					common_scripts\utility::flag_set("sloppy_kill");
					return;
				}

				return;
			}

			return;
		}
	}
}

//Function Number: 26
check_enemies_for_alert()
{
	var_00 = getaiarray("axis");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.alerted))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 27
dont_shoot_warning_vo_setup(param_00)
{
	level.drone_warning_vo = [];
	level.civilian_warning_vo = [];
	level.exposed_guard_warning_vo = [];
	if(param_00 == "iln")
	{
		level.drone_warning_vo[0] = spawnstruct();
		level.drone_warning_vo[0].vo = "ie_iln_alertdrones";
		level.drone_warning_vo[0].vo_priority = 2;
		level.drone_warning_vo[1] = spawnstruct();
		level.drone_warning_vo[1].vo = "ie_iln_dontshoot5";
		level.drone_warning_vo[1].vo_priority = 2;
		level.civilian_warning_vo[0] = spawnstruct();
		level.civilian_warning_vo[0].vo = "ie_iln_civiliancasualties";
		level.civilian_warning_vo[0].vo_priority = 2;
		if(level.start_point_scripted == "meet_cormack")
		{
			level.exposed_guard_warning_vo[0] = spawnstruct();
			level.exposed_guard_warning_vo[0].vo = "ie_iln_hesopen";
			level.exposed_guard_warning_vo[0].vo_priority = 2;
			return;
		}

		level.exposed_guard_warning_vo[0] = spawnstruct();
		level.exposed_guard_warning_vo[0].vo = "ie_iln_hesopen";
		level.exposed_guard_warning_vo[0].vo_priority = 2;
		level.exposed_guard_warning_vo[1] = spawnstruct();
		level.exposed_guard_warning_vo[1].vo = "ie_iln_holdfire";
		level.exposed_guard_warning_vo[1].vo_priority = 2;
		level.exposed_guard_warning_vo[2] = spawnstruct();
		level.exposed_guard_warning_vo[2].vo = "ie_iln_dontengage";
		level.exposed_guard_warning_vo[2].vo_priority = 2;
		level.exposed_guard_warning_vo[3] = spawnstruct();
		level.exposed_guard_warning_vo[3].vo = "ie_iln_targetexposed";
		level.exposed_guard_warning_vo[3].vo_priority = 2;
		return;
	}

	level.drone_warning_vo[0] = spawnstruct();
	level.drone_warning_vo[0].vo = "ie_nox_dontengagedrone";
	level.drone_warning_vo[0].vo_priority = 2;
	level.drone_warning_vo[1] = spawnstruct();
	level.drone_warning_vo[1].vo = "ie_nox_avoiddrone";
	level.drone_warning_vo[1].vo_priority = 2;
	level.civilian_warning_vo[0] = spawnstruct();
	level.civilian_warning_vo[0].vo = "ie_nox_civiliancasualties";
	level.civilian_warning_vo[0].vo_priority = 2;
	level.exposed_guard_warning_vo[0] = spawnstruct();
	level.exposed_guard_warning_vo[0].vo = "ie_nox_outinopen";
	level.exposed_guard_warning_vo[0].vo_priority = 2;
}

//Function Number: 28
dont_shoot_warning_vo(param_00,param_01)
{
	level endon("poolyard_save");
	level endon("bedroom_start");
	level endon("meet_cormack_end");
	dont_shoot_warning_vo_setup(param_00);
	for(;;)
	{
		var_02 = !isdefined(level.drone_warning_given) && isdefined(level.civilian_warning_given) && isdefined(level.exposed_guard_warning_given);
		if(var_02)
		{
			level.player childthread dont_shoot_warning_vo_player_thread(param_00);
			level waittill("dont_shoot_vo_warning",var_03);
			if(var_03 == "drone")
			{
				if(!isdefined(level.drone_warning_given))
				{
					var_04 = common_scripts\utility::random(level.drone_warning_vo);
					thread ally_vo_controller(var_04);
					if(!isdefined(param_01))
					{
						level.drone_warning_given = 1;
					}
				}
			}
			else if(var_03 == "guard")
			{
				if(!isdefined(level.exposed_guard_warning_given))
				{
					var_04 = common_scripts\utility::random(level.exposed_guard_warning_vo);
					thread ally_vo_controller(var_04);
					if(!isdefined(param_01))
					{
						level.exposed_guard_warning_given = 1;
					}
				}
			}
			else if(!isdefined(level.civilian_warning_given))
			{
				var_04 = common_scripts\utility::random(level.civilian_warning_vo);
				thread ally_vo_controller(var_04);
				if(!isdefined(param_01))
				{
					level.civilian_warning_given = 1;
				}
			}
		}
		else
		{
			break;
		}

		wait(5);
	}
}

//Function Number: 29
dont_shoot_warning_vo_player_thread(param_00)
{
	self notify("drone_warning_vo_player_thread");
	self endon("drone_warning_vo_player_thread");
	self endon("death");
	for(;;)
	{
		wait 0.05;
		level.active_civilians = maps\_utility::remove_dead_from_array(level.active_civilians);
		if(level.player maps\_utility::isads())
		{
			var_01 = level.player geteye();
			var_02 = anglestoforward(level.player getplayerangles());
			if(!isdefined(level.play_ally_callout_vo))
			{
				continue;
			}

			if(!isdefined(level.play_ally_warning_vo))
			{
				continue;
			}

			if(!check_player_in_stop_enemy_callout_vo_volume())
			{
				continue;
			}

			var_03 = bullettrace(var_01,var_01 + var_02 * 15000,1,level.player);
			var_04 = var_03["entity"];
			var_05 = getaiarray("axis");
			var_05 = maps\_utility::remove_dead_from_array(var_05);
			if(isdefined(level.active_drones))
			{
				var_03 = isdefined(var_04) && common_scripts\utility::array_contains(level.active_drones,var_04) || common_scripts\utility::array_contains(level.active_civilians,var_04) || common_scripts\utility::array_contains(var_05,var_04);
				if(var_03)
				{
					if(var_04.classname == "script_vehicle_pdrone_security")
					{
						var_06 = "drone";
					}
					else if(var_05.classname == "actor_enemy_atlas_bodyguard_smg" || var_05.classname == "actor_enemy_atlas_pmc_estate_smg")
					{
						if((isdefined(var_05.script_parameters) && var_05.script_parameters == "exposed") || isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "exposed")
						{
							var_06 = "guard";
						}
						else
						{
							continue;
						}
					}
					else
					{
						var_06 = "civilian";
					}

					level notify("dont_shoot_vo_warning",var_06);
					return;
				}
			}
		}
	}
}

//Function Number: 30
exposed_group_logic()
{
	level endon("player_on_security_center_rooftop");
	level endon("bedroom_start");
	common_scripts\utility::flag_clear("HINT_DECOY");
	common_scripts\utility::flag_clear("HINT_DECOY_STOP");
	var_00 = undefined;
	var_01 = 0;
	for(;;)
	{
		wait 0.05;
		var_02 = getaiarray("axis");
		var_02 = maps\_utility::remove_dead_from_array(var_02);
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if((isdefined(var_05.script_parameters) && var_05.script_parameters == "exposed_group") || isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "exposed_group")
			{
				var_03 = common_scripts\utility::add_to_array(var_03,var_05);
			}
		}

		if(var_03.size == 0)
		{
			return;
		}

		var_05 = maps\_utility::get_closest_living(level.player.origin,var_03);
		if(!isdefined(var_05))
		{
			continue;
		}

		var_07 = isdefined(level.player.ent_flag["_stealth_in_shadow"]) && level.player.ent_flag["_stealth_in_shadow"];
		var_08 = distancesquared(var_05.origin,level.player.origin) < 490000;
		if(var_07 && var_08)
		{
			var_09 = level.player geteye();
			var_0A = anglestoforward(level.player getplayerangles());
			var_0B = bullettrace(var_09,var_09 + var_0A * 15000,1,level.player);
			var_0C = var_0B["entity"];
			var_0B = isdefined(var_0C) && common_scripts\utility::array_contains(var_03,var_0C);
			if(var_0B)
			{
				var_01 = var_01 + 0.05;
				if(var_01 == 0.5)
				{
					if(!isdefined(var_0C.exposed_vo_said))
					{
						if(!isdefined(level.play_ally_warning_vo) && !check_player_in_stop_enemy_callout_vo_volume())
						{
							var_0D = common_scripts\utility::random(level.exposed_guard_warning_vo);
							thread ally_vo_controller(var_0D);
							var_0E = maps\_stealth_shared_utilities::group_get_ai_in_group(var_0C.script_stealthgroup);
							foreach(var_10 in var_0E)
							{
								var_10.exposed_vo_said = 1;
							}
						}
					}

					if(!isdefined(var_00) && !isdefined(var_0C.whistle_hint_used))
					{
						common_scripts\utility::flag_clear("HINT_DECOY_STOP");
						var_0C thread handle_whistle_hint();
						var_00 = 1;
					}
				}
			}
			else
			{
				var_01 = 0;
				if(isdefined(var_00))
				{
					common_scripts\utility::flag_set("HINT_DECOY_STOP");
					var_00 = undefined;
				}
			}

			continue;
		}

		var_01 = 0;
		if(isdefined(var_00))
		{
			common_scripts\utility::flag_set("HINT_DECOY_STOP");
			var_00 = undefined;
		}
	}
}

//Function Number: 31
handle_whistle_hint()
{
	level endon("HINT_DECOY_STOP");
	common_scripts\utility::flag_clear("HINT_DECOY");
	level.player thread maps\_utility::display_hint_timeout("HINT_DECOY_EXPOSED_GROUP");
	level.player notifyonplayercommand("whistle","+actionslot " + level.action_slot_whistle);
	level.player waittill("whistle");
	common_scripts\utility::flag_set("HINT_DECOY");
	if(isdefined(self.script_stealthgroup))
	{
		var_00 = maps\_stealth_shared_utilities::group_get_ai_in_group(self.script_stealthgroup);
		foreach(var_02 in var_00)
		{
			var_02.whistle_hint_used = 1;
		}
	}
}

//Function Number: 32
enemy_alert_vo_setup(param_00)
{
	level.enemy_alert_vo = [];
	level.enemy_return_to_normal_vo = [];
	if(param_00 == "iln")
	{
		level.enemy_alert_vo[0] = spawnstruct();
		level.enemy_alert_vo[0].vo = "ie_iln_hidemitch2";
		level.enemy_alert_vo[0].vo_priority = 5;
		level.enemy_alert_vo[1] = spawnstruct();
		level.enemy_alert_vo[1].vo = "ie_iln_outofsight2";
		level.enemy_alert_vo[1].vo_priority = 5;
		level.enemy_alert_vo[2] = spawnstruct();
		level.enemy_alert_vo[2].vo = "ie_iln_quickhide";
		level.enemy_alert_vo[2].vo_priority = 5;
		level.enemy_return_to_normal_vo[0] = spawnstruct();
		level.enemy_return_to_normal_vo[0].vo = "ie_iln_allclearmitch";
		level.enemy_return_to_normal_vo[0].vo_priority = 3;
		level.enemy_return_to_normal_vo[1] = spawnstruct();
		level.enemy_return_to_normal_vo[1].vo = "ie_iln_movingback";
		level.enemy_return_to_normal_vo[1].vo_priority = 3;
		level.enemy_return_to_normal_vo[2] = spawnstruct();
		level.enemy_return_to_normal_vo[2].vo = "ie_iln_youreclear";
		level.enemy_return_to_normal_vo[2].vo_priority = 3;
		return;
	}

	level.enemy_alert_vo[0] = spawnstruct();
	level.enemy_alert_vo[0].vo = "ie_nox_hide1";
	level.enemy_alert_vo[0].vo_priority = 5;
	level.enemy_alert_vo[1] = spawnstruct();
	level.enemy_alert_vo[1].vo = "ie_nox_getout1";
	level.enemy_alert_vo[1].vo_priority = 5;
	level.enemy_alert_vo[2] = spawnstruct();
	level.enemy_alert_vo[2].vo = "ie_nox_tangoincoming1";
	level.enemy_alert_vo[2].vo_priority = 5;
	level.enemy_return_to_normal_vo[0] = spawnstruct();
	level.enemy_return_to_normal_vo[0].vo = "ie_nox_youresafe";
	level.enemy_return_to_normal_vo[0].vo_priority = 3;
	level.enemy_return_to_normal_vo[1] = spawnstruct();
	level.enemy_return_to_normal_vo[1].vo = "ie_nox_looksclear";
	level.enemy_return_to_normal_vo[1].vo_priority = 3;
	level.enemy_return_to_normal_vo[2] = spawnstruct();
	level.enemy_return_to_normal_vo[2].vo = "ie_nox_noalerts";
	level.enemy_return_to_normal_vo[2].vo_priority = 3;
}

//Function Number: 33
enemy_alert_vo()
{
	level endon("missionfailed");
	level.player endon("death");
	self endon("death");
	level endon("bedroom_end");
	for(;;)
	{
		maps\_utility::ent_flag_waitopen("_stealth_normal");
		self.alerted = 1;
		wait 0.05;
		if((isdefined(self.event_type) && self.event_type == "whistle" || self.event_type == "reaction_generic") || maps\_utility::ent_flag("_stealth_saw_corpse") || maps\_utility::ent_flag("_stealth_found_corpse"))
		{
			if((maps\_utility::ent_flag("_stealth_saw_corpse") || maps\_utility::ent_flag("_stealth_found_corpse")) && !isdefined(self.alerted_by_corpse))
			{
				self.alerted_by_corpse = 1;
			}

			thread maps\irons_estate_stealth::wait_till_every_thing_stealth_normal_for(3);
		}
		else if(!common_scripts\utility::flag("someone_became_alert"))
		{
			common_scripts\utility::flag_set("someone_became_alert");
			level maps\_utility::add_wait(::maps\irons_estate_stealth::wait_till_every_thing_stealth_normal_for,3);
			level maps\_utility::add_func(::common_scripts\utility::flag_clear,"someone_became_alert");
			thread maps\_utility::do_wait();
			wait(1);
			if(common_scripts\utility::flag("_stealth_spotted"))
			{
				continue;
			}

			if(isdefined(level.enemy_alert_vo))
			{
				var_00 = common_scripts\utility::random(level.enemy_alert_vo);
				thread ally_vo_controller(var_00);
			}
		}

		maps\_utility::ent_flag_wait("_stealth_normal");
		if(isdefined(self.isbeinggrappled))
		{
			continue;
		}

		self.alerted = undefined;
		if(common_scripts\utility::flag("drones_investigating"))
		{
			continue;
		}

		if(common_scripts\utility::flag("_stealth_spotted"))
		{
			continue;
		}

		if(isdefined(self.alerted_by_corpse))
		{
			maps\_utility::ent_flag_waitopen("_stealth_saw_corpse");
			maps\_utility::ent_flag_waitopen("_stealth_found_corpse");
			self.alerted_by_corpse = undefined;
			continue;
		}

		if(distancesquared(level.player.origin,self.origin) < 250000)
		{
			if(isdefined(level.enemy_return_to_normal_vo))
			{
				var_00 = common_scripts\utility::random(level.enemy_return_to_normal_vo);
				thread ally_vo_controller(var_00);
			}
		}
	}
}

//Function Number: 34
drone_incoming_vo_setup(param_00)
{
	level.drones_sent_vo = [];
	if(param_00 == "iln")
	{
		level.drones_sent_vo[0] = spawnstruct();
		level.drones_sent_vo[0].vo = "ie_iln_sendingindrones";
		level.drones_sent_vo[0].vo_priority = 3;
		level.drones_sent_vo[1] = spawnstruct();
		level.drones_sent_vo[1].vo = "ie_iln_droneincoming";
		level.drones_sent_vo[1].vo_priority = 3;
		level.drones_sent_vo[2] = spawnstruct();
		level.drones_sent_vo[2].vo = "ie_iln_droneontheway";
		level.drones_sent_vo[2].vo_priority = 3;
		return;
	}

	level.drones_sent_vo[0] = spawnstruct();
	level.drones_sent_vo[0].vo = "ie_nox_sendingindrones";
	level.drones_sent_vo[0].vo_priority = 3;
	level.drones_sent_vo[1] = spawnstruct();
	level.drones_sent_vo[1].vo = "ie_nox_droneincoming";
	level.drones_sent_vo[1].vo_priority = 3;
	level.drones_sent_vo[2] = spawnstruct();
	level.drones_sent_vo[2].vo = "ie_nox_droneontheway";
	level.drones_sent_vo[2].vo_priority = 3;
}

//Function Number: 35
drone_incoming_vo(param_00)
{
	level endon("emp_detonated");
	level endon("bedroom_end");
	drone_incoming_vo_setup(param_00);
	while(!common_scripts\utility::flag("mission_failing"))
	{
		common_scripts\utility::flag_wait("drones_investigating");
		if(!isdefined(level.drone_investigating_has_happened_once))
		{
			level.drone_investigating_has_happened_once = 1;
		}

		if(common_scripts\utility::flag("drone_investigate_triggered"))
		{
			var_01 = [];
			var_01[0] = level.drones_sent_vo[1];
			var_01[1] = level.drones_sent_vo[2];
			var_02 = common_scripts\utility::random(var_01);
		}
		else
		{
			var_02 = common_scripts\utility::random(level.drones_sent_vo);
		}

		thread ally_vo_controller(var_02);
		common_scripts\utility::flag_waitopen("drones_investigating");
		wait 0.05;
	}
}

//Function Number: 36
failed_vo_setup(param_00)
{
	level.failed_vo = [];
	if(param_00 == "iln")
	{
		level.failed_vo[0] = spawnstruct();
		level.failed_vo[0].vo = "ie_iln_abortmission";
		level.failed_vo[0].vo_priority = 6;
		level.failed_vo[1] = spawnstruct();
		level.failed_vo[1].vo = "ie_iln_alertedthem1";
		level.failed_vo[1].vo_priority = 6;
		return;
	}

	level.failed_vo[0] = spawnstruct();
	level.failed_vo[0].vo = "ie_nox_compromised1";
	level.failed_vo[0].vo_priority = 6;
	level.failed_vo[1] = spawnstruct();
	level.failed_vo[1].vo = "ie_nox_ontous1";
	level.failed_vo[1].vo_priority = 6;
}

//Function Number: 37
failed_vo(param_00)
{
	level.player endon("death");
	level endon("emp_detonated");
	level endon("bedroom_end");
	failed_vo_setup(param_00);
	common_scripts\utility::flag_wait("mission_failing");
	level.failed_vo = common_scripts\utility::array_randomize(level.failed_vo);
	var_01 = level.failed_vo[0];
	thread ally_vo_controller(var_01);
}

//Function Number: 38
ally_vo_controller(param_00)
{
	level.player endon("death");
	level endon("bedroom_end");
	if(isdefined(level.play_ally_warning_vo) && level.play_ally_warning_vo == 1)
	{
		if(isdefined(level.current_vo) && isdefined(param_00.vo_priority) && param_00.vo_priority > level.current_vo.vo_priority)
		{
			level.ally_vo_org stopsounds();
			wait(0.05);
			level.current_vo = param_00;
			level.ally_vo_org playsound(param_00.vo,"sounddone",1);
			level.ally_vo_org waittill("sounddone");
			wait(0.5);
			level.current_vo = undefined;
			return;
		}

		if(!isdefined(level.current_vo))
		{
			level.current_vo = param_00;
			level.ally_vo_org playsound(param_00.vo,"sounddone",1);
			level.ally_vo_org waittill("sounddone");
			wait(0.5);
			level.current_vo = undefined;
			return;
		}
	}
}

//Function Number: 39
irons_estate_animated_trees_setup()
{
	thread handle_irons_estate_animated_trees();
	switch(level.start_point)
	{
		case "infil":
		case "recon":
			common_scripts\utility::flag_set("ie_west_poolhouse_trees");
			break;

		case "hack_security":
		case "security_center":
			common_scripts\utility::flag_set("ie_west_poolhouse_trees");
			common_scripts\utility::flag_set("ie_west_central_garden_trees");
			break;

		case "intel":
		case "penthouse":
		case "meet_cormack":
			common_scripts\utility::flag_set("ie_west_poolhouse_trees");
			common_scripts\utility::flag_set("ie_west_central_garden_trees");
			common_scripts\utility::flag_set("ie_west_driveway_trees");
			break;

		case "plant_tracker":
		case "hangar":
		case "infil_hangar":
			common_scripts\utility::flag_set("remove_pre_penthouse_trees");
			common_scripts\utility::flag_set("ie_west_poolhouse_trees");
			common_scripts\utility::flag_set("ie_west_central_garden_trees");
			common_scripts\utility::flag_set("ie_west_driveway_trees");
			common_scripts\utility::flag_set("post_penthouse_trees");
			break;

		default:
			break;
	}
}

//Function Number: 40
handle_irons_estate_animated_trees()
{
	common_scripts\utility::flag_wait("ie_west_poolhouse_trees");
	if(!common_scripts\utility::flag("remove_pre_penthouse_trees"))
	{
		spawn_struct_array("ie_west_poolhouse_trees","targetname");
	}

	common_scripts\utility::flag_wait("ie_west_central_garden_trees");
	if(!common_scripts\utility::flag("remove_pre_penthouse_trees"))
	{
		spawn_struct_array("ie_west_central_garden_trees","targetname");
	}

	common_scripts\utility::flag_wait("ie_west_driveway_trees");
	if(!common_scripts\utility::flag("remove_pre_penthouse_trees"))
	{
		spawn_struct_array("ie_west_driveway_trees","targetname");
	}

	common_scripts\utility::flag_wait("post_penthouse_trees");
	if(!common_scripts\utility::flag("remove_pre_penthouse_trees"))
	{
		thread remove_pre_penthouse_trees();
	}

	spawn_struct_array("post_penthouse_trees","targetname");
}

//Function Number: 41
remove_pre_penthouse_trees()
{
	var_00 = getentarray("ie_west_poolhouse_trees","targetname");
	var_01 = getentarray("ie_west_central_garden_trees","targetname");
	var_02 = getentarray("ie_west_driveway_trees","targetname");
	var_03 = common_scripts\utility::array_combine(var_00,var_01);
	var_03 = common_scripts\utility::array_combine(var_03,var_02);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05))
		{
			var_05 delete();
		}
	}

	common_scripts\utility::flag_set("remove_pre_penthouse_trees");
}

//Function Number: 42
spawn_struct_array(param_00,param_01)
{
	var_02 = common_scripts\utility::getstructarray(param_00,param_01);
	var_03 = [];
	var_03[0] = "palm_tree_02";
	var_03[1] = "palm_tree_03";
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "foliage_fan_palm_tree_01_anim")
		{
			spawn_model_from_struct(var_05,"palm_tree_01");
			continue;
		}

		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "foliage_fan_palm_tree_02_anim")
		{
			var_06 = common_scripts\utility::random(var_03);
			spawn_model_from_struct(var_05,var_06);
		}
	}
}

//Function Number: 43
spawn_model_from_struct(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	if(isdefined(param_00.script_noteworthy))
	{
		if(param_00.script_noteworthy == "foliage_fan_palm_tree_01_anim")
		{
			param_00.angles = (0,30,0);
		}

		if(param_00.script_noteworthy == "foliage_fan_palm_tree_02_anim")
		{
			if(param_01 == "palm_tree_02")
			{
				param_00.angles = (0,180,0);
			}
			else
			{
				param_00.angles = (0,0,0);
			}
		}

		var_02.angles = param_00.angles;
	}

	var_02 setmodel(param_00.script_noteworthy);
	if(level.nextgen)
	{
		var_02.animname = param_01;
		var_02 useanimtree(level.scr_animtree[var_02.animname]);
	}

	var_02.script_noteworthy = param_00.script_noteworthy;
	var_02.targetname = param_00.targetname;
	var_02.target = param_00.target;
	if(level.nextgen)
	{
		var_02 thread irons_estate_animated_trees(param_01);
	}
}

//Function Number: 44
irons_estate_animated_trees(param_00)
{
	wait(randomfloatrange(0.25,1.5));
	thread maps\_anim::anim_loop_solo(self,param_00);
}

//Function Number: 45
delay_scripting_if_stealth_broken(param_00,param_01,param_02,param_03)
{
	level endon(param_01);
	for(;;)
	{
		if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("someone_became_alert") && !common_scripts\utility::flag("drones_investigating"))
		{
			common_scripts\utility::flag_wait_any("_stealth_spotted","someone_became_alert","drones_investigating");
		}

		param_00 common_scripts\utility::trigger_off();
		if(isdefined(param_02))
		{
			param_02 hide();
		}

		common_scripts\utility::flag_waitopen("someone_became_alert");
		common_scripts\utility::flag_waitopen("drones_investigating");
		common_scripts\utility::flag_waitopen("_stealth_spotted");
		while(level.stealth_spotted_drones.size > 0)
		{
			wait(0.05);
		}

		if(isdefined(param_02))
		{
			param_02 show();
		}

		param_00 common_scripts\utility::trigger_on();
		thread [[ param_03 ]]();
		wait(0.05);
	}
}

//Function Number: 46
player_kill_trigger(param_00)
{
	level endon("intel_begin");
	common_scripts\utility::flag_wait(param_00);
	level.player disableinvulnerability();
	level.player kill();
}

//Function Number: 47
waterfall_save(param_00)
{
	level endon(param_00);
	for(;;)
	{
		if(level.player istouching(self) && level.player isonground())
		{
			maps\_utility::autosave_stealth();
			break;
		}

		wait(1);
	}
}

//Function Number: 48
player_alerted_mission_fail_convoy()
{
	soundscripts\_snd_playsound::snd_play_2d("irons_guards_alerted_fail");
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_YOU_FAILED_TO_WAIT_FOR_CORMACK");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 49
player_alerted_mission_fail()
{
	soundscripts\_snd_playsound::snd_play_2d("irons_guards_alerted_fail");
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_ALERT_MISSION_FAIL");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 50
player_alerted_mission_fail_meter()
{
	soundscripts\_snd_playsound::snd_play_2d("irons_guards_alerted_fail");
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_STEALTH_DETECTION_HINT");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 51
handle_player_abandoned_mission(param_00)
{
	if(param_00 == "iln")
	{
		var_01 = getent("border_drone_warning_trigger","targetname");
		var_01 thread player_abandoned_mission_warning("bedroom_end",param_00);
		level endon("bedroom_end");
		common_scripts\utility::flag_wait("border_drone_driveway_trigger");
		common_scripts\utility::flag_set("_stealth_spotted");
		level.border_drone_fail = 1;
		thread player_abandoned_mission_fail();
		return;
	}

	var_02 = getent("abandoning_mission_warning_trigger","targetname");
	var_02 thread player_abandoned_mission_warning("emp_detonated",param_00);
	level endon("emp_detonated");
	common_scripts\utility::flag_wait("player_entering_ie_west");
	common_scripts\utility::flag_set("_stealth_spotted");
	level.border_drone_fail = 1;
	thread player_abandoned_mission_fail();
}

//Function Number: 52
player_abandoned_mission_warning_vo_setup(param_00)
{
	if(param_00 == "iln")
	{
		level.player_abandoning_mission_vo = [];
		level.player_abandoning_mission_vo[0] = spawnstruct();
		level.player_abandoning_mission_vo[0].vo = "ie_iln_gettooffice";
		level.player_abandoning_mission_vo[0].vo_priority = 4;
		level.player_abandoning_mission_vo[1] = spawnstruct();
		level.player_abandoning_mission_vo[1].vo = "ie_iln_tooclose2";
		level.player_abandoning_mission_vo[1].vo_priority = 4;
		level.player_abandoning_mission_vo[2] = spawnstruct();
		level.player_abandoning_mission_vo[2].vo = "ie_iln_spotyou";
		level.player_abandoning_mission_vo[2].vo_priority = 4;
		return;
	}

	level.player_abandoning_mission_vo = [];
	level.player_abandoning_mission_vo[0] = spawnstruct();
	level.player_abandoning_mission_vo[0].vo = "ie_nox_where2";
	level.player_abandoning_mission_vo[0].vo_priority = 4;
	level.player_abandoning_mission_vo[1] = spawnstruct();
	level.player_abandoning_mission_vo[1].vo = "ie_nox_stayonpoint";
	level.player_abandoning_mission_vo[1].vo_priority = 4;
}

//Function Number: 53
player_abandoned_mission_warning(param_00,param_01)
{
	level endon(param_00);
	player_abandoned_mission_warning_vo_setup(param_01);
	var_02 = 0;
	for(;;)
	{
		self waittill("trigger");
		var_03 = common_scripts\utility::random(level.player_abandoning_mission_vo);
		thread ally_vo_controller(var_03);
		var_04 = randomfloatrange(8,10);
		while(level.player istouching(self))
		{
			if(!isdefined(level.abandon_mission_warning_hint))
			{
				common_scripts\utility::flag_clear("HINT_ABANDON_WARNING_STOP");
				thread maps\_utility::display_hint("HINT_ABANDON_WARNING");
				level.abandon_mission_warning_hint = 1;
			}

			var_02 = var_02 + 0.05;
			if(var_02 >= var_04)
			{
				var_03 = common_scripts\utility::random(level.player_abandoning_mission_vo);
				thread ally_vo_controller(var_03);
				var_02 = 0;
			}

			wait(0.05);
		}

		var_02 = 0;
		common_scripts\utility::flag_set("HINT_ABANDON_WARNING_STOP");
		if(isdefined(level.abandon_mission_warning_hint))
		{
			level.abandon_mission_warning_hint = undefined;
		}

		wait 0.05;
	}
}

//Function Number: 54
player_abandoned_mission_fail()
{
	maps\_player_death::set_deadquote(&"IRONS_ESTATE_ABANDON_FAIL");
	thread maps\_utility::missionfailedwrapper();
}

//Function Number: 55
ally_grapple(param_00,param_01,param_02)
{
	if(isdefined(self.move_origin))
	{
		self unlink();
		self.move_origin delete();
	}

	var_03 = self.origin;
	param_00 = common_scripts\utility::getstruct(param_00,"targetname");
	maps\_utility::set_goal_radius(16);
	self.move_origin = common_scripts\utility::spawn_tag_origin();
	self linkto(self.move_origin,"tag_origin");
	self.move_origin moveto(param_00.origin,param_01);
	wait(param_01);
	wait 0.05;
	if(!isdefined(param_02))
	{
		self unlink();
		if(isdefined(self.move_origin))
		{
			self.move_origin delete();
		}
	}
}

//Function Number: 56
check_allies_in_volume(param_00,param_01)
{
	common_scripts\utility::flag_clear("all_in");
	for(;;)
	{
		var_02 = 1;
		foreach(var_04 in param_00)
		{
			if(isalive(var_04) && !var_04 istouching(param_01))
			{
				var_02 = 0;
			}
		}

		if(var_02)
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set("all_in");
}

//Function Number: 57
remove_grapple(param_00)
{
	common_scripts\utility::flag_clear("grapple_disabled");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	for(;;)
	{
		if(level.player.grapple["connected"] == 0)
		{
			if(level.player.grapple["grappling"] == 0)
			{
				break;
			}
		}

		wait(0.05);
	}

	level.player maps\_grapple::grapple_take();
	common_scripts\utility::flag_set("grapple_disabled");
}

//Function Number: 58
security_center_lights(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		foreach(var_04 in param_01)
		{
			var_04 setlightintensity(0);
		}

		return;
	}

	foreach(var_04 in param_02)
	{
		var_04 setlightintensity(param_02);
	}
}

//Function Number: 59
security_center_script_brushmodels(param_00)
{
	if(isdefined(param_00))
	{
		self hide();
		return;
	}

	self show();
}

//Function Number: 60
security_center_player_rig_and_hatch_door_setup()
{
	level.security_center_anim_struct = common_scripts\utility::getstruct("security_center_anim_struct","targetname");
	level.hatch_door_middle = getent("hatch_door_middle","targetname");
	level.hatch_door_middle.animname = "hatch_door_middle";
	level.hatch_door_middle useanimtree(level.scr_animtree["hatch_door_middle"]);
	level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.player_rig hide();
	level.player_and_hatch_doors = [];
	level.player_and_hatch_doors[0] = level.player_rig;
	level.player_and_hatch_doors[1] = level.hatch_door_middle;
	if(level.start_point_scripted == "hack_security")
	{
		level.security_center_anim_struct maps\_anim::anim_last_frame_solo(level.hatch_door_middle,"plant_emp");
		return;
	}

	level.security_center_anim_struct maps\_anim::anim_first_frame(level.player_and_hatch_doors,"plant_emp");
}

//Function Number: 61
security_center_bink()
{
	wait 0.05;
	level endon("hack_security_end");
	thread security_center_bink_off();
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("atlas_logo_loop");
	common_scripts\utility::flag_wait("handprint_start");
	wait(1.5);
	stopcinematicingame();
	maps\_utility::delaythread(2,::security_center_main_screen_bink,1);
	cinematicingame("security_center_table_scan");
	soundscripts\_snd_playsound::snd_play_2d("irons_bink_tablescan");
	wait(0.05);
	level waittill("security_center_table_bink_done");
	stopcinematicingame();
	var_00 = getent("security_center_desk_screen","targetname");
	var_00 hide();
	thread security_center_main_screen_bink(undefined);
	soundscripts\_snd::snd_message("aud_security_main_screen");
	cinematicingameloop("security_center_main_screen");
}

//Function Number: 62
security_center_bink_off()
{
	common_scripts\utility::flag_wait("hack_security_end");
	stopcinematicingame();
}

//Function Number: 63
security_center_main_screen_bink(param_00,param_01)
{
	if(isdefined(param_00))
	{
		var_02 = getent("security_center_main_screen_model","targetname");
		var_02 hide();
		var_03 = getent("security_center_main_screen_brush","targetname");
		var_03 hide();
		var_04 = getent("security_center_main_screen_off","targetname");
		var_04 show();
		return;
	}

	if(isdefined(var_04))
	{
		var_02 = getent("security_center_main_screen_model","targetname");
		var_04 show();
		var_03 = getent("security_center_main_screen_brush","targetname");
		var_04 hide();
	}
	else
	{
		var_03 = getent("security_center_main_screen_brush","targetname");
		var_04 show();
		var_03 = getent("security_center_main_screen_model","targetname");
		var_03 hide();
	}

	var_04 = getent("security_center_main_screen_off","targetname");
	var_04 hide();
}

//Function Number: 64
timer(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02))
	{
		level endon(param_02);
		thread maps\_utility::flagwaitthread(param_02,::killtimer);
	}

	level.hudtimerindex = 20;
	level.timer = maps\_hud_util::get_countdown_hud(-250);
	level.timer setpulsefx(30,900000,700);
	if(isdefined(param_03))
	{
		level.timer.label = param_03;
	}

	level.timer settimer(param_00);
	level.start_time = gettime();
	var_04 = level.timer;
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_wait_or_timeout(param_02,param_00);
	}
	else if(!isdefined(param_01))
	{
		wait(param_00);
	}
	else
	{
		wait(param_01);
	}

	if(isdefined(var_04))
	{
		killtimer();
	}
}

//Function Number: 65
killtimer()
{
	if(isdefined(level.timer))
	{
		level.timer destroy();
	}
}

//Function Number: 66
tennis_court_floor(param_00)
{
	var_01 = getentarray("tennis_court_floor_lines","targetname");
	var_02 = getentarray("tennis_court_net","targetname");
	if(isdefined(param_00))
	{
		foreach(var_04 in var_01)
		{
			var_04 hide();
		}

		foreach(var_07 in var_02)
		{
			var_07 hide();
		}

		return;
	}

	foreach(var_04 in var_04)
	{
		var_04 show();
	}

	foreach(var_07 in var_02)
	{
		var_07 show();
	}
}

//Function Number: 67
notify_delay_param(param_00,param_01,param_02)
{
	self endon("_stealth_enemy_alert_level_change");
	self endon("enemy_awareness_reaction");
	self endon("death");
	self endon("pain_death");
	if(param_01 > 0)
	{
		wait(param_01);
	}

	if(!isdefined(self))
	{
		return;
	}

	self notify(param_00,param_02);
}

//Function Number: 68
notifyaftertime(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 69
stopsounds_on_death()
{
	common_scripts\utility::waittill_any("death","damage","_stealth_enemy_alert_level_change","alert","attack","stealth_enemy_endon_alert","alerted","spotted_player");
	if(isdefined(self))
	{
		self notify("something_alerted_me");
		if(isdefined(self.anim_org))
		{
			self.anim_org notify("stop_looping_anim");
		}

		self notify("stop_sound");
		self stopsounds();
	}
}

//Function Number: 70
drone_investigate_triggers_main()
{
	common_scripts\utility::flag_init("drone_investigate_triggered");
	var_00 = getentarray("drone_investigate_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread drone_investigate_trigger();
	}
}

//Function Number: 71
drone_investigate_trigger()
{
	level.player endon("death");
	self endon("death");
	var_00 = undefined;
	if(isdefined(self.script_noteworthy))
	{
		var_00 = self.script_noteworthy;
		level endon(self.script_noteworthy);
	}

	self waittill("trigger");
	if(isdefined(var_00))
	{
		if(common_scripts\utility::flag(var_00))
		{
			return;
		}
	}

	if(isdefined(level.drone_investigating_has_happened_once))
	{
		return;
	}

	if(isdefined(self.script_parameters))
	{
		thread maps\_utility::smart_radio_dialogue(self.script_parameters);
	}

	if(isdefined(self.target))
	{
		var_01 = common_scripts\utility::getstruct(self.target,"targetname");
		var_02 = var_01.origin;
	}
	else
	{
		var_02 = level.player.origin;
	}

	level notify("drone_investigate",var_02);
	common_scripts\utility::flag_set("drone_investigate_triggered");
	maps\_utility::delaythread(1,::common_scripts\utility::flag_clear,"drone_investigate_triggered");
}

//Function Number: 72
irons_estate_stealth_disable()
{
	level.player.grapple["dist_max"] = 800;
	level notify("stop_player_broke_stealth_monitor");
	level notify("stealth_alerted_drone_monitor");
	level notify("stop_stealth_spotted_drone_monitor");
	level.stealth_disabled = 1;
}

//Function Number: 73
irons_estate_stealth_enable()
{
	thread maps\irons_estate_stealth::player_broke_stealth();
	thread maps\irons_estate_drone::stealth_alerted_drone_monitor();
	thread maps\irons_estate_drone::stealth_spotted_drone_monitor();
	level.stealth_disabled = undefined;
}

//Function Number: 74
trigger_sprinklervolume_setup()
{
	var_00 = getentarray("trigger_sprinklervolume","targetname");
	foreach(var_02 in var_00)
	{
		thread trigger_sprinklervolume_think(var_02);
	}
}

//Function Number: 75
trigger_sprinklervolume_think(param_00)
{
	param_00.sprinkler_origin = common_scripts\utility::getstruct(param_00.target,"targetname");
	param_00.sprinkler_origin thread sprinkler_sound_proximity_toggle();
	playfx(level._effect["ie_sprinkler"],param_00.sprinkler_origin.origin);
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 maps\_utility::ent_flag_exist("in_sprinkler_volume"))
		{
		}
		else
		{
			var_01 maps\_utility::ent_flag_init("in_sprinkler_volume");
		}

		if(distancesquared(var_01.origin,level.player.origin) < 6250000)
		{
			if(var_01 maps\_utility::ent_flag("in_sprinkler_volume"))
			{
				continue;
			}

			var_01 thread volume_fallingwaterfx(param_00);
			var_01 maps\_utility::ent_flag_set("in_sprinkler_volume");
		}
	}
}

//Function Number: 76
volume_fallingwaterfx(param_00)
{
	self endon("death");
	var_01 = param_00 getpointinbounds(1,1,0);
	var_02 = param_00 getpointinbounds(-1,-1,0);
	var_03 = var_01[0] - var_02[0] * var_01[1] - var_02[1];
	var_04 = 3;
	if(isdefined(param_00.script_duration))
	{
		var_04 = param_00.script_duration;
	}

	var_05 = 1;
	if(isdefined(param_00.script_flowrate))
	{
		var_05 = param_00.script_flowrate;
	}

	var_06 = int(var_05 * var_03 / 50);
	var_07 = "null";
	if(isdefined(param_00.script_fxid))
	{
		var_07 = param_00.script_fxid;
	}

	var_08 = "null";
	if(isdefined(param_00.script_screen_fxid))
	{
		var_08 = param_00.script_screen_fxid;
	}

	var_09 = -1;
	for(;;)
	{
		if(self istouching(param_00))
		{
			if(isai(self))
			{
				wait(0.05);
				for(var_0A = 0;var_0A < var_06;var_0A++)
				{
					if(var_07 != "null")
					{
						var_0B = param_00.sprinkler_origin.origin;
						var_0C = self.origin + (randomfloatrange(0,4),randomfloatrange(0,4),randomfloatrange(10,50));
						if(distance2dsquared(var_0C,self.origin) < 900)
						{
							var_0D = bullettrace(var_0B,var_0C,1,undefined,0,1);
							if(isdefined(var_0D["entity"]) && var_0D["entity"] == self)
							{
								var_0E = common_scripts\utility::getfx(var_07);
								var_0B = var_0D["position"];
								var_0F = vectortoangles(var_0D["normal"] + (90,0,0));
								var_10 = anglestoforward(var_0F);
								var_11 = anglestoup(var_0F);
								playfx(var_0E,var_0B,var_11,var_10);
							}
						}
					}
				}
			}

			if(isplayer(self) && level.player is_player_looking_at(param_00.sprinkler_origin.origin,cos(45),undefined,level.player))
			{
				wait(0.05);
				playfx(level._effect["ie_sprinkler_screen_drops"],level.player.origin);
				var_09 = var_09 + 0.05;
				if((var_09 > var_04 * 0.2 || var_09 < 0) && distancesquared(param_00.sprinkler_origin.origin,level.player geteye()) < 4096)
				{
					self setwatersheeting(1,var_04);
					var_09 = 0;
				}
			}
		}
		else
		{
			maps\_utility::ent_flag_clear("in_sprinkler_volume");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 77
is_player_looking_at(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.8;
	}

	var_04 = maps\_utility::get_player_from_self();
	var_05 = var_04 geteye();
	var_06 = vectortoangles(param_00 - var_05);
	var_07 = anglestoforward(var_06);
	var_08 = var_04 getplayerangles();
	var_09 = anglestoforward(var_08);
	var_0A = vectordot(var_07,var_09);
	if(var_0A < param_01)
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		return 1;
	}

	var_0B = bullettrace(param_00,var_05,0,param_03);
	return var_0B["fraction"] == 1;
}

//Function Number: 78
sprinkler_sound_proximity_toggle()
{
	var_00 = self.targetname + "_stop_irons_sprinkler_02";
	var_01 = undefined;
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < 1000000)
		{
			if(!isdefined(var_01))
			{
				var_01 = common_scripts\utility::spawn_tag_origin();
			}

			var_01 soundscripts\_snd_playsound::snd_play_loop_linked("irons_sprinkler_02",var_00,1,1.5);
			while(distancesquared(self.origin,level.player.origin) < 1000000)
			{
				wait(0.05);
			}

			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
		else if(isdefined(var_01))
		{
			var_01 delete();
		}

		wait(0.05);
	}
}

//Function Number: 79
hide_friendname_until_flag_or_notify(param_00)
{
	if(!isdefined(self.name))
	{
		return;
	}

	level.player endon("death");
	self endon("death");
	self.old_name = self.name;
	self.name = " ";
	level waittill(param_00);
	self.name = self.old_name;
}

//Function Number: 80
force_alert_trigger_setup()
{
	var_00 = getentarray("force_alert_trigger","targetname");
	common_scripts\utility::array_thread(var_00,::force_alert_trigger_monitor);
}

//Function Number: 81
force_alert_trigger_monitor()
{
	if(isdefined(self.script_noteworthy))
	{
		level endon(self.script_noteworthy);
	}

	self waittill("trigger",var_00);
	var_01 = getaiarray("neutral");
	var_01 = maps\_utility::remove_dead_from_array(var_01);
	foreach(var_03 in var_01)
	{
		if(!var_03 istouching(self))
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_03);
		}
	}

	var_01 = sortbydistance(var_01,var_00.origin);
	if(isdefined(var_01[0]))
	{
		var_01[0] notify("alerted");
	}
}

//Function Number: 82
tff_cleanup_vehicle(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "cliffs":
			var_01 = "tff_pre_cliffs_to_lower";
			break;

		case "lower":
			var_01 = "tff_pre_lower_to_upper";
			break;
	}

	if(var_01 == "")
	{
		return;
	}

	level waittill(var_01);
	if(!isdefined(self))
	{
		return;
	}

	if(isremovedentity(self))
	{
		return;
	}

	maps\_vehicle_code::_freevehicle();
	self delete();
}