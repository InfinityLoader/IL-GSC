/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\window_2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 1:59:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("wallhop",40);
		return;
	}

	advancedwindowtraverse(%windowclimb,35);
}

//Function Number: 2
advancedwindowtraverse(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.traverse_height - var_02.origin[2];
	self setflaggedanimknoballrestart("traverse",param_00,%body,1,0.15,1);
	wait(0.7);
	thread animscripts\traverse\shared::teleportthread(var_03 - param_01);
	wait(0.9);
	self traversemode("gravity");
	animscripts\shared::donotetracks("traverse");
}