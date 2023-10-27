/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\dog\dog_death.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 2:17:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	if(isdefined(self.a.var_D55))
	{
		wait 1.1;
		var_00 = self getdroptofloorposition();
		if(isdefined(var_00))
		{
			var_01 = common_scripts\utility::spawn_tag_origin();
			var_01.origin = self.origin;
			var_01.angles = self.angles;
			self linkto(var_01);
			var_01 moveto(var_00,0.5);
			wait 0.5;
			self unlink();
			var_01 delete();
		}
		else
		{
			wait 0.5;
		}

		return;
	}

	self unlink();
	if(isdefined(self.enemy) && isdefined(self.enemy.var_78A) && self.enemy.var_78A == self)
	{
		self.enemy.var_78A = undefined;
	}

	self clearanim(%root,0.2);
	self setflaggedanimrestart("dog_anim",%german_shepherd_death_front,1,0.2,1);
	animscripts/shared::donotetracks("dog_anim");
}