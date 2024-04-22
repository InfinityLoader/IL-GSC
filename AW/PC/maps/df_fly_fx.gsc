/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_fly_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 94 ms
 * Timestamp: 4/22/2024 2:28:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["bagh_dam_waterfall_impact"] = loadfx("vfx/map/baghdad/bagh_dam_waterfall_impact");
	level._effect["bagh_vista_explosion_runner"] = loadfx("vfx/map/baghdad/bagh_vista_explosion_runner");
	level._effect["bagh_vista_explosion"] = loadfx("vfx/map/baghdad/bagh_vista_explosion");
	level._effect["bagh_dam_canopy_drops"] = loadfx("vfx/map/baghdad/bagh_dam_canopy_drops");
	level._effect["bagh_atlas_jet_disintegrate02"] = loadfx("vfx/map/baghdad/bagh_atlas_jet_disintegrate02");
	level._effect["bagh_tanker_dust_trail_small"] = loadfx("vfx/map/baghdad/bagh_tanker_dust_trail_small");
	level._effect["bagh_atlas_jet_disintegrate01"] = loadfx("vfx/map/baghdad/bagh_atlas_jet_disintegrate01");
	level._effect["bagh_dam_burst01"] = loadfx("vfx/water/bagh_dam_burst01");
	level._effect["bagh_hoodoo_cliff_collapse"] = loadfx("vfx/map/baghdad/bagh_hoodoo_cliff_collapse");
	level._effect["bagh_flight_cloud_volume"] = loadfx("vfx/map/baghdad/bagh_flight_cloud_volume");
	level._effect["bagh_hoodoo_impact1_atlas"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1_atlas");
	level._effect["bagh_aircraft_explosion_midair_atlas"] = loadfx("vfx/map/baghdad/bagh_aircraft_explosion_midair_atlas");
	level._effect["bagh_groundtarget_muzzleflash"] = loadfx("vfx/map/baghdad/bagh_groundtarget_muzzleflash");
	level._effect["bagh_tanker_dust_trail"] = loadfx("vfx/map/baghdad/bagh_tanker_dust_trail");
	level._effect["bagh_aircraft_damage_fire_trail"] = loadfx("vfx/map/baghdad/bagh_aircraft_damage_fire_trail");
	level._effect["bagh_aircraft_damage_trail_huge"] = loadfx("vfx/map/baghdad/bagh_aircraft_damage_trail_huge");
	level._effect["bagh_tanker_crash"] = loadfx("vfx/map/baghdad/bagh_tanker_crash");
	level._effect["bagh_aircraft_flares"] = loadfx("vfx/map/baghdad/bagh_aircraft_flares");
	level._effect["pod_exhaust_strong"] = loadfx("vfx/vehicle/pod_exhaust_strong");
	level._effect["df_fly_sun_flare"] = loadfx("vfx/map/fly/df_fly_sun_flare");
	level._effect["bagh_trench_dust"] = loadfx("vfx/map/baghdad/bagh_trench_dust");
	level._effect["bagh_hoodoo_dust_trail"] = loadfx("vfx/map/baghdad/bagh_hoodoo_dust_trail");
	level._effect["bagh_hoodoo_domino_impact1"] = loadfx("vfx/map/baghdad/bagh_hoodoo_domino_impact1");
	level._effect["bagh_hoodoo_impact1_crack_large"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1_crack_large");
	level._effect["bagh_hoodoo_impact1_crack"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1_crack");
	level._effect["bagh_hoodoo_impact1_dust"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1_dust");
	level._effect["bagh_hoodoo_impact1_dust_small"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1_dust_small");
	level._effect["bagh_hoodoo_impact1"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1");
	level._effect["bagh_metal_bridge_dust"] = loadfx("vfx/map/baghdad/bagh_metal_bridge_dust");
	level._effect["bagh_dam_water_burst"] = loadfx("vfx/map/baghdad/bagh_dam_water_burst");
	level._effect["bagh_dam_explosion"] = loadfx("vfx/map/baghdad/bagh_dam_explosion");
	level._effect["bagh_aircraft_gun_tracer"] = loadfx("vfx/map/baghdad/bagh_aircraft_gun_tracer");
	level._effect["tracer_ricochet"] = loadfx("vfx/map/baghdad/bagh_aircraft_gun_tracer");
	level._effect["missile_trail"] = loadfx("vfx/map/baghdad/bagh_aircraft_missile_trail_player");
	level._effect["missile_explode"] = loadfx("vfx/map/baghdad/bagh_missile_explode_midair");
	level._effect["canyon_impact"] = loadfx("vfx/map/baghdad/bagh_canyon_impact");
	level._effect["canyon_jet_impact"] = loadfx("vfx/map/baghdad/bagh_hoodoo_impact1_atlas");
	level._effect["bagh_aircraft_explosion_midair"] = loadfx("vfx/map/baghdad/bagh_aircraft_explosion_midair");
	level._effect["bagh_aircraft_damage_trail"] = loadfx("vfx/map/baghdad/bagh_aircraft_damage_trail");
	level._effect["explosion_small"] = loadfx("vfx/explosion/fire_spurt_runner_a");
	level._effect["flak_cannon_explode"] = loadfx("vfx/explosion/vehicle_x4walker_explosion");
	level._effect["turret_gun_muzzle"] = loadfx("vfx/map/baghdad/bagh_groundtarget_muzzleflash");
	level._effect["flak_explosion"] = loadfx("vfx/explosion/flak_explosion_far");
	level._effect["explosion"] = loadfx("vfx/explosion/vehicle_warbird_explosion_a");
	level._effect["missile_repel"] = loadfx("vfx/map/baghdad/bagh_aircraft_flares");
	level._effect["large_cloud"] = loadfx("vfx/cloud/cloud_oriented_large");
	level._effect["medium_cloud"] = loadfx("vfx/cloud/cloud_oriented_med");
	level._effect["thin_cloud_vol"] = loadfx("vfx/cloud/clouds_thin_volume");
	level._effect["cloud_vtol_wing_wispy"] = loadfx("vfx/cloud/cloud_vtol_wing_wispy");
	level._effect["cloud_wing_wispy"] = loadfx("vfx/cloud/cloud_wing_wispy");
}

//Function Number: 2
vfx_dam_setup()
{
	var_00 = getent("dam_cracks1","targetname");
	var_01 = getent("dam_cracks2","targetname");
	var_00 thread vfx_dam_burst("dam_cracks1");
	var_01 thread vfx_dam_burst("dam_cracks2");
}

//Function Number: 3
vfx_dam_burst(param_00)
{
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	wait(0.5);
	playfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_01");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_02");
	wait(0.35);
	playfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_03");
	wait(0.25);
	playfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_04");
	common_scripts\utility::flag_wait("airbrake_hint");
	stopfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_01");
	stopfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_02");
	stopfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_03");
	stopfxontag(common_scripts\utility::getfx("bagh_dam_burst01"),self,"tag_fx_04");
}

//Function Number: 4
vfx_handle_disintegrating_jet()
{
	self hide();
	maps\_utility::ent_flag_clear("engineeffects");
	var_00 = randomintrange(1,5);
	var_01 = undefined;
	switch(var_00)
	{
		case 1:
			playfx(common_scripts\utility::getfx("bagh_aircraft_explosion_midair"),self.origin);
			break;

		case 2:
			var_01 = "bagh_atlas_jet_disintegrate01";
			break;

		case 3:
			var_01 = "bagh_atlas_jet_disintegrate02";
			break;

		case 4:
			var_01 = "bagh_atlas_jet_disintegrate01";
			break;
	}

	if(var_00 > 1)
	{
		var_02 = spawn("script_model",self.origin);
		var_02.angles = self.angles;
		var_02 setmodel("tag_origin");
		var_02 linkto(self,"tag_origin",(0,0,5),(0,5,0));
		var_03 = spawn("script_model",self.origin);
		var_03.angles = self.angles;
		var_03 setmodel("vfx_atlas_fighter_jet_dest_body_01");
		var_03 linkto(var_02,"tag_origin",(0,0,0),(0,0,0));
		var_03 show();
		playfxontag(common_scripts\utility::getfx(var_01),var_02,"tag_origin");
		var_04 = playfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_fire_trail"),var_02,"tag_origin");
		if(var_00 == 4)
		{
			var_05 = 1;
			if(randomfloat(100) > 50)
			{
				var_05 = -1;
			}

			var_02 rotate_roll_link(self,"tag_origin",-1440 * var_05,0,randomintrange(2,5));
		}
		else if(isdefined(self))
		{
			var_06 = spawn("script_model",self.origin);
			if(isdefined(var_06))
			{
				var_06.angles = self.angles;
				var_06 linkto(var_02,"tag_origin",(0,0,0),(0,0,0));
				if(var_00 == 2)
				{
					var_06 setmodel("vfx_atlas_fighter_jet_dest_wing_rt");
					var_02 rotate_roll_link(self,"tag_origin",-1 * randomintrange(360,1080),randomintrange(0,2000),randomintrange(2,5));
				}
				else
				{
					var_06 setmodel("vfx_atlas_fighter_jet_dest_wing_lt");
					var_02 rotate_roll_link(self,"tag_origin",randomintrange(360,1080),randomintrange(0,2000),randomintrange(2,5));
				}

				var_06 delete();
			}
		}

		wait 0.05;
		if(isdefined(self))
		{
			killfxontag(common_scripts\utility::getfx(var_01),var_02,"tag_origin");
			playfx(common_scripts\utility::getfx("bagh_aircraft_explosion_midair"),self.origin);
		}

		var_03 delete();
		var_02 delete();
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 5
rotate_roll_link(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = param_02 / param_04 / 0.05;
	var_07 = 0;
	if(param_03 != 0)
	{
		var_07 = param_03 / param_04 / 0.05;
	}

	while(var_05 < param_04 && isalive(param_00))
	{
		self unlink();
		self.angles = self.angles + (0,0,var_06);
		if(var_07 > 0)
		{
			self.origin = maps\df_fly_flight_code::offset_position_from_tag("down","tag_origin",var_07);
		}

		self linkto(param_00,param_01);
		wait(0.05);
		var_05 = var_05 + 0.05;
	}
}

//Function Number: 6
pod_engine_fx(param_00)
{
	var_01 = common_scripts\utility::getfx("pod_exhaust_strong");
	if(param_00)
	{
		playfxontag(var_01,self,"tag_exhaust");
		return;
	}

	stopfxontag(var_01,self,"tag_exhaust");
}