/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\slide_across_car.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:29:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		slide_across_car_dog();
		return;
	}

	func_3B08();
}

//Function Number: 2
func_3B08()
{
	var_00 = [];
	var_29["interruptDeathAnim"] = 0;
	animscripts/traverse/shared::func_3AEF(var_29);
}

//Function Number: 3
slide_across_car_dog()
{
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self clearanim(%root,0.1);
	self setflaggedanimrestart("traverse",level.dogtraverseanims["jump_up_40"],1,0.1,1);
	animscripts/shared::donotetracks("traverse");
	thread common_scripts\utility::play_sound_in_space("anml_dog_bark",self gettagorigin("tag_eye"));
	self clearanim(%root,0);
	self setflaggedanimrestart("traverse",level.dogtraverseanims["jump_down_40"],1,0,1);
	animscripts/shared::donotetracks("traverse");
	self traversemode("gravity");
	self.var_3682 = 1;
}