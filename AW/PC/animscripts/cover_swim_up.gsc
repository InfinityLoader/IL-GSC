/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: cover_swim_up.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 2:00:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::setanims_coverup_stand;
	self.animarrayfuncs["hiding"]["crouch"] = ::setanims_coverup_stand;
	self endon("killanimscript");
	animscripts\utility::initialize("cover_swim_up");
	if(!isdefined(self.approachtype) || self.approachtype != "cover_u")
	{
		self.approachtype = "cover_u";
	}

	animscripts\corner::corner_think("up",0);
}

//Function Number: 2
end_script()
{
	animscripts\corner::end_script_corner();
	animscripts\cover_behavior::end_script("up");
}

//Function Number: 3
setanims_coverup_stand()
{
	self.a.array = animscripts\swim::getswimanim("cover_u");
	self.hideyawoffset = 0;
}