/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\hummer_turret\minigun_stand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 1:53:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = self getturret();
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self.primaryturretanim = %humveegunner_aim;
	self.additiveturretrotateleft = %humvee_turret_aim_6_add;
	self.additiveturretrotateright = %humvee_turret_aim_4_add;
	self.additiverotateroot = %additive_humveegunner_aim_leftright;
	self.additiveturretidle = %humvee_turret_idle;
	self.additiveturretdriveidle = %humvee_turret_driveidle;
	self.additiveturretfire = %humvee_turret_fire;
	self.additiveusegunroot = %additive_humveegunner_usegun;
	self.turretdeathanimroot = %humveegunner_death;
	self.turretdeathanim = %humvee_turret_death;
	self.turretpainanims[0] = %humvee_turret_paina;
	self.turretpainanims[1] = %humvee_turret_painb;
	self.turretflashbangedanim = %humvee_turret_flincha;
	self.turretreloadanim = %humvee_turret_rechamber;
	self.turretspecialanimsroot = %humveegunner;
	var_01 = [];
	var_01["humvee_turret_bounce"] = %humvee_turret_bounce;
	var_01["humvee_turret_idle_lookback"] = %humvee_turret_idle_lookback;
	var_01["humvee_turret_idle_lookbackB"] = %humvee_turret_idle_lookbackb;
	var_01["humvee_turret_idle_signal_forward"] = %humvee_turret_idle_signal_forward;
	var_01["humvee_turret_idle_signal_side"] = %humvee_turret_idle_signal_side;
	var_01["humvee_turret_radio"] = %humvee_turret_radio;
	var_01["humvee_turret_flinchA"] = %humvee_turret_flincha;
	var_01["humvee_turret_flinchB"] = %humvee_turret_flinchb;
	var_01["humvee_turret_rechamber"] = %humvee_turret_rechamber;
	self.turretspecialanims = var_01;
	var_00 setup_turret_anims();
	thread animscripts\hummer_turret\minigun_code::main(var_00);
}

//Function Number: 2
setup_turret_anims()
{
	self useanimtree(#animtree);
	self.passenger2turret_anime = %humvee_passenger_2_turret_minigun;
	self.turret2passenger_anime = %humvee_turret_2_passenger_minigun;
}