/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_traverse.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 87 ms
 * Timestamp: 10/27/2023 1:16:42 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	if(!isdefined(level.dogtraverseanims))
	{
		func_4607();
	}

	var_00 = self getnegotiationstartnode();
	var_01 = self getnegotiationendnode();
	var_02 = undefined;
	var_02 = level.dogtraverseanims[var_00.animscript];
	if(!isdefined(var_02))
	{
		return;
	}

	self.blockgoalpos = 1;
	var_03 = var_01.origin - var_00.origin;
	var_04 = (var_03[0],var_03[1],0);
	var_05 = vectortoangles(var_04);
	self scragentsetorientmode("face angle abs",var_05);
	self scragentsetanimmode("anim deltas");
	var_06 = self getanimentry(var_02,0);
	var_07 = getnotetracktimes(var_06,"code_move");
	if(var_07.size > 0)
	{
		var_08 = getmovedelta(var_06,0,var_07[0]);
	}
	else
	{
		var_08 = getmovedelta(var_07,0,1);
	}

	var_09 = maps/mp/agents/_scriptedagents::getanimscalefactors(var_03,var_08);
	self scragentsetphysicsmode("noclip");
	if(var_03[2] > 0)
	{
		if(var_08[2] > 0)
		{
			var_0A = getnotetracktimes(var_06,"traverse_jump_start");
			if(var_0A.size > 0)
			{
				var_0B = 1;
				var_0C = 1;
				if(length2dsquared(var_04) < 0.64 * length2dsquared(var_08))
				{
					var_0B = 0.4;
				}

				if(var_03[2] < 0.75 * var_08[2])
				{
					var_0C = 0.5;
				}

				self scragentsetanimscale(var_0B,var_0C);
				maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_02,0,"traverse","traverse_jump_start");
				var_0D = getnotetracktimes(var_06,"traverse_jump_end");
				var_0E = getmovedelta(var_06,0,var_0A[0]);
				var_0F = getmovedelta(var_06,0,var_0D[0]);
				var_0B = 1;
				var_0C = 1;
				var_10 = var_01.origin - self.origin;
				var_11 = var_08 - var_0E;
				if(length2dsquared(var_10) < 0.5625 * length2dsquared(var_11))
				{
					var_0B = 0.75;
				}

				if(var_10[2] < 0.75 * var_11[2])
				{
					var_0C = 0.75;
				}

				var_12 = var_08 - var_0F;
				var_13 = (var_12[0] * var_0B,var_12[1] * var_0B,var_12[2] * var_0C);
				var_14 = rotatevector(var_13,var_05);
				var_15 = var_01.origin - var_14;
				var_16 = var_0F - var_0E;
				var_17 = rotatevector(var_16,var_05);
				var_18 = var_15 - self.origin;
				var_09 = maps/mp/agents/_scriptedagents::getanimscalefactors(var_18,var_17,1);
				self scragentsetanimscale(var_09.xy,var_09.z);
				maps/mp/agents/_scriptedagents::func_8BCA("traverse","traverse_jump_end");
				self scragentsetanimscale(var_0B,var_0C);
				maps/mp/agents/_scriptedagents::func_8BCA("traverse","code_move");
				return;
			}

			self scragentsetanimscale(var_09.xy,var_09.z);
			maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_02,0,"traverse");
			return;
		}

		var_19 = getnotetracktimes(var_06,"gravity on");
		if(var_19.size > 0)
		{
			var_1A = var_00 gettargetentpos();
			if(isdefined(var_1A))
			{
				var_1B = var_1A - self.origin;
				var_1C = var_01.origin - var_1A;
				var_1D = getmovedelta(var_06,0,var_19[0]);
				var_09 = maps/mp/agents/_scriptedagents::getanimscalefactors(var_1B,var_1D);
				self scragentsetanimscale(var_09.xy,var_09.z);
				maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_02,0,"traverse","gravity on");
				var_1E = getmovedelta(var_06,var_19[0],1);
				var_09 = maps/mp/agents/_scriptedagents::getanimscalefactors(var_1C,var_1E);
				self scragentsetanimscale(var_09.xy,var_09.z);
				maps/mp/agents/_scriptedagents::func_8BCA("traverse","code_move");
				return;
			}
		}

		var_1F = getanimlength(var_19);
		self scragentdoanimlerp(var_04.origin,var_05.origin,var_1F);
		maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_06,0,"traverse");
		return;
	}

	var_19 = getnotetracktimes(var_1B,"gravity on");
	if(var_1F.size > 0)
	{
		self scragentsetanimscale(var_1D.xy,1);
		maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_07,0,"traverse","gravity on");
		var_20 = getmovedelta(var_1A,0,var_1F[0]);
		var_21 = var_20[2] - var_1C[2];
		if(abs(var_21) > 0)
		{
			var_22 = self.origin[2] - var_06.origin[2];
			var_0C = var_22 / var_21;
			self scragentsetanimscale(var_1D.xy,var_0C);
			var_23 = clamp(2 / var_0C,0.5,1);
			var_24 = var_07 + "_norestart";
			self setanimstate(var_24,0,var_23);
		}

		maps/mp/agents/_scriptedagents::func_8BCA("traverse","code_move");
	}
	else
	{
		self scragentsetanimscale(var_1D.xy,var_1D.z);
		var_23 = clamp(2 / var_1D.z,0.5,1);
		var_0D = getnotetracktimes(var_1A,"traverse_jump_end");
		if(var_0D.size > 0)
		{
			maps/mp/agents/_scriptedagents::playanimnatrateuntilnotetrack(var_07,0,var_23,"traverse","traverse_jump_end");
			var_24 = var_07 + "_norestart";
			self setanimstate(var_24,0,1);
			maps/mp/agents/_scriptedagents::func_8BCA("traverse","code_move");
		}
		else
		{
			maps/mp/agents/_scriptedagents::playanimnuntilnotetrack(var_07,0,"traverse");
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
func_4607()
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
	level.dogtraverseanims["jump_up_40"] = "traverse_jump_up_40";
	level.dogtraverseanims["jump_down_40"] = "traverse_jump_down_40";
	level.dogtraverseanims["step_up"] = "traverse_jump_up_24";
	level.dogtraverseanims["step_up_24"] = "traverse_jump_up_24";
	level.dogtraverseanims["step_down"] = "traverse_jump_down_24";
	level.dogtraverseanims["jump_down"] = "traverse_jump_down_24";
	level.dogtraverseanims["jump_across"] = "traverse_jump_over_36";
	level.dogtraverseanims["jump_across_100"] = "traverse_jump_over_36";
}