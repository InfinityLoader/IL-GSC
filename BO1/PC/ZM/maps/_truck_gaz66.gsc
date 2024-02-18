
#include maps\_vehicle;
main( model, type )
{
	if(self.vehicletype == "truck_gaz66_player_single50")
	{
		build_aianims( ::set_gunner_anims , ::set_gunner_vehicle_anims );
	}
	else
	{
		build_aianims( ::setanims , ::set_vehicle_anims );
		build_unload_groups( ::unload_groups );
	}
	self thread attach_truck_bed();
}
attach_truck_bed()
{
	bed_base = "t5_veh_gaz66_flatbed";
	bed_dead = "t5_veh_gaz66_flatbed_dead";
	switch(self.vehicletype)
	{
		case "truck_gaz66_canvas":
		self Attach(bed_base, "tag_origin_animate_jnt");
		self Attach( "t5_veh_gaz66_canvas", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_flatbed":
		self Attach(bed_base, "tag_origin_animate_jnt");
		break;
		case "truck_gaz66_tanker":
		case "truck_gaz66_tanker_physics":
		self Attach( "t5_veh_gaz66_tanker", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_troops":
		case "truck_gaz66_troops_physics":
		self Attach( "t5_veh_gaz66_troops", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_troops_attacking_physics":
		self Attach( "t5_veh_gaz66_troops_no_benches", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_single50":
		self Attach("t5_veh_gaz66_single50", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_player_single50":
		self Attach(bed_base, "tag_origin_animate_jnt");
		self Attach ("t5_veh_gunner_turret_enemy_50cal", "tag_gunner_attach");
		break;
		default:
		break;
	}
	self waittill("death");
	if(!IsDefined(self) || !IsDefined(self.vehicletype))
	{
		return;
	}
	switch(self.vehicletype)
	{
		case "truck_gaz66_canvas":
		self Detach(bed_base, "tag_origin_animate_jnt");
		self Detach( "t5_veh_gaz66_canvas", "tag_origin_animate_jnt" );
		self Attach(bed_dead, "tag_origin_animate_jnt");
		self Attach( "t5_veh_gaz66_canvas_dead", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_flatbed":
		self Detach(bed_base, "tag_origin_animate_jnt");
		self Attach(bed_dead, "tag_origin_animate_jnt");
		break;
		case "truck_gaz66_tanker":
		case "truck_gaz66_tanker_physics":
		self Detach( "t5_veh_gaz66_tanker", "tag_origin_animate_jnt" );
		self Attach( "t5_veh_gaz66_tanker_dead", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_troops":
		case "truck_gaz66_troops_physics":
		self Detach( "t5_veh_gaz66_troops", "tag_origin_animate_jnt" );
		self Attach( "t5_veh_gaz66_troops_dead", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_troops_attacking_physics":
		self Detach( "t5_veh_gaz66_troops_no_benches", "tag_origin_animate_jnt" );
		self Attach( "t5_veh_gaz66_troops_dead", "tag_origin_animate_jnt" );
		break;
		case "truck_gaz66_single50":
		self Detach("t5_veh_gaz66_single50", "tag_origin_animate_jnt");
		self Attach("t5_veh_gaz66_single50_dead", "tag_origin_animate_jnt");
		break;
		case "truck_gaz66_player_single50":
		self Detach( bed_base, "tag_origin_animate_jnt" );
		self Detach ("t5_veh_gunner_turret_enemy_50cal", "tag_gunner_attach");
		self Attach(bed_dead, "tag_origin_animate_jnt");
		break;
		default:
		break;
	}
}
#using_animtree( "vehicles" );
set_vehicle_anims( positions )
{
	positions[ 0 ].sittag = "tag_driver";
	positions[ 1 ].sittag = "tag_passenger";
	positions[ 2 ].sittag = "tag_guy1";
	positions[ 3 ].sittag = "tag_guy6";
	positions[ 4 ].sittag = "tag_guy3";
	positions[ 5 ].sittag = "tag_guy8";
	positions[ 6 ].sittag = "tag_guy5";
	positions[ 7 ].sittag = "tag_guy2";
	positions[ 8 ].sittag = "tag_guy7";
	positions[ 9 ].sittag = "tag_guy4";
	positions[ 0 ].vehicle_getoutanim_clear = false;
	positions[ 1 ].vehicle_getoutanim_clear = false;
	positions[ 0 ].vehicle_getinanim = %v_gaz63_driver_door_open;
	positions[ 1 ].vehicle_getinanim = %v_gaz63_passenger_door_open;
	positions[ 0 ].vehicle_getoutanim = %v_gaz63_driver_door_open;
	positions[ 1 ].vehicle_getoutanim = %v_gaz63_passenger_door_open;
	return positions;
}
#using_animtree( "generic_human" );
setanims()
{
	positions = [];
	num_positions = 10;
	for( i =0 ;i < num_positions; i++ )
	{
		positions[ i ] = spawnstruct();
	}
	positions[ 0 ].sittag = "tag_driver";
	positions[ 1 ].sittag = "tag_passenger";
	positions[ 2 ].sittag = "tag_guy1";
	positions[ 3 ].sittag = "tag_guy6";
	positions[ 4 ].sittag = "tag_guy3";
	positions[ 5 ].sittag = "tag_guy8";
	positions[ 6 ].sittag = "tag_guy5";
	positions[ 7 ].sittag = "tag_guy2";
	positions[ 8 ].sittag = "tag_guy7";
	positions[ 9 ].sittag = "tag_guy4";
	positions[ 0 ].getout = %crew_truck_driver_climbout;
	positions[ 1 ].getout = %crew_truck_passenger_climbout;
	positions[ 2 ].getout = %crew_truck_guy1_climbout;
	positions[ 3 ].getout = %crew_truck_guy6_climbout;
	positions[ 4 ].getout = %crew_truck_guy3_climbout;
	positions[ 5 ].getout = %crew_truck_guy8_climbout;
	positions[ 6 ].getout = %crew_truck_guy5_climbout;
	positions[ 7 ].getout = %crew_truck_guy2_climbout;
	positions[ 8 ].getout = %crew_truck_guy7_climbout;
	positions[ 9 ].getout = %crew_truck_guy4_climbout;
	positions[ 0 ].getout_combat = %crew_gaz63_driver_jump_out;
	positions[ 1 ].getout_combat = %crew_gaz63_passenger_climbout_fast;
	positions[ 2 ].getout_combat = %crew_truck_guy1_climbout_fast;
	positions[ 3 ].getout_combat = %crew_truck_guy6_climbout_fast;
	positions[ 4 ].getout_combat = %crew_truck_guy3_climbout;
	positions[ 5 ].getout_combat = %crew_truck_guy8_climbout;
	positions[ 6 ].getout_combat = %crew_truck_guy5_climbout_fast;
	positions[ 7 ].getout_combat = %crew_truck_guy2_climbout_fast;
	positions[ 8 ].getout_combat = %crew_truck_guy7_climbout;
	positions[ 9 ].getout_combat = %crew_truck_guy4_climbout;
	positions[ 0 ].idle = %crew_truck_driver_sit_idle;
	positions[ 1 ].idle = %crew_gaz63_passenger_sit_idle;
	positions[ 2 ].idle = %crew_truck_guy1_sit_idle;
	positions[ 3 ].idle = %crew_truck_guy6_sit_idle;
	positions[ 4 ].idle = %crew_truck_guy3_sit_idle;
	positions[ 5 ].idle = %crew_truck_guy8_sit_idle;
	positions[ 6 ].idle = %crew_truck_guy5_sit_idle;
	positions[ 7 ].idle = %crew_truck_guy2_sit_idle;
	positions[ 8 ].idle = %crew_truck_guy7_sit_idle;
	positions[ 9 ].idle = %crew_truck_guy4_sit_idle;
	return positions;
}
unload_groups()
{
	unload_groups = [];
	unload_groups[ "all" ] = [];
	unload_groups[ "passengers" ] = [];
	unload_groups[ "rear_passengers" ] = [];
	group = "all";
	unload_groups[ group ][ unload_groups[ group ].size ] = 0;
	unload_groups[ group ][ unload_groups[ group ].size ] = 1;
	unload_groups[ group ][ unload_groups[ group ].size ] = 2;
	unload_groups[ group ][ unload_groups[ group ].size ] = 3;
	unload_groups[ group ][ unload_groups[ group ].size ] = 4;
	unload_groups[ group ][ unload_groups[ group ].size ] = 5;
	unload_groups[ group ][ unload_groups[ group ].size ] = 6;
	unload_groups[ group ][ unload_groups[ group ].size ] = 7;
	unload_groups[ group ][ unload_groups[ group ].size ] = 8;
	unload_groups[ group ][ unload_groups[ group ].size ] = 9;
	group = "passengers";
	unload_groups[ group ][ unload_groups[ group ].size ] = 2;
	unload_groups[ group ][ unload_groups[ group ].size ] = 3;
	unload_groups[ group ][ unload_groups[ group ].size ] = 4;
	unload_groups[ group ][ unload_groups[ group ].size ] = 5;
	unload_groups[ group ][ unload_groups[ group ].size ] = 6;
	unload_groups[ group ][ unload_groups[ group ].size ] = 7;
	unload_groups[ group ][ unload_groups[ group ].size ] = 8;
	unload_groups[ group ][ unload_groups[ group ].size ] = 9;
	group = "rear_passengers";
	unload_groups[ group ][ unload_groups[ group ].size ] = 3;
	unload_groups[ group ][ unload_groups[ group ].size ] = 4;
	unload_groups[ group ][ unload_groups[ group ].size ] = 5;
	unload_groups[ group ][ unload_groups[ group ].size ] = 6;
	unload_groups[ group ][ unload_groups[ group ].size ] = 7;
	unload_groups[ group ][ unload_groups[ group ].size ] = 8;
	unload_groups[ group ][ unload_groups[ group ].size ] = 9;
	unload_groups[ "default" ] = unload_groups[ "passengers" ];
	return unload_groups;
}
#using_animtree( "generic_human" );
set_gunner_vehicle_anims(positions)
{
	return positions;
}
set_gunner_anims()
{
	positions = [];
	num_positions = 3;
	for( i =0 ;i < num_positions; i++ )
	{
		positions[ i ] = spawnstruct();
	}
	positions[0].sittag = "tag_driver";
	positions[1].sittag = "tag_passenger";
	positions[2].sittag = "tag_gunner1";
	positions[ 0 ].idle = %crew_truck_driver_sit_idle;
	positions[ 1 ].idle = %crew_gaz63_passenger_sit_idle;
	positions[2].vehiclegunner = 1;
	positions[2].idle = %ai_50cal_gunner_aim;
	positions[2].aimup = %ai_50cal_gunner_aim_up;
	positions[2].aimdown = %ai_50cal_gunner_aim_down;
	return positions;
} 