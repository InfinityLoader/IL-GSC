/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: technical_lagos\stand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 1:58:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self.a.movement = "stop";
	var_00 = self getturret();
	var_00 thread turretinit(self);
	self.primaryturretanim = %technicalgunner_aim;
	self.additiveturretidle = %technical_turret_driveidle;
	self.additiveturretfire = %technical_turret_firing;
	self.painfunction = ::technical_pain;
	self.deathanim = %technical_turret_death;
	thread animscripts\technical_lagos\common::main(var_00);
}

//Function Number: 2
technical_pain()
{
	self setflaggedanimknoballrestart("painanim",%technical_turret_pain,%body,1,0.1,1);
	animscripts\shared::donotetracks("painanim");
}

//Function Number: 3
turretinit(param_00)
{
	self.leftarc = 115;
	self.rightarc = 115;
	self useanimtree(#animtree);
	self.additiveturretidle = %saw_gunner_idle_mg;
	self.additiveturretfire = %saw_gunner_firing_mg_add;
	self endon("death");
	param_00 waittill("killanimscript");
	self stopuseanimtree();
}