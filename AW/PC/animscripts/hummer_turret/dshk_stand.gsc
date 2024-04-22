/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: hummer_turret\dshk_stand.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 54 ms
 * Timestamp: 4/22/2024 1:58:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = self getturret();
	var_01 = get_death_anim();
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self.primaryturretanim = %gazgunner_aim;
	self.additiveturretrotateleft = %gaz_turret_aim_6_add;
	self.additiveturretrotateright = %gaz_turret_aim_4_add;
	self.additiverotateroot = %additive_gazgunner_aim_leftright;
	self.additiveturretidle = %gaz_turret_idle;
	self.additiveturretdriveidle = %gaz_turret_idle;
	self.additiveturretfire = %gaz_turret_fire;
	self.additiveusegunroot = %additive_gazgunner_usegun;
	self.turretdeathanimroot = %gazgunner_death;
	self.turretdeathanim = var_01;
	self.turretpainanims[0] = %gaz_turret_paina;
	self.turretpainanims[1] = %gaz_turret_painb;
	self.turretflashbangedanim = %gaz_turret_flincha;
	self.turretreloadanim = %gaz_turret_paina;
	self.turretspecialanimsroot = %gazgunner;
	var_02 = [];
	var_02["humvee_turret_flinchA"] = %gaz_turret_flincha;
	var_02["humvee_turret_flinchB"] = %gaz_turret_flinchb;
	self.turretspecialanims = var_02;
	var_00 setup_turret_anims();
	thread animscripts\hummer_turret\minigun_code::main(var_00);
}

//Function Number: 2
get_death_anim()
{
	var_00 = %gaz_turret_death;
	if(isdefined(self.ridingvehicle))
	{
		if(isdefined(level.dshk_death_anim))
		{
			var_00 = self [[ level.dshk_death_anim ]]();
		}
	}

	return var_00;
}

//Function Number: 3
setup_turret_anims()
{
	self useanimtree(#animtree);
	self.passenger2turret_anime = %humvee_passenger_2_turret_minigun;
	self.turret2passenger_anime = %humvee_turret_2_passenger_minigun;
}