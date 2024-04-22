/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_ending_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 280 ms
 * Timestamp: 4/22/2024 2:31:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread precachefx();
}

//Function Number: 2
precachefx()
{
	level._effect["vehicle_explosion_technical"] = loadfx("vfx/map/greece/greece_vehicle_explo_med");
	level._effect["small_vehicle_explosion"] = loadfx("vfx/map/greece/greece_vehicle_explo_charge");
	level._effect["vehicle_engine_smoke_1"] = loadfx("vfx/map/greece/greece_veh_engine_damage_smk_1");
	level._effect["vehicle_engine_smoke_2"] = loadfx("vfx/map/greece/greece_veh_engine_damage_smk_2");
	level._effect["vehicle_engine_smoke_3"] = loadfx("vfx/map/greece/greece_veh_engine_damage_smk_3");
	level._effect["vehicle_tire_smoke_1"] = loadfx("vfx/map/greece/greece_veh_tire_damage_smk_1");
	level._effect["vehicle_tire_smoke_1a"] = loadfx("vfx/map/greece/greece_veh_tire_damage_smk_1a");
	level._effect["vehicle_tire_smoke_2"] = loadfx("vfx/map/greece/greece_veh_tire_damage_smk_2");
	level._effect["fruit_table_impact_lrg_x"] = loadfx("vfx/food/fruit_table_impact_lrg_x");
	level._effect["ending_hades_throat_slash"] = loadfx("vfx/map/greece/greece_flesh_throat_blood_slash");
	level._effect["ending_ilana_throat_slash"] = loadfx("vfx/map/greece/greece_flesh_throat_blood_slash2");
	level._effect["ending_ilana_stabbed"] = loadfx("vfx/map/greece/greece_flesh_throat_blood_spurt");
	level._effect["ending_ilana_stabbed_takeout"] = loadfx("vfx/map/greece/greece_flesh_throat_blood_spurt2");
	level._effect["ending_vm_arm_cut"] = loadfx("vfx/map/greece/greece_flesh_prosthetic_sparks");
	level._effect["ending_hades_stabbed_takeout"] = loadfx("vfx/map/greece/greece_flesh_throat_blood_fall_rnr");
	level._effect["ending_hades_stabbed_takeout2"] = loadfx("vfx/map/greece/greece_flesh_throat_blood_fall2_rnr");
}

//Function Number: 3
endingambushbreachexplosionfx()
{
	var_00 = common_scripts\utility::getstruct("AmbushBreachFX","targetname");
	playfx(common_scripts\utility::getfx("small_vehicle_explosion"),var_00.origin);
	earthquake(0.5,0.3,level.player.origin,1000);
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 4
endingcrashtruckexplosionfx()
{
	var_00 = common_scripts\utility::getstruct("CrashTruckFX","targetname");
	var_01 = common_scripts\utility::getstruct("CrashTruckWindows","targetname");
	playfx(common_scripts\utility::getfx("vehicle_explosion_technical"),var_00.origin);
	soundscripts\_snd::snd_message("convoy_truck_explosion",var_00);
	var_02 = getentarray("EndingShopDoor1","targetname");
	foreach(var_04 in var_02)
	{
		var_04 delete();
	}

	glassradiusdamage(var_00.origin,100,1000,100);
	glassradiusdamage(var_01.origin,200,1000,100);
	radiusdamage(var_00.origin,200,100,10);
	physicsexplosionsphere(var_00.origin,300,0,randomfloatrange(2,5));
	earthquake(0.5,0.3,var_00.origin,800);
	level.player playrumbleonentity("damage_light");
	common_scripts\utility::flag_set("FlagEndingTruckExplode");
	var_06 = getent("convoy_vehicle_3","targetname");
	var_06.animname = "convoy_vehicle_3";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_3"),var_06,"TAG_ORIGIN");
	thread maps\greece_ending::endingtruckfiredamagevol();
}

//Function Number: 5
endingvehicledamagefx()
{
	var_00 = getent("hades_vehicle","targetname");
	var_00.animname = "hades_vehicle";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_1"),var_00,"TAG_ORIGIN");
	playfxontag(common_scripts\utility::getfx("vehicle_tire_smoke_1"),var_00,"TAG_ORIGIN");
	var_01 = getent("convoy_vehicle_2","targetname");
	var_01.animname = "convoy_vehicle_2";
	playfxontag(common_scripts\utility::getfx("vehicle_tire_smoke_1a"),var_01,"TAG_ORIGIN");
	var_02 = getent("convoy_vehicle_3","targetname");
	var_02.animname = "convoy_vehicle_3";
	playfxontag(common_scripts\utility::getfx("vehicle_tire_smoke_1a"),var_02,"TAG_ORIGIN");
	wait(4);
	var_01 = getent("convoy_vehicle_2","targetname");
	var_01.animname = "convoy_vehicle_2";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_1"),var_01,"TAG_ORIGIN");
	var_02 = getent("convoy_vehicle_3","targetname");
	var_02.animname = "convoy_vehicle_3";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_2"),var_02,"TAG_ORIGIN");
}

//Function Number: 6
endingvehicledamageresidualfx()
{
	var_00 = getent("hades_vehicle","targetname");
	var_00.animname = "hades_vehicle";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_1"),var_00,"TAG_ORIGIN");
	var_01 = getent("convoy_vehicle_2","targetname");
	var_01.animname = "convoy_vehicle_2";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_1"),var_01,"TAG_ORIGIN");
	var_02 = getent("convoy_vehicle_3","targetname");
	var_02.animname = "convoy_vehicle_3";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_2"),var_02,"TAG_ORIGIN");
}

//Function Number: 7
stumbleonfirefx()
{
	playfxontag(common_scripts\utility::getfx("character_fire_torso2"),self,"J_SpineUpper");
	soundscripts\_snd::snd_message("enemy_on_fire");
}

//Function Number: 8
endingshopcrashfx()
{
	common_scripts\_exploder::exploder(220);
}

//Function Number: 9
endingfirehydrantfx()
{
	common_scripts\_exploder::exploder(221);
}

//Function Number: 10
endingplayercarpinnedfx()
{
	wait(1.5);
	common_scripts\_exploder::exploder(222);
	var_00 = getent("enemy_vehicle","targetname");
	var_00.animname = "enemy_vehicle";
	playfxontag(common_scripts\utility::getfx("vehicle_tire_smoke_2"),var_00,"TAG_ORIGIN");
	wait(8.75);
	var_00 = getent("enemy_vehicle","targetname");
	var_00.animname = "enemy_vehicle";
	playfxontag(common_scripts\utility::getfx("vehicle_engine_smoke_1"),var_00,"TAG_ORIGIN");
}

//Function Number: 11
hadesthroatslashfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_hades_throat_slash"),param_00,"J_Neck");
	soundscripts\_snd::snd_message("hades_throat_slash");
	earthquake(0.1,0.1,level.player.origin,128);
	wait(5);
	common_scripts\_exploder::exploder(224);
}

//Function Number: 12
ilanahitwallfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("safehouse_character_dust_impact3"),param_00,"J_SpineUpper");
	common_scripts\_exploder::exploder(228);
	wait(1.1);
	playfxontag(common_scripts\utility::getfx("knife_block_sparks"),param_00,"J_WristTwist_RI");
}

//Function Number: 13
ilanahitcarfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("safehouse_character_dust_impact3"),param_00,"J_SpineUpper");
}

//Function Number: 14
ilanathroatslashfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_ilana_throat_slash"),param_00,"J_Head");
}

//Function Number: 15
ilanastabbedfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_ilana_stabbed_takeout"),param_00,"J_SpineUpper");
	wait(2);
	common_scripts\_exploder::exploder(227);
}

//Function Number: 16
ilanastabbedtakeoutfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_ilana_stabbed_takeout"),param_00,"J_SpineUpper");
}

//Function Number: 17
hadesstabbedtakeoutfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_hades_stabbed_takeout"),param_00,"J_WristTwist_RI");
}

//Function Number: 18
vmstabbedfacefx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_hades_stabbed_takeout2"),param_00,"J_WristTwist_RI");
}

//Function Number: 19
vmknifeblockfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("ending_vm_arm_cut"),param_00,"J_WristTwist_LE");
}