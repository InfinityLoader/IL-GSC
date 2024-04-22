/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_mutators.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 923 ms
 * Timestamp: 4/22/2024 2:13:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	initmutatortable();
	initexomutator();
	initdismemberment();
	initdismembermentweaponmodifiers();
	level.activemutators = [];
}

//Function Number: 2
addmutatortotable(param_00,param_01,param_02,param_03,param_04)
{
	level.mutators[param_00] = [];
	level.mutators[param_00][0] = param_01;
	level.mutators[param_00][2] = param_02;
	level.mutators[param_00][3] = param_03;
	level.mutators[param_00][4] = param_04;
}

//Function Number: 3
disablemutatorfortypes(param_00,param_01)
{
	if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	foreach(var_03 in param_01)
	{
		level.mutators_disabled[var_03][param_00] = 1;
	}
}

//Function Number: 4
initfastmutator()
{
	level._effect["mut_fast_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_fast_head");
	addmutatortotable("fast",::mutatorfast,"zmb_mut_fast_spawn");
	disablemutatorfortypes("fast",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
}

//Function Number: 5
initexplodermutator()
{
	level._effect["mut_exp_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_head");
	level._effect["mut_exp_arm_l"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_upperarm_lt");
	level._effect["mut_exp_arm_r"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_upperarm_rt");
	level._effect["mut_exp_back"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_back");
	level._effect["mut_exp_explosion_sm"] = loadfx("vfx/gameplay/mp/zombie/zombie_xplod_detonate_sml");
	level._effect["mut_exp_explosion_lg"] = loadfx("vfx/gameplay/mp/zombie/zombie_xplod_detonate_lrg");
	level._effect["mut_exp_charge"] = loadfx("vfx/gameplay/mp/zombie/zombie_xplod_detonate_charge");
	addmutatortotable("exploder",::mutatorexploder,"zmb_mut_expl_spawn",::onexploderzombiekilled);
	disablemutatorfortypes("exploder",["zombie_melee_goliath","zombie_ranged_goliath"]);
}

//Function Number: 6
initemzmutator()
{
	level._effect["mut_emz_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_head");
	level._effect["mut_emz_arm_l"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_upperarm_lt");
	level._effect["mut_emz_arm_r"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_upperarm_rt");
	level._effect["mut_emz_back"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_back");
	level._effect["mut_emz_explosion"] = loadfx("vfx/explosion/emp_grenade_lrg_mp");
	level._effect["mut_emz_attack_sm"] = loadfx("vfx/gameplay/mp/zombie/zombie_attack_emz");
	level._effect["mut_emz_attack_lg"] = loadfx("vfx/gameplay/mp/zombie/zombie_attack_emz_lrg");
	addmutatortotable("emz",::mutatoremz,"zmb_mut_emz_spawn");
	disablemutatorfortypes("emz",["zombie_ranged_goliath"]);
}

//Function Number: 7
initmutatortable()
{
	level.mutators = [];
	addmutatortotable("crawl",::mutatorcrawl);
	disablemutatorfortypes("crawl",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
	addmutatortotable("exo",::mutatorexo);
	disablemutatorfortypes("exo",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
}

//Function Number: 8
initexomutator()
{
	if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark")
	{
		level.exobodyparts["zom_civ_ruban_male_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["torso"] = "zom_marine_exo_torso_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_arm"] = "zom_marine_exo_r_arm_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_arm"] = "zom_marine_exo_l_arm_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_leg"] = "zom_marine_exo_r_leg_slice";
		level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_leg"] = "zom_marine_exo_l_leg_slice";
		level.exobodyparts["zom_marine_shotgun_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
		level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
		level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
		level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
		level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
		return;
	}

	level.exobodyparts["zom_civ_ruban_male_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["left_leg"] = "zom_marine_exo_l_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_leg"] = "zom_marine_exo_l_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["left_leg"] = "zom_marine_exo_l_leg_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["left_leg"] = "zom_marine_exo_l_leg_slice";
}

//Function Number: 9
initdismemberment()
{
	level.fullbodygibcounter = 0;
	if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark")
	{
		level.dismemberment["zom_marine_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_emp_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_m_emp_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_m_emp_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_emp_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_emp_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_emp_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_fire_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_m_fire_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_m_fire_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_fire_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_fire_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_fire_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_ovr_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_m_ovr_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
		level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
		level.dismemberment[1]["modelToSpawn"] = "zom_civ_ruban_male_r_arm_phys";
		level.dismemberment[2]["modelToSpawn"] = "zom_civ_ruban_male_r_arm_phys";
		level.dismemberment[4]["modelToSpawn"] = "zom_civ_ruban_male_r_leg_phys";
		level.dismemberment[8]["modelToSpawn"] = "zom_civ_ruban_male_r_leg_phys";
		level.dismemberment[16]["modelToSpawn"] = "zom_civ_urban_male_head_phys";
		level.dismemberment[16]["nub"] = "zom_civ_urban_male_head_slice";
		level.dismemberment[1]["tagName"] = "J_Shoulder_RI";
		level.dismemberment[2]["tagName"] = "J_Shoulder_LE";
		level.dismemberment[4]["tagName"] = "J_Hip_RI";
		level.dismemberment[8]["tagName"] = "J_Hip_LE";
		level.dismemberment[16]["tagName"] = "J_Head";
		level.dismemberment[1]["fxTagName"] = "J_Shoulder_RI";
		level.dismemberment[2]["fxTagName"] = "J_Shoulder_LE";
		level.dismemberment[4]["fxTagName"] = "J_Hip_RI";
		level.dismemberment[8]["fxTagName"] = "J_Hip_LE";
		level.dismemberment[16]["fxTagName"] = "J_Head";
		level.dismemberment["full"]["fxTagName"] = "J_MainRoot";
		level.dismemberment[1]["torsoFX"] = "torso_arm_loss_right";
		level.dismemberment[2]["torsoFX"] = "torso_arm_loss_left";
		level.dismemberment[4]["torsoFX"] = "torso_loss_right";
		level.dismemberment[8]["torsoFX"] = "torso_loss_left";
		level.dismemberment[16]["torsoFX"] = "torso_head_loss";
		level.dismemberment[1]["limbFX"] = "arm_loss_right";
		level.dismemberment[2]["limbFX"] = "arm_loss_left";
		level.dismemberment[4]["limbFX"] = "limb_loss_right";
		level.dismemberment[8]["limbFX"] = "limb_loss_left";
		level.dismemberment[16]["limbFX"] = "head_loss";
		level.dismemberment[1]["dismemberSound"] = "zmb_dism_arm";
		level.dismemberment[2]["dismemberSound"] = "zmb_dism_arm";
		level.dismemberment[4]["dismemberSound"] = "zmb_dism_leg";
		level.dismemberment[8]["dismemberSound"] = "zmb_dism_leg";
		level.dismemberment[16]["dismemberSound"] = "zmb_dism_head";
		level.dismemberment["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
		level.dismemberment[1]["dismemberExoSound"] = "zmb_dism_arm";
		level.dismemberment[2]["dismemberExoSound"] = "zmb_dism_arm_exo";
		level.dismemberment[4]["dismemberExoSound"] = "zmb_dism_leg_exo";
		level.dismemberment[8]["dismemberExoSound"] = "zmb_dism_leg_exo";
		level.dismemberment[16]["dismemberExoSound"] = "zmb_dism_head";
		level.dismemberment["full"]["dismemberExoSound"] = "zmb_dism_instakill_explosion";
		return;
	}

	level.dismemberment["zom_marine_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
	level.dismemberment["zom_marine_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
	level.dismemberment["zom_marine_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment["zom_marine_m_emp_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
	level.dismemberment["zom_marine_m_emp_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
	level.dismemberment["zom_marine_m_emp_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_m_emp_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_m_emp_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment["zom_marine_m_emp_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment["zom_marine_m_fire_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
	level.dismemberment["zom_marine_m_fire_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
	level.dismemberment["zom_marine_m_fire_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_m_fire_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_m_fire_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment["zom_marine_m_fire_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment["zom_marine_m_ovr_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
	level.dismemberment["zom_marine_m_ovr_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
	level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
	level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
	level.dismemberment[1]["modelToSpawn"] = "zom_civ_ruban_male_r_arm_phys";
	level.dismemberment[2]["modelToSpawn"] = "zom_civ_ruban_male_l_arm_phys";
	level.dismemberment[4]["modelToSpawn"] = "zom_civ_ruban_male_r_leg_phys";
	level.dismemberment[8]["modelToSpawn"] = "zom_civ_ruban_male_l_leg_phys";
	level.dismemberment[16]["modelToSpawn"] = "zom_civ_urban_male_head_phys";
	level.dismemberment[16]["nub"] = "zom_civ_urban_male_head_slice";
	level.dismemberment[1]["tagName"] = "J_Shoulder_RI";
	level.dismemberment[2]["tagName"] = "J_Shoulder_LE";
	level.dismemberment[4]["tagName"] = "J_Hip_RI";
	level.dismemberment[8]["tagName"] = "J_Hip_LE";
	level.dismemberment[16]["tagName"] = "J_Head";
	level.dismemberment[1]["fxTagName"] = "J_Shoulder_RI";
	level.dismemberment[2]["fxTagName"] = "J_Shoulder_LE";
	level.dismemberment[4]["fxTagName"] = "J_Hip_RI";
	level.dismemberment[8]["fxTagName"] = "J_Hip_LE";
	level.dismemberment[16]["fxTagName"] = "J_Head";
	level.dismemberment["full"]["fxTagName"] = "J_MainRoot";
	level.dismemberment[1]["torsoFX"] = "torso_arm_loss_right";
	level.dismemberment[2]["torsoFX"] = "torso_arm_loss_left";
	level.dismemberment[4]["torsoFX"] = "torso_loss_right";
	level.dismemberment[8]["torsoFX"] = "torso_loss_left";
	level.dismemberment[16]["torsoFX"] = "torso_head_loss";
	level.dismemberment[1]["limbFX"] = "arm_loss_right";
	level.dismemberment[2]["limbFX"] = "arm_loss_left";
	level.dismemberment[4]["limbFX"] = "limb_loss_right";
	level.dismemberment[8]["limbFX"] = "limb_loss_left";
	level.dismemberment[16]["limbFX"] = "head_loss";
	level.dismemberment[1]["dismemberSound"] = "zmb_dism_arm";
	level.dismemberment[2]["dismemberSound"] = "zmb_dism_arm";
	level.dismemberment[4]["dismemberSound"] = "zmb_dism_leg";
	level.dismemberment[8]["dismemberSound"] = "zmb_dism_leg";
	level.dismemberment[16]["dismemberSound"] = "zmb_dism_head";
	level.dismemberment["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
	level.dismemberment[1]["dismemberExoSound"] = "zmb_dism_arm";
	level.dismemberment[2]["dismemberExoSound"] = "zmb_dism_arm_exo";
	level.dismemberment[4]["dismemberExoSound"] = "zmb_dism_leg_exo";
	level.dismemberment[8]["dismemberExoSound"] = "zmb_dism_leg_exo";
	level.dismemberment[16]["dismemberExoSound"] = "zmb_dism_head";
	level.dismemberment["full"]["dismemberExoSound"] = "zmb_dism_instakill_explosion";
}

//Function Number: 10
initdismembermentweaponmodifiers()
{
	var_00 = "mp/zombieDismembermentModifiers.csv";
	var_01 = 0;
	var_02 = 2;
	var_03 = 3;
	var_04 = 4;
	var_05 = 5;
	var_06 = tablegetrowcount(var_00);
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		var_08 = tablelookupbyrow(var_00,var_07,var_01);
		var_09 = tablelookupbyrow(var_00,var_07,var_02);
		var_0A = tablelookupbyrow(var_00,var_07,var_03);
		var_0B = tablelookupbyrow(var_00,var_07,var_04);
		var_0C = tablelookupbyrow(var_00,var_07,var_05);
		level.dismembermentmodifiers[var_08] = float(var_09);
		level.dismembermentupgrademodifiers[var_08] = float(var_0A);
		level.highdamageweapons[var_08] = var_0B == "true";
		level.dismembermentignorelocation[var_08] = var_0C == "true";
	}
}

//Function Number: 11
mutator_apply(param_00)
{
	if(!isdefined(level.activemutators[param_00]))
	{
		level.activemutators[param_00] = 0;
	}

	if(!isdefined(self.activemutators))
	{
		self.activemutators = [];
	}

	if(isdefined(self.activemutators[param_00]))
	{
		return;
	}

	if(isdefined(level.mutators_disabled[self.agent_type]))
	{
		if(isdefined(level.mutators_disabled[self.agent_type][param_00]) && level.mutators_disabled[self.agent_type][param_00])
		{
			return;
		}
	}

	level.activemutators[param_00]++;
	self.activemutators[param_00] = 1;
	self [[ level.mutators[param_00][0] ]]();
	if(isdefined(self.activemutators))
	{
		self.activemutators[param_00] = undefined;
	}

	level.activemutators[param_00]--;
}

//Function Number: 12
torso_effects_apply(param_00,param_01)
{
	if(isdefined(level._effect[param_00 + "_head"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect[param_00 + "_head"],self,"j_head");
	}

	if(isdefined(level._effect[param_00 + "_arm_r"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect[param_00 + "_arm_r"],self,"j_shoulder_ri");
	}

	if(isdefined(level._effect[param_00 + "_arm_l"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect[param_00 + "_arm_l"],self,"j_shoulder_le");
	}

	if(isdefined(level._effect[param_00 + "_back"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect[param_00 + "_back"],self,"j_spineupper");
	}

	self.torso_fx = param_00;
	if(isdefined(param_01))
	{
		thread torso_effects_remove(param_00,param_01);
	}
}

//Function Number: 13
torso_effects_remove(param_00,param_01)
{
	self notify("removeTorsoEffectsDelayed");
	self endon("removeTorsoEffectsDelayed");
	self endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(isdefined(self))
	{
		if(isdefined(level._effect[param_00 + "_head"]))
		{
			maps\mp\zombies\_util::stopfxontagnetwork(level._effect[param_00 + "_head"],self,"j_head");
		}

		if(isdefined(level._effect[param_00 + "_arm_r"]))
		{
			maps\mp\zombies\_util::stopfxontagnetwork(level._effect[param_00 + "_arm_r"],self,"j_shoulder_ri");
		}

		if(isdefined(level._effect[param_00 + "_arm_l"]))
		{
			maps\mp\zombies\_util::stopfxontagnetwork(level._effect[param_00 + "_arm_l"],self,"j_shoulder_le");
		}

		if(isdefined(level._effect[param_00 + "_back"]))
		{
			maps\mp\zombies\_util::stopfxontagnetwork(level._effect[param_00 + "_back"],self,"j_spineupper");
		}
	}
}

//Function Number: 14
mutator_precloneswap_limb(param_00,param_01,param_02)
{
	if(param_02)
	{
		var_03 = level.dismemberment[param_00]["nub"];
		if(isdefined(var_03))
		{
			self attach(var_03,"",1);
			return;
		}

		return;
	}

	if(isdefined(self.swaplimbmodels) && isdefined(self.swaplimbmodels[param_01]))
	{
		self attach(self.swaplimbmodels[param_01]);
		return;
	}

	if(isdefined(self.limbmodels) && isdefined(self.limbmodels[param_01]))
	{
		self attach(self.limbmodels[param_01]);
		return;
	}
}

//Function Number: 15
mutator_precloneswap()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	if(isdefined(self.missingbodyparts))
	{
		if(self.missingbodyparts & 16)
		{
			var_00 = 1;
		}

		if(self.missingbodyparts & 1)
		{
			var_01 = 1;
		}

		if(self.missingbodyparts & 2)
		{
			var_02 = 1;
		}

		if(self.missingbodyparts & 4)
		{
			var_03 = 1;
		}

		if(self.missingbodyparts & 8)
		{
			var_04 = 1;
		}
	}

	self detachall();
	if(isdefined(self.swapbody))
	{
		self setmodel(self.swapbody);
	}

	if(var_00)
	{
		var_05 = level.dismemberment[16]["nub"];
		if(isdefined(var_05))
		{
			self attach(var_05,"",1);
		}
	}
	else
	{
		self attach(self.headmodel);
	}

	mutator_precloneswap_limb(4,"right_leg",var_03);
	mutator_precloneswap_limb(8,"left_leg",var_04);
	mutator_precloneswap_limb(1,"right_arm",var_01);
	mutator_precloneswap_limb(2,"left_arm",var_02);
}

//Function Number: 16
mutatorexo()
{
	thread mutatorspawnsound("exo");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	var_00 = self getmodelfromentity();
	self setmodel(level.exobodyparts[var_00]["torso"]);
	if(isdefined(level.exobodyparts[var_00]["heads"]))
	{
		var_01 = level.exobodyparts[var_00]["heads"][randomint(level.exobodyparts[var_00]["heads"].size)];
		self detach(self.headmodel);
		self.headmodel = var_01;
		self attach(var_01);
	}

	replacelimbtoexolimb(var_00,"right_leg");
	replacelimbtoexolimb(var_00,"left_leg");
	replacelimbtoexolimb(var_00,"right_arm");
	replacelimbtoexolimb(var_00,"left_arm");
	if(!isdefined(self.moverateroundmod))
	{
		self.moverateroundmod = 0;
	}

	self.moverateroundmod = self.moverateroundmod + 1;
	self waittill("death");
}

//Function Number: 17
replacelimbtoexolimb(param_00,param_01)
{
	self detach(self.limbmodels[param_01]);
	self.limbmodels[param_01] = level.exobodyparts[param_00][param_01];
	self attach(self.limbmodels[param_01]);
}

//Function Number: 18
mutatorfast()
{
	thread mutatorspawnsound("fast");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	thread runner_ambient_sound();
	var_00 = ["zom_marine_m_ovr_exo_torso_slice"];
	var_01 = ["zom_marine_m_ovr_nofx_exo_torso_slice"];
	var_02 = ["zombies_head_mutator_overcharge","zombies_head_mutator_ovrchrg_cau_a","zombies_head_mutator_ovrchrg_cau_b","zombies_head_mutator_ovrchrg_cau_c"];
	var_03 = ["zom_marine_m_ovr_exo_r_leg_slice","zom_marine_m_ovr_exo_r_leg_slice_ab"];
	var_04 = ["zom_marine_m_ovr_nofx_exo_r_leg_slice","zom_marine_m_ovr_nofx_exo_r_leg_slice_ab"];
	var_05 = ["zom_marine_m_ovr_exo_l_leg_slice","zom_marine_m_ovr_exo_l_leg_slice_ab"];
	var_06 = ["zom_marine_m_ovr_nofx_exo_l_leg_slice","zom_marine_m_ovr_nofx_exo_l_leg_slice_ab"];
	var_07 = ["zom_marine_m_ovr_exo_r_arm_slice"];
	var_08 = ["zom_marine_m_ovr_nofx_exo_r_arm_slice"];
	var_09 = ["zom_marine_m_ovr_exo_l_arm_slice"];
	var_0A = ["zom_marine_m_ovr_nofx_exo_l_arm_slice"];
	var_0B = randomint(var_00.size);
	var_0C = randomint(var_02.size);
	var_0D = randomint(var_03.size);
	var_0E = randomint(var_05.size);
	var_0F = randomint(var_07.size);
	var_10 = randomint(var_09.size);
	self.precloneswapfunc = ::mutator_precloneswap;
	self detachall();
	self setmodel(var_00[var_0B]);
	self.swapbody = var_01[var_0B];
	self attach(var_02[var_0C]);
	self.headmodel = var_02[var_0C];
	self attach(var_03[var_0D]);
	self attach(var_05[var_0E]);
	self attach(var_07[var_0F]);
	self attach(var_09[var_10]);
	self.limbmodels["right_leg"] = var_03[var_0D];
	self.limbmodels["left_leg"] = var_05[var_0E];
	self.limbmodels["right_arm"] = var_07[var_0F];
	self.limbmodels["left_arm"] = var_09[var_10];
	self.swaplimbmodels["right_leg"] = var_04[var_0D];
	self.swaplimbmodels["left_leg"] = var_06[var_0E];
	self.swaplimbmodels["right_arm"] = var_08[var_0F];
	self.swaplimbmodels["left_arm"] = var_0A[var_10];
	var_11 = maps\mp\gametypes\zombies::geteyeeffectforzombie("fast",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_11);
	torso_effects_apply("mut_fast");
	self setsurfacetype("slush");
	if(!isdefined(self.moverateroundmod))
	{
		self.moverateroundmod = 0;
	}

	self.moverateroundmod = self.moverateroundmod + 5;
	self waittill("death");
}

//Function Number: 19
mutatoremz_clearemp(param_00)
{
	self.empgrenaded = 0;
	self setempjammed(0);
	maps\mp\_utility::playerallowhighjump(1,"empgrenade");
	maps\mp\_utility::playerallowhighjumpdrop(1,"empgrenade");
	maps\mp\_utility::playerallowboostjump(1,"empgrenade");
	maps\mp\_utility::playerallowpowerslide(1,"empgrenade");
	maps\mp\_utility::playerallowdodge(1,"empgrenade");
	self playsoundtoplayer("emp_system_reboot",self);
	if(!maps\mp\zombies\_util::iszombieshardmode())
	{
		self digitaldistortsetparams(0,0);
	}

	maps\mp\gametypes\_scrambler::playersethudempscrambledoff(param_00);
}

//Function Number: 20
mutatoremz_deathwaiter(param_00)
{
	self notify("emzDeathWaiter");
	self endon("emzDeathWaiter");
	self endon("emzTimedOut");
	self waittill("death");
	mutatoremz_clearemp(param_00);
}

//Function Number: 21
mutatoremz_rumbleloop(param_00)
{
	self endon("emp_rumble_loop");
	self notify("emp_rumble_loop");
	var_01 = gettime() + param_00 * 1000;
	while(gettime() < var_01)
	{
		self playrumbleonentity("damage_heavy");
		wait(0.05);
	}
}

//Function Number: 22
mutatoremz_watchdistortdisconnectdeath(param_00)
{
	self notify("mutatorEMZ_watchDistortDisconnectDeath");
	self endon("mutatorEMZ_watchDistortDisconnectDeath");
	common_scripts\utility::waittill_any("death","disconnect","faux_spawn","joined_team");
	if(isdefined(self))
	{
		self digitaldistortsetparams(0,0);
		maps\mp\gametypes\_scrambler::playersethudempscrambledoff(param_00);
	}
}

//Function Number: 23
mutatoremz_digitaldistort(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	var_02 = 0.6;
	self digitaldistortsetmaterial("digital_distort_mp");
	self digitaldistortsetparams(var_02,1);
	thread mutatoremz_watchdistortdisconnectdeath(param_01);
	wait(0.1);
	var_03 = param_00;
	var_04 = var_02;
	var_05 = 0.2;
	var_06 = var_04 - var_05;
	var_07 = 0.1;
	var_08 = var_04;
	while(var_03 > 0)
	{
		var_08 = var_06 * var_03 / param_00 + var_05;
		self digitaldistortsetparams(var_08,1);
		var_03 = var_03 - var_07;
		wait(var_07);
	}

	self digitaldistortsetparams(0,0);
}

//Function Number: 24
mutatoremz_applyemp()
{
	self notify("applyEmp");
	self endon("applyEmp");
	self endon("death");
	self endon("disconnect");
	wait(0.05);
	self.empduration = 5;
	if(isdefined(self.isexotacticalarmoractive) && self.isexotacticalarmoractive)
	{
		self.empduration = self.empduration - 1.25;
	}

	var_00 = 1;
	maps\mp\_utility::playerallowhighjump(0,"empgrenade");
	maps\mp\_utility::playerallowhighjumpdrop(0,"empgrenade");
	maps\mp\_utility::playerallowboostjump(0,"empgrenade");
	maps\mp\_utility::playerallowpowerslide(0,"empgrenade");
	maps\mp\_utility::playerallowdodge(0,"empgrenade");
	self playsoundtoplayer("emp_big_activate",self);
	self.empgrenaded = 1;
	self.empendtime = gettime() + self.empduration * 1000;
	var_01 = maps\mp\gametypes\_scrambler::playersethudempscrambled(self.empendtime,var_00,"emp");
	if(!maps\mp\zombies\_util::iszombieshardmode())
	{
		thread mutatoremz_digitaldistort(self.empduration,var_01);
	}

	thread mutatoremz_rumbleloop(0.75);
	self setempjammed(1);
	thread maps\mp\zombies\_zombies_audio::player_emp();
	thread mutatoremz_deathwaiter(var_01);
	wait(self.empduration);
	self notify("emzTimedOut");
	mutatoremz_clearemp(var_01);
}

//Function Number: 25
mutatoremz_watchforattackhits()
{
	self endon("death");
	for(;;)
	{
		self waittill("attack_hit",var_00,var_01);
		if(isplayer(var_00) && maps\mp\_utility::isreallyalive(var_00))
		{
			if(isdefined(var_00.exosuitonline) && var_00.exosuitonline)
			{
				var_00 thread mutatoremz_applyemp();
			}

			if(isdefined(level.noflashemzfunc))
			{
				var_02 = var_00 [[ level.noflashemzfunc ]]();
			}
			else
			{
				var_02 = level._effect["mut_emz_attack_sm"];
			}

			playfx(var_02,var_01);
			var_00 playlocalsound("zmb_emz_impact");
			level notify("zmb_emz_attack",self,var_01,10000);
		}
	}
}

//Function Number: 26
mutatoremz_watchforproximityboosters()
{
	self endon("death");
	var_00 = 32400;
	var_01 = 500;
	var_02 = 3;
	maps\mp\zombies\_util::waittill_enter_game();
	for(;;)
	{
		if(isdefined(self.distractiondrone))
		{
			wait(0.1);
			continue;
		}

		var_03 = [];
		if(self.aistate != "traverse" && !maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
		{
			foreach(var_05 in level.players)
			{
				if(!maps\mp\zombies\_util::isonhumanteam(var_05) || !maps\mp\_utility::isreallyalive(var_05) || maps\mp\zombies\_util::isplayerinlaststand(var_05))
				{
					continue;
				}

				if(!isdefined(var_05.exosuitonline) || !var_05.exosuitonline)
				{
					continue;
				}

				if(!isdefined(var_05.exoeventtime) || gettime() - var_05.exoeventtime > var_01)
				{
					continue;
				}

				if(distancesquared(var_05.origin,self.origin) > var_00)
				{
					continue;
				}

				if(var_05.ignoreme || maps\mp\zombies\_util::shouldignoreent(var_05))
				{
					continue;
				}

				if(var_05 isnotarget())
				{
					continue;
				}

				var_03[var_03.size] = var_05;
			}
		}

		var_07 = self.origin + (0,0,40);
		if(var_03.size > 0)
		{
			playfx(level._effect["mut_emz_attack_lg"],var_07);
			foreach(var_05 in var_03)
			{
				var_05 playlocalsound("zmb_emz_impact");
				var_05 thread mutatoremz_applyemp();
			}

			level notify("zmb_emz_attack",self,var_07,var_00);
			wait(var_02);
		}

		wait(0.1);
	}
}

//Function Number: 27
mutatoremz_bursttonearbyplayers(param_00)
{
	var_01 = 32400;
	var_02 = 500;
	var_03 = 3;
	if(isdefined(self.distractiondrone))
	{
		return;
	}

	if(self.aistate == "traverse" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_04 = self.origin + (0,0,40);
	if(param_00)
	{
		playfx(level._effect["mut_emz_attack_lg"],var_04);
	}

	foreach(var_06 in level.players)
	{
		if(!maps\mp\zombies\_util::isonhumanteam(var_06) || !maps\mp\_utility::isreallyalive(var_06) || maps\mp\zombies\_util::isplayerinlaststand(var_06))
		{
			continue;
		}

		if(!isdefined(var_06.exosuitonline) || !var_06.exosuitonline)
		{
			continue;
		}

		if(!isdefined(var_06.exoeventtime) || gettime() - var_06.exoeventtime > var_02)
		{
			continue;
		}

		if(distancesquared(var_06.origin,self.origin) > var_01)
		{
			continue;
		}

		if(var_06.ignoreme || maps\mp\zombies\_util::shouldignoreent(var_06))
		{
			continue;
		}

		if(var_06 isnotarget())
		{
			continue;
		}

		var_06 playlocalsound("zmb_emz_impact");
		var_06 thread mutatoremz_applyemp();
	}

	level notify("zmb_emz_attack",self,var_04,var_01);
}

//Function Number: 28
mutatoremz()
{
	if(self.agent_type == "zombie_dog")
	{
		thread mutatoremz_dog();
		self waittill("death");
		return;
	}

	thread mutatorspawnsound("emz");
	if(!maps\mp\zombies\_util::is_true(self.nomutatormodelswap))
	{
		maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
		self.boostfxtag = "tag_jetpack";
		var_00 = ["zom_marine_m_emp_exo_torso_slice","zom_marine_m_emp_exo_torso_slice_ab"];
		var_01 = ["zom_marine_m_emp_nofx_exo_torso_slice","zom_marine_m_emp_nofx_exo_torso_slice_ab"];
		var_02 = ["zombies_head_mutator_emp","zombies_head_mutator_emp_cau_a","zombies_head_mutator_emp_cau_b","zombies_head_mutator_emp_cau_c"];
		var_03 = ["zom_marine_m_emp_exo_r_leg_slice","zom_marine_m_emp_exo_r_leg_slice_ab"];
		var_04 = ["zom_marine_m_emp_nofx_exo_r_leg_slice","zom_marine_m_emp_nofx_exo_r_leg_slice_ab"];
		var_05 = ["zom_marine_m_emp_exo_l_leg_slice","zom_marine_m_emp_exo_l_leg_slice_ab"];
		var_06 = ["zom_marine_m_emp_nofx_exo_l_leg_slice","zom_marine_m_emp_nofx_exo_l_leg_slice_ab"];
		var_07 = ["zom_marine_m_emp_exo_r_arm_slice"];
		var_08 = ["zom_marine_m_emp_nofx_exo_r_arm_slice"];
		var_09 = ["zom_marine_m_emp_exo_l_arm_slice"];
		var_0A = ["zom_marine_m_emp_nofx_exo_l_arm_slice"];
		var_0B = randomint(var_00.size);
		var_0C = randomint(var_02.size);
		var_0D = randomint(var_03.size);
		var_0E = randomint(var_05.size);
		var_0F = randomint(var_07.size);
		var_10 = randomint(var_09.size);
		self.precloneswapfunc = ::mutator_precloneswap;
		self detachall();
		self setmodel(var_00[var_0B]);
		self.swapbody = var_01[var_0B];
		self attach(var_02[var_0C]);
		self.headmodel = var_02[var_0C];
		self attach(var_03[var_0D]);
		self attach(var_05[var_0E]);
		self attach(var_07[var_0F]);
		self attach(var_09[var_10]);
		self.limbmodels["right_leg"] = var_03[var_0D];
		self.limbmodels["left_leg"] = var_05[var_0E];
		self.limbmodels["right_arm"] = var_07[var_0F];
		self.limbmodels["left_arm"] = var_09[var_10];
		self.swaplimbmodels["right_leg"] = var_04[var_0D];
		self.swaplimbmodels["left_leg"] = var_06[var_0E];
		self.swaplimbmodels["right_arm"] = var_08[var_0F];
		self.swaplimbmodels["left_arm"] = var_0A[var_10];
	}

	var_11 = maps\mp\gametypes\zombies::geteyeeffectforzombie("emp",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_11);
	torso_effects_apply("mut_emz");
	if(isdefined(self.goliathweapon))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_r"],self.goliathweapon,"tag_fx");
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_l"],self.goliathweapon,"tag_fx");
	}

	self setsurfacetype("bark");
	self playloopsound("zmb_emz_crackle_loop");
	thread mutatoremz_watchforattackhits();
	thread mutatoremz_watchforproximityboosters();
	self waittill("death");
}

//Function Number: 29
mutatoremz_dog()
{
	thread mutatorspawnsound("emz");
	self setmodel("zom_dog_emz");
	maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_emp");
	if(isdefined(level._effect["mut_emz_head"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_head"],self,"j_head");
	}

	if(isdefined(level._effect["mut_emz_arm_r"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_r"],self,"r_frontLeg1_jnt");
	}

	if(isdefined(level._effect["mut_emz_arm_l"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_l"],self,"l_frontLeg1_jnt");
	}

	if(isdefined(level._effect["mut_emz_back"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_back"],self,"spine4_jnt");
	}

	self setsurfacetype("bark");
	self playloopsound("zmb_emz_crackle_loop");
	thread mutatoremz_watchforattackhits();
	thread mutatoremz_watchforproximityboosters();
	self waittill("death");
}

//Function Number: 30
hasexplodermutator()
{
	if(maps\mp\zombies\_util::checkactivemutator("exploder"))
	{
		return 1;
	}

	if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && maps\mp\zombies\_util::checkactivemutator("combo_exploder_teleport"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
onexploderzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!hasexplodermutator())
	{
		return;
	}

	if(self.hasexploded)
	{
		return;
	}

	self.hasexploded = 1;
	var_09 = self;
	if(isdefined(param_01))
	{
		var_09 = param_01;
	}

	var_0A = self.origin;
	if(!isdefined(level.nextexplodertime) || gettime() >= level.nextexplodertime)
	{
		level.nextexplodertime = gettime() + 100;
	}
	else
	{
		var_0B = level.nextexplodertime - gettime() * 0.001;
		level.nextexplodertime = level.nextexplodertime + 100;
		wait(var_0B);
	}

	mutatorexploder_explode(var_09,var_0A,0);
}

//Function Number: 32
mutatorexploder_explode(param_00,param_01,param_02)
{
	self.hasexploded = 1;
	if(param_02)
	{
		var_03 = level._effect["mut_exp_explosion_lg"];
		if(isdefined(self.detonatelargefxoverride))
		{
			var_03 = self.detonatelargefxoverride;
		}

		playfx(var_03,param_01);
		self notify("stopWarningSound");
		playsoundatpos(param_01,"zmb_exploder_explode");
		radiusdamage(param_01 + (0,0,60),180,45,15,param_00,"MOD_EXPLOSIVE","exploder_zm_large_mp",1);
	}
	else
	{
		var_03 = level._effect["mut_exp_explosion_sm"];
		if(isdefined(self.detonatesmallfxoverride))
		{
			var_03 = self.detonatesmallfxoverride;
		}

		playfx(var_03,param_01);
		self notify("stopWarningSound");
		playsoundatpos(param_01,"zmb_exploder_explode_small");
		radiusdamage(param_01 + (0,0,60),120,1,1,param_00,"MOD_EXPLOSIVE","exploder_zm_small_mp",1);
	}

	if(isalive(self))
	{
		trymutilate(undefined,"exploder_zm_large_mp","MOD_EXPLOSIVE",1,self,undefined);
		self suicide();
	}
}

//Function Number: 33
mutatorexploder_warningsound(param_00)
{
	var_01 = spawn("script_model",param_00);
	var_01 setmodel("tag_origin");
	wait 0.05;
	if(isdefined(self))
	{
		var_01 playsoundonmovingent("zmb_exploder_warning");
		common_scripts\utility::waittill_either("death","stopWarningSound");
	}

	var_01 stopsounds();
	wait(1);
	var_01 delete();
}

//Function Number: 34
mutatorexploder_proximitybomb()
{
	self endon("death");
	maps\mp\zombies\_util::waittill_enter_game();
	var_00 = 14400;
	for(;;)
	{
		wait(0.1);
		if(isdefined(self.distractiondrone))
		{
			continue;
		}

		var_01 = 0;
		if(self.aistate != "traverse" && !maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
		{
			foreach(var_03 in level.players)
			{
				if(!maps\mp\zombies\_util::isonhumanteam(var_03) || !maps\mp\_utility::isreallyalive(var_03) || maps\mp\zombies\_util::isplayerinlaststand(var_03))
				{
					continue;
				}

				if(var_03.ignoreme || maps\mp\zombies\_util::shouldignoreent(var_03))
				{
					continue;
				}

				if(var_03 isnotarget())
				{
					continue;
				}

				if(distancesquared(var_03.origin,self.origin) > var_00)
				{
					continue;
				}

				var_01 = 1;
				break;
			}
		}

		if(var_01)
		{
			self.ignoreall = 1;
			self.curmeleetarget = undefined;
			self scragentsetgoalpos(self.origin);
			self scragentsetscripted(1);
			maps\mp\agents\_scripted_agent_anim_util::set_anim_state("exploder_explode");
			var_05 = "j_spineupper";
			if(self.agent_type == "zombie_dog")
			{
				var_05 = "spine4_jnt";
			}

			var_06 = level._effect["mut_exp_charge"];
			if(isdefined(self.detonatechargefxoverride))
			{
				var_06 = self.detonatechargefxoverride;
			}

			maps\mp\zombies\_util::playfxontagnetwork(var_06,self,var_05,1);
			thread mutatorexploder_warningsound(self.origin);
			wait(randomfloatrange(1.75,1.9));
			mutatorexploder_explode(self,self.origin,1);
			return;
		}
	}
}

//Function Number: 35
mutatorexploder()
{
	if(self.agent_type == "zombie_dog")
	{
		thread mutatorexploder_dog();
		self waittill("death");
		return;
	}

	thread mutatorspawnsound("exploder");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	var_00 = ["zom_marine_m_fire_exo_torso_slice","zom_marine_m_fire_exo_torso_slice_ab"];
	var_01 = ["zom_marine_m_fire_nofx_exo_torso_slice","zom_marine_m_fire_nofx_exo_torso_slice_ab"];
	var_02 = ["zombies_head_mutator_fire","zombies_head_mutator_fire_cau_a","zombies_head_mutator_fire_cau_b","zombies_head_mutator_fire_cau_c"];
	var_03 = ["zom_marine_m_fire_exo_r_leg_slice","zom_marine_m_fire_exo_r_leg_slice_ab"];
	var_04 = ["zom_marine_m_fire_exo_l_leg_slice","zom_marine_m_fire_exo_l_leg_slice_ab"];
	var_05 = ["zom_marine_m_fire_exo_r_arm_slice"];
	var_06 = ["zom_marine_m_fire_exo_l_arm_slice"];
	var_07 = randomint(var_00.size);
	var_08 = randomint(var_02.size);
	var_09 = randomint(var_03.size);
	var_0A = randomint(var_04.size);
	var_0B = randomint(var_05.size);
	var_0C = randomint(var_06.size);
	self.precloneswapfunc = ::mutator_precloneswap;
	self detachall();
	self setmodel(var_00[var_07]);
	self.swapbody = var_01[var_07];
	self attach(var_02[var_08]);
	self.headmodel = var_02[var_08];
	self attach(var_03[var_09]);
	self attach(var_04[var_0A]);
	self attach(var_05[var_0B]);
	self attach(var_06[var_0C]);
	self.limbmodels["right_leg"] = var_03[var_09];
	self.limbmodels["left_leg"] = var_04[var_0A];
	self.limbmodels["right_arm"] = var_05[var_0B];
	self.limbmodels["left_arm"] = var_06[var_0C];
	var_0D = maps\mp\gametypes\zombies::geteyeeffectforzombie("exploder",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_0D);
	torso_effects_apply("mut_exp");
	self setsurfacetype("fruit");
	thread exploder_ambient_sound();
	self.hasexploded = 0;
	thread mutatorexploder_proximitybomb();
	self waittill("death");
}

//Function Number: 36
mutatorexploder_dog()
{
	thread mutatorspawnsound("exploder");
	maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_exploder");
	if(isdefined(level._effect["mut_exp_head"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_head"],self,"j_head");
	}

	if(isdefined(level._effect["mut_exp_arm_r"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_arm_r"],self,"r_frontLeg1_jnt");
	}

	if(isdefined(level._effect["mut_exp_arm_l"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_arm_l"],self,"l_frontLeg1_jnt");
	}

	if(isdefined(level._effect["mut_exp_back"]))
	{
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_back"],self,"spine4_jnt");
	}

	self setsurfacetype("fruit");
	thread exploder_ambient_sound();
	self.hasexploded = 0;
	self.bypasscorpse = 1;
	thread mutatorexploder_proximitybomb();
	self waittill("death");
}

//Function Number: 37
exploder_ambient_sound()
{
	self playloopsound("zmb_exploder_ambient_loop");
	self waittill("death");
	self stoploopsound("zmb_exploder_ambient_loop");
}

//Function Number: 38
runner_ambient_sound()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 linkto(self);
	var_00 playloopsound("zmb_runner_ambient_loop");
	var_01 = 0;
	while(isalive(self))
	{
		var_02 = self getvelocity();
		var_03 = distance((var_02[0],var_02[1],0),(0,0,0));
		if(var_01 == 0 && var_03 < 5)
		{
			var_00 scalevolume(0,0.5);
			self scalevolume(1,0.5);
			var_01 = 1;
			continue;
		}

		if(var_01 && var_03 >= 5)
		{
			var_00 scalevolume(1,0.5);
			self scalevolume(0,0.5);
			var_01 = 0;
		}

		wait(1);
	}

	var_00 stoploopsound("zmb_runner_ambient_loop");
	wait 0.05;
	var_00 delete();
}

//Function Number: 39
mutatorcrawl()
{
	mutilate(12,0);
}

//Function Number: 40
startcrawl()
{
	self.dismember_crawl = 1;
	maps\mp\agents\humanoid\_humanoid_util::dodgedisable();
	if(isdefined(self.lungemeleeenabled))
	{
		maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(10,240,120,"attack_lunge_boost",level._effect["boost_lunge"],1,255);
	}

	maps\mp\agents\humanoid\_humanoid_util::leapdisable();
	self scragentallowboost(0);
	self scragentsetorienttoground(1);
	self scragentsetviewheight(15);
	level.crawlingzombies++;
	self waittill("death");
	level.crawlingzombies--;
}

//Function Number: 41
getdismembermentmodifier(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::isinstakill())
	{
		return 0;
	}

	var_03 = undefined;
	if(isdefined(param_01))
	{
		param_01 = getweaponbasename(param_01);
		var_03 = param_01;
	}
	else if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	if(!isdefined(var_03))
	{
		return 1;
	}

	var_04 = level.dismembermentmodifiers[var_03];
	if(isdefined(param_00) && isplayer(param_00) && isdefined(param_01) && isdefined(var_04) && !maps\mp\_utility::iskillstreakweapon(param_01))
	{
		var_04 = checkweaponupgrademodifier(param_00,param_01,var_04);
		return var_04;
	}

	if(isdefined(var_04))
	{
		return var_04;
	}

	return 1;
}

//Function Number: 42
checkweaponupgrademodifier(param_00,param_01,param_02)
{
	var_03 = level.dismembermentupgrademodifiers[param_01];
	if(!isdefined(var_03))
	{
		return param_02;
	}

	var_04 = maps\mp\zombies\_util::getzombieweaponlevel(param_00,param_01);
	if(var_04 <= 1)
	{
		return param_02;
	}

	var_05 = param_02 - var_03;
	var_06 = param_02 - var_04 / 3 * var_05;
	return clamp(var_06,var_03,param_02);
}

//Function Number: 43
getmutilationmask(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_03 >= 1)
	{
		if(hasexplodermutator())
		{
			return 31;
		}

		if(isdefined(param_02) && param_02 == "MOD_MELEE")
		{
			if(isdefined(param_04) && param_04 maps\mp\zombies\_terminals::hasexosuit())
			{
				return 16;
			}
		}

		if(param_01 == "iw5_dlcgun4zm_mp")
		{
			return 31;
		}

		if(param_01 == "iw5_tridentzm_mp" && issubstr(param_00,"torso"))
		{
			return common_scripts\utility::random([17,18,3,19,16]);
		}
	}

	var_06 = maps\mp\zombies\_util::is_true(level.dismembermentignorelocation[param_01]) || maps\mp\zombies\_util::is_true(level.dismembermentignorelocation[param_02]) || maps\mp\zombies\_util::isinstakill();
	if(var_06)
	{
		var_07 = 31;
	}
	else
	{
		var_07 = locationtobodypart(param_01);
	}

	var_08 = 1;
	if(var_07 == 0)
	{
		return 0;
	}

	var_08 = var_08 * getdismembermentmodifier(param_04,param_01,undefined) * getdismembermentmodifier(param_04,undefined,param_02);
	var_08 = var_08 * -0.7 * param_03 + 1;
	return getmutilationmaskinternal(var_07,param_05,param_03,var_08);
}

//Function Number: 44
getmutilationmaskinternal(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(param_00 & param_00 - 1 > 0)
	{
		if(param_02 < 1)
		{
			var_05 = randomint(24);
			var_06 = 228;
			for(var_07 = 4;var_07 > 0;var_07--)
			{
				var_08 = 1 << var_05 % var_07 * 2;
				var_05 = int(var_05 / var_07);
				var_09 = var_06 % var_08;
				var_0A = int(var_06 / var_08);
				var_06 = var_09 + var_0A >> 2 * var_08;
				var_0B = 1 << var_0A & 3;
				if(param_00 & var_0B != 0 && isdefined(bodypartmasktoanimclass(param_01 | var_04 | var_0B)))
				{
					if(randomfloat(1) >= chancetokeepbodypart(var_0B) * param_03)
					{
						var_04 = var_04 | var_0B;
					}
				}
			}
		}
		else
		{
			while(param_00 > 0)
			{
				var_0B = param_00 & 0 - param_00;
				if(randomfloat(1) >= chancetokeepbodypart(var_0B) * param_03)
				{
					var_04 = var_04 | var_0B;
				}

				param_00 = param_00 - var_0B;
			}
		}
	}
	else if(param_02 >= 1 || isdefined(bodypartmasktoanimclass(param_01 | param_00)))
	{
		if(randomfloat(1) >= chancetokeepbodypart(param_00) * param_03)
		{
			var_04 = param_00;
		}
	}

	return var_04;
}

//Function Number: 45
trymutilate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	if(isalive(self) && !maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || param_03 >= 1 && self.aistate != "traverse" && maps\mp\zombies\_util::has_entered_game())
	{
		var_07 = getmutilationmask(param_00,param_01,param_02,param_03,param_04,self.missingbodyparts);
		if(var_07 != 0)
		{
			var_08 = !maps\mp\zombies\_util::is_true(self.dismember_crawl);
			var_09 = isdefined(self.missingbodyparts) && self.missingbodyparts == 0;
			if(level.crawlingzombies < 3 || self.dismember_crawl || var_07 & 12 == 0 || var_07 & 16 != 0 || self.missingbodyparts & 3 != 0)
			{
				if(mutilate(self.missingbodyparts | var_07,maps\mp\zombies\_util::is_true(level.highdamageweapons[param_01]),param_03,param_05))
				{
					if(maps\mp\zombies\_util::isinstakill())
					{
						earthquake(randomfloatrange(0.15,0.35),1,self.origin,200);
					}

					var_06 = 1;
				}
				else if(!isdefined(self.limbmodels) && var_07 != 0 && hasexplodermutator() || maps\mp\zombies\_util::isinstakill() && maps\mp\zombies\_util::checkactivemutator("emz") || maps\mp\zombies\_util::checkactivemutator("fast"))
				{
					earthquake(randomfloatrange(0.15,0.35),1,self.origin,200);
					var_06 = 1;
				}

				if(isalive(self) && isplayer(param_04))
				{
					if(var_08 && maps\mp\zombies\_util::is_true(self.dismember_crawl))
					{
						param_04 thread maps\mp\zombies\_zombies_audio::player_hurt_zombie_vox("crawl_spawn");
					}
					else if(var_09 && isdefined(self.missingbodyparts) && self.missingbodyparts != 0)
					{
						param_04 thread maps\mp\zombies\_zombies_audio::player_hurt_zombie_vox("shoot_arm");
					}
				}
			}
		}
	}

	return var_06;
}

//Function Number: 46
isfullbodymutilation()
{
	if(!isdefined(self.recentlylostlimbs))
	{
		return 0;
	}

	return maps\mp\zombies\_util::countlimbs(self.recentlylostlimbs) >= 3;
}

//Function Number: 47
mutilate(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	if(isdefined(self.limbmodels) && param_00 != self.missingbodyparts)
	{
		var_06 = ~self.missingbodyparts & param_00;
		self.missingbodyparts = param_00;
		var_07 = self.spawntime < gettime();
		if(maps\mp\zombies\_util::countlimbs(var_06) >= 3)
		{
			if(var_07)
			{
				self.recentlylostlimbs = var_06;
			}

			var_07 = 0;
		}

		if(var_06 & 1 != 0)
		{
			detachlimb(1,self.limbmodels["right_arm"],param_03,var_07,param_04);
		}

		if(var_06 & 2 != 0)
		{
			detachlimb(2,self.limbmodels["left_arm"],param_03,var_07,param_04);
		}

		if(var_06 & 4 != 0)
		{
			detachlimb(4,self.limbmodels["right_leg"],param_03,var_07,param_04);
		}

		if(var_06 & 8 != 0)
		{
			detachlimb(8,self.limbmodels["left_leg"],param_03,var_07,param_04);
		}

		if(var_06 & 16 != 0)
		{
			detachlimb(16,self.headmodel,param_03,var_07,param_04);
			if(isdefined(self.linked_fx) && isdefined(self.linked_fx["tag_eye"]))
			{
				setfxkillondelete(self.linked_fx["tag_eye"],1);
				thread delayeddeleteeyesfx();
			}
		}

		var_08 = bodypartmasktoanimclass(param_00);
		if(isdefined(var_08))
		{
			if(!self.dismember_crawl && param_00 & 12 != 0)
			{
				thread startcrawl();
			}

			if(var_07)
			{
				var_09 = var_08;
				switch(self.movemode)
				{
					case "walk":
						var_09 = var_09 + "_walk";
						break;

					case "sprint":
					case "run":
						var_09 = var_09 + "_run";
						break;
				}

				if(param_01)
				{
					var_09 = var_09 + "_highdamage";
				}

				if(param_02 < 1)
				{
					thread maps\mp\agents\humanoid\_humanoid_util::changeanimclass(var_08,var_09);
				}
				else
				{
					var_05 = 1;
				}
			}
			else
			{
				self setanimclass(var_08);
				if(self.aistate == "idle")
				{
					maps\mp\agents\_scripted_agent_anim_util::set_anim_state("idle_noncombat");
				}
			}
		}
		else
		{
			var_05 = 1;
		}

		if(var_05 && var_07)
		{
			self.recentlylostlimbs = var_06;
		}
	}

	return var_05;
}

//Function Number: 48
delayeddeleteeyesfx()
{
	self endon("death");
	wait 0.05;
	if(isdefined(self.linked_fx["tag_eye"]))
	{
		self.linked_fx["tag_eye"] delete();
		self.linked_fx["tag_eye"] = undefined;
	}
}

//Function Number: 49
bodypartmasktoanimclass(param_00)
{
	switch(param_00)
	{
		case 1:
			return "zombie_missing_right_arm_animclass";

		case 2:
			return "zombie_missing_left_arm_animclass";

		case 4:
			return "zombie_missing_right_leg_animclass";

		case 8:
			return "zombie_missing_left_leg_animclass";

		case 12:
			return "zombie_crawl_animclass";

		case 0:
			return "zombie_animclass";

		default:
			return undefined;
	}
}

//Function Number: 50
locationtobodypart(param_00)
{
	switch(param_00)
	{
		case "right_hand":
		case "right_arm_lower":
		case "right_arm_upper":
			return 1;

		case "left_hand":
		case "left_arm_lower":
		case "left_arm_upper":
			return 2;

		case "right_foot":
		case "right_leg_lower":
		case "right_leg_upper":
			return 4;

		case "left_foot":
		case "left_leg_lower":
		case "left_leg_upper":
			return 8;

		case "neck":
		case "helmet":
		case "head":
			return 16;

		default:
			return 0;
	}
}

//Function Number: 51
chancetokeepbodypart(param_00)
{
	if(isdefined(self.hasarmor) && param_00 != 16)
	{
		return 1;
	}

	switch(param_00)
	{
		case 1:
			return 0.45;

		case 2:
			return 0.45;

		case 4:
			return 0.5;

		case 8:
			return 0.5;

		case 16:
			if(isdefined(self.hashelmet))
			{
				return 1;
			}
			return 0.65;

		default:
			return 1;
	}
}

//Function Number: 52
getlimbproperty(param_00,param_01,param_02)
{
	if(isdefined(level.dismemberment[param_01]))
	{
		var_03 = level.dismemberment[param_01][param_02];
		if(isdefined(var_03))
		{
			return var_03;
		}
	}

	var_03 = level.dismemberment[param_00][param_02];
	return var_03;
}

//Function Number: 53
getlimborigin(param_00,param_01)
{
	var_02 = 40;
	switch(param_00)
	{
		case 2:
		case 1:
			return self.origin + (0,0,var_02);

		case 8:
		case 4:
			var_03 = self gettagorigin(param_01);
			return (self.origin[0],self.origin[1],var_03[2]);

		case 16:
			return self gettagorigin(var_02);
	}
}

//Function Number: 54
detachlimb(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	var_06 = undefined;
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_03)
	{
		var_07 = getlimbproperty(param_00,param_01,"tagName");
		var_05 = getlimborigin(param_00,var_07);
		var_06 = self gettagangles(var_07);
	}

	self notify("detachLimb",param_00);
	self detach(param_01,"",1);
	var_08 = getlimbproperty(param_00,param_01,"nub");
	if(isdefined(var_08))
	{
		self attach(var_08,"",1);
	}

	if(param_03)
	{
		var_09 = undefined;
		if(!level.currentgen && param_04)
		{
			var_09 = spawn("script_model",var_05);
			var_0A = getlimbproperty(param_00,param_01,"modelToSpawn");
			if(!isdefined(var_0A))
			{
				var_0A = param_01;
			}

			var_09 setmodel(var_0A);
			var_09.angles = var_06;
			var_0B = (0,0,randomfloatrange(1000,2000));
			if(!isdefined(param_02))
			{
				param_02 = (0,0,0);
			}

			var_0C = param_02 * randomfloatrange(500,1000);
			var_0D = (randomfloatrange(-2000,2000),randomfloatrange(-2000,2000),randomfloatrange(-2000,2000));
			var_0E = anglestoright(self.angles);
			switch(param_00)
			{
				case 1:
					var_0C = var_0C + var_0E * 750;
					break;

				case 4:
					var_0C = var_0C + var_0E * 500;
					break;

				case 2:
					var_0C = var_0C - var_0E * 750;
					break;

				case 8:
					var_0C = var_0C - var_0E * 500;
					break;
			}

			var_0F = var_0B + var_0C;
			var_10 = length(var_0F);
			var_11 = var_0F / var_10;
			var_10 = min(var_10,1750);
			var_09 physicslaunchclientwithimpulse(var_11 * var_10,var_0D);
			var_09 deleteonhostmigration();
			if(level.nextdismemberedbodypartindex < level.dismemberedbodyparts.size)
			{
				level.dismemberedbodyparts[level.nextdismemberedbodypartindex] delete();
			}

			level.dismemberedbodyparts[level.nextdismemberedbodypartindex] = var_09;
			level.nextdismemberedbodypartindex = level.nextdismemberedbodypartindex + 1 % 20;
		}

		var_12 = getlimbproperty(param_00,param_01,"fxTagName");
		var_13 = getlimbproperty(param_00,param_01,"torsoFX");
		var_14 = getlimbproperty(param_00,param_01,"limbFX");
		if(maps\mp\zombies\_util::checkactivemutator("emz"))
		{
			var_13 = var_13 + "_emz";
			var_14 = var_14 + "_emz";
		}
		else if(hasexplodermutator())
		{
			var_13 = var_13 + "_exp";
			var_14 = var_14 + "_exp";
		}
		else if(maps\mp\zombies\_util::checkactivemutator("fast"))
		{
			var_13 = var_13 + "_ovr";
			var_14 = var_14 + "_ovr";
		}

		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_13),self,var_12,1);
		if(!level.currentgen)
		{
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_14),var_09,var_12,1);
		}

		var_15 = maps\mp\zombies\_util::getdismembersoundname();
		var_16 = getlimbproperty(param_00,param_01,var_15);
		thread play_dismember_sound(var_16);
	}
}

//Function Number: 55
play_dismember_sound(param_00)
{
	wait 0.05;
	if(self.health > 0)
	{
		self playsoundonmovingent(param_00);
		return;
	}

	self playsound(param_00);
}

//Function Number: 56
mutatorspawnsound(param_00)
{
	self notify("mutatorSpawnSound");
	self endon("mutatorSpawnSound");
	if(maps\mp\zombies\_util::is_true(self.nomutatorspawnsound))
	{
		return;
	}

	if(isdefined(level.mutators[param_00][2]))
	{
		wait(randomfloatrange(0.2,0.8));
		var_01 = level.mutators[param_00][2];
		self playsoundonmovingent(var_01);
	}
}

//Function Number: 57
ondamagefinishedmutators(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	foreach(var_0B in level.mutators)
	{
		if(isdefined(var_0B[4]))
		{
			self [[ var_0B[4] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		}
	}
}

//Function Number: 58
onkilledmutators(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	foreach(var_0A in level.mutators)
	{
		if(isdefined(var_0A[3]))
		{
			self [[ var_0A[3] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
	}
}