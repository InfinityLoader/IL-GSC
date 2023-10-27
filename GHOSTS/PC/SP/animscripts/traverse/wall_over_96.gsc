/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_over_96.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 1:23:07 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.traversedeath = 1;
	advancedtraverse2(%traverse90,96);
}

//Function Number: 2
advancedtraverse2(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.var_82CB - var_02.origin[2];
	self setflaggedanimknoballrestart("traverse",param_00,%body,1,0.15,1);
	var_04 = gettime();
	thread animscripts/notetracks::donotetracksforever("traverse","no clear",::handle_death);
	if(!animhasnotetrack(param_00,"gravity on"))
	{
		var_04 = 1.23;
		var_05 = 0.2;
		wait(5);
		self traversemode("gravity");
		wait(var_05);
	}

	self waittillmatch("gravity on","traverse");
	self traversemode("gravity");
	if(!animhasnotetrack(param_00,"blend"))
	{
		wait(0.2);
	}

	self waittillmatch("blend","traverse");
}

//Function Number: 3
handle_death(param_00)
{
	if(param_00 != "traverse_death")
	{
	}

	self endon("killanimscript");
	if(self.health == 1)
	{
		self.a.var_564F = 1;
		if(self.traversedeath > 1)
		{
			self setflaggedanimknoball("deathanim",%traverse90_end_death,%body,1,0.2,1);
		}
		else
		{
			self setflaggedanimknoball("deathanim",%traverse90_start_death,%body,1,0.2,1);
		}

		animscripts/face::func_6AB2("death");
	}

	self.traversedeath++;
}