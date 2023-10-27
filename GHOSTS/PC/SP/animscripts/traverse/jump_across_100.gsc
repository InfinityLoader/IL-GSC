/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_100.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:22:58 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::dog_long_jump("window_40",20);
		return;
	}

	self.desired_anim_pose = "stand";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	var_01 = [];
	var_01[0] = %jump_across_100_spring;
	var_01[1] = %jump_across_100_lunge;
	var_01[2] = %jump_across_100_stumble;
	var_02 = var_01[randomint(var_01.size)];
	self setflaggedanimknoballrestart("jumpanim",var_02,%body,1,0.1,1);
	animscripts/shared::func_2986("jumpanim");
}