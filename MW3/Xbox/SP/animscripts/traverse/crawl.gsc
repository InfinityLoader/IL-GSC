/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\crawl.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 2:29:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	animscripts/setposemovement::beginpronerun();
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("crawlanim",%prone_crawl,%body,1,0.1,1);
	animscripts/shared::donotetracks("crawlanim");
	self.a.movement = "run";
	self.a.var_911 = "crouch";
}