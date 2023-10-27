/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_swim_right.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 1:23:50 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::func_6FE1;
	self.animarrayfuncs["hiding"]["crouch"] = ::func_6FE1;
	self endon("killanimscript");
	animscripts/utility::func_4622("cover_swim_right");
	if(!isdefined(self.var_EB9) || self.var_EB9 != "cover_corner_r")
	{
		self.var_EB9 = "cover_corner_r";
	}

	var_00 = level.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
	animscripts/corner::func_1F52("right",var_00[1]);
}

//Function Number: 2
end_script()
{
	animscripts/corner::end_script_corner();
	animscripts/cover_behavior::end_script("right");
}

//Function Number: 3
func_6FE1()
{
	self.a.var_ED8 = animscripts/swim::func_3C1D("cover_corner_r");
	var_00 = level.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
	self.var_420F = var_00[1];
}