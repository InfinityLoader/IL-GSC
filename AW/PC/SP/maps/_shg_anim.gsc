/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_shg_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 148 ms
 * Timestamp: 10/27/2023 2:00:20 AM
*******************************************************************/

//Function Number: 1
multiple_dialogue_queue(param_00)
{
	maps\_utility::bcs_scripted_dialogue_start();
	if(isdefined(self.last_queue_time))
	{
		maps\_utility::wait_for_buffer_time_to_pass(self.last_queue_time,0.5);
	}

	var_01 = [];
	var_01[0] = [self,0];
	maps\_utility::function_stack(::anim_single_end_early,var_01,param_00);
	if(isalive(self))
	{
		self.last_queue_time = gettime();
	}
}

//Function Number: 2
anim_single_end_early(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = [];
	foreach(var_07, var_06 in param_00)
	{
		var_04[var_07] = var_06[0];
	}

	foreach(var_09 in var_04)
	{
		if(!isdefined(var_09))
		{
			continue;
		}

		if(!isdefined(var_09._animactive))
		{
			var_09._animactive = 0;
		}

		var_09._animactive++;
	}

	var_0B = maps\_anim::get_anim_position(param_02);
	var_0C = var_0B["origin"];
	var_0D = var_0B["angles"];
	var_0E = "single anim";
	var_0F = spawnstruct();
	var_10 = 0;
	foreach(var_07, var_09 in var_04)
	{
		var_12 = 0;
		var_13 = 0;
		var_14 = 0;
		var_15 = 0;
		var_16 = undefined;
		var_17 = undefined;
		var_18 = var_09.animname;
		if(isdefined(level.scr_face[var_18]) && isdefined(level.scr_face[var_18][param_01]))
		{
			var_12 = 1;
			var_17 = level.scr_face[var_18][param_01];
		}

		if(isdefined(level.scr_sound[var_18]) && isdefined(level.scr_sound[var_18][param_01]))
		{
			var_13 = 1;
			var_16 = level.scr_sound[var_18][param_01];
		}

		if(isdefined(level.scr_anim[var_18]) && isdefined(level.scr_anim[var_18][param_01]) && !isai(var_09) || !var_09 maps\_utility::doinglongdeath())
		{
			var_14 = 1;
		}

		if(isdefined(level.scr_animsound[var_18]) && isdefined(level.scr_animsound[var_18][param_01]))
		{
			var_09 playsound(level.scr_animsound[var_18][param_01]);
		}

		if(var_14)
		{
			var_09 maps\_anim::last_anim_time_check();
			if(isplayer(var_09))
			{
				var_19 = level.scr_anim[var_18]["root"];
				var_09 setanim(var_19,0,0.2);
				var_1A = level.scr_anim[var_18][param_01];
				var_09 setflaggedanim(var_0E,var_1A,1,0.2);
			}
			else if(var_09.code_classname == "misc_turret")
			{
				var_1A = level.scr_anim[var_18][param_01];
				var_09 setflaggedanim(var_0E,var_1A,1,0.2);
			}
			else
			{
				var_09 animscripted(var_0E,var_0C,var_0D,level.scr_anim[var_18][param_01]);
			}

			thread maps\_anim::start_notetrack_wait(var_09,var_0E,param_01,var_18,level.scr_anim[var_18][param_01]);
			thread maps\_anim::animscriptdonotetracksthread(var_09,var_0E,param_01);
		}

		if(var_12 || var_13)
		{
			if(var_12)
			{
				if(var_13)
				{
					var_09 thread dofacialdialogue(param_01,var_12,var_16,level.scr_face[var_18][param_01]);
				}

				thread maps\_anim::anim_facialanim(var_09,param_01,level.scr_face[var_18][param_01]);
			}
			else if(isai(var_09))
			{
				if(var_14)
				{
					var_09 animscripts\face::sayspecificdialogue(var_17,var_16,1);
				}
				else
				{
					var_09 thread maps\_anim::anim_facialfiller("single dialogue");
					var_09 animscripts\face::sayspecificdialogue(var_17,var_16,1,"single dialogue");
				}
			}
			else
			{
				var_09 thread maps\_utility::play_sound_on_entity(var_16,"single dialogue");
			}
		}

		if(var_14)
		{
			var_1B = getanimlength(level.scr_anim[var_18][param_01]);
			var_0F thread anim_end_early_deathnotify(var_09,param_01);
			var_0F thread anim_end_early_animationendnotify(var_09,param_01,var_1B,param_00[var_07][1]);
			var_10++;
			continue;
		}

		if(var_12)
		{
			var_0F thread anim_end_early_deathnotify(var_09,param_01);
			var_0F thread anim_end_early_facialendnotify(var_09,param_01,var_17);
			var_10++;
			continue;
		}

		if(var_13)
		{
			var_0F thread anim_end_early_deathnotify(var_09,param_01);
			var_0F thread anim_end_early_dialogueendnotify(var_09,param_01);
			var_10++;
		}
	}

	while(var_10 > 0)
	{
		var_0F waittill(param_01,var_09);
		var_10--;
		if(!isdefined(var_09))
		{
			continue;
		}

		if(isplayer(var_09))
		{
			var_18 = var_09.animname;
			if(isdefined(level.scr_anim[var_18][param_01]))
			{
				var_19 = level.scr_anim[var_18]["root"];
				var_09 setanim(var_19,1,0.2);
				var_1A = level.scr_anim[var_18][param_01];
				var_09 clearanim(var_1A,0.2);
			}
		}

		var_09._animactive--;
		var_09._lastanimtime = gettime();
	}

	self notify(param_01);
}

//Function Number: 3
anim_end_early_deathnotify(param_00,param_01)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_00 waittill("death");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 4
anim_end_early_facialendnotify(param_00,param_01,param_02)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	var_03 = getanimlength(param_02);
	wait(var_03);
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 5
anim_end_early_dialogueendnotify(param_00,param_01)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_00 waittill("single dialogue");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 6
anim_end_early_animationendnotify(param_00,param_01,param_02,param_03)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_02 = param_02 - param_03;
	if(param_03 > 0 && param_02 > 0)
	{
		param_00 maps\_utility::waittill_match_or_timeout("single anim","end",param_02);
		param_00 stopanimscripted();
	}
	else
	{
		param_00 waittillmatch("end","single anim");
	}

	param_00 notify("anim_ended");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 7
dofacialdialogue(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		thread notify_facial_anim_end(param_00);
		thread warn_facial_dialogue_unspoken(param_00);
		thread warn_facial_dialogue_too_many(param_00);
		var_04 = [];
		if(!isarray(param_02))
		{
			var_04[0] = param_02;
		}
		else
		{
			var_04 = param_02;
		}

		foreach(var_06 in var_04)
		{
			self waittillmatch("dialogue_line","face_done_" + param_00);
			animscripts\face::sayspecificdialogue(undefined,var_06,1);
		}

		self notify("all_facial_lines_done");
		return;
	}

	animscripts\face::sayspecificdialogue(undefined,param_02,1,"single dialogue");
}

//Function Number: 8
notify_facial_anim_end(param_00)
{
	self endon("death");
	self waittillmatch("end","face_done_" + param_00);
	self notify("facial_anim_end_" + param_00);
}

//Function Number: 9
warn_facial_dialogue_unspoken(param_00)
{
	self endon("death");
	self endon("all_facial_lines_done");
	self waittill("facial_anim_end_" + param_00);
}

//Function Number: 10
warn_facial_dialogue_too_many(param_00)
{
	self endon("death");
	self endon("facial_anim_end_" + param_00);
	self waittill("all_facial_lines_done");
	self waittillmatch("dialogue_line","face_done_" + param_00);
}