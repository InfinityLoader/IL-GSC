/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\dog\_dog_traverse.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 80 ms
 * Timestamp: 4/22/2024 2:08:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	if(!isdefined(level.dogtraverseanims))
	{
		initdogtraverseanims();
	}

	var_00 = self getnegotiationstartnode();
	var_01 = self getnegotiationendnode();
	if(var_00.animscript == "bot_walk_forward")
	{
		var_02 = var_01.origin - var_00.origin;
		var_03 = length(var_02) / 256;
		var_04 = (var_02[0],var_02[1],0);
		var_05 = vectortoangles(var_04);
		self scragentsetorientmode("face angle abs",var_05);
		self scragentdoanimlerp(var_00.origin,var_01.origin,var_03);
		self scragentsetphysicsmode("noclip");
		maps\mp\agents\_scriptedagents::playanimfortime("run",var_03);
		return;
	}

	var_06 = undefined;
	var_06 = level.dogtraverseanims[var_04.animscript];
	if(!isdefined(var_06))
	{
		return;
	}

	self.blockgoalpos = 1;
	var_02 = var_05.origin - var_04.origin;
	var_04 = (var_06[0],var_06[1],0);
	var_05 = vectortoangles(var_06);
	self scragentsetorientmode("face angle abs",var_06);
	self scragentsetanimmode("anim deltas");
	var_07 = self getanimentry(var_03,0);
	var_08 = getnotetracktimes(var_07,"code_move");
	if(var_08.size > 0)
	{
		var_09 = getmovedelta(var_07,0,var_08[0]);
	}
	else
	{
		var_09 = getmovedelta(var_08,0,1);
	}

	var_0A = maps\mp\agents\_scriptedagents::getanimscalefactors(var_04,var_09);
	self scragentsetphysicsmode("noclip");
	if(var_04[2] > 0)
	{
		if(var_09[2] > 0)
		{
			var_0B = getnotetracktimes(var_07,"traverse_jump_start");
			if(var_0B.size > 0)
			{
				var_0C = 1;
				var_0D = 1;
				if(length2dsquared(var_05) < 0.64 * length2dsquared(var_09))
				{
					var_0C = 0.4;
				}

				if(var_04[2] < 0.75 * var_09[2])
				{
					var_0D = 0.5;
				}

				self scragentsetanimscale(var_0C,var_0D);
				maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_03,0,"traverse","traverse_jump_start");
				var_0E = getnotetracktimes(var_07,"traverse_jump_end");
				var_0F = getmovedelta(var_07,0,var_0B[0]);
				var_10 = getmovedelta(var_07,0,var_0E[0]);
				var_0C = 1;
				var_0D = 1;
				var_11 = var_02.origin - self.origin;
				var_12 = var_09 - var_0F;
				if(length2dsquared(var_11) < 0.5625 * length2dsquared(var_12))
				{
					var_0C = 0.75;
				}

				if(var_11[2] < 0.75 * var_12[2])
				{
					var_0D = 0.75;
				}

				var_13 = var_09 - var_10;
				var_14 = (var_13[0] * var_0C,var_13[1] * var_0C,var_13[2] * var_0D);
				var_15 = rotatevector(var_14,var_06);
				var_16 = var_02.origin - var_15;
				var_17 = var_10 - var_0F;
				var_18 = rotatevector(var_17,var_06);
				var_19 = var_16 - self.origin;
				var_0A = maps\mp\agents\_scriptedagents::getanimscalefactors(var_19,var_18,1);
				self scragentsetanimscale(var_0A.xy,var_0A.z);
				maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse","traverse_jump_end");
				self scragentsetanimscale(var_0C,var_0D);
				maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse","code_move");
				return;
			}

			self scragentsetanimscale(var_0A.xy,var_0A.z);
			maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_03,0,"traverse");
			return;
		}

		var_1A = getnotetracktimes(var_07,"gravity on");
		if(var_1A.size > 0)
		{
			var_1B = var_01 gettargetentpos();
			if(isdefined(var_1B))
			{
				var_1C = var_1B - self.origin;
				var_1D = var_02.origin - var_1B;
				var_1E = getmovedelta(var_07,0,var_1A[0]);
				var_0A = maps\mp\agents\_scriptedagents::getanimscalefactors(var_1C,var_1E);
				self scragentsetanimscale(var_0A.xy,var_0A.z);
				maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_03,0,"traverse","gravity on");
				var_1F = getmovedelta(var_07,var_1A[0],1);
				var_0A = maps\mp\agents\_scriptedagents::getanimscalefactors(var_1D,var_1F);
				self scragentsetanimscale(var_0A.xy,var_0A.z);
				maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse","code_move");
				return;
			}
		}

		var_20 = getanimlength(var_1A);
		self scragentdoanimlerp(var_05.origin,var_06.origin,var_20);
		maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_07,0,"traverse");
		return;
	}

	var_1A = getnotetracktimes(var_1C,"gravity on");
	if(var_20.size > 0)
	{
		self scragentsetanimscale(var_1E.xy,1);
		maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_08,0,"traverse","gravity on");
		var_21 = getmovedelta(var_1B,0,var_20[0]);
		var_22 = var_21[2] - var_1D[2];
		if(abs(var_22) > 0)
		{
			var_23 = self.origin[2] - var_07.origin[2];
			var_0D = var_23 / var_22;
			self scragentsetanimscale(var_1E.xy,var_0D);
			var_24 = clamp(2 / var_0D,0.5,1);
			var_25 = var_08 + "_norestart";
			self setanimstate(var_25,0,var_24);
		}

		maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse","code_move");
	}
	else
	{
		self scragentsetanimscale(var_1E.xy,var_1E.z);
		var_24 = clamp(2 / var_1E.z,0.5,1);
		var_0E = getnotetracktimes(var_1B,"traverse_jump_end");
		if(var_0E.size > 0)
		{
			maps\mp\agents\_scriptedagents::playanimnatrateuntilnotetrack(var_08,0,var_24,"traverse","traverse_jump_end");
			var_25 = var_08 + "_norestart";
			self setanimstate(var_25,0,1);
			maps\mp\agents\_scriptedagents::waituntilnotetrack("traverse","code_move");
		}
		else
		{
			maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_08,0,"traverse");
		}
	}

	self scragentsetanimscale(1,1);
}

//Function Number: 2
end_script()
{
	self scragentsetanimscale(1,1);
	self.blockgoalpos = 0;
}

//Function Number: 3
gettargetentpos()
{
	if(isdefined(self.targetentpos))
	{
		return self.targetentpos;
	}

	var_00 = getent(self.target,"targetname");
	if(!isdefined(var_00))
	{
		return undefined;
	}

	self.targetentpos = var_00.origin;
	var_00 delete();
	return self.targetentpos;
}

//Function Number: 4
initdogtraverseanims()
{
	level.dogtraverseanims = [];
	level.dogtraverseanims["hjk_tree_hop"] = "traverse_jump_over_24";
	level.dogtraverseanims["jump_across_72"] = "traverse_jump_over_24";
	level.dogtraverseanims["wall_hop"] = "traverse_jump_over_36";
	level.dogtraverseanims["window_2"] = "traverse_jump_over_36";
	level.dogtraverseanims["wall_over_40"] = "traverse_jump_over_36";
	level.dogtraverseanims["wall_over"] = "traverse_jump_over_36";
	level.dogtraverseanims["window_divethrough_36"] = "traverse_jump_over_36";
	level.dogtraverseanims["window_over_40"] = "traverse_jump_over_36";
	level.dogtraverseanims["window_over_quick"] = "traverse_jump_over_36";
	level.dogtraverseanims["jump_up_80"] = "traverse_jump_up_70";
	level.dogtraverseanims["jump_standing_80"] = "traverse_jump_up_70";
	level.dogtraverseanims["jump_down_80"] = "traverse_jump_down_70";
	level.dogtraverseanims["jumpdown_96"] = "traverse_jump_down_70";
	level.dogtraverseanims["jump_up_40"] = "traverse_jump_up_40";
	level.dogtraverseanims["jump_down_40"] = "traverse_jump_down_40";
	level.dogtraverseanims["step_up"] = "traverse_jump_up_24";
	level.dogtraverseanims["step_up_24"] = "traverse_jump_up_24";
	level.dogtraverseanims["step_down"] = "traverse_jump_down_24";
	level.dogtraverseanims["jump_down"] = "traverse_jump_down_24";
	level.dogtraverseanims["jump_across"] = "traverse_jump_over_36";
	level.dogtraverseanims["jump_across_100"] = "traverse_jump_over_36";
}