/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_cover_arrival.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 21 ms
 * Timestamp: 4/22/2024 1:58:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	thread animscripts\dog\dog_move::handlefootstepnotetracks();
	self clearanim(%dog_move,0.2);
	self setflaggedanimknoballrestart("dog_stop",self.dogarrivalanim,%body,1,0.2,self.moveplaybackrate);
	animscripts\shared::donotetracks("dog_stop");
	self.dogarrivalanim = undefined;
}