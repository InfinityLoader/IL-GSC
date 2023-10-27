/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_scripted.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 177 ms
 * Timestamp: 10/27/2023 3:02:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("death");
	self notify("killanimscript");
	self endon("end_sequence");
	if(!(IsDefined(self.codescripted["animState"])))
	{
		return;
	}

	self startscriptedanim(self.codescripted["origin"],self.codescripted["angles"],self.codescripted["animState"],self.codescripted["animSubState"],self.codescripted["AnimMode"]);
	self.a.script = "scripted";
	self.codescripted = undefined;
	if(IsDefined(self.deathstring_passed))
	{
		self.deathstring = self.deathstring_passed;
	}

	self waittill("killanimscript");
}

//Function Number: 2
init(origin,angles,animstate,animsubstate,animmode)
{
	self.codescripted["origin"] = origin;
	self.codescripted["angles"] = angles;
	self.codescripted["animState"] = animstate;
	self.codescripted["animSubState"] = animsubstate;
	if(IsDefined(animmode))
	{
		self.codescripted["AnimMode"] = animmode;
	}
	else
	{
		self.codescripted["AnimMode"] = "normal";
	}
}

//Function Number: 3
end_script()
{
}