
#include common_scripts\utility;
#include maps\_utility;
camsys_init()
{
	level.cam_shots = [];
}
create_cp( origin )
{
	cp = SpawnStruct();
	cp.origin = origin;
	cp.attrib = [];
	cp.attrib["time"] = 1;
	cp.attrib["fov"] = undefined;
	cp.attrib["blur"] = undefined;
	cp.attrib["shake"] = undefined;
	return cp;
}
build_shot( shot_name, track_type, target_type, track_array, target_array )
{
	if( IsDefined( level.cam_shots[shot_name] ) )
	{
		assertmsg( "shot_name of, '" + shot_name + "' already exists." );
		return;
	}
	shot = SpawnStruct();
	track = SpawnStruct();
	track.type = track_type;
	track.cpoints = [];
	for( i = 0; i < track_array.size; i++ )
	{
		track.cpoints[track.cpoints.size] = track_array[i];
	}
	shot.cam_track = track;
	target = SpawnStruct();
	target.type = target_type;
	target.cpoints = [];
	for( i = 0; i < target_array.size; i++ )
	{
		target.cpoints[target.cpoints.size] = target_array[i];
	}
	shot.cam_target = target;
	level.cam_shots[shot_name] = shot;
}
build_curve( cpoints )
{
	curve_id = GetCurve();
	for( i = 0; i < cpoints.size; i++ )
	{
		if( i == 0 )
		{
			AddNodeToCurve( curve_id, cpoints[i].origin, 0 );
		}
		else
		{
			AddNodeToCurve( curve_id, cpoints[i].origin, cpoints[i].attrib["time"] );
		}
	}
	BuildCurve( curve_id );
	return curve_id;
}
create_camera( origin )
{
	if( !IsDefined( origin ) )
	{
		origin = ( 0, 0, 0 );
	}
	return Spawn( "script_camera", origin );
}
create_scene( scene_name, shots )
{
	for( i = 0; i < shots.size; i++ )
	{
		create_scene_add_shot( scene_name, shots[i] );
	}
}
play_scene( scene )
{
	camera = create_camera();
	link_players_to_camera( camera );
	level thread skip_scene( scene );
	level.flag["skip_igc_" + scene] = undefined;
	level.flags_lock["skip_igc_" + scene] = undefined;
	flag_init( "skip_igc_" + scene );
	flag_clear( "skip_igc_" + scene );
	for( i = 0; i < level.cam_scenes[scene].shots.size; i++ )
	{
		if( flag( "skip_igc_" + scene ) )
		{
			break;
		}
		play_shot( level.cam_scenes[scene].shots[i], camera );
	}
	unlink_players_from_camera( camera );
	level notify( "igc_finished" );
}
skip_scene( scene )
{
	level endon( "igc_finished" );
	level thread catch_use_button();
	level waittill( "player_skip_igc" );
	flag_set( "skip_igc_" + scene );
	level notify( "player_skip_igc_confirmed" );
}
catch_use_button()
{
	level endon( "igc_finished" );
	wait( 0.2 );
	while( 1 )
	{
		players = get_players();
		for( i = 0; i < players.size; i++ )
		{
			if( players[i] UseButtonPressed() )
			{
				level notify( "player_skip_igc" );
				return;
			}
		}
		wait( 0.05 );
	}
}
create_scene_add_shot( name_of_scene, shot_name, shot_number )
{
	if( !IsDefined( level.cam_scenes ) )
	{
		level.cam_scenes = [];
	}
	if( !IsDefined( level.cam_scenes[name_of_scene] ) )
	{
		level.cam_scenes[name_of_scene] = SpawnStruct();
	}
	if( !IsDefined( level.cam_scenes[name_of_scene].shots ) )
	{
		level.cam_scenes[name_of_scene].shots = [];
	}
	if( !IsDefined( shot_number ) )
	{
		shot_number = level.cam_scenes[name_of_scene].shots.size;
	}
	level.cam_scenes[name_of_scene].shots[shot_number] = shot_name;
}
play_shot( shot_name, camera )
{
	track = level.cam_shots[shot_name].cam_track;
	target = level.cam_shots[shot_name].cam_target;
	play_shot_internal( camera, track, target );
}
play_shot_internal( camera, track, target, end_on )
{
	level endon( "player_skip_igc_confirmed" );
	track_id = -1;
	if( IsCurve( track.type ) )
	{
		track_id = build_curve( track.cpoints );
	}
	target_id = -1;
	if( IsCurve( target.type ) )
	{
		target_id = build_curve( target.cpoints );
	}
	if( track_id > 0 )
	{
		camera CameraLinkToCurve( track_id );
		SetCurveNotifyEnt( track_id, get_players()[0] );
	}
	else if( track.type == "Point" )
	{
		camera.origin = track.cpoints[0].origin;
		wait( 1 );
		camera.origin = ( 1000, 1000, 1000 );
	}
	if( track_id > 0 )
	{
		StartCurve( track_id );
	}
	else if( target.type == "Point" )
	{
		camera SetLookAtOrigin( target.cpoints[0].origin );
	}
	if( target_id > 0 )
	{
		camera SetLookAtCurve( target_id );
		StartCurve( target_id );
	}
	if( track_id > 0 )
	{
		get_players()[0] waittill( "curve_end" );
	}
	else
	{
		wait( track.cpoints[0].attrib["time"] );
	}
	if( track_id > 0 )
	{
		FreeCurve( track_id );
	}
	if( target_id > 0 )
	{
		FreeCurve( target_id );
	}
}
link_players_to_camera( camera )
{
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] PlayerLinkToCamera( camera );
	}
}
unlink_players_from_camera( camera )
{
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] Unlink();
	}
	camera Delete();
}
IsCurve( type )
{
	if( type == "Timed Curve" || type == "Rounded Curve" || type == "Smoothed Curve" )
	{
		return true;
	}
	return false;
}
create_cam_node( scene_name, pos, angles, time, accel, deccel )
{
	if( !IsDefined( level.cam_scenes ) )
	{
		level.cam_scenes = [];
	}
	if( !IsDefined( level.cam_scenes_names ) )
	{
		level.cam_scenes_names = [];
	}
	if( !IsDefined( level.cam_scenes[scene_name] ) )
	{
		level.cam_scenes[scene_name] = [];
	}
	if( level.cam_scenes[scene_name].size == 0 )
	{
		level.cam_scenes_names[level.cam_scenes_names.size] = scene_name;
	}
	size = level.cam_scenes[scene_name].size;
	level.cam_scenes[scene_name][size]["pos"] = pos;
	level.cam_scenes[scene_name][size]["angles"] = angles;
	level.cam_scenes[scene_name][size]["time"] = time;
	level.cam_scenes[scene_name][size]["accel"] = accel;
	level.cam_scenes[scene_name][size]["deccel"] = deccel;
}
playback_scene( option1, option2, option3 )
{
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] FreezeControls( true );
		players[i] EnableInvulnerability();
	}
	black_bg = NewHudElem();
	black_bg.x = 0;
	black_bg.y = 0;
	black_bg.alpha = 0;
	black_bg.horzAlign = "fullscreen";
	black_bg.vertAlign = "fullscreen";
	black_bg SetShader( "black", 640, 480 );
	temp_text = NewHudElem();
	temp_text.x = 320;
	temp_text.y = 240;
	temp_text.alignY = "middle";
	temp_text.alignX = "center";
	temp_text.alpha = 0;
	temp_text.fontscale = 2;
	temp_text SetText( "[IGC WILL BE HERE]" );
	black_bg FadeOverTime( 1.0 );
	black_bg.alpha = 0.8;
	temp_text FadeOverTime( 1.0 );
	temp_text.alpha = 1;
	wait( 1.0 );
	level notify ("blacked out");
	if( IsDefineD( option1 ) && !IsString( option1 ) )
	{
		wait( option1 );
	}
	else
	{
		wait( 3 );
		if( IsDefined( option2 ) )
		{
			level waittill( option2 );
		}
	}
	black_bg FadeOverTime( 1.0 );
	black_bg.alpha = 0;
	temp_text FadeOverTime( 1.0 );
	temp_text.alpha = 0;
	wait( 1.0 );
	black_bg destroy();
	temp_text destroy();
	level notify ("fade complete");
	players = get_players();
	for( i = 0; i < players.size; i++ )
	{
		players[i] FreezeControls( false );
		players[i] DisableInvulnerability();
	}
	level notify( "plackback_finished" );
}
draw_shot( shot_name )
{
}
draw_shot_track( shot_name )
{
}
draw_shot_target( shot_name )
{
}
stop_drawing_all()
{
}
stop_drawing_tracks()
{
}
stop_drawing_targets()
{
}
fade_to_black()
{
	fadetoblack = NewHudElem();
	fadetoblack.x = 0;
	fadetoblack.y = 0;
	fadetoblack.alpha = 0;
	fadetoblack.horzAlign = "fullscreen";
	fadetoblack.vertAlign = "fullscreen";
	fadetoblack.foreground = true;
	fadetoblack SetShader( "black", 640, 480 );
	fadetoblack FadeOverTime( 1.0 );
	fadetoblack.alpha = 1;
	wait (1.0);
	level notify ("blacked out");
	fadetoblack FadeOverTime( 1.0 );
	fadetoblack.alpha = 0;
	wait (1.0);
	fadetoblack destroy();
	level notify ("fade complete");
} 