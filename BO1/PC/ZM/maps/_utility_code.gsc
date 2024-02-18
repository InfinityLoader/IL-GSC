#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
structarray_swap( object1, object2 )
{
	index1 = object1.struct_array_index;
	index2 = object2.struct_array_index;
	self.array[ index2 ] = object1;
	self.array[ index1 ] = object2;
	self.array[ index1 ].struct_array_index = index1;
	self.array[ index2 ].struct_array_index = index2;
}
waitSpread_insert( allotment )
{
	gapIndex = -1;
	gap = 0;
	for ( p = 0; p < allotment.size - 1; p++ )
	{
		newgap = allotment[ p + 1 ] - allotment[ p ];
		if ( newgap <= gap )
		{
			continue;
		}
		gap = newgap;
		gapIndex = p;
	}
	assert( gap > 0 );
	newAllotment = [];
	for ( i = 0; i < allotment.size; i++ )
	{
		if ( gapIndex == i - 1 )
		{
			newAllotment[ newAllotment.size ] = randomfloatrange( allotment[ gapIndex ], allotment[ gapIndex + 1 ] );
		}
		newAllotment[ newAllotment.size ] = allotment[ i ];
	}
	return newAllotment;
}
waittill_objective_event_proc( requireTrigger )
{
	while ( level.deathSpawner[ self.script_deathChain ] > 0 )
	{
		level waittill( "spawner_expired" + self.script_deathChain );
	}
	if ( requireTrigger )
	{
		self waittill( "trigger" );
	}
	flag = self get_trigger_flag();
	flag_set( flag );
}
wait_until_done_speaking()
{
	self endon( "death" );
	while ( self.isSpeaking )
	{
		wait( 0.05 );
	}
}
ent_waits_for_level_notify( msg )
{
	level waittill( msg );
	self notify( "done" );
}
ent_waits_for_trigger( trigger )
{
	trigger waittill( "trigger" );
	self notify( "done" );
}
ent_times_out( timer )
{
	wait( timer );
	self notify( "done" );
}
update_debug_friendlycolor_on_death()
{
	self notify( "debug_color_update" );
	self endon( "debug_color_update" );
	num = self.ai_number;
	self waittill( "death" );
	level.debug_color_friendlies[ num ] = undefined;
	level notify( "updated_color_friendlies" );
}
update_debug_friendlycolor( num )
{
	thread update_debug_friendlycolor_on_death();
	if ( isdefined( self.script_forceColor ) )
	{
		level.debug_color_friendlies[ num ] = self.script_forceColor;
	}
	else
	{
		level.debug_color_friendlies[ num ] = undefined;
	}
	level notify( "updated_color_friendlies" );
}
insure_player_does_not_set_forcecolor_twice_in_one_frame()
{
}
new_color_being_set( color )
{
	self notify( "new_color_being_set" );
	self.new_force_color_being_set = true;
	maps\_colors::left_color_node();
	self endon( "new_color_being_set" );
	self endon( "death" );
	waittillframeend;
	waittillframeend;
	if ( isdefined( self.script_forceColor ) )
	{
		self.currentColorCode = level.currentColorForced[ self.team ][ self.script_forceColor ];
		self thread maps\_colors::goto_current_ColorIndex();
	}
	self.new_force_color_being_set = undefined;
	self notify( "done_setting_new_color" );
}
delayThread_proc( func, timer, param1, param2, param3, param4 )
{
	self endon( "death" );
	wait( timer );
	if ( isdefined( param4 ) )
	{
		thread [[ func ]]( param1, param2, param3, param4 );
	}
	else if ( isdefined( param3 ) )
	{
		thread [[ func ]]( param1, param2, param3 );
	}
	else if ( isdefined( param2 ) )
	{
		thread [[ func ]]( param1, param2 );
	}
	else if ( isdefined( param1 ) )
	{
		thread [[ func ]]( param1 );
	}
	else
	{
		thread [[ func ]]();
	}
}
wait_for_flag_or_time_elapses( flagname, timer )
{
	level endon( flagname );
	wait( timer );
}
ent_wait_for_flag_or_time_elapses( flagname, timer )
{
	self endon( flagname );
	wait( timer );
}
waittill_either_function_internal( ent, func, parm )
{
	ent endon( "done" );
	[[ func ]]( parm );
	ent notify( "done" );
}
HintPrintWait( length, breakfunc )
{
	if ( !isdefined( breakfunc ) )
	{
		wait( length );
		return;
	}
	timer = length * 20;
	for ( i = 0; i < timer; i++ )
	{
		if ( [[ breakfunc ]]() )
		{
			break;
		}
		wait( 0.05 );
	}
}
HintPrint( string, breakfunc )
{
	MYFADEINTIME = 1.0;
	MYFLASHTIME = 0.75;
	MYALPHAHIGH = 0.95;
	MYALPHALOW = 0.4;
	flag_waitopen( "global_hint_in_use" );
	flag_set( "global_hint_in_use" );
	Hint = createFontString( "objective", 2 );
	Hint.alpha = 0.9;
	Hint.x = 0;
	Hint.y = -68;
	Hint.alignx = "center";
	Hint.aligny = "middle";
	Hint.horzAlign = "center";
	Hint.vertAlign = "middle";
	Hint.foreground = false;
	Hint.hidewhendead = true;
	Hint setText( string );
	Hint.alpha = 0;
	Hint FadeOverTime( MYFADEINTIME );
	Hint.alpha = MYALPHAHIGH;
	HintPrintWait( MYFADEINTIME );
	if ( isdefined( breakfunc ) )
	{
		for ( ;; )
		{
			Hint FadeOverTime( MYFLASHTIME );
			Hint.alpha = MYALPHALOW;
			HintPrintWait( MYFLASHTIME, breakfunc );
			if ( [[ breakfunc ]]() )
			{
				break;
			}
			Hint FadeOverTime( MYFLASHTIME );
			Hint.alpha = MYALPHAHIGH;
			HintPrintWait( MYFLASHTIME );
			if ( [[ breakfunc ]]() )
			{
				break;
			}
		}
	}
	else
	{
		for ( i = 0; i < 5; i++ )
		{
			Hint FadeOverTime( MYFLASHTIME );
			Hint.alpha = MYALPHALOW;
			HintPrintWait( MYFLASHTIME );
			Hint FadeOverTime( MYFLASHTIME );
			Hint.alpha = MYALPHAHIGH;
			HintPrintWait( MYFLASHTIME );
		}
	}
	Hint Destroy();
	flag_clear( "global_hint_in_use" );
}
lerp_player_view_to_tag_internal( ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo )
{
	if( IsPlayer( self ) )
	{
		self endon( "disconnect" );
	}
	if ( isdefined( self.first_frame_time ) && ent.first_frame_time == gettime() )
	{
		wait( 0.10 );
	}
	origin = ent gettagorigin( tag );
	angles = ent gettagangles( tag );
	self lerp_player_view_to_position( origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo );
	if ( IsDefined(hit_geo) && hit_geo )
	{
		return;
	}
	if( IsDefined( right_arc ) )
	{
		self playerlinkto( ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc );
	}
	else if( IsDefined( fraction ) )
	{
		self playerlinkto( ent, tag, fraction );
	}
	else
	{
		self playerlinkto( ent );
	}
}
lerp_player_view_to_tag_oldstyle_internal( ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo )
{
	if( IsPlayer( self ) )
	{
		self endon( "disconnect" );
	}
	if ( isdefined( ent.first_frame_time ) && ent.first_frame_time == gettime() )
	{
		wait( 0.10 );
	}
	origin = ent gettagorigin( tag );
	angles = ent gettagangles( tag );
	self lerp_player_view_to_position_oldstyle( origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true );
	if ( hit_geo )
	{
		return;
	}
	self playerlinktodelta( ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, false );
}
lerp_player_view_to_moving_tag_oldstyle_internal( ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo )
{
	if( IsPlayer( self ) )
	{
		self endon( "disconnect" );
	}
	if ( isdefined( ent.first_frame_time ) && ent.first_frame_time == gettime() )
	{
		wait( 0.10 );
	}
	self lerp_player_view_to_position_oldstyle( ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true );
	if ( hit_geo )
	{
		return;
	}
	self playerlinkto( ent, tag, fraction, right_arc, left_arc, top_arc, bottom_arc, false );
}
function_stack_proc( caller, func, param1, param2, param3, param4 )
{
	if ( !isdefined( caller.function_stack ) )
	{
		caller.function_stack = [];
	}
	caller.function_stack[ caller.function_stack.size ] = self;
	function_stack_caller_waits_for_turn( caller );
	if ( isdefined( caller ) )
	{
		if ( isdefined( param4 ) )
		{
			caller [[ func ]]( param1, param2, param3, param4 );
		}
		else if ( isdefined( param3 ) )
		{
			caller [[ func ]]( param1, param2, param3 );
		}
		else if ( isdefined( param2 ) )
		{
			caller [[ func ]]( param1, param2 );
		}
		else if ( isdefined( param1 ) )
		{
			caller [[ func ]]( param1 );
		}
		else
		{
			caller [[ func ]]();
		}
		if ( isdefined( caller ) )
		{
			caller.function_stack = array_remove( caller.function_stack, self );
			caller notify( "level_function_stack_ready" );
		}
	}
	if ( isdefined( self ) )
	{
		self notify( "function_done" );
	}
}
function_stack_caller_waits_for_turn( caller )
{
	caller endon( "death" );
	self endon( "death" );
	while ( caller.function_stack[ 0 ] != self )
	{
		caller waittill( "level_function_stack_ready" );
	}
}
alphabet_compare( a, b )
{
	list = [];
	val = 1;
	list[ "0" ] = val; val++;
	list[ "1" ] = val; val++;
	list[ "2" ] = val; val++;
	list[ "3" ] = val; val++;
	list[ "4" ] = val; val++;
	list[ "5" ] = val; val++;
	list[ "6" ] = val; val++;
	list[ "7" ] = val; val++;
	list[ "8" ] = val; val++;
	list[ "9" ] = val; val++;
	list[ "_" ] = val; val++;
	list[ "a" ] = val; val++;
	list[ "b" ] = val; val++;
	list[ "c" ] = val; val++;
	list[ "d" ] = val; val++;
	list[ "e" ] = val; val++;
	list[ "f" ] = val; val++;
	list[ "g" ] = val; val++;
	list[ "h" ] = val; val++;
	list[ "i" ] = val; val++;
	list[ "j" ] = val; val++;
	list[ "k" ] = val; val++;
	list[ "l" ] = val; val++;
	list[ "m" ] = val; val++;
	list[ "n" ] = val; val++;
	list[ "o" ] = val; val++;
	list[ "p" ] = val; val++;
	list[ "q" ] = val; val++;
	list[ "r" ] = val; val++;
	list[ "s" ] = val; val++;
	list[ "t" ] = val; val++;
	list[ "u" ] = val; val++;
	list[ "v" ] = val; val++;
	list[ "w" ] = val; val++;
	list[ "x" ] = val; val++;
	list[ "y" ] = val; val++;
	list[ "z" ] = val; val++;
	a = tolower( a );
	b = tolower( b );
	val1 = 0;
	if ( isdefined( list[ a ] ) )
	{
		val1 = list[ a ];
	}
	val2 = 0;
	if ( isdefined( list[ b ] ) )
	{
		val2 = list[ b ];
	}
	if ( val1 > val2 )
	{
		return "1st";
	}
	if ( val1 < val2 )
	{
		return "2nd";
	}
	return "same";
}
is_later_in_alphabet( string1, string2 )
{
	count = string1.size;
	if ( count >= string2.size )
	{
		count = string2.size;
	}
	for ( i = 0; i < count; i++ )
	{
		val = alphabet_compare( string1[ i ], string2[ i ] );
		if ( val == "1st" )
		{
			return true;
		}
		if ( val == "2nd" )
		{
			return false;
		}
	}
	return string1.size > string2.size;
}
wait_for_sounddone_or_death( org )
{
	self endon( "death" );
	org waittill( "sounddone" );
}
sound_effect()
{
	self effect_soundalias();
}
effect_soundalias()
{
	origin = self.v[ "origin" ];
	alias = self.v[ "soundalias" ];
	self exploder_delay();
	play_sound_in_space( alias, origin );
}
cannon_effect()
{
	if( isdefined( self.v[ "repeat" ] ) )
	{
		for( i = 0;i < self.v[ "repeat" ];i ++ )
		{
			playfx( level._effect[ self.v[ "fxid" ] ], self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
			self exploder_delay();
		}
		return;
	}
	self exploder_delay();
	if ( isdefined( self.looper ) )
	{
		self.looper delete();
	}
	self.looper = spawnFx( getfx( self.v[ "fxid" ] ), self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
	triggerFx( self.looper );
	exploder_playSound();
}
exploder_delay()
{
	if( !isdefined( self.v[ "delay" ] ) )
	{
		self.v[ "delay" ] = 0;
	}
	min_delay = self.v[ "delay" ];
	max_delay = self.v[ "delay" ] + 0.001;
	if( isdefined( self.v[ "delay_min" ] ) )
	{
		min_delay = self.v[ "delay_min" ];
	}
	if( isdefined( self.v[ "delay_max" ] ) )
	{
		max_delay = self.v[ "delay_max" ];
	}
	if( min_delay > 0 )
	{
		wait( randomfloatrange( min_delay, max_delay ) );
	}
}
exploder_earthquake()
{
	earthquake_name = self.v[ "earthquake" ];
	assertex(IsDefined(level.earthquake) && IsDefined(level.earthquake[earthquake_name]),
	"No earthquake '" + earthquake_name + "' defined for exploder - call add_earthquake() in your level script.");
	self exploder_delay();
	eq = level.earthquake[earthquake_name];
	earthquake( eq[ "magnitude" ], eq[ "duration" ], self.v[ "origin" ], eq[ "radius" ] );
}
exploder_rumble()
{
	self exploder_delay();
	level.player PlayRumbleonentity( self.v[ "rumble" ] );
}
exploder_playSound()
{
	if( !isdefined( self.v[ "soundalias" ] ) || self.v[ "soundalias" ] == "nil" )
	{
		return;
	}
	play_sound_in_space( self.v[ "soundalias" ], self.v[ "origin" ] );
}
fire_effect()
{
	forward = self.v[ "forward" ];
	up = self.v[ "up" ];
	org = undefined;
	firefxSound = self.v[ "firefxsound" ];
	origin = self.v[ "origin" ];
	firefx = self.v[ "firefx" ];
	ender = self.v[ "ender" ];
	if( !isdefined( ender ) )
	{
		ender = "createfx_effectStopper";
	}
	timeout = self.v[ "firefxtimeout" ];
	fireFxDelay = 0.5;
	if( isdefined( self.v[ "firefxdelay" ] ) )
	{
		fireFxDelay = self.v[ "firefxdelay" ];
	}
	self exploder_delay();
	if( isdefined( firefxSound ) )
	{
		level thread loop_fx_sound( firefxSound, origin, ender, timeout );
	}
	playfx( level._effect[ firefx ], self.v[ "origin" ], forward, up );
}
trail_effect()
{
	self exploder_delay();
	if( !IsDefined( self.v["trailfxtag"] ) )
	{
		self.v["trailfxtag"] = "tag_origin";
	}
	temp_ent = undefined;
	if(self.v["trailfxtag"] == "tag_origin")
	{
		PlayFxOnTag( level._effect[self.v["trailfx"]], self.model, self.v["trailfxtag"] );
	}
	else
	{
		temp_ent = Spawn( "script_model", self.model.origin );
		temp_ent SetModel( "tag_origin" );
		temp_ent LinkTo( self.model );
		PlayFxOnTag( level._effect[self.v["trailfx"]], temp_ent, self.v["trailfxtag"] );
	}
	if( IsDefined( self.v["trailfxsound"] ) )
	{
		if(!isdefined(temp_ent))
		{
			self.model PlayLoopSound( self.v["trailfxsound"] );
		}
		else
		{
			temp_ent PlayLoopSound( self.v["trailfxsound"] );
		}
	}
	if( IsDefined( self.v[ "ender" ] ) )
	{
	}
	if( !IsDefined( self.v["trailfxtimeout"] ) )
	{
		return;
	}
	wait( self.v["trailfxtimeout"] );
	if(isdefined(temp_ent))
	{
		temp_ent Delete();
	}
}
trail_effect_ender( ent, ender )
{
	ent endon( "death" );
	self waittill( ender );
	ent Delete();
}
init_vision_set( visionset )
{
	level.lvl_visionset = visionset;
	if ( !isdefined ( level.vision_cheat_enabled ) )
	{
		level.vision_cheat_enabled = false;
	}
	return level.vision_cheat_enabled;
}
exec_func( func, endons )
{
	for ( i = 0; i < endons.size; i++ )
	{
		endons[ i ].caller endon( endons[ i ].ender );
	}
	if ( func.parms.size == 0 )
	{
		func.caller [[ func.func ]]();
	}
	else if ( func.parms.size == 1 )
	{
		func.caller [[ func.func ]]( func.parms[ 0 ] );
	}
	else if ( func.parms.size == 2 )
	{
		func.caller [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ] );
	}
	else if ( func.parms.size == 3 )
	{
		func.caller [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ] );
	}
}
waittill_func_ends( func, endons )
{
	self endon( "all_funcs_ended" );
	exec_func( func, endons );
	self.count--;
	self notify( "func_ended" );
}
 