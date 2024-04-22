/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\humanoid\_humanoid_traverse.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 97 ms
 * Timestamp: 4/22/2024 2:08:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.zombietraverseanims) || !isdefined(level.zombietraverseanims["humanoid"]))
	{
		inithumanoidtraverseanims();
	}

	dotraverse();
}

//Function Number: 2
dotraverse()
{
	self endon("killanimscript");
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoTraverse");
	var_00 = self getnegotiationstartnode();
	var_01 = self getnegotiationendnode();
	self.traversalvector = vectornormalize(var_01.origin - var_00.origin);
	if(var_00.animscript == "bot_walk_forward")
	{
		var_02 = var_01.origin - var_00.origin;
		var_03 = length(var_02) / 64;
		var_04 = (var_02[0],var_02[1],0);
		var_05 = vectortoangles(var_04);
		self scragentsetorientmode("face angle abs",var_05);
		self scragentdoanimlerp(var_00.origin,var_01.origin,var_03);
		self scragentsetphysicsmode("noclip");
		maps\mp\agents\_scripted_agent_anim_util::playanimnatratefortime(self.movemode,randomint(self getanimentrycount(self.movemode)),self.moveratescale,var_03);
		return;
	}

	var_06 = undefined;
	var_06 = level.zombietraverseanims[self.species][var_04.animscript];
	if(!isdefined(var_06))
	{
		return;
	}

	var_07 = -1;
	if(isdefined(level.zombietraverseanimchance[self.species][var_06]))
	{
		var_08 = randomfloat(1);
		for(var_09 = 0;var_09 < level.zombietraverseanimchance[self.species][var_06].size;var_09++)
		{
			var_0A = level.zombietraverseanimchance[self.species][var_06][var_09];
			if(var_08 < var_0A)
			{
				var_07 = var_09;
				break;
			}
			else
			{
				var_08 = var_08 - var_0A;
			}
		}
	}
	else
	{
		var_07 = randomint(self getanimentrycount(var_06));
	}

	var_02 = var_05.origin - var_04.origin;
	var_04 = (var_07[0],var_07[1],0);
	var_05 = vectortoangles(var_07);
	var_0B = issubstr(var_01.animscript,"jump_across");
	var_0C = (var_03 == "traverse_boost" || issubstr(var_01.animscript,"boost_jump_across")) && self.species == "humanoid";
	if(var_0C)
	{
		maps\mp\agents\humanoid\_humanoid_util::play_boost_fx(level._effect["boost_jump"]);
	}

	self scragentsetorientmode("face angle abs",var_07);
	self scragentsetanimmode("anim deltas");
	if(maps\mp\zombies\_util::getzombieslevelnum() >= 4)
	{
		self setvelocity((0,0,0));
	}

	var_0D = self getanimentry(var_03,var_04);
	var_0E = getnotetracktimes(var_0D,"code_move");
	if(var_0E.size > 0)
	{
		var_0F = getmovedelta(var_0D,0,var_0E[0]);
	}
	else
	{
		var_0F = getmovedelta(var_0E,0,1);
	}

	var_10 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_05,var_0F);
	var_11 = animhasnotetrack(var_0D,"ignoreanimscaling");
	if(var_11)
	{
		var_10.xy = 1;
	}

	self scragentsetphysicsmode("noclip");
	if(maps\mp\zombies\_util::getzombieslevelnum() >= 3 && var_0B && abs(var_05[2]) < 48)
	{
		var_12 = getnotetracktimes(var_0D,"traverse_jump_start");
		var_13 = getnotetracktimes(var_0D,"traverse_jump_end");
		var_14 = getanimlength(var_0D);
		var_15 = var_12[0] * var_14;
		var_16 = var_13[0] * var_14;
		self scragentsetanimscale(var_10.xy,1);
		maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,self.traverseratescale,"traverse","traverse_jump_start");
		self scragentsetanimscale(var_10.xy,0);
		childthread traverse_lerp_z_over_time(var_01.origin[2],var_02.origin[2],var_16 - var_15 / self.traverseratescale);
		maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03 + "_norestart",var_04,self.traverseratescale,"traverse","traverse_jump_end");
		self scragentsetanimscale(var_10.xy,1);
		maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03 + "_norestart",var_04,self.traverseratescale,"traverse");
		return;
	}

	if(var_05[2] > 16)
	{
		if(var_0F[2] > 0)
		{
			if(var_0C)
			{
				self scragentsetanimscale(var_10.xy,var_10.z);
				var_17 = clamp(2 / var_10.z,0.5,1);
				if(animhasnotetrack(var_0D,"traverse_jump_end"))
				{
					maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,var_17 * self.traverseratescale,"traverse","traverse_jump_end");
					maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoTraverse");
					var_18 = var_03 + "_norestart";
					maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_18,var_04,self.traverseratescale);
					maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse","code_move");
				}
				else if(maps\mp\zombies\_util::getzombieslevelnum() >= 4)
				{
					maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,self.traverseratescale,"traverse","code_move");
				}
				else
				{
					maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,self.traverseratescale,"traverse");
				}

				self scragentsetanimscale(1,1);
				return;
			}

			var_12 = getnotetracktimes(var_0D,"traverse_jump_start");
			if(var_12.size > 0)
			{
				var_10.xy = 1;
				var_10.z = 1;
				if(!var_11 && length2dsquared(var_06) < 0.64 * length2dsquared(var_0F))
				{
					var_10.xy = 0.4;
				}

				self scragentsetanimscale(var_10.xy,var_10.z);
				maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,self.traverseratescale,"traverse","traverse_jump_start");
				var_13 = getnotetracktimes(var_0D,"traverse_jump_end");
				var_19 = getmovedelta(var_0D,0,var_12[0]);
				var_1A = getmovedelta(var_0D,0,var_13[0]);
				var_10.xy = 1;
				var_10.z = 1;
				var_1B = var_02.origin - self.origin;
				var_1C = var_0F - var_19;
				if(!var_11 && length2dsquared(var_1B) < 0.5625 * length2dsquared(var_1C))
				{
					var_10.xy = 0.75;
				}

				var_1D = var_0F - var_1A;
				var_1E = (var_1D[0] * var_10.xy,var_1D[1] * var_10.xy,var_1D[2] * var_10.z);
				var_1F = rotatevector(var_1E,var_07);
				var_20 = var_02.origin - var_1F;
				var_21 = var_1A - var_19;
				var_22 = rotatevector(var_21,var_07);
				var_23 = var_20 - self.origin;
				var_24 = var_10;
				var_10 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_23,var_22,1);
				if(var_11)
				{
					var_10.xy = 1;
				}

				if(var_23[2] <= 0)
				{
					var_10.z = 0;
				}

				self scragentsetanimscale(var_10.xy,var_10.z);
				maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse","traverse_jump_end");
				maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoTraverse");
				var_10 = var_24;
				self scragentsetanimscale(var_10.xy,var_10.z);
				maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse","code_move");
				return;
			}

			self scragentsetanimscale(var_10.xy,var_10.z);
			if(maps\mp\zombies\_util::getzombieslevelnum() >= 4)
			{
				maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,self.traverseratescale,"traverse","code_move");
				return;
			}

			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_04,self.traverseratescale,"traverse");
			return;
		}

		return;
	}

	if(abs(var_06[2]) < 16 || var_10[2] == 0)
	{
		self scragentsetanimscale(var_11.xy,var_11.z);
		var_17 = clamp(2 / var_11.z,0.5,1);
		if(animhasnotetrack(var_0E,"traverse_jump_end"))
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,var_17 * self.traverseratescale,"traverse","traverse_jump_end");
			maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoTraverse");
			var_18 = var_04 + "_norestart";
			maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_18,var_05,self.traverseratescale);
			maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse","code_move");
		}
		else if(maps\mp\zombies\_util::getzombieslevelnum() >= 4)
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,self.traverseratescale,"traverse","code_move");
		}
		else
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,self.traverseratescale,"traverse");
		}

		self scragentsetanimscale(1,1);
		return;
	}

	if(var_10[2] < 0)
	{
		self scragentsetanimscale(var_11.xy,var_11.z);
		var_17 = clamp(2 / var_11.z,0.5,1);
		var_26 = var_04 + "_norestart";
		if(animhasnotetrack(var_0E,"traverse_jump_start"))
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,self.traverseratescale,"traverse","traverse_jump_start");
			var_04 = var_26;
		}

		if(animhasnotetrack(var_0E,"traverse_jump_end"))
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,var_17 * 1,"traverse","traverse_jump_end");
			maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_26,var_05,self.traverseratescale);
			if(animhasnotetrack(var_0E,"removestatelock"))
			{
				maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse","removestatelock");
			}

			maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoTraverse");
			maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("traverse","code_move");
		}
		else if(maps\mp\zombies\_util::getzombieslevelnum() >= 4)
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,self.traverseratescale,"traverse","code_move");
		}
		else
		{
			maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_04,var_05,1,"traverse");
		}

		self scragentsetanimscale(1,1);
		return;
	}
}

//Function Number: 3
traverse_lerp_z_over_time(param_00,param_01,param_02)
{
	var_03 = gettime();
	for(;;)
	{
		var_04 = gettime() - var_03 / 1000;
		var_05 = var_04 / param_02;
		if(var_05 > 1)
		{
			break;
		}

		var_06 = maps\mp\zombies\_util::lerp(var_05,param_00,param_01);
		self setorigin((self.origin[0],self.origin[1],var_06),0);
		wait(0.05);
	}
}

//Function Number: 4
end_script()
{
	self scragentsetanimscale(1,1);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"Traverse end_script");
	self.hastraversed = 1;
	self.traversalvector = undefined;
}

//Function Number: 5
inithumanoidtraverseanims()
{
	if(!isdefined(level.zombietraverseanims))
	{
		level.zombietraverseanims = [];
	}

	if(!isdefined(level.zombietraverseanims["humanoid"]))
	{
		level.zombietraverseanims["humanoid"] = [];
	}

	level.zombietraverseanims["humanoid"]["jump_across_100"] = "traverse_jump_across_100";
	level.zombietraverseanims["humanoid"]["jump_across_196"] = "traverse_jump_across_196";
	level.zombietraverseanims["humanoid"]["boost_jump_across_100"] = level.zombietraverseanims["humanoid"]["jump_across_100"];
	level.zombietraverseanims["humanoid"]["boost_jump_across_196"] = level.zombietraverseanims["humanoid"]["jump_across_196"];
	level.zombietraverseanims["humanoid"]["jump_down_40"] = "traverse_jump_down_40";
	level.zombietraverseanims["humanoid"]["jump_down_slow"] = "traverse_jump_down_slow";
	level.zombietraverseanims["humanoid"]["jump_down_fast"] = "traverse_jump_down_fast";
	level.zombietraverseanims["humanoid"]["step_over_40"] = "traverse_step_over_40";
	level.zombietraverseanims["humanoid"]["window_over_36"] = "traverse_window_over_36";
	level.zombietraverseanims["humanoid"]["step_up_40"] = "traverse_step_up_40";
	level.zombietraverseanims["humanoid"]["wall_over_40"] = "traverse_mantle_over_40";
	level.zombietraverseanims["humanoid"]["nonboost_jump_up_120"] = "traverse_jump_up_120";
	level.zombietraverseanims["humanoid"]["boost_jump_up"] = "traverse_boost";
	level.zombietraverseanims["humanoid"]["climbup_shaft"] = "traverse_climbup_shaft";
	level.zombietraverseanims["humanoid"]["spawn_closet_door"] = "traverse_spawn_closet_door";
	level.zombietraverseanims["humanoid"]["spawn_closet_vault"] = "traverse_spawn_closet_vault";
	level.zombietraverseanims["humanoid"]["spawn_closet_window"] = "traverse_spawn_closet_window";
	level.zombietraverseanims["humanoid"]["spawn_closet_high_window"] = "traverse_spawn_closet_high_window";
	if(!isdefined(level.zombietraverseanimchance))
	{
		level.zombietraverseanimchance = [];
	}

	if(!isdefined(level.zombietraverseanimchance["humanoid"]))
	{
		level.zombietraverseanimchance["humanoid"] = [];
	}

	foreach(var_01 in level.zombietraverseanimchance["humanoid"])
	{
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			var_02 = var_02 + var_04;
		}
	}
}