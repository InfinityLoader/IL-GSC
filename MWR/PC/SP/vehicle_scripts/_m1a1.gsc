/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts\_m1a1.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 110 ms
 * Timestamp: 10/27/2023 2:46:19 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("m1a1",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_m1a1_abrams","vehicle_m1a1_abrams_dmg");
	maps\_vehicle::build_shoot_shock("tankblast");
	maps\_vehicle::build_drive(%abrams_movement,%abrams_movement_backwards,10);
	maps\_vehicle::build_exhaust("fx/distortion/abrams_exhaust");
	maps\_vehicle::build_deckdust("fx/dust/abrams_deck_dust");
	maps\_vehicle::build_treadfx();
	maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion",undefined,"exp_armor_vehicle");
	maps\_vehicle::build_turret("m1a1_coaxial_mg","tag_coax_mg","vehicle_m1a1_abrams_PKT_Coaxial_MG");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_rumble("tank_rumble",0.15,4.5,900,1,1);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_mainturret();
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_frontarmor(0.33);
}

//Function Number: 2
init_local()
{
	if(!isdefined(level.aud.disable_m1a1_audio))
	{
		handle_audio();
	}
}

//Function Number: 3
handle_audio()
{
	self endon("death");
	var_00 = 0;
	var_01 = 6000;
	var_02 = 1;
	vehicle_scripts\_m1a1_aud::snd_init_m1a1();
	thread monitor_death_stop_sounds();
	self.snd_disable_vehicle_system = self.script_disablevehicleaudio;
	for(;;)
	{
		if(!isdefined(self.script_disablevehicleaudio) || !self.script_disablevehicleaudio)
		{
			var_03 = distance(self.origin,level.player.origin);
			if(var_00 && var_03 > var_01)
			{
				vehicle_scripts\_m1a1_aud::snd_stop_m1a1(var_02);
				var_00 = 0;
				wait(0.1);
			}
			else if(!var_00 && var_03 < var_01)
			{
				vehicle_scripts\_m1a1_aud::snd_start_m1a1();
				var_00 = 1;
			}
		}
		else if(var_00)
		{
			vehicle_scripts\_m1a1_aud::snd_stop_m1a1(var_02);
			var_00 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 4
monitor_death_stop_sounds()
{
	self waittill("death");
	var_00 = 1;
	vehicle_scripts\_m1a1_aud::snd_stop_m1a1(var_00);
}

//Function Number: 5
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 6
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 11;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].getout_delete = 1;
	return var_00;
}