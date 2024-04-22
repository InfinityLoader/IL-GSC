/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_mutators_spiked.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 76 ms
 * Timestamp: 4/22/2024 2:13:48 AM
*******************************************************************/

//Function Number: 1
initspikedmutator()
{
	level._effect["mut_spiked_explosion"] = loadfx("vfx/blood/dlc_zombie_spike_explosion");
	level._effect["mut_spiked_explosion_2"] = loadfx("vfx/blood/dlc_zombie_spike_explosion_2");
	maps\mp\zombies\_mutators::addmutatortotable("spiked",::mutatorspiked,"zmb_mut_spiked_spawn",undefined,::onspikedzombiedamaged);
	maps\mp\zombies\_mutators::disablemutatorfortypes("spiked",["zombie_dog","zombie_melee_goliath","zombie_ranged_goliath"]);
}

//Function Number: 2
mutatorspiked()
{
	thread maps\mp\zombies\_mutators::mutatorspawnsound("spiked");
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
	self.boostfxtag = "tag_jetpack";
	var_00 = ["zom_marine_m_spikes_exo_torso_slice"];
	var_01 = ["zom_marine_m_spikes_exo_torso_slice"];
	var_02 = ["zombies_head_mutator_fire","zombies_head_mutator_fire_cau_a","zombies_head_mutator_fire_cau_b","zombies_head_mutator_fire_cau_c"];
	var_03 = ["zom_marine_m_ovr_exo_r_leg_slice","zom_marine_m_ovr_exo_r_leg_slice_ab"];
	var_04 = ["zom_marine_m_ovr_nofx_exo_r_leg_slice","zom_marine_m_ovr_nofx_exo_r_leg_slice_ab"];
	var_05 = ["zom_marine_m_ovr_exo_l_leg_slice","zom_marine_m_ovr_exo_l_leg_slice_ab"];
	var_06 = ["zom_marine_m_ovr_nofx_exo_l_leg_slice","zom_marine_m_ovr_nofx_exo_l_leg_slice_ab"];
	var_07 = ["zom_marine_m_spikes_exo_r_arm_slice"];
	var_08 = ["zom_marine_m_spikes_exo_r_arm_slice"];
	var_09 = ["zom_marine_m_spikes_exo_l_arm_slice"];
	var_0A = ["zom_marine_m_spikes_exo_l_arm_slice"];
	var_0B = randomint(var_00.size);
	var_0C = randomint(var_02.size);
	var_0D = randomint(var_03.size);
	var_0E = randomint(var_05.size);
	var_0F = randomint(var_07.size);
	var_10 = randomint(var_09.size);
	self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap();
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
	self.swaplimbmodels["right_arm"] = var_08[var_0F];
	self.swaplimbmodels["left_arm"] = var_0A[var_10];
	if(!isdefined(self.moverateroundmod))
	{
		self.moverateroundmod = 0;
	}

	self.moverateroundmod = self.moverateroundmod + 5;
	var_11 = maps\mp\gametypes\zombies::geteyeeffectforzombie("fast",self.headmodel);
	maps\mp\zombies\_util::zombie_set_eyes(var_11);
	self waittill("death");
	playsoundatpos(self.origin,"zmb_mut_spiked_explo");
}

//Function Number: 3
onspikedzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!maps\mp\zombies\_util::checkactivemutator("spiked"))
	{
		return;
	}

	if(common_scripts\utility::cointoss())
	{
		return;
	}

	if(!isdefined(self.spikeblastready))
	{
		thread spikeblast(param_01);
	}
}

//Function Number: 4
spikeblast(param_00)
{
	self endon("death");
	self.spikeblastready = 0;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = self gettagorigin("J_Spine4");
	var_01 linkto(self,"J_Spine4");
	wait(0.05);
	playfx(common_scripts\utility::getfx("mut_spiked_explosion_2"),var_01.origin);
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