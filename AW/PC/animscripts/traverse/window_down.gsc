/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\window_down.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 70 ms
 * Timestamp: 4/22/2024 1:59:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = %windowclimb_fall;
	var_01 = %windowclimb_land;
	var_02 = 35;
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("noclip");
	var_03 = self getnegotiationstartnode();
	self orientmode("face angle",var_03.angles[1]);
	var_04 = var_03.traverse_height - var_03.origin[2];
	self setflaggedanimknoballrestart("traverse",var_00,%body,1,0.15,1);
	thread animscripts\notetracks::donotetracksforever("traverse","stop_traverse_notetracks");
	wait(1.5);
	var_05 = (0,var_03.angles[1],0);
	var_06 = anglestoforward(var_05);
	var_06 = var_06 * 85;
	var_07 = bullettrace(var_03.origin + var_06,var_03.origin + var_06 + (0,0,-500),0,undefined);
	var_08 = var_07["position"][2];
	var_09 = var_03.origin[2] - var_08;
	var_0A = 0;
	for(var_0B = 0;var_0B < level.window_down_height.size;var_0B++)
	{
		if(var_09 < level.window_down_height[var_0B])
		{
			continue;
		}

		var_0A = var_09 - level.window_down_height[var_0B];
	}

	thread animscripts\traverse\shared::teleportthread(var_0A * -1);
	var_0C = self.origin[2];
	var_0D = 0;
	level.traversefall = [];
	for(;;)
	{
		var_0D = var_0C - self.origin[2];
		if(self.origin[2] - var_0D < var_08)
		{
			break;
		}

		var_0C = self.origin[2];
		wait(0.05);
	}

	if(isdefined(self.groundtype))
	{
		self playsound("Land_" + self.groundtype);
	}

	self notify("stop_traverse_notetracks");
	self setflaggedanimknoballrestart("traverse",var_01,%body,1,0.15,1);
	self traversemode("gravity");
	animscripts\shared::donotetracks("traverse");
}

//Function Number: 2
printer(param_00)
{
	level notify("print_this_" + param_00);
	level endon("print_this_" + param_00);
	wait(0.05);
}

//Function Number: 3
showline(param_00,param_01)
{
	wait(0.05);
}

//Function Number: 4
printerdebugger(param_00,param_01)
{
	level notify("prrint_this_" + param_01);
	level endon("prrint_this_" + param_01);
	wait(0.05);
}