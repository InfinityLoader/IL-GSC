/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\crawl.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:53:31 AM
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