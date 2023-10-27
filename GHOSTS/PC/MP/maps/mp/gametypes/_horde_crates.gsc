/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_horde_crates.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 522 ms
 * Timestamp: 10/27/2023 1:18:24 AM
*******************************************************************/

//Function Number: 1
createhordecrates(param_00,param_01)
{
	level.getrandomcratetypeforgamemode = ::func_3BB9;
	level.hordeicon["ammo"] = "specialty_ammo_crate";
	level.hordeicon["iw6_mts255_mp_barrelrange03_reflexshotgun"] = "hud_icon_mts255";
	level.hordeicon["iw6_fp6_mp_barrelrange03_reflexshotgun"] = "hud_icon_fp6";
	level.hordeicon["iw6_vepr_mp_grip"] = "hud_icon_vepr";
	level.hordeicon["iw6_microtar_mp_eotechsmg"] = "hud_icon_microtar";
	level.hordeicon["iw6_ak12_mp_flashsuppress_grip"] = "hud_icon_ak12";
	level.hordeicon["iw6_arx160_mp_flashsuppress_hybrid"] = "hud_icon_arx160";
	level.hordeicon["iw6_m27_mp_flashsuppress_hybrid"] = "hud_icon_m27";
	level.hordeicon["iw6_kac_mp_flashsuppress"] = "hud_icon_kac";
	level.hordeicon["iw6_usr_mp_usrvzscope_xmags"] = "hud_icon_usr";
	level.hordeicon["iw6_magnumhorde_mp_fmj"] = "hud_icon_magnum";
	level.hordeicon["throwingknife_mp"] = "throw_knife_sm";
	level.hordeicon["specialty_lightweight"] = "icon_perks_agility";
	level.hordeicon["specialty_fastreload"] = "icon_perks_sleight_of_hand";
	level.hordeicon["specialty_quickdraw"] = "icon_perks_quickdraw";
	level.hordeicon["specialty_marathon"] = "icon_perks_marathon";
	level.hordeicon["specialty_quickswap"] = "icon_perks_reflex";
	level.hordeicon["specialty_bulletaccuracy"] = "icon_perks_steady_aim";
	level.hordeicon["specialty_fastsprintrecovery"] = "icon_perks_ready_up";
	level.hordeicon["_specialty_blastshield"] = "icon_perks_blast_shield";
	level.hordeicon["specialty_stalker"] = "icon_perks_stalker";
	level.hordeicon["specialty_sharp_focus"] = "icon_perks_focus";
	level.hordeicon["specialty_regenfaster"] = "icon_perks_icu";
	level.hordeicon["specialty_sprintreload"] = "icon_perks_on_the_go";
	level.hordeicon["specialty_triggerhappy"] = "icon_perks_triggerhappy";
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_mts255_mp_barrelrange03_reflexshotgun",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MTS");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_fp6_mp_barrelrange03_reflexshotgun",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FP6");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_vepr_mp_grip",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_VEPR");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_microtar_mp_eotechsmg",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MICRO");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_ak12_mp_flashsuppress_grip",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AK");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_arx160_mp_flashsuppress_hybrid",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_ARX");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_m27_mp_flashsuppress_hybrid",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_M27");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_kac_mp_flashsuppress",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_KAC");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_usr_mp_usrvzscope_xmags",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_USR");
	maps\mp\killstreaks\_airdrop::addcratetype("a","iw6_magnumhorde_mp_fmj",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_WEST");
	maps\mp\killstreaks\_airdrop::addcratetype("a","throwingknife_mp",3,::func_42AA,param_00,param_01,&"HORDE_DOUBLE_TAP_KNIFE");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_lightweight",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_LIGHT");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_fastreload",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FAST");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_quickdraw",10,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_QIUCK");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_marathon",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MARA");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_quickswap",10,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_SWAP");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_bulletaccuracy",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AIM");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_fastsprintrecovery",7,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_READY");
	maps\mp\killstreaks\_airdrop::addcratetype("a","_specialty_blastshield",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_BLAST");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_stalker",10,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_STALK");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_sharp_focus",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FOCUS");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_regenfaster",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_HEALTH");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_sprintreload",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_GO");
	maps\mp\killstreaks\_airdrop::addcratetype("a","specialty_triggerhappy",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_TRIGGER");
	maps\mp\killstreaks\_airdrop::addcratetype("a","ammo",0,::func_42A9,param_00,param_01,&"HORDE_AMMO");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_mts255_mp_barrelrange03_reflexshotgun",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MTS");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_fp6_mp_barrelrange03_reflexshotgun",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FP6");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_vepr_mp_grip",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_VEPR");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_microtar_mp_eotechsmg",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MICRO");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_ak12_mp_flashsuppress_grip",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AK");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_arx160_mp_flashsuppress_hybrid",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_ARX");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_m27_mp_flashsuppress_hybrid",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_M27");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_kac_mp_flashsuppress",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_KAC");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_usr_mp_usrvzscope_xmags",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_USR");
	maps\mp\killstreaks\_airdrop::addcratetype("b","iw6_magnumhorde_mp_fmj",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_WEST");
	maps\mp\killstreaks\_airdrop::addcratetype("b","throwingknife_mp",3,::func_42AA,param_00,param_01,&"HORDE_DOUBLE_TAP_KNIFE");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_lightweight",10,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_LIGHT");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_fastreload",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FAST");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_quickdraw",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_QIUCK");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_marathon",10,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MARA");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_quickswap",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_SWAP");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_bulletaccuracy",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AIM");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_fastsprintrecovery",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_READY");
	maps\mp\killstreaks\_airdrop::addcratetype("b","_specialty_blastshield",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_BLAST");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_stalker",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_STALK");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_sharp_focus",7,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FOCUS");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_regenfaster",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_HEALTH");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_sprintreload",10,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_GO");
	maps\mp\killstreaks\_airdrop::addcratetype("b","specialty_triggerhappy",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_TRIGGER");
	maps\mp\killstreaks\_airdrop::addcratetype("b","ammo",0,::func_42A9,param_00,param_01,&"HORDE_AMMO");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_mts255_mp_barrelrange03_reflexshotgun",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MTS");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_fp6_mp_barrelrange03_reflexshotgun",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FP6");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_vepr_mp_grip",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_VEPR");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_microtar_mp_eotechsmg",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MICRO");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_ak12_mp_flashsuppress_grip",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AK");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_arx160_mp_flashsuppress_hybrid",12,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_ARX");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_m27_mp_flashsuppress_hybrid",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_M27");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_kac_mp_flashsuppress",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_KAC");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_usr_mp_usrvzscope_xmags",6,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_USR");
	maps\mp\killstreaks\_airdrop::addcratetype("c","iw6_magnumhorde_mp_fmj",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_WEST");
	maps\mp\killstreaks\_airdrop::addcratetype("c","throwingknife_mp",2,::func_42AA,param_00,param_01,&"HORDE_DOUBLE_TAP_KNIFE");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_lightweight",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_LIGHT");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_fastreload",12,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FAST");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_quickdraw",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_QIUCK");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_marathon",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MARA");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_quickswap",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_SWAP");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_bulletaccuracy",12,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AIM");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_fastsprintrecovery",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_READY");
	maps\mp\killstreaks\_airdrop::addcratetype("c","_specialty_blastshield",12,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_BLAST");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_stalker",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_STALK");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_sharp_focus",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FOCUS");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_regenfaster",12,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_HEALTH");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_sprintreload",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_GO");
	maps\mp\killstreaks\_airdrop::addcratetype("c","specialty_triggerhappy",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_TRIGGER");
	maps\mp\killstreaks\_airdrop::addcratetype("c","ammo",0,::func_42A9,param_00,param_01,&"HORDE_AMMO");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_mts255_mp_barrelrange03_reflexshotgun",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MTS");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_fp6_mp_barrelrange03_reflexshotgun",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FP6");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_vepr_mp_grip",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_VEPR");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_microtar_mp_eotechsmg",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MICRO");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_ak12_mp_flashsuppress_grip",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AK");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_arx160_mp_flashsuppress_hybrid",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_ARX");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_m27_mp_flashsuppress_hybrid",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_M27");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_kac_mp_flashsuppress",10,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_KAC");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_usr_mp_usrvzscope_xmags",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_USR");
	maps\mp\killstreaks\_airdrop::addcratetype("d","iw6_magnumhorde_mp_fmj",0,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_WEST");
	maps\mp\killstreaks\_airdrop::addcratetype("d","throwingknife_mp",2,::func_42AA,param_00,param_01,&"HORDE_DOUBLE_TAP_KNIFE");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_lightweight",3,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_LIGHT");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_fastreload",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FAST");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_quickdraw",3,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_QIUCK");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_marathon",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MARA");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_quickswap",3,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_SWAP");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_bulletaccuracy",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AIM");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_fastsprintrecovery",3,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_READY");
	maps\mp\killstreaks\_airdrop::addcratetype("d","_specialty_blastshield",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_BLAST");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_stalker",3,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_STALK");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_sharp_focus",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FOCUS");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_regenfaster",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_HEALTH");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_sprintreload",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_GO");
	maps\mp\killstreaks\_airdrop::addcratetype("d","specialty_triggerhappy",0,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_TRIGGER");
	maps\mp\killstreaks\_airdrop::addcratetype("d","ammo",0,::func_42A9,param_00,param_01,&"HORDE_AMMO");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_mts255_mp_barrelrange03_reflexshotgun",4,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MTS");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_fp6_mp_barrelrange03_reflexshotgun",4,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FP6");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_vepr_mp_grip",4,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_VEPR");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_microtar_mp_eotechsmg",4,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MICRO");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_ak12_mp_flashsuppress_grip",4,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AK");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_arx160_mp_flashsuppress_hybrid",4,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_ARX");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_m27_mp_flashsuppress_hybrid",9,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_M27");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_kac_mp_flashsuppress",9,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_KAC");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_usr_mp_usrvzscope_xmags",5,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_USR");
	maps\mp\killstreaks\_airdrop::addcratetype("e","iw6_magnumhorde_mp_fmj",3,::hordecrateweaponthink,param_00,param_01,&"HORDE_DOUBLE_TAP_WEST");
	maps\mp\killstreaks\_airdrop::addcratetype("e","throwingknife_mp",2,::func_42AA,param_00,param_01,&"HORDE_DOUBLE_TAP_KNIFE");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_lightweight",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_LIGHT");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_fastreload",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FAST");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_quickdraw",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_QIUCK");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_marathon",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_MARA");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_quickswap",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_SWAP");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_bulletaccuracy",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_AIM");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_fastsprintrecovery",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_READY");
	maps\mp\killstreaks\_airdrop::addcratetype("e","_specialty_blastshield",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_BLAST");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_stalker",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_STALK");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_sharp_focus",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_FOCUS");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_regenfaster",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_HEALTH");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_sprintreload",4,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_GO");
	maps\mp\killstreaks\_airdrop::addcratetype("e","specialty_triggerhappy",3,::hordecrateperkthink,param_00,param_01,&"HORDE_DOUBLE_TAP_TRIGGER");
	maps\mp\killstreaks\_airdrop::addcratetype("e","ammo",0,::func_42A9,param_00,param_01,&"HORDE_AMMO");
	func_71FE(param_00,param_01);
}

//Function Number: 2
func_71FE(param_00,param_01)
{
	maps\mp\killstreaks\_airdrop::addcratetype("loot","ims",15,::func_4B36,param_00,param_01,&"KILLSTREAKS_HINTS_IMS_PICKUP");
	maps\mp\killstreaks\_airdrop::addcratetype("loot","helicopter",15,::func_4B36,param_00,param_01,&"KILLSTREAKS_HINTS_HELICOPTER_PICKUP");
	maps\mp\killstreaks\_airdrop::addcratetype("loot","drone_hive",15,::func_4B36,param_00,param_01,&"KILLSTREAKS_HINTS_DRONE_HIVE_PICKUP");
	maps\mp\killstreaks\_airdrop::addcratetype("loot","sentry",15,::func_4B36,param_00,param_01,&"KILLSTREAKS_HINTS_SENTRY_PICKUP");
	maps\mp\killstreaks\_airdrop::addcratetype("loot","heli_sniper",15,::func_4B36,param_00,param_01,&"KILLSTREAKS_HINTS_HELI_SNIPER_PICKUP");
	maps\mp\killstreaks\_airdrop::addcratetype("loot","ball_drone_backup",15,::func_4B36,param_00,param_01,&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP");
}

//Function Number: 3
hordecrateweaponthink(param_00)
{
	self endon("death");
	self endon("doubleTap");
	self endon("restarting_physics");
	if(!isdefined(self.doubletapcount))
	{
		self.doubletapcount = 0;
	}

	var_01 = game["strings"][self.cratetype + "_hint"];
	thread doubletapthink();
	maps\mp\killstreaks\_airdrop::cratesetupforuse(var_01,level.hordeicon[self.cratetype]);
	thread func_2039(1000);
	func_700F(self);
	level thread func_65A3(self);
	for(;;)
	{
		self waittill("captured",var_02);
		func_83FF(var_02,self.cratetype);
		maps\mp\killstreaks\_airdrop::deletecrate();
	}
}

//Function Number: 4
func_83FF(param_00,param_01)
{
	param_00 playlocalsound("ammo_crate_use");
	var_02 = [];
	var_03 = param_00 getweaponslistprimaries();
	var_04 = getweaponbasename(param_01);
	foreach(var_06 in var_03)
	{
		if(var_06 == level.intelminigun)
		{
			continue;
		}

		var_02[var_02.size] = var_06;
	}

	if(var_02.size > 1)
	{
		var_08 = 1;
		foreach(var_0A in var_02)
		{
			if(param_01 == var_0A)
			{
				var_08 = 0;
			}
		}

		if(var_08)
		{
			var_0C = param_00 getcurrentprimaryweapon();
			if(var_0C == "none")
			{
				var_0C = param_00 common_scripts\utility::func_3B0A();
			}

			if(!param_00 hasweapon(var_0C) || var_0C == level.intelminigun)
			{
				var_0C = param_00 maps\mp\killstreaks\_killstreaks::func_3AAA();
			}

			param_00 takeweapon(var_0C);
		}
		else
		{
			param_00 givemaxammo(param_01);
			var_0D = param_00.weaponstate[var_04]["barSize"];
			param_00.weaponstate[var_04]["vaule"] = var_0D;
			param_00 notify("weaponPointsEarned");
		}
	}

	maps/mp/gametypes/horde::func_20FA(param_00,var_04,1);
	param_00 maps\mp\_utility::_giveweapon(param_01);
	param_00 switchtoweaponimmediate(param_01);
}

//Function Number: 5
hordecrateperkthink(param_00)
{
	self endon("death");
	self endon("doubleTap");
	self endon("restarting_physics");
	if(!isdefined(self.doubletapcount))
	{
		self.doubletapcount = 0;
	}

	var_01 = game["strings"][self.cratetype + "_hint"];
	thread doubletapthink();
	maps\mp\killstreaks\_airdrop::cratesetupforuse(var_01,level.hordeicon[self.cratetype]);
	thread func_2039(1000);
	func_700F(self);
	level thread func_65A3(self);
	for(;;)
	{
		self waittill("captured",var_02);
		var_02 playlocalsound("ammo_crate_use");
		if(!var_02 maps\mp\_utility::_hasperk(self.cratetype))
		{
			var_03 = self.cratetype;
			var_02 maps\mp\_utility::func_3CFB(var_03,0);
			var_04 = tablelookup("mp/hordeIcons.csv",1,var_03,0);
			var_02 setclientomnvar("ui_horde_update_perk",int(var_04));
			var_05 = var_02.horde_perks.size;
			var_02.horde_perks[var_05]["name"] = var_03;
			var_02.horde_perks[var_05]["index"] = int(var_04);
		}

		maps\mp\killstreaks\_airdrop::deletecrate();
	}
}

//Function Number: 6
func_42AA(param_00)
{
	self endon("death");
	self endon("doubleTap");
	self endon("restarting_physics");
	if(!isdefined(self.doubletapcount))
	{
		self.doubletapcount = 0;
	}

	var_01 = game["strings"][self.cratetype + "_hint"];
	thread doubletapthink();
	maps\mp\killstreaks\_airdrop::cratesetupforuse(var_01,level.hordeicon[self.cratetype]);
	thread func_2039(1000);
	func_700F(self);
	level thread func_65A3(self);
	for(;;)
	{
		self waittill("captured",var_02);
		var_02 playlocalsound("ammo_crate_use");
		if(!var_02 hasweapon(self.cratetype))
		{
			var_03 = var_02 getcurrentoffhand();
			var_02 takeweapon(var_03);
			var_02 maps\mp\_utility::giveperkequipment(self.cratetype,1);
		}
		else
		{
			var_02 givemaxammo(self.cratetype);
		}

		maps\mp\killstreaks\_airdrop::deletecrate();
	}
}

//Function Number: 7
func_42A9(param_00)
{
	self endon("death");
	self endon("restarting_physics");
	var_01 = game["strings"][self.cratetype + "_hint"];
	maps\mp\killstreaks\_airdrop::cratesetupforuse(var_01,level.hordeicon[self.cratetype]);
	thread func_2039(2000);
	self.friendlymodel hudoutlineenable(5,0);
	self.outlinecolor = 5;
	level thread func_65A3(self);
	for(;;)
	{
		self waittill("captured",var_02);
		var_02 playlocalsound("ammo_crate_use");
		level thread maps\mp\gametypes\_horde_util::func_93E8(var_02);
		maps\mp\killstreaks\_airdrop::deletecrate();
	}
}

//Function Number: 8
func_4B36(param_00)
{
	self endon("death");
	self endon("restarting_physics");
	var_01 = game["strings"][self.cratetype + "_hint"];
	maps\mp\killstreaks\_airdrop::cratesetupforuse(var_01,maps\mp\_utility::getkillstreakoverheadicon(self.cratetype));
	thread func_2039(2000);
	func_700E(self,3,(0.157,0.784,0.784));
	for(;;)
	{
		self waittill("captured",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		var_03 = func_3BE8(var_02);
		if(!isdefined(var_03))
		{
			continue;
		}

		var_02 playlocalsound("ammo_crate_use");
		var_02 thread maps\mp\killstreaks\_killstreaks::func_3CF2(self.cratetype,0,0,self.owner,var_03);
		maps\mp\killstreaks\_airdrop::deletecrate();
	}
}

//Function Number: 9
func_3BE8(param_00)
{
	var_01 = undefined;
	for(var_02 = 1;var_02 < 4;var_02++)
	{
		var_03 = param_00.pers["killstreaks"][var_02];
		if(!isdefined(var_03) || !isdefined(var_03.streakname) || var_03.available == 0)
		{
			var_01 = var_02;
			break;
		}
	}

	return var_01;
}

//Function Number: 10
func_2039(param_00)
{
	self endon("doubleTap");
	self endon("restarting_physics");
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	while(isdefined(self))
	{
		self makeusable();
		self waittill("trigger",var_01);
		if(func_3F6B(var_01))
		{
			continue;
		}

		if(func_3F85(var_01))
		{
			continue;
		}

		if(!maps\mp\killstreaks\_airdrop::func_8816(var_01))
		{
			continue;
		}

		self makeunusable();
		var_01.iscapturingcrate = 1;
		if(!maps\mp\killstreaks\_airdrop::func_87BF(var_01,param_00))
		{
			var_01.iscapturingcrate = 0;
			continue;
		}

		var_01.iscapturingcrate = 0;
		maps\mp\gametypes\_horde_util::func_8F92(var_01);
		self notify("captured",var_01);
	}
}

//Function Number: 11
func_3F85(param_00)
{
	if(self.droptype == "loot" && !isdefined(func_3BE8(param_00)))
	{
		param_00 setclientomnvar("ui_killstreak_limit",1);
		return 1;
	}

	return 0;
}

//Function Number: 12
func_3F6B(param_00)
{
	if(!isplayer(param_00))
	{
		if(isdefined(param_00.disableplayeruseent))
		{
			param_00.disableplayeruseent enableplayeruse(param_00);
		}

		param_00.disableplayeruseent = self;
		self disableplayeruse(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 13
func_5381(param_00)
{
	param_00 endon("disconnect");
	var_01 = 0;
	for(;;)
	{
		if(param_00 usebuttonpressed())
		{
			var_01 = 0;
			while(param_00 usebuttonpressed())
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			var_01 = 0;
			while(!param_00 usebuttonpressed() && var_01 < 0.5)
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			level notify("doubleTap",param_00);
		}

		wait(0.05);
	}
}

//Function Number: 14
doubletapthink()
{
	self endon("death");
	self endon("capture");
	self endon("restarting_physics");
	var_00 = 16384;
	if(self.doubletapcount > 0)
	{
		wait(1);
	}

	for(;;)
	{
		level waittill("doubleTap",var_01);
		if(maps\mp\gametypes\_horde_util::func_4934(var_01))
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_01))
		{
			continue;
		}

		if(isdefined(self.inuse) && self.inuse)
		{
			continue;
		}

		if(distance2dsquared(var_01.origin,self.origin) < var_00)
		{
			self notify("doubleTap");
			newrandomcrate();
			break;
		}
	}
}

//Function Number: 15
newrandomcrate()
{
	self.doubletapcount++;
	playsoundatpos(self.origin,"mp_killconfirm_tags_drop");
	if(self.doubletapcount > 1)
	{
		var_00 = "ammo";
	}
	else
	{
		var_01 = level.cratetypes[self.droptype][self.cratetype].raw_weight;
		maps\mp\killstreaks\_airdrop::changecrateweight(self.droptype,self.cratetype,0);
		var_00 = func_3BB9(self.droptype);
		maps\mp\killstreaks\_airdrop::changecrateweight(self.droptype,self.cratetype,var_01);
	}

	self.cratetype = var_00;
	self thread [[ level.cratetypes[self.droptype][self.cratetype].func ]](self.droptype);
}

//Function Number: 16
func_6990()
{
	var_00 = "loot";
	var_01 = 8;
	var_02 = randomint(level.cratetypes["loot"].size);
	var_03 = (0,0,75);
	if(!level.carepackages.size)
	{
		maps/mp/gametypes/horde::func_76F8();
	}

	for(var_04 = 0;var_04 < var_01;var_04++)
	{
		var_05 = level.hordedroplocations[level.droplocationindex];
		var_06 = func_3AA9(var_05.tracelocation);
		if(!isdefined(var_06))
		{
			level.droplocationindex = maps/mp/gametypes/horde::func_3B3E(level.droplocationindex);
			continue;
		}

		var_07 = var_06;
		var_08 = func_3A66(var_02 + var_04);
		var_09 = level.players[0] maps\mp\killstreaks\_airdrop::createairdropcrate(level.players[0],var_00,var_08,var_07 + var_03,var_07,3);
		var_09.angles = (0,0,0);
		var_09.droppingtoground = 1;
		var_09.friendlymodel hide();
		wait(0.05);
		var_09 thread maps\mp\killstreaks\_airdrop::func_8AE2(var_09,(randomint(25),randomint(25),randomint(25)),var_00,var_08,800,1);
		level thread func_6579(var_09);
		level.droplocationindex = maps/mp/gametypes/horde::func_3B3E(level.droplocationindex);
		wait(0.05);
		playfx(level._effect["crate_teleport"],var_09.origin,(0,0,1));
		playsoundatpos(var_09.origin,"crate_teleport_safeguard");
		var_09.friendlymodel show();
	}
}

//Function Number: 17
func_4F94(param_00)
{
	param_00 waittill("physics_finished");
	var_01 = spawnfx(level._effect["loot_crtae"],param_00.origin - (0,0,16));
	triggerfx(var_01);
	param_00 common_scripts\utility::func_8B36(level.specialroundtime,"death");
	var_01 delete();
}

//Function Number: 18
func_3AA9(param_00)
{
	if(!func_4935(param_00))
	{
		return param_00;
	}

	var_01 = getnodesinradiussorted(param_00,256,64,128,"Path");
	foreach(var_03 in var_01)
	{
		if(!func_4935(var_03.origin))
		{
			return var_03.origin;
		}
	}

	return undefined;
}

//Function Number: 19
func_4935(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		var_04 = distance2dsquared(var_03.origin,param_00);
		if(var_04 < 4096)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 20
func_3A66(param_00)
{
	while(param_00 >= level.cratetypes["loot"].size)
	{
		param_00 = param_00 - level.cratetypes["loot"].size;
	}

	var_01 = getarraykeys(level.cratetypes["loot"]);
	var_02 = level.cratetypes["loot"][var_01[param_00]].type;
	return var_02;
}

//Function Number: 21
func_65A3(param_00)
{
	param_00 endon("death");
	param_00 endon("doubleTap");
	param_00 endon("restarting_physics");
	level waittill("airSupport");
	while(isdefined(param_00.inuse) && param_00.inuse)
	{
		common_scripts\utility::func_8AFE();
	}

	param_00 maps\mp\killstreaks\_airdrop::deletecrate();
}

//Function Number: 22
func_6579(param_00)
{
	param_00 endon("death");
	level waittill("round_ended");
	while(isdefined(param_00.inuse) && param_00.inuse)
	{
		common_scripts\utility::func_8AFE();
	}

	param_00 maps\mp\killstreaks\_airdrop::deletecrate();
}

//Function Number: 23
func_3BB9(param_00)
{
	var_01 = func_3B5C();
	var_02 = randomint(level.cratemaxval[param_00]);
	var_03 = undefined;
	foreach(var_05 in level.cratetypes[param_00])
	{
		var_06 = var_05.type;
		if(!level.cratetypes[param_00][var_06].weight)
		{
			continue;
		}

		if(!canpickcrate(var_06,var_01))
		{
			continue;
		}

		var_03 = var_06;
		if(level.cratetypes[param_00][var_06].weight > var_02)
		{
			break;
		}
	}

	return var_03;
}

//Function Number: 24
func_3B5C()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(!maps\mp\gametypes\_horde_util::isonhumanteam(var_02))
		{
			continue;
		}

		if(var_02 hasweapon("iw6_magnumhorde_mp_fmj"))
		{
			var_00++;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_triggerhappy"))
		{
			var_00++;
		}
	}

	var_04 = getentarray("care_package","targetname");
	foreach(var_06 in var_04)
	{
		if(var_06.cratetype == "iw6_magnumhorde_mp_fmj")
		{
			var_00++;
		}

		if(var_06.cratetype == "specialty_triggerhappy")
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 25
func_493A(param_00)
{
	return param_00 == "iw6_magnumhorde_mp_fmj" || param_00 == "specialty_triggerhappy";
}

//Function Number: 26
canpickcrate(param_00,param_01)
{
	if(func_493A(param_00) && param_01 >= 2)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
func_700E(param_00,param_01,param_02)
{
	param_00.friendlymodel hudoutlineenable(param_01,0);
	param_00.outlinecolor = param_01;
	foreach(var_04 in param_00.entityheadicons)
	{
		var_04.color = param_02;
	}
}

//Function Number: 28
func_700F(param_00)
{
	if(param_00.doubletapcount == 0)
	{
		func_700E(param_00,2,(0.431,0.745,0.235));
	}

	func_700E(param_00,5,(0.804,0.804,0.035));
}