/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: cover_swim_right.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:00:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::setanims_coverright_stand;
	self.animarrayfuncs["hiding"]["crouch"] = ::setanims_coverright_stand;
	self endon("killanimscript");
	animscripts\utility::initialize("cover_swim_right");
	if(!isdefined(self.approachtype) || self.approachtype != "cover_corner_r")
	{
		self.approachtype = "cover_corner_r";
	}

	var_00 = level.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
	animscripts\corner::corner_think("right",var_00[1]);
}

//Function Number: 2
end_script()
{
	animscripts\corner::end_script_corner();
	animscripts\cover_behavior::end_script("right");
}

//Function Number: 3
setanims_coverright_stand()
{
	self.a.array = animscripts\swim::getswimanim("cover_corner_r");
	var_00 = level.archetypes["soldier"]["swim"]["arrival_cover_corner_r_angleDelta"][4][4];
	self.hideyawoffset = var_00[1];
}