/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: saw\stand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 1:58:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self.a.movement = "stop";
	var_00 = self getturret();
	var_00 thread turretinit(self);
	self.primaryturretanim = %standsawgunner_aim;
	self.additiveturretidle = %saw_gunner_idle;
	self.additiveturretfire = %saw_gunner_firing_add;
	thread animscripts\saw\common::main(var_00);
}

//Function Number: 2
turretinit(param_00)
{
	self useanimtree(#animtree);
	self.additiveturretidle = %saw_gunner_idle_mg;
	self.additiveturretfire = %saw_gunner_firing_mg_add;
	self endon("death");
	param_00 waittill("killanimscript");
	self stopuseanimtree();
}