/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_shipment_s2.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 3:16:54 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	maps/mp/mp_shipment_s2_precache::func_F9();
	maps/createart/mp_shipment_s2_art::func_F9();
	maps/mp/mp_shipment_s2_fx::func_F9();
	maps\mp\_load::func_F9();
	maps/mp/mp_shipment_s2_lighting::func_F9();
	maps/mp/mp_shipment_s2_aud::func_F9();
	maps\mp\_compass::func_8A2F("compass_map_mp_shipment_s2");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.var_6C5F = "mp_shipment_s2_osp";
	level.var_6C5E = "mp_shipment_s2_osp";
	level.var_3445 = "mp_shipment_s2_drone";
	level.var_343A = "mp_shipment_s2_drone";
	level.var_A853 = "mp_shipment_s2_warbird";
	level.var_A852 = "mp_shipment_s2_warbird";
	level.var_5A7C = "mp_shipment_s2_killstreak";
	level.var_5A6B = "mp_shipment_s2_killstreak";
	level.var_47CD = "mp_shipment_s2_glide1";
	level.var_47CE = "mp_shipment_s2_glide2";
	level.crafting_table = "glidebomb_hatchdoors_light_low";
	level.var_A4B5["intensity"] = 0.2;
	level.var_A4B5["falloff"] = 1.2;
	level.var_A4B5["scaleX"] = 1;
	level.var_A4B5["scaleY"] = 1;
	level.var_A4B5["squareAspectRatio"] = 0;
	level.var_A4B5["lerpDuration"] = 0.1;
	level.var_A4BE["intensity"] = 0.5;
	level.var_A4BE["falloff"] = 1.2;
	level.var_A4BE["scaleX"] = 1;
	level.var_A4BE["scaleY"] = 1;
	level.var_A4BE["squareAspectRatio"] = 0;
	level.var_A4BE["lerpDuration"] = 0.4;
	level.var_6465["velocityscaler"] = 0.35;
	level.var_6465["cameraRotationInfluence"] = 0;
	level.var_6465["cameraTranslationInfluence"] = 0;
	setdvar("5800",3);
	thread animate_tanks();
	thread movetriggerhurt();
}

//Function Number: 2
animate_tanks()
{
	var_00 = getentarray("truck_scripted_node","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.var_116);
		var_03 setmodel("vehicle_usa_trans_cckw_nophysics_opaqueglass");
		var_03 method_8495("shipment_truck_convoy_anim",var_02.var_116,var_02.var_1D);
		var_03 lib_0378::func_8D74("aud_truck_moving");
		wait(randomfloatrange(20,30));
	}
}

//Function Number: 3
movetriggerhurt()
{
	var_00 = getentarray("ball_out_of_bounds_triggers","targetname");
	var_01 = getent("trigger_hurt_moveto","targetname");
	if(!isdefined(var_00) || !isdefined(var_01) || var_00.size == 0)
	{
		return;
	}

	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.var_165) && var_03.var_165 == "do_not_move")
		{
			continue;
		}

		var_03.var_116 = var_01.var_116;
	}
}