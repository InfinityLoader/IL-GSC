/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\ladder_up.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 1:23:02 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(isdefined(self.type) && self.type == "dog")
	{
		return;
	}

	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = %ladder_climbup;
	var_01 = %ladder_climboff;
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = 1;
	if(isdefined(self.moveplaybackrate))
	{
		var_03 = self.moveplaybackrate;
	}

	self setflaggedanimknoballrestart("climbanim",var_00,%body,1,0.1,var_03);
	var_04 = getmovedelta(var_01,0,1);
	var_05 = self getnegotiationendnode();
	var_06 = var_05.origin - var_04 + (0,0,1);
	var_07 = getmovedelta(var_00,0,1);
	var_08 = var_07[2] * var_03 / getanimlength(var_00);
	var_09 = var_06[2] - self.origin[2] / var_08;
	if(var_09 > 0)
	{
		self.allowpain = 1;
		animscripts/notetracks::donotetracksfortime(var_09,"climbanim");
		self setflaggedanimknoballrestart("climbanim",var_01,%body,1,0.1,var_03);
		animscripts/shared::func_2986("climbanim");
	}

	self traversemode("gravity");
	self.a.var_5486 = "run";
	self.a.var_60B1 = "crouch";
}