/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\seoul_jump_landassist.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 1:59:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = [];
	var_01 = undefined;
	var_02 = undefined;
	var_03 = randomfloat(100);
	var_04 = undefined;
	if(var_03 < 33)
	{
		var_04 = "a";
	}
	else if(var_03 < 66)
	{
		var_04 = "b";
	}
	else if(var_03 < 100)
	{
		var_04 = "c";
	}

	if(var_04 == "a")
	{
		var_00["traverseAnim"] = %seo_jumpdown_assist_start_jump_a;
		var_01 = %seo_jumpdown_assist_falling_idle_a;
	}
	else if(var_04 == "b")
	{
		var_00["traverseAnim"] = %seo_jumpdown_assist_start_jump_b;
		var_01 = %seo_jumpdown_assist_falling_idle_b;
	}
	else if(var_04 == "c")
	{
		var_00["traverseAnim"] = %seo_jumpdown_assist_start_jump_c;
		var_01 = %seo_jumpdown_assist_falling_idle_c;
	}

	var_00["traverseNotetrackFunc"] = ::animscripts\traverse\boost::handletraversenotetrackslandassist;
	var_05 = get_post_landing_dir(self.node);
	var_06 = undefined;
	if(var_05 == 1)
	{
		var_06 = %seo_jumpdown_assist_landing_1;
	}
	else if(var_05 == 2)
	{
		var_06 = %seo_jumpdown_assist_landing_2;
	}
	else if(var_05 == 3)
	{
		var_06 = %seo_jumpdown_assist_landing_3;
	}
	else if(var_05 == 4)
	{
		var_06 = %seo_jumpdown_assist_landing_4;
	}
	else if(var_05 == 6)
	{
		var_06 = %seo_jumpdown_assist_landing_6;
	}
	else if(var_05 == 7)
	{
		var_06 = %seo_jumpdown_assist_landing_7;
	}
	else if(var_05 == 8)
	{
		var_06 = %seo_jumpdown_assist_landing_8;
	}
	else if(var_05 == 9)
	{
		var_06 = %seo_jumpdown_assist_landing_9;
	}

	var_07 = 0;
	if(isdefined(var_06))
	{
		var_07 = getmovedelta(var_06,0,1)[2];
	}

	animscripts\traverse\shared::dotraverse(var_00);
	var_08 = self.origin + (0,0,32);
	if(isdefined(self getnegotiationendnode()))
	{
		var_02 = (var_08[0],var_08[1],self getnegotiationendnode().origin[2]);
	}
	else
	{
		var_02 = physicstrace(var_08,self.origin + (0,0,-5120));
	}

	var_09 = distance(var_08,var_02);
	var_0A = var_09 - 32 - 0.5 + var_07;
	play_loop_until_drop_distance(var_01,var_0A,var_07);
	self setflaggedanimknoballrestart("traverse_align",var_06,%body,1,0.2,1);
	animscripts\shared::donotetracks("traverse_align",::animscripts\traverse\boost::handletraversenotetrackslandassist);
}

//Function Number: 2
play_loop_until_drop_distance(param_00,param_01,param_02)
{
	var_03 = self.origin[2];
	var_04 = animscripts\utility::get_trajectory_time_given_x(0,param_01,self.velocity[2],getdvarfloat("g_gravity"));
	self setflaggedanimknoballrestart("idle",param_00,%body,1,0.1,1);
	self animmode("gravity_noclip");
	var_05 = -1;
	var_06 = 0;
	while(var_05 <= param_01)
	{
		var_05 = var_03 - self.origin[2];
		var_06 = var_06 + 0.05;
		var_07 = animscripts\utility::get_trajectory_x_given_time(0,self.velocity[2],-1 * getdvarfloat("g_gravity"),0.05);
		if(var_07 < var_05 - param_01)
		{
			self animmode("gravity");
		}

		if(var_06 > var_04 + 1)
		{
			self forceteleport(self getnegotiationendnode().origin + (0,0,param_02));
			break;
		}

		wait(0.05);
	}

	self clearanim(param_00,0.2);
}

//Function Number: 3
get_post_landing_dir(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(!isdefined(param_01))
	{
		var_02 = self getnegotiationendnode().origin;
		var_03 = self getnegotiationnextnode();
	}
	else
	{
		var_02 = param_01;
		var_04 = getnodesonpath(var_02,param_00.origin,1,undefined,param_00);
		var_03 = undefined;
		foreach(var_03 in var_04)
		{
			if(var_03.type != "End" && (isdefined(var_03.radius) && distance2d(param_01,var_03.origin) > var_03.radius) || !isdefined(var_03.radius) && distance2d(param_01,var_03.origin) > self.goalradius)
			{
				break;
			}
		}
	}

	if(!isdefined(var_03) || !isdefined(var_03))
	{
		return 5;
	}

	var_07 = self.angles[1];
	var_08 = "exposed";
	var_09 = var_02 - var_03.origin;
	var_09 = (var_09[0],var_09[1],0);
	var_0A = 9;
	var_0B = -1;
	var_0C = spawnstruct();
	animscripts\exit_node::calculatenodetransitionangles(var_0C,var_08,1,var_07,var_09,var_0A,var_0B);
	animscripts\exit_node::sortnodetransitionangles(var_0C,var_0A);
	return var_0C.transindex[1];
}

//Function Number: 4
find_landing_node_along_path(param_00)
{
	var_01 = getnodesonpath(self.origin,param_00.origin);
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in var_01)
	{
		if(!isdefined(var_02))
		{
			if(isdefined(var_05.animscript) && var_05.animscript == "seoul_jump_landassist")
			{
				var_02 = var_05;
			}

			continue;
		}

		var_03 = var_05;
		break;
	}

	return [var_02,var_03];
}