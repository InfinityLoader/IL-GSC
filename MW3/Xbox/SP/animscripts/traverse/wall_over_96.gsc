/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_over_96.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 72 ms
 * Timestamp: 10/27/2023 2:29:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.traversedeath = 1;
	func_3B0B(%traverse90,96);
}

//Function Number: 2
func_3B0B(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.var_1A98 - var_02.origin[2];
	self setflaggedanimknoballrestart("traverse",param_00,%body,1,0.15,1);
	var_04 = gettime();
	thread animscripts/notetracks::donotetracksforever("traverse","no clear",::func_3B0C);
	if(!animhasnotetrack(param_00,"gravity on"))
	{
		var_04 = 1.23;
		var_05 = 0.2;
		wait 5;
		self traversemode("gravity");
		wait var_05;
		return;
	}

	self waittillmatch("gravity on","traverse");
	self traversemode("gravity");
	if(!animhasnotetrack(param_00,"blend"))
	{
		wait 0.2;
		return;
	}

	self waittillmatch("blend","traverse");
}

//Function Number: 3
func_3B0C(param_00)
{
	if(param_00 != "traverse_death")
	{
		return;
	}

	self endon("killanimscript");
	if(self.health == 1)
	{
		self.a.nodeath = 1;
		if(self.traversedeath > 1)
		{
			self setflaggedanimknoball("deathanim",%traverse90_end_death,%body,1,0.2,1);
		}
		else
		{
			self setflaggedanimknoball("deathanim",%traverse90_start_death,%body,1,0.2,1);
		}

		animscripts/face::saygenericdialogue("death");
	}

	self.traversedeath++;
}