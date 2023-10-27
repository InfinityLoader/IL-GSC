/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_100.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 2:17:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_176("window_40",20);
		return;
	}

	self.desired_anim_pose = "stand";
	animscripts/utility::func_247B();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	var_01 = [];
	var_02 = var_7B[randomint(var_7B.size)];
	self setflaggedanimknoballrestart("jumpanim",var_02,%body,1,0.1,1);
	animscripts/shared::donotetracks("jumpanim");
}