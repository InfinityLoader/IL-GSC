/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\dog\dog_pain.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 2:17:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	if(isdefined(self.enemy) && isdefined(self.enemy.var_78A) && self.enemy.var_78A == self)
	{
		self unlink();
		self.enemy.var_78A = undefined;
	}

	self clearanim(%root,0.2);
	self setflaggedanimrestart("dog_pain_anim",%german_shepherd_run_pain,1,0.2,1);
	animscripts/shared::donotetracks("dog_pain_anim");
}