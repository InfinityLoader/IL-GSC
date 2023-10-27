/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\ladder_down.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 2:29:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationendnode();
	var_01 = var_00.origin;
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = 1;
	if(isdefined(self.moveplaybackrate))
	{
		var_03 = self.moveplaybackrate;
	}

	self setflaggedanimknoballrestart("climbanim",%ladder_climbon,%body,1,0.1,var_03);
	animscripts/shared::donotetracks("climbanim");
	var_04 = %ladder_climbdown;
	self setflaggedanimknoballrestart("climbanim",var_04,%body,1,0.1,var_03);
	var_05 = getmovedelta(var_04,0,1);
	var_06 = var_05[2] * var_03 / getanimlength(var_04);
	var_07 = var_01[2] - self.origin[2] / var_06;
	animscripts/notetracks::donotetracksfortime(var_07,"climbanim");
	self traversemode("gravity");
	self.a.movement = "stop";
	self.a.var_911 = "stand";
}