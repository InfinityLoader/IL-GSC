/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_treadfx.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 10/27/2023 2:35:52 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	level.var_2470[param_00] = 1;
	switch(param_00)
	{
		case "script_vehicle_m1a1_abrams_player_tm":
		case "script_vehicle_m1a1_abrams_minigun":
			setallvehiclefx(param_00,"treadfx/tread_dust_hamburg_cheap");
			setvehiclefx(param_00,"water");
			setvehiclefx(param_00,"paintedmetal");
			setvehiclefx(param_00,"riotshield");
			break;

		case "script_vehicle_uk_utility_truck_no_rail_player":
		case "script_vehicle_uk_utility_truck_no_rail":
		case "script_vehicle_uk_utility_truck":
			setallvehiclefx(param_00,"treadfx/tread_dust_default");
			setvehiclefx(param_00,"water");
			setvehiclefx(param_00,"rock");
			setvehiclefx(param_00,"metal");
			setvehiclefx(param_00,"brick");
			setvehiclefx(param_00,"plaster");
			setvehiclefx(param_00,"asphalt");
			setvehiclefx(param_00,"paintedmetal");
			setvehiclefx(param_00,"riotshield");
			setvehiclefx(param_00,"snow","treadfx/tread_snow_default");
			setvehiclefx(param_00,"slush","treadfx/tread_snow_default");
			setvehiclefx(param_00,"ice","treadfx/tread_ice_default");
			break;

		case "script_vehicle_b2":
		case "script_vehicle_pavelow_noai":
		case "script_vehicle_pavelow":
		case "script_vehicle_mi28_flying_low":
		case "script_vehicle_osprey_fly":
		case "script_vehicle_osprey":
		case "script_vehicle_mi28_flying":
		case "script_vehicle_ch46e_ny_harbor":
		case "script_vehicle_ch46e_low":
		case "script_vehicle_ch46e_notsolid":
		case "script_vehicle_ch46e":
		case "script_vehicle_mi17_woodland_landing_noai":
		case "script_vehicle_mi17_woodland_fly_cheap_noai":
		case "script_vehicle_mi17_woodland_fly_noai":
		case "script_vehicle_mi17_woodland_noai":
		case "script_vehicle_mi17_woodland_landing_so":
		case "script_vehicle_mi17_woodland_landing":
		case "script_vehicle_mi17_woodland_fly_cheap":
		case "script_vehicle_mi17_woodland_fly":
		case "script_vehicle_mi17_woodland":
		case "script_vehicle_harrier":
		case "script_vehicle_blackhawk_minigun_low":
		case "script_vehicle_blackhawk_hero_hamburg":
		case "script_vehicle_blackhawk_low_thermal":
		case "script_vehicle_blackhawk_low":
		case "script_vehicle_blackhawk_hero_sas_night":
		case "script_vehicle_blackhawk":
		case "script_vehicle_littlebird_player":
		case "script_vehicle_littlebird_bench":
		case "script_vehicle_cobra_helicopter_fly_player":
		case "script_vehicle_cobra_helicopter_player":
		case "script_vehicle_cobra_helicopter_low":
		case "script_vehicle_cobra_helicopter_fly_low":
		case "script_vehicle_cobra_helicopter_fly":
		case "script_vehicle_cobra_helicopter":
		case "script_vehicle_apache_dark":
		case "script_vehicle_apache_mg":
		case "script_vehicle_apache":
		case "script_vehicle_mi24p_hind_woodland_opened_door":
		case "script_vehicle_ny_harbor_hind":
		case "script_vehicle_ny_blackhawk":
		case "script_vehicle_littlebird_md500":
		case "script_vehicle_littlebird_armed":
		case "b2":
		case "mig29":
		case "blackhawk_minigun_so":
		case "harrier":
		case "pavelow":
		case "mi28":
		case "littlebird":
		case "littlebird_player":
		case "cobra_player":
		case "cobra":
		case "mi17_noai":
		case "mi17":
		case "ny_harbor_hind":
		case "hind":
		case "seaknight":
		case "apache":
		case "blackhawk_minigun":
		case "blackhawk":
			setallvehiclefx(param_00,"treadfx/heli_dust_default");
			setvehiclefx(param_00,"water","treadfx/heli_water");
			setvehiclefx(param_00,"snow","treadfx/heli_snow_default");
			setvehiclefx(param_00,"slush","treadfx/heli_snow_default");
			setvehiclefx(param_00,"ice","treadfx/heli_snow_default");
			break;

		default:
			setallvehiclefx(param_00,"treadfx/tread_dust_default");
			setvehiclefx(param_00,"water");
			setvehiclefx(param_00,"concrete");
			setvehiclefx(param_00,"rock");
			setvehiclefx(param_00,"metal");
			setvehiclefx(param_00,"brick");
			setvehiclefx(param_00,"plaster");
			setvehiclefx(param_00,"asphalt");
			setvehiclefx(param_00,"paintedmetal");
			setvehiclefx(param_00,"riotshield");
			setvehiclefx(param_00,"snow","treadfx/tread_snow_default");
			setvehiclefx(param_00,"slush","treadfx/tread_snow_default");
			setvehiclefx(param_00,"ice","treadfx/tread_ice_default");
			break;
	}
}

//Function Number: 2
setvehiclefx(param_00,param_01,param_02)
{
	if(!isdefined(level.var_2472))
	{
		level.var_2472 = [];
	}

	if(!isdefined(param_02))
	{
		level.var_2472[param_00][param_01] = -1;
		return;
	}

	level.var_2472[param_00][param_01] = loadfx(param_02);
}

//Function Number: 3
setallvehiclefx(param_00,param_01)
{
	setvehiclefx(param_00,"brick",param_01);
	setvehiclefx(param_00,"bark",param_01);
	setvehiclefx(param_00,"carpet",param_01);
	setvehiclefx(param_00,"cloth",param_01);
	setvehiclefx(param_00,"concrete",param_01);
	setvehiclefx(param_00,"dirt",param_01);
	setvehiclefx(param_00,"flesh",param_01);
	setvehiclefx(param_00,"foliage",param_01);
	setvehiclefx(param_00,"glass",param_01);
	setvehiclefx(param_00,"grass",param_01);
	setvehiclefx(param_00,"gravel",param_01);
	setvehiclefx(param_00,"ice",param_01);
	setvehiclefx(param_00,"metal",param_01);
	setvehiclefx(param_00,"mud",param_01);
	setvehiclefx(param_00,"paper",param_01);
	setvehiclefx(param_00,"plaster",param_01);
	setvehiclefx(param_00,"rock",param_01);
	setvehiclefx(param_00,"sand",param_01);
	setvehiclefx(param_00,"snow",param_01);
	setvehiclefx(param_00,"water",param_01);
	setvehiclefx(param_00,"wood",param_01);
	setvehiclefx(param_00,"asphalt",param_01);
	setvehiclefx(param_00,"ceramic",param_01);
	setvehiclefx(param_00,"plastic",param_01);
	setvehiclefx(param_00,"rubber",param_01);
	setvehiclefx(param_00,"cushion",param_01);
	setvehiclefx(param_00,"fruit",param_01);
	setvehiclefx(param_00,"paintedmetal",param_01);
	setvehiclefx(param_00,"riotshield",param_01);
	setvehiclefx(param_00,"slush",param_01);
	setvehiclefx(param_00,"default",param_01);
	setvehiclefx(param_00,"none");
}