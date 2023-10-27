/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perks.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 279 ms
 * Timestamp: 10/27/2023 1:22:02 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.perkfuncs = [];
	level.spawnglowmodel["enemy"] = "emergency_flare_iw6";
	level.spawnglowmodel["friendly"] = "emergency_flare_iw6";
	level.spawnglow["enemy"] = loadfx("fx/misc/flare_ambient");
	level.spawnglow["friendly"] = loadfx("fx/misc/flare_ambient_green");
	level.spawnfire = loadfx("fx/props/barrelexp");
	level._effect["ricochet"] = loadfx("fx/impacts/large_metalhit_1");
	level.scriptperks = [];
	level.perksetfuncs = [];
	level.perkunsetfuncs = [];
	level.fauxperks = [];
	level.scriptperks["_specialty_blastshield"] = 1;
	level.scriptperks["_specialty_onemanarmy"] = 1;
	level.scriptperks["_specialty_rearview"] = 1;
	level.scriptperks["specialty_ac130"] = 1;
	level.scriptperks["specialty_akimbo"] = 1;
	level.scriptperks["specialty_anytwo"] = 1;
	level.scriptperks["specialty_armorpiercing"] = 1;
	level.scriptperks["specialty_assists"] = 1;
	level.scriptperks["specialty_autospot"] = 1;
	level.scriptperks["specialty_blackbox"] = 1;
	level.scriptperks["specialty_blastshield"] = 1;
	level.scriptperks["specialty_bloodrush"] = 1;
	level.scriptperks["specialty_boom"] = 1;
	level.scriptperks["specialty_challenger"] = 1;
	level.scriptperks["specialty_combat_speed"] = 1;
	level.scriptperks["specialty_comexp"] = 1;
	level.scriptperks["specialty_concussiongrenade"] = 1;
	level.scriptperks["specialty_dangerclose"] = 1;
	level.scriptperks["specialty_deadeye"] = 1;
	level.scriptperks["specialty_delaymine"] = 1;
	level.scriptperks["specialty_double_load"] = 1;
	level.scriptperks["specialty_endgame"] = 1;
	level.scriptperks["specialty_explosivedamage"] = 1;
	level.scriptperks["specialty_extra_attachment"] = 1;
	level.scriptperks["specialty_extra_deadly"] = 1;
	level.scriptperks["specialty_extra_equipment"] = 1;
	level.scriptperks["specialty_extraspecialduration"] = 1;
	level.scriptperks["specialty_falldamage"] = 1;
	level.scriptperks["specialty_fasterlockon"] = 1;
	level.scriptperks["specialty_feigndeath"] = 1;
	level.scriptperks["specialty_flashgrenade"] = 1;
	level.scriptperks["specialty_gambler"] = 1;
	level.scriptperks["specialty_gunsmith"] = 1;
	level.scriptperks["specialty_hard_shell"] = 1;
	level.scriptperks["specialty_hardjack"] = 1;
	level.scriptperks["specialty_hardline"] = 1;
	level.scriptperks["specialty_helicopter_minigun"] = 1;
	level.scriptperks["specialty_incog"] = 1;
	level.scriptperks["specialty_laststandoffhand"] = 1;
	level.scriptperks["specialty_littlebird_support"] = 1;
	level.scriptperks["specialty_localjammer"] = 1;
	level.scriptperks["specialty_luckycharm"] = 1;
	level.scriptperks["specialty_moreHealth"] = 1;
	level.scriptperks["specialty_omaquickchange"] = 1;
	level.scriptperks["specialty_onemanarmy"] = 1;
	level.scriptperks["specialty_overkillpro"] = 1;
	level.scriptperks["specialty_paint"] = 1;
	level.scriptperks["specialty_paint_pro"] = 1;
	level.scriptperks["specialty_pitcher"] = 1;
	level.scriptperks["specialty_precision_airstrike"] = 1;
	level.scriptperks["specialty_predator_missile"] = 1;
	level.scriptperks["specialty_primarydeath"] = 1;
	level.scriptperks["specialty_rearview"] = 1;
	level.scriptperks["specialty_refill_ammo"] = 1;
	level.scriptperks["specialty_refill_grenades"] = 1;
	level.scriptperks["specialty_regenfaster"] = 1;
	level.scriptperks["specialty_rollover"] = 1;
	level.scriptperks["specialty_saboteur"] = 1;
	level.scriptperks["specialty_secondarybling"] = 1;
	level.scriptperks["specialty_sentry_minigun"] = 1;
	level.scriptperks["specialty_shellshock"] = 1;
	level.scriptperks["specialty_shield"] = 1;
	level.scriptperks["specialty_smokegrenade"] = 1;
	level.scriptperks["specialty_steadyaimpro"] = 1;
	level.scriptperks["specialty_steelnerves"] = 1;
	level.scriptperks["specialty_stun_resistance"] = 1;
	level.scriptperks["specialty_tagger"] = 1;
	level.scriptperks["specialty_tank"] = 1;
	level.scriptperks["specialty_thermal"] = 1;
	level.scriptperks["specialty_triggerhappy"] = 1;
	level.scriptperks["specialty_twoprimaries"] = 1;
	level.scriptperks["specialty_weaponlaser"] = 1;
	level.fauxperks["specialty_shield"] = 1;
	level.scriptperks["specialty_marksman"] = 1;
	level.scriptperks["specialty_sharp_focus"] = 1;
	level.scriptperks["specialty_bling"] = 1;
	level.scriptperks["specialty_moredamage"] = 1;
	level.scriptperks["specialty_rshieldradar"] = 1;
	level.scriptperks["specialty_rshieldscrambler"] = 1;
	level.scriptperks["specialty_combathigh"] = 1;
	level.scriptperks["specialty_finalstand"] = 1;
	level.scriptperks["specialty_c4death"] = 1;
	level.scriptperks["specialty_juiced"] = 1;
	level.scriptperks["specialty_revenge"] = 1;
	level.scriptperks["specialty_light_armor"] = 1;
	level.scriptperks["specialty_carepackage"] = 1;
	level.scriptperks["specialty_stopping_power"] = 1;
	level.scriptperks["specialty_uav"] = 1;
	level.scriptperks["bouncingbetty_mp"] = 1;
	level.scriptperks["c4_mp"] = 1;
	level.scriptperks["claymore_mp"] = 1;
	level.scriptperks["frag_grenade_mp"] = 1;
	level.scriptperks["semtex_mp"] = 1;
	level.scriptperks["throwingknife_mp"] = 1;
	level.scriptperks["throwingknifejugg_mp"] = 1;
	level.scriptperks["thermobaric_grenade_mp"] = 1;
	level.scriptperks["mortar_shell_mp"] = 1;
	level.scriptperks["proximity_explosive_mp"] = 1;
	level.scriptperks["mortar_shelljugg_mp"] = 1;
	level.scriptperks["concussion_grenade_mp"] = 1;
	level.scriptperks["flash_grenade_mp"] = 1;
	level.scriptperks["smoke_grenade_mp"] = 1;
	level.scriptperks["smoke_grenadejugg_mp"] = 1;
	level.scriptperks["emp_grenade_mp"] = 1;
	level.scriptperks["specialty_tacticalinsertion"] = 1;
	level.scriptperks["trophy_mp"] = 1;
	level.scriptperks["motion_sensor_mp"] = 1;
	level.scriptperks["specialty_null"] = 1;
	level.perksetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::func_6FEB;
	level.perkunsetfuncs["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::func_8606;
	level.perksetfuncs["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::func_703B;
	level.perkunsetfuncs["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::func_8620;
	level.perksetfuncs["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::func_7066;
	level.perkunsetfuncs["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::func_862E;
	level.perksetfuncs["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::func_70E5;
	level.perkunsetfuncs["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::func_8649;
	level.perksetfuncs["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::func_6FE9;
	level.perkunsetfuncs["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::func_8605;
	level.perksetfuncs["specialty_lightweight"] = ::maps\mp\perks\_perkfunctions::setlightweight;
	level.perkunsetfuncs["specialty_lightweight"] = ::maps\mp\perks\_perkfunctions::func_862C;
	level.perksetfuncs["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::func_70D4;
	level.perkunsetfuncs["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::func_8643;
	level.perksetfuncs["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::setdelaymine;
	level.perkunsetfuncs["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::func_8619;
	level.perksetfuncs["specialty_challenger"] = ::maps\mp\perks\_perkfunctions::func_6FFF;
	level.perkunsetfuncs["specialty_challenger"] = ::maps\mp\perks\_perkfunctions::func_860D;
	level.perksetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::func_70BC;
	level.perkunsetfuncs["specialty_saboteur"] = ::maps\mp\perks\_perkfunctions::func_863E;
	level.perksetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::func_7029;
	level.perkunsetfuncs["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::func_861C;
	level.perksetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::func_70B0;
	level.perkunsetfuncs["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::func_8637;
	level.perksetfuncs["specialty_ac130"] = ::maps\mp\perks\_perkfunctions::setac130;
	level.perkunsetfuncs["specialty_ac130"] = ::maps\mp\perks\_perkfunctions::func_8602;
	level.perksetfuncs["specialty_sentry_minigun"] = ::maps\mp\perks\_perkfunctions::func_70C0;
	level.perkunsetfuncs["specialty_sentry_minigun"] = ::maps\mp\perks\_perkfunctions::func_863F;
	level.perksetfuncs["specialty_predator_missile"] = ::maps\mp\perks\_perkfunctions::func_70AB;
	level.perkunsetfuncs["specialty_predator_missile"] = ::maps\mp\perks\_perkfunctions::func_8635;
	level.perksetfuncs["specialty_tank"] = ::maps\mp\perks\_perkfunctions::func_70DE;
	level.perkunsetfuncs["specialty_tank"] = ::maps\mp\perks\_perkfunctions::func_8648;
	level.perksetfuncs["specialty_precision_airstrike"] = ::maps\mp\perks\_perkfunctions::func_70AA;
	level.perkunsetfuncs["specialty_precision_airstrike"] = ::maps\mp\perks\_perkfunctions::func_8634;
	level.perksetfuncs["specialty_helicopter_minigun"] = ::maps\mp\perks\_perkfunctions::func_704D;
	level.perkunsetfuncs["specialty_helicopter_minigun"] = ::maps\mp\perks\_perkfunctions::func_8625;
	level.perksetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::func_7087;
	level.perkunsetfuncs["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::func_8630;
	level.perksetfuncs["specialty_littlebird_support"] = ::maps\mp\perks\_perkfunctions::func_7065;
	level.perkunsetfuncs["specialty_littlebird_support"] = ::maps\mp\perks\_perkfunctions::func_862D;
	level.perksetfuncs["specialty_tacticalinsertion"] = ::maps\mp\perks\_perkfunctions::func_70DA;
	level.perkunsetfuncs["specialty_tacticalinsertion"] = ::maps\mp\perks\_perkfunctions::func_8646;
	level.perksetfuncs["specialty_weaponlaser"] = ::maps\mp\perks\_perkfunctions::func_7216;
	level.perkunsetfuncs["specialty_weaponlaser"] = ::maps\mp\perks\_perkfunctions::func_864D;
	level.perksetfuncs["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::func_70D3;
	level.perkunsetfuncs["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::func_8642;
	level.perksetfuncs["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::func_70D8;
	level.perkunsetfuncs["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::func_8645;
	level.perksetfuncs["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::func_7069;
	level.perkunsetfuncs["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::func_862F;
	level.perksetfuncs["specialty_rshieldradar"] = ::maps\mp\perks\_perkfunctions::func_70B8;
	level.perkunsetfuncs["specialty_rshieldradar"] = ::maps\mp\perks\_perkfunctions::func_863C;
	level.perksetfuncs["specialty_rshieldscrambler"] = ::maps\mp\perks\_perkfunctions::func_70BA;
	level.perkunsetfuncs["specialty_rshieldscrambler"] = ::maps\mp\perks\_perkfunctions::func_863D;
	level.perksetfuncs["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::func_7023;
	level.perkunsetfuncs["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::func_861A;
	level.perksetfuncs["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::func_70C1;
	level.perkunsetfuncs["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::func_8640;
	level.perksetfuncs["specialty_hard_shell"] = ::maps\mp\perks\_perkfunctions::sethardshell;
	level.perkunsetfuncs["specialty_hard_shell"] = ::maps\mp\perks\_perkfunctions::func_8624;
	level.perksetfuncs["specialty_regenfaster"] = ::maps\mp\perks\_perkfunctions::func_70B4;
	level.perkunsetfuncs["specialty_regenfaster"] = ::maps\mp\perks\_perkfunctions::func_863A;
	level.perksetfuncs["specialty_autospot"] = ::maps\mp\perks\_perkfunctions::func_6FE7;
	level.perkunsetfuncs["specialty_autospot"] = ::maps\mp\perks\_perkfunctions::func_8604;
	level.perksetfuncs["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::func_7027;
	level.perkunsetfuncs["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::func_861B;
	level.perksetfuncs["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::func_7089;
	level.perkunsetfuncs["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::func_8631;
	level.perksetfuncs["specialty_assists"] = ::maps\mp\perks\_perkfunctions::func_6FE6;
	level.perkunsetfuncs["specialty_assists"] = ::maps\mp\perks\_perkfunctions::func_8603;
	level.perksetfuncs["specialty_refill_grenades"] = ::maps\mp\perks\_perkfunctions::func_70B3;
	level.perkunsetfuncs["specialty_refill_grenades"] = ::maps\mp\perks\_perkfunctions::unsetrefillgrenades;
	level.perksetfuncs["specialty_refill_ammo"] = ::maps\mp\perks\_perkfunctions::func_70B2;
	level.perkunsetfuncs["specialty_refill_ammo"] = ::maps\mp\perks\_perkfunctions::func_8638;
	level.perksetfuncs["specialty_combat_speed"] = ::maps\mp\perks\_perkfunctions::func_7006;
	level.perkunsetfuncs["specialty_combat_speed"] = ::maps\mp\perks\_perkfunctions::func_8611;
	level.perksetfuncs["specialty_gambler"] = ::maps\mp\perks\_perkfunctions::func_703E;
	level.perkunsetfuncs["specialty_gambler"] = ::maps\mp\perks\_perkfunctions::func_8622;
	level.perksetfuncs["specialty_comexp"] = ::maps\mp\perks\_perkfunctions::setcomexp;
	level.perkunsetfuncs["specialty_comexp"] = ::maps\mp\perks\_perkfunctions::func_8613;
	level.perksetfuncs["specialty_gunsmith"] = ::maps\mp\perks\_perkfunctions::func_7045;
	level.perkunsetfuncs["specialty_gunsmith"] = ::maps\mp\perks\_perkfunctions::func_8623;
	level.perksetfuncs["specialty_tagger"] = ::maps\mp\perks\_perkfunctions::func_70DB;
	level.perkunsetfuncs["specialty_tagger"] = ::maps\mp\perks\_perkfunctions::func_8647;
	level.perksetfuncs["specialty_pitcher"] = ::maps\mp\perks\_perkfunctions::func_7095;
	level.perkunsetfuncs["specialty_pitcher"] = ::maps\mp\perks\_perkfunctions::func_8633;
	level.perksetfuncs["specialty_boom"] = ::maps\mp\perks\_perkfunctions::func_6FF1;
	level.perkunsetfuncs["specialty_boom"] = ::maps\mp\perks\_perkfunctions::func_860A;
	level.perksetfuncs["specialty_silentkill"] = ::maps\mp\perks\_perkfunctions::func_70C7;
	level.perkunsetfuncs["specialty_silentkill"] = ::maps\mp\perks\_perkfunctions::func_8641;
	level.perksetfuncs["specialty_bloodrush"] = ::maps\mp\perks\_perkfunctions::func_6FED;
	level.perkunsetfuncs["specialty_bloodrush"] = ::maps\mp\perks\_perkfunctions::func_8608;
	level.perksetfuncs["specialty_triggerhappy"] = ::maps\mp\perks\_perkfunctions::func_70E8;
	level.perkunsetfuncs["specialty_triggerhappy"] = ::maps\mp\perks\_perkfunctions::func_864A;
	level.perksetfuncs["specialty_deadeye"] = ::maps\mp\perks\_perkfunctions::func_7012;
	level.perkunsetfuncs["specialty_deadeye"] = ::maps\mp\perks\_perkfunctions::func_8618;
	level.perksetfuncs["specialty_incog"] = ::maps\mp\perks\_perkfunctions::func_7054;
	level.perkunsetfuncs["specialty_incog"] = ::maps\mp\perks\_perkfunctions::func_8626;
	level.perksetfuncs["specialty_blindeye"] = ::maps\mp\perks\_perkfunctions::func_6FEC;
	level.perkunsetfuncs["specialty_blindeye"] = ::maps\mp\perks\_perkfunctions::func_8607;
	level.perksetfuncs["specialty_quickswap"] = ::maps\mp\perks\_perkfunctions::func_70AC;
	level.perkunsetfuncs["specialty_quickswap"] = ::maps\mp\perks\_perkfunctions::func_8636;
	level.perksetfuncs["specialty_extraammo"] = ::maps\mp\perks\_perkfunctions::setextraammo;
	level.perkunsetfuncs["specialty_extraammo"] = ::maps\mp\perks\_perkfunctions::unsetextraammo;
	level.perksetfuncs["specialty_extra_equipment"] = ::maps\mp\perks\_perkfunctions::setextraequipment;
	level.perkunsetfuncs["specialty_extra_equipment"] = ::maps\mp\perks\_perkfunctions::unsetextraequipment;
	level.perksetfuncs["specialty_extra_deadly"] = ::maps\mp\perks\_perkfunctions::setextradeadly;
	level.perkunsetfuncs["specialty_extra_deadly"] = ::maps\mp\perks\_perkfunctions::unsetextradeadly;
	level.perksetfuncs["specialty_combathigh"] = ::maps\mp\perks\_perkfunctions::func_7005;
	level.perkunsetfuncs["specialty_combathigh"] = ::maps\mp\perks\_perkfunctions::func_860E;
	level.perksetfuncs["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::func_7063;
	level.perkunsetfuncs["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::unsetlightarmor;
	level.perksetfuncs["specialty_revenge"] = ::maps\mp\perks\_perkfunctions::func_70B6;
	level.perkunsetfuncs["specialty_revenge"] = ::maps\mp\perks\_perkfunctions::func_863B;
	level.perksetfuncs["specialty_c4death"] = ::maps\mp\perks\_perkfunctions::func_6FF4;
	level.perkunsetfuncs["specialty_c4death"] = ::maps\mp\perks\_perkfunctions::func_860B;
	level.perksetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::func_7031;
	level.perkunsetfuncs["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::func_861D;
	level.perksetfuncs["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::func_705B;
	level.perkunsetfuncs["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::func_8627;
	level.perksetfuncs["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::func_6FF6;
	level.perkunsetfuncs["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::func_860C;
	level.perksetfuncs["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::func_70D5;
	level.perkunsetfuncs["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::func_8644;
	level.perksetfuncs["specialty_uav"] = ::maps\mp\perks\_perkfunctions::func_70EE;
	level.perkunsetfuncs["specialty_uav"] = ::maps\mp\perks\_perkfunctions::func_864B;
	func_463D();
	level thread func_595D();
}

//Function Number: 2
validateequipment(param_00,param_01,param_02)
{
	param_02 = common_scripts\utility::func_803F(isdefined(param_02),param_02,1);
	param_00 = common_scripts\utility::func_803F(param_00 == "none","specialty_null",param_00);
	if(param_01)
	{
		switch(param_00)
		{
			case "proximity_explosive_mp":
			case "semtex_mp":
			case "c4_mp":
			case "throwingknifejugg_mp":
			case "throwingknife_mp":
			case "mortar_shelljugg_mp":
			case "mortar_shell_mp":
			case "frag_grenade_mp":
			case "specialty_null":
				break;

			default:
				param_00 = "specialty_null";
				break;
		}
	}
	else
	{
		switch(param_00)
		{
			case "concussion_grenade_mp":
			case "smoke_grenadejugg_mp":
			case "smoke_grenade_mp":
			case "thermobaric_grenade_mp":
			case "motion_sensor_mp":
			case "flash_grenade_mp":
			case "trophy_mp":
			case "specialty_null":
				break;

			default:
				param_00 = "specialty_null";
				break;
		}
	}

	return param_00;
}

//Function Number: 3
func_8817(param_00)
{
	if(!maps\mp\_utility::perksenabled())
	{
		param_00 = "specialty_null";
	}
	else
	{
		switch(param_00)
		{
			case "specialty_deadeye":
			case "specialty_explosivedamage":
			case "specialty_comexp":
			case "specialty_gpsjammer":
			case "specialty_quickdraw":
			case "specialty_stalker":
			case "specialty_boom":
			case "specialty_extraammo":
			case "specialty_extra_deadly":
			case "_specialty_blastshield":
			case "specialty_regenfaster":
			case "specialty_selectivehearing":
			case "specialty_detectexplosive":
			case "specialty_scavenger":
			case "specialty_quieter":
			case "specialty_marathon":
			case "specialty_lightweight":
			case "specialty_fastreload":
			case "specialty_gambler":
			case "specialty_extra_equipment":
			case "specialty_falldamage":
			case "specialty_paint":
			case "specialty_silentkill":
			case "specialty_sprintreload":
			case "specialty_pitcher":
			case "specialty_fastsprintrecovery":
			case "specialty_extra_attachment":
			case "specialty_twoprimaries":
			case "specialty_bulletaccuracy":
			case "specialty_quickswap":
			case "specialty_sharp_focus":
			case "specialty_blindeye":
			case "specialty_incog":
			case "specialty_hardline":
			case "specialty_stun_resistance":
			case "specialty_null":
				break;

			default:
				param_00 = "specialty_null";
				break;
		}
	}

	return param_00;
}

//Function Number: 4
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	self.perks = [];
	self.perksperkname = [];
	self.perksuseslot = [];
	self.weaponlist = [];
	self.omaclasschanged = 0;
	for(;;)
	{
		self waittill("spawned_player");
		self.omaclasschanged = 0;
		thread maps\mp\killstreaks\_portableaoegenerator::func_3782();
	}
}

//Function Number: 6
func_8085()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = gettime() + 5000;
	wait(0.05);
	self.thermodebuffed = 1;
	for(;;)
	{
		if(self.health == self.maxhealth)
		{
			self.thermodebuffed = 0;
		}

		if(gettime() >= var_00)
		{
			self.thermodebuffed = 0;
		}

		wait(0.05);
	}
}

//Function Number: 7
func_1905(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(maps\mp\_utility::func_50C1() && self.maxhealth > 100)
	{
		if(isdefined(param_04) && weaponclass(param_04) == "spread")
		{
			param_02 = param_02 * self.maxhealth / 100;
		}
	}

	var_09 = 0;
	var_0A = 0;
	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		var_0A = level.juggernautmod;
		if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac)
		{
			var_0A = level.juggernautmaniacmod;
		}
	}

	if(maps\mp\_utility::func_488D(param_03))
	{
		if(maps\mp\_utility::isfmjdamage(param_04,param_03,param_01))
		{
			var_0A = var_0A * level.armorpiercingmod;
		}

		if(isplayer(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_paint_pro") && !maps\mp\_utility::func_48F7(param_04))
		{
			if(!param_00 maps\mp\perks\_perkfunctions::ispainted())
			{
				param_01 maps\mp\gametypes\_missions::func_61CE("ch_bulletpaint");
			}

			param_00 thread maps\mp\perks\_perkfunctions::func_708E(param_01);
		}

		if(isplayer(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_bulletdamage") && param_00 maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
		}
		else if(isplayer(param_01) && param_01 maps\mp\_utility::_hasperk("specialty_bulletdamage") || param_01 maps\mp\_utility::_hasperk("specialty_moredamage"))
		{
			var_09 = var_09 + param_02 * level.bulletdamagemod;
		}
		else if(param_00 maps\mp\_utility::_hasperk("specialty_armorvest"))
		{
			var_09 = var_09 - param_02 * level.armorvestmod;
		}

		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			if(level.hardcoremode && isdefined(param_04) && weaponclass(param_04) == "spread")
			{
				param_02 = min(param_02,25) * var_0A;
				var_09 = min(param_02,25) * var_0A;
			}
			else
			{
				param_02 = param_02 * var_0A;
				var_09 = var_09 * var_0A;
			}
		}
	}
	else if(isexplosivedamagemod(param_03))
	{
		if(param_04 == "proximity_explosive_mp" && isdefined(param_08.origin))
		{
			if(param_00 getstance() == "prone")
			{
				param_02 = param_02 * 0.65;
			}
			else if(!param_00 isonground())
			{
				param_02 = param_02 * 0.8;
			}
			else if(param_00 getstance() == "crouch")
			{
				param_02 = param_02 * 0.9;
			}
		}

		if(isplayer(param_01))
		{
			if(param_01 != param_00 && param_01 isitemunlocked("specialty_paint") && param_01 maps\mp\_utility::_hasperk("specialty_paint") && !maps\mp\_utility::func_48F7(param_04))
			{
				if(!param_00 maps\mp\perks\_perkfunctions::ispainted())
				{
					param_01 maps\mp\gametypes\_missions::func_61CE("ch_paint_pro");
				}

				param_00 thread maps\mp\perks\_perkfunctions::func_708E(param_01);
			}
		}

		if(isdefined(param_00.thermodebuffed) && param_00.thermodebuffed)
		{
			var_09 = var_09 + int(param_02 * level.thermodebuffmod);
		}

		if(param_04 == "thermobaric_grenade_mp")
		{
			if(level.hardcoremode)
			{
				param_02 = param_02 * 0.3;
			}

			param_00 thread func_8085();
		}

		if(isplayer(param_01) && weaponinheritsperks(param_04) && param_01 maps\mp\_utility::_hasperk("specialty_explosivedamage") && param_00 maps\mp\_utility::_hasperk("_specialty_blastshield"))
		{
		}
		else if(isplayer(param_01) && weaponinheritsperks(param_04) && !maps\mp\_utility::func_48F7(param_04) && param_01 maps\mp\_utility::_hasperk("specialty_explosivedamage"))
		{
			var_09 = var_09 + param_02 * level.explosivedamagemod;
		}
		else if(param_00 maps\mp\_utility::_hasperk("_specialty_blastshield") && !maps\mp\_utility::weaponignoresblastshield(param_04) && !isdefined(param_08) || !isdefined(param_08.stuckenemyentity) || param_08.stuckenemyentity != param_00)
		{
			var_0B = int(param_02 * level.blastshieldmod);
			if(maps\mp\gametypes\_weapons::func_48D0(param_04) || maps\mp\_utility::func_49B3(param_04))
			{
				var_0B = clamp(var_0B,0,level.blastshieldclamp);
			}

			var_09 = var_09 - param_02 - var_0B;
		}

		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			var_09 = var_09 * var_0A;
			if(param_02 < 1000)
			{
				param_02 = param_02 * var_0A;
			}
		}

		if(!maps\mp\_utility::func_47BB())
		{
			if(10 - level.graceperiod - level.ingraceperiod > 0)
			{
				param_02 = param_02 * level.graceperiodgrenademod;
			}
		}
	}
	else if(param_03 == "MOD_FALLING")
	{
		if(param_00 maps\mp\_utility::_hasperk("specialty_falldamage"))
		{
			if(param_02 > 0)
			{
				param_00 maps\mp\gametypes\_missions::func_61CE("ch_falldamage");
			}

			var_09 = 0;
			param_02 = 0;
		}
		else if(param_00 maps\mp\_utility::isjuggernaut())
		{
			param_02 = param_02 * var_0A;
		}
	}
	else if(param_03 == "MOD_MELEE")
	{
		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			param_02 = 20;
			var_09 = 0;
		}
		else if(maps\mp\perks\_perkfunctions::func_400D(param_00))
		{
			param_02 = 100;
		}
		else if(isdefined(param_00.custommeleedamagetaken) && param_00.custommeleedamagetaken >= 0)
		{
			param_02 = param_00.custommeleedamagetaken;
		}
		else if(maps\mp\gametypes\_weapons::func_494E(param_04))
		{
			if(level.hardcoremode)
			{
				param_02 = int(param_00.maxhealth + 1);
			}
			else
			{
				param_02 = int(param_00.maxhealth * 0.66);
			}
		}
		else
		{
			param_02 = param_00.maxhealth + 1;
		}
	}
	else if(param_03 == "MOD_IMPACT")
	{
		if(param_00 maps\mp\_utility::isjuggernaut())
		{
			switch(param_04)
			{
				case "semtexproj_mp":
				case "semtex_mp":
				case "concussion_grenade_mp":
				case "smoke_grenadejugg_mp":
				case "smoke_grenade_mp":
				case "flash_grenade_mp":
				case "mortar_shelljugg_mp":
				case "mortar_shell_mp":
				case "frag_grenade_mp":
								param_02 = 5;
								break;

				default:
								if(param_02 < 1000)
								{
									param_02 = 25;
								}
								break;
			}

			var_09 = 0;
		}
	}
	else if(param_03 == "MOD_UNKNOWN" || param_03 == "MOD_MELEE_DOG")
	{
		if(isagent(param_01) && isdefined(param_01.agent_type) && param_01.agent_type == "dog" && param_00 maps\mp\_utility::isjuggernaut())
		{
			param_00 shellshock("dog_bite",2);
			param_02 = param_02 * var_0A;
		}
	}

	if(param_00 maps\mp\_utility::_hasperk("specialty_combathigh"))
	{
		if(isdefined(self.damageblockedtotal) && !level.teambased || isdefined(param_01) && isdefined(param_01.team) && param_00.team != param_01.team)
		{
			var_0C = param_02 + var_09;
			var_0D = var_0C - var_0C / 3;
			self.damageblockedtotal = self.damageblockedtotal + var_0D;
			if(self.damageblockedtotal >= 101)
			{
				self notify("combathigh_survived");
				self.damageblockedtotal = undefined;
			}
		}

		if(param_04 != "throwingknife_mp" && param_04 != "throwingknifejugg_mp")
		{
			switch(param_03)
			{
				case "MOD_FALLING":
				case "MOD_MELEE":
					break;

				default:
					param_02 = int(param_02 / 3);
					var_09 = int(var_09 / 3);
					break;
			}
		}
	}

	if(isdefined(param_00.lightarmorhp))
	{
		switch(param_04)
		{
			case "throwingknifejugg_mp":
			case "throwingknife_mp":
				param_02 = param_00.health;
				var_09 = 0;
				break;

			case "semtexproj_mp":
			case "semtex_mp":
				if(isdefined(param_08) && isdefined(param_08.stuckenemyentity) && param_08.stuckenemyentity == param_00)
				{
					param_02 = param_00.health;
					var_09 = 0;
				}
				break;

			default:
				if(param_03 != "MOD_FALLING" && param_03 != "MOD_MELEE" && !maps\mp\_utility::func_48D2(param_04,param_07,param_03,param_01) && !maps\mp\_utility::isfmjdamage(param_04,param_03,param_01))
				{
					param_00.lightarmorhp = param_00.lightarmorhp - param_02 + var_09;
					param_02 = 0;
					var_09 = 0;
					if(param_00.lightarmorhp <= 0)
					{
						param_02 = abs(param_00.lightarmorhp);
						var_09 = 0;
						maps\mp\perks\_perkfunctions::unsetlightarmor();
					}
				}
				break;
		}
	}

	if(maps\mp\perks\_perkfunctions::func_400D(param_00))
	{
		param_00.heavyarmorhp = param_00.heavyarmorhp - param_02 + var_09;
		param_02 = 0;
		if(param_00.heavyarmorhp < 0)
		{
			param_02 = abs(param_00.heavyarmorhp);
		}
	}

	if(!maps\mp\_utility::func_47BB() && param_02 <= 1)
	{
		param_02 = 1;
	}
	else
	{
		param_02 = int(param_02 + var_09);
	}

	return param_02;
}

//Function Number: 8
func_463D()
{
	level.graceperiodgrenademod = 0.08;
	level.juggernautmod = 0.08;
	level.juggernautmaniacmod = 0.08;
	level.armorpiercingmod = 1.5;
	level.regenfastermod = maps\mp\_utility::func_3ADD("perk_fastRegenWaitMS",500) / 1000;
	level.regenfasterhealthmod = maps\mp\_utility::func_3ADD("perk_fastRegenRate",2);
	level.bulletdamagemod = maps\mp\_utility::func_3ADD("perk_bulletDamage",40) / 100;
	level.explosivedamagemod = maps\mp\_utility::func_3ADD("perk_explosiveDamage",40) / 100;
	level.blastshieldmod = maps\mp\_utility::func_3ADD("perk_blastShieldScale",65) / 100;
	level.blastshieldclamp = maps\mp\_utility::func_3ADD("perk_blastShieldClampHP",80);
	level.thermodebuffmod = maps\mp\_utility::func_3ADD("weap_thermoDebuffMod",185) / 100;
	level.riotshieldmod = maps\mp\_utility::func_3ADD("perk_riotShield",100) / 100;
	level.armorvestmod = maps\mp\_utility::func_3ADD("perk_armorVest",75) / 100;
	if(isdefined(level.hardcoremode) && level.hardcoremode)
	{
		level.blastshieldmod = maps\mp\_utility::func_3ADD("perk_blastShieldScale_HC",10) / 100;
		level.blastshieldclamp = maps\mp\_utility::func_3ADD("perk_blastShieldClampHP_HC",20);
	}
}

//Function Number: 9
cac_selector()
{
	var_00 = self.specialty;
}

//Function Number: 10
giveperksafterspawn()
{
	self endon("death");
	self endon("disconnect");
	var_00 = [];
	if(!maps\mp\_utility::_hasperk("specialty_blindeye"))
	{
		maps\mp\_utility::func_3CFB("specialty_blindeye",0);
		var_00[var_00.size] = "specialty_blindeye";
	}

	if(!maps\mp\_utility::_hasperk("specialty_gpsjammer"))
	{
		maps\mp\_utility::func_3CFB("specialty_gpsjammer",0);
		var_00[var_00.size] = "specialty_gpsjammer";
	}

	if(var_00.size > 0)
	{
		self.spawnperk = 1;
		while(self.avoidkillstreakonspawntimer > 0)
		{
			self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
			wait(0.05);
		}

		foreach(var_02 in var_00)
		{
			maps\mp\_utility::_unsetperk(var_02);
		}

		self.spawnperk = 0;
		self notify("starting_perks_unset");
	}
}

//Function Number: 11
func_3B87(param_00)
{
	return tablelookup("mp/perkTable.csv",1,param_00,3);
}

//Function Number: 12
func_3B88(param_00)
{
	return tablelookupistring("mp/perkTable.csv",1,param_00,2);
}

//Function Number: 13
func_86C4(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00) && isplayer(param_00) && isdefined(param_01) && isplayer(param_01) && param_01 != param_02)
	{
		if(param_01 maps\mp\_utility::_hasperk("specialty_triggerhappy"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::func_70E9();
		}

		if(param_01 maps\mp\_utility::_hasperk("specialty_boom"))
		{
			param_02 thread maps\mp\perks\_perkfunctions::func_6FF2(param_01);
		}

		if(param_01 maps\mp\_utility::_hasperk("specialty_bloodrush"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::setbloodrushinternal();
		}

		if(param_01 maps\mp\_utility::_hasperk("specialty_deadeye"))
		{
			param_01.deadeyekillcount++;
		}

		var_05 = param_01.pers["abilityRecharging"];
		if(isdefined(var_05) && var_05)
		{
			param_01 notify("abilityFastRecharge");
		}

		var_06 = param_01.pers["abilityOn"];
		if(isdefined(var_06) && var_06)
		{
			param_01 notify("abilityExtraTime");
		}
	}
}