/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_mutators_combo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 638 ms
 * Timestamp: 4/22/2024 2:13:48 AM
*******************************************************************/

//Function Number: 1
initcombomutators()
{
	initcombomutatorfx();
	maps\mp\zombies\_mutators::addmutatortotable("combo_spike_teleport",::mutatorcombospiketeleport,"zmb_mut_spiked_spawn",undefined,::mutatorcombospiketeleportondamaged);
	maps\mp\zombies\_mutators::addmutatortotable("combo_exploder_teleport",::mutatorcomboexploderteleport,"zmb_mut_expl_spawn",::maps\mp\zombies\_mutators::onexploderzombiekilled);
	maps\mp\zombies\_mutators::addmutatortotable("combo_armor_emz",::mutatorcomboarmoremz,"zmb_mut_emz_spawn",::mutatorcomboarmoremzkilled,::mutatorcomboarmoremzondamaged);
	maps\mp\zombies\_mutators::addmutatortotable("combo_emz_spike",::mutatorcomboemzspike,"zmb_mut_emz_spawn",undefined,::mutatorcomboemzspikeondamaged);
	maps\mp\zombies\_mutators::disablemutatorfortypes("combo_spike_teleport",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
	maps\mp\zombies\_mutators::disablemutatorfortypes("combo_exploder_teleport",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
	maps\mp\zombies\_mutators::disablemutatorfortypes("combo_armor_emz",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
	maps\mp\zombies\_mutators::disablemutatorfortypes("combo_emz_spike",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
}

//Function Number: 2
initcombomutatorfx()
{
	level.valideyetypes[level.valideyetypes.size] = "combo_spike_teleport";
	level.valideyetypes[level.valideyetypes.size] = "combo_exploder_teleport";
	level.valideyetypes[level.valideyetypes.size] = "combo_armor_emz";
	level.valideyetypes[level.valideyetypes.size] = "combo_emz_spike";
	level._effect["zombie_eye_combo_spike_teleport"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_tele_spike_dlc");
	level._effect["zombie_eye_combo_exploder_teleport"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_tele_exp_dlc");
	level._effect["zombie_eye_combo_armor_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_a");
	level._effect["zombie_eye_combo_armor_emz_cau_dlc_a"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_a");
	level._effect["zombie_eye_combo_armor_emz_cau_dlc_b"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_b");
	level._effect["zombie_eye_combo_armor_emz_cau_dlc_c"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_c");
	level._effect["zombie_eye_combo_emz_spike"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_a");
	level._effect["zombie_eye_combo_emz_spike_cau_dlc_a"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_a");
	level._effect["zombie_eye_combo_emz_spike_cau_dlc_b"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_b");
	level._effect["zombie_eye_combo_emz_spike_cau_dlc_c"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_c");
	level._effect["mut_combo_exploder_teleport_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_head");
	level._effect["mut_combo_exploder_teleport_arm_l"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_upperarm_lt");
	level._effect["mut_combo_exploder_teleport_arm_r"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_upperarm_rt");
	level._effect["mut_combo_exploder_teleport_back"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_back");
	level._effect["mut_combo_exploder_teleport_pre"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_exp_start");
	level._effect["mut_combo_exploder_teleport_post"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_exp");
	level._effect["mut_combo_exploder_spike_pre"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_spike_start");
	level._effect["mut_combo_exploder_spike_post"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_spike");
	level._effect["mut_combo_exploder_detonate_lrg"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_detonate_lrg");
	level._effect["mut_combo_exploder_detonate_sml"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_detonate_sml");
	level._effect["mut_combo_exploder_detonate_charge"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_detonate_charge");
	level._effect["mut_combo_emz_spike_attack"] = loadfx("vfx/gameplay/mp/zombie/dlc_zombie_attack_combo_emp_spike");
}

//Function Number: 3
mutatorcombospiketeleport()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_spike_teleport");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	mutatorcombospiketeleportmodelsetup();
	mutatorcombospiketeleportbehavior();
}

//Function Number: 4
mutatorcombospiketeleportmodelsetup()
{
	var_00 = ["zom_cmb_blink_spike_torso_a_slice"];
	var_01 = ["zom_cmb_blink_spike_nofx_torso_a_slice"];
	var_02 = ["zom_cmb_blink_spike_head_a"];
	var_03 = ["zom_cmb_blink_spike_r_leg_a_slice"];
	var_04 = ["zom_cmb_blink_spike_l_leg_a_slice"];
	var_05 = ["zom_cmb_blink_spike_r_arm_a_slice"];
	var_06 = ["zom_cmb_blink_spike_nofx_r_arm_a_slice"];
	var_07 = ["zom_cmb_blink_spike_l_arm_a_slice"];
	var_08 = ["zom_cmb_blink_spike_nofx_l_arm_a_slice"];
	var_09 = randomint(var_00.size);
	var_0A = randomint(var_02.size);
	var_0B = randomint(var_03.size);
	var_0C = randomint(var_04.size);
	var_0D = randomint(var_05.size);
	var_0E = randomint(var_07.size);
	self.precloneswapfunc = ::maps\mp\zombies\_mutators::mutator_precloneswap;
	self detachall();
	self setmodel(var_00[var_09]);
	self.swapbody = var_01[var_09];
	self attach(var_02[var_0A]);
	self.headmodel = var_02[var_0A];
	self attach(var_03[var_0B]);
	self attach(var_04[var_0C]);
	self attach(var_05[var_0D]);
	self attach(var_07[var_0E]);
	self.limbmodels["right_leg"] = var_03[var_0B];
	self.limbmodels["left_leg"] = var_04[var_0C];
	self.limbmodels["right_arm"] = var_05[var_0D];
	self.limbmodels["left_arm"] = var_07[var_0E];
	self.swaplimbmodels["right_arm"] = var_06[var_0D];
	self.swaplimbmodels["left_arm"] = var_08[var_0E];
	if(!isdefined(self.moverateroundmod))
	{
		self.moverateroundmod = 0;
	}

	self.moverateroundmod = self.moverateroundmod + 5;
	mutatorcombospiketeleporteyefx();
	self.eyefxfunc = ::mutatorcombospiketeleporteyefx;
	self.teleportprefxoverride = level._effect["mut_combo_exploder_spike_pre"];
	self.teleportpostfxoverride = level._effect["mut_combo_exploder_spike_post"];
}

//Function Number: 5
mutatorcombospiketeleporteyefx()
{
	var_00 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_spike_teleport",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_00);
}

//Function Number: 6
mutatorcombospiketeleportbehavior()
{
	thread maps\mp\zombies\_mutators_teleport::mutatorteleport_handleteleport();
	self waittill("death");
	playsoundatpos(self.origin,"zmb_mut_spiked_explo");
}

//Function Number: 7
mutatorcombospiketeleportondamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!maps\mp\zombies\_util::checkactivemutator("combo_spike_teleport"))
	{
		return;
	}

	if(common_scripts\utility::cointoss())
	{
		return;
	}

	if(!isdefined(self.spikeblastready))
	{
		thread mutatorcombospikeblast(param_01);
	}
}

//Function Number: 8
mutatorcombospikeblast(param_00)
{
	self endon("death");
	self.spikeblastready = 0;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = self gettagorigin("J_Spine4");
	var_01 linkto(self,"J_Spine4");
	wait(0.05);
	if(maps\mp\zombies\_util::checkactivemutator("combo_emz_spike"))
	{
		playfx(common_scripts\utility::getfx("mut_combo_emz_spike_attack"),var_01.origin);
	}
	else
	{
		playfx(common_scripts\utility::getfx("mut_spiked_explosion_2"),var_01.origin);
	}

	playsoundatpos(var_01.origin,"zmb_mut_spiked_explo_overkill");
	wait(0.1);
	foreach(var_03 in level.players)
	{
		if(distance(var_03.origin,self.origin) < 150)
		{
			var_04 = clamp(25 * level.wavecounter / 9,25,50);
			if(isdefined(param_00) && var_03 == param_00)
			{
				var_03 dodamage(var_04,self.origin);
			}
			else
			{
				var_03 dodamage(var_04 * 0.5,self.origin);
			}
		}
	}

	var_01 delete();
	wait(0.75);
	if(isalive(self))
	{
		self.spikeblastready = undefined;
	}
}

//Function Number: 9
mutatorcomboexploderteleport()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_exploder_teleport");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	mutatorcomboexploderteleportmodelsetup();
	mutatorcomboexploderteleportbehavior();
}

//Function Number: 10
mutatorcomboexploderteleportmodelsetup()
{
	var_00 = ["zom_cmb_blink_fire_torso_a_slice"];
	var_01 = ["zom_cmb_blink_fire_nofx_torso_a_slice"];
	var_02 = ["zom_cmb_blink_fire_head_a"];
	var_03 = ["zom_cmb_blink_fire_r_leg_a_slice"];
	var_04 = ["zom_cmb_blink_fire_l_leg_a_slice"];
	var_05 = ["zom_cmb_blink_fire_r_arm_a_slice"];
	var_06 = ["zom_cmb_blink_fire_l_arm_a_slice"];
	var_07 = randomint(var_00.size);
	var_08 = randomint(var_02.size);
	var_09 = randomint(var_03.size);
	var_0A = randomint(var_04.size);
	var_0B = randomint(var_05.size);
	var_0C = randomint(var_06.size);
	self.precloneswapfunc = ::maps\mp\zombies\_mutators::mutator_precloneswap;
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
	mutatorcomboexploderteleporteyefx();
	self.eyefxfunc = ::mutatorcomboexploderteleporteyefx;
	self setsurfacetype("bark");
	self.teleportprefxoverride = level._effect["mut_combo_exploder_teleport_pre"];
	self.teleportpostfxoverride = level._effect["mut_combo_exploder_teleport_post"];
	self.detonatechargefxoverride = level._effect["mut_combo_exploder_detonate_charge"];
	self.detonatelargefxoverride = level._effect["mut_combo_exploder_detonate_lrg"];
	self.detonatesmallfxoverride = level._effect["mut_combo_exploder_detonate_sml"];
}

//Function Number: 11
mutatorcomboexploderteleporteyefx()
{
	var_00 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_exploder_teleport",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_00);
	maps\mp\zombies\_mutators::torso_effects_apply("mut_combo_exploder_teleport");
}

//Function Number: 12
mutatorcomboexploderteleportbehavior()
{
	thread maps\mp\zombies\_mutators::exploder_ambient_sound();
	self.hasexploded = 0;
	thread maps\mp\zombies\_mutators::mutatorexploder_proximitybomb();
	thread maps\mp\zombies\_mutators_teleport::mutatorteleport_handleteleport();
	self waittill("death");
}

//Function Number: 13
mutatorcomboarmoremz()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_armor_emz");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "no_boost_fx";
	mutatorcomboarmoremzmodelsetup();
	mutatorcomboarmoremzbehavior();
}

//Function Number: 14
mutatorcomboarmoremzmodelsetup()
{
	var_00 = ["zom_cmb_armor_emp_body"];
	var_01 = ["zom_cmb_armor_emp_nofx_body"];
	var_02 = ["zombies_head_mutator_emp","zombies_head_mutator_emp_cau_a","zombies_head_mutator_emp_cau_b","zombies_head_mutator_emp_cau_c"];
	var_03 = randomint(var_00.size);
	var_04 = randomint(var_02.size);
	self.precloneswapfunc = ::maps\mp\zombies\_mutators::mutator_precloneswap;
	self detachall();
	self.limbmodels = undefined;
	self setmodel(var_00[var_03]);
	self.swapbody = var_01[var_03];
	self attach(var_02[var_04]);
	self.headmodel = var_02[var_04];
	var_05 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_armor_emz",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_05);
	maps\mp\zombies\_mutators::torso_effects_apply("mut_emz");
	self setsurfacetype("bark");
	self playloopsound("zmb_emz_crackle_loop");
}

//Function Number: 15
mutatorcomboarmoremzbehavior()
{
	thread maps\mp\zombies\_mutators::mutatoremz_watchforattackhits();
	thread maps\mp\zombies\_mutators::mutatoremz_watchforproximityboosters();
	thread mutatorcomboaddhelmet();
	self waittill("death");
}

//Function Number: 16
mutatorcomboarmoremzondamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!maps\mp\zombies\_util::checkactivemutator("combo_armor_emz"))
	{
		return;
	}

	if(isdefined(self.hashelmet) && isplayer(param_01) && maps\mp\_utility::isheadshot(param_05,param_08,param_04))
	{
		self.helmet_health = self.helmet_health - param_02;
		if(self.helmet_health <= 0)
		{
			self notify("helmet_lost");
		}
	}
}

//Function Number: 17
mutatorcomboarmoremzkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\zombies\_util::checkactivemutator("combo_armor_emz"))
	{
		return;
	}

	if(isdefined(self.hashelmet) && isdefined(self.helmet))
	{
		self.helmet unlink();
		self.helmet setmodel("zombie_helmet_collision");
		self.helmet physicslaunchclient(self.helmet.origin,(randomintrange(-5,5),randomintrange(-5,5),randomintrange(-5,5)));
	}
}

//Function Number: 18
mutatorcomboaddhelmet()
{
	var_00 = "J_helmet";
	self.hasarmor = 1;
	self.hashelmet = 1;
	self.helmet_health = 50;
	var_01 = self gettagorigin(var_00);
	var_02 = self gettagangles(var_00);
	var_03 = spawn("script_model",var_01);
	self.helmet = var_03;
	var_03.angles = var_02;
	var_03 setmodel("zombie_helmet");
	var_03 linkto(self,var_00,(-0.2,-0.45,-4.7),(0,90,0));
	thread mutatorcombohelmetdetach(var_03);
	self waittill("death");
	self.hashelmet = undefined;
	self.helmet = undefined;
	thread mutatorcombohelmetcleanup(var_03);
}

//Function Number: 19
mutatorcombohelmetdetach(param_00)
{
	self endon("death");
	self waittill("helmet_lost");
	self.hashelmet = undefined;
	self.helmet = undefined;
	earthquake(0.25,0.4,self.origin,128);
	self.moverateroundmod = self.moverateroundmod + 5;
	playfx(common_scripts\utility::getfx("mut_helmet_impact"),param_00.origin);
	param_00 playsound("zmb_mut_armor_helmet_ping");
	param_00 unlink();
	param_00 setmodel("zombie_helmet_collision");
	param_00 physicslaunchclient(param_00.origin,(randomintrange(-5,5),randomintrange(-5,5),randomintrange(-5,5)));
	physicsexplosionsphere(param_00.origin - (0,0,2),16,1,5);
	thread mutatorcombohelmetcleanup(param_00);
}

//Function Number: 20
mutatorcombohelmetcleanup(param_00)
{
	wait(5);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 21
mutatorcomboemzspike()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_spike_teleport");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	mutatorcomboemzspikemodelsetup();
	mutatorcomboemzspikebehavior();
}

//Function Number: 22
mutatorcomboemzspikemodelsetup()
{
	var_00 = ["zom_mut_cmb_spikes_emp_torso_slice"];
	var_01 = ["zom_mut_cmb_spikes_emp_nofx_torso_slice"];
	var_02 = ["zombies_head_mutator_fire","zombies_head_mutator_fire_cau_a","zombies_head_mutator_fire_cau_b","zombies_head_mutator_fire_cau_c"];
	var_03 = ["zom_mut_cmb_spikes_emp_r_leg_slice"];
	var_04 = ["zom_mut_cmb_spikes_emp_l_leg_slice"];
	var_05 = ["zom_mut_cmb_spikes_emp_r_arm_slice"];
	var_06 = ["zom_mut_cmb_spikes_emp_nofx_r_arm_slice"];
	var_07 = ["zom_mut_cmb_spikes_emp_l_arm_slice"];
	var_08 = ["zom_mut_cmb_spikes_emp_nofx_l_arm_slice"];
	var_09 = randomint(var_00.size);
	var_0A = randomint(var_02.size);
	var_0B = randomint(var_03.size);
	var_0C = randomint(var_04.size);
	var_0D = randomint(var_05.size);
	var_0E = randomint(var_07.size);
	self.precloneswapfunc = ::maps\mp\zombies\_mutators::mutator_precloneswap;
	self detachall();
	self setmodel(var_00[var_09]);
	self.swapbody = var_01[var_09];
	self attach(var_02[var_0A]);
	self.headmodel = var_02[var_0A];
	self attach(var_03[var_0B]);
	self attach(var_04[var_0C]);
	self attach(var_05[var_0D]);
	self attach(var_07[var_0E]);
	self.limbmodels["right_leg"] = var_03[var_0B];
	self.limbmodels["left_leg"] = var_04[var_0C];
	self.limbmodels["right_arm"] = var_05[var_0D];
	self.limbmodels["left_arm"] = var_07[var_0E];
	self.swaplimbmodels["right_arm"] = var_06[var_0D];
	self.swaplimbmodels["left_arm"] = var_08[var_0E];
	if(!isdefined(self.moverateroundmod))
	{
		self.moverateroundmod = 0;
	}

	self.moverateroundmod = self.moverateroundmod + 5;
	var_0F = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_emz_spike",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_0F);
	maps\mp\zombies\_mutators::torso_effects_apply("mut_emz");
	self setsurfacetype("bark");
	self playloopsound("zmb_emz_crackle_loop");
}

//Function Number: 23
mutatorcomboemzspikebehavior()
{
	thread maps\mp\zombies\_mutators::mutatoremz_watchforattackhits();
	thread maps\mp\zombies\_mutators::mutatoremz_watchforproximityboosters();
	self waittill("death");
	playsoundatpos(self.origin,"zmb_mut_spiked_explo");
}

//Function Number: 24
mutatorcomboemzspikeondamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!maps\mp\zombies\_util::checkactivemutator("combo_emz_spike"))
	{
		return;
	}

	if(common_scripts\utility::cointoss())
	{
		return;
	}

	if(!isdefined(self.spikeblastready))
	{
		thread mutatorcombospikeblast(param_01);
		thread maps\mp\zombies\_mutators::mutatoremz_bursttonearbyplayers(0);
	}
}