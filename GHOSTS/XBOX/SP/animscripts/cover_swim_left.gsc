/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_swim_left.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 1:36:20 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::func_6FE0;
	self.animarrayfuncs["hiding"]["crouch"] = ::func_6FE0;
	self endon("killanimscript");
	animscripts/utility::func_4622("cover_swim_left");
	if(!isdefined(self.var_EB9) || self.var_EB9 != "cover_corner_l")
	{
		self.var_EB9 = "cover_corner_l";
	}

	var_00 = level.archetypes["soldier"]["swim"]["arrival_cover_corner_l_angleDelta"][4][4];
	animscripts/corner::func_1F52("left",var_00[1]);
}

//Function Number: 2
end_script()
{
	animscripts/corner::end_script_corner();
	animscripts/cover_behavior::end_script("left");
}

//Function Number: 3
func_6FE0()
{
	self.a.var_ED8 = animscripts/swim::func_3C1D("cover_corner_l");
	var_00 = level.archetypes["soldier"]["swim"]["arrival_cover_corner_l_angleDelta"][4][4];
	self.var_420F = var_00[1];
}