/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\crawl.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 1:59:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	animscripts\setposemovement::pronerun_begin();
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("crawlanim",%prone_crawl,%body,1,0.1,1);
	animscripts\shared::donotetracks("crawlanim");
	self.a.movement = "run";
	self.a.pose = "crouch";
}