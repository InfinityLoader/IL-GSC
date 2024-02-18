#include clientscripts\_utility_code;
#include clientscripts\_fx;
error( message )
{
	println( "^c * ERROR * ", message );
	wait 0.05;
}
getstruct( name, type )
{
	if(!IsDefined( level.struct_class_names ) )
		return undefined;
	array = level.struct_class_names[ type ][ name ];
	if( !IsDefined( array ) )
	{
		println("**** Getstruct returns undefined on " + name + " : " + " type.");
		return undefined;
	}
	if( array.size > 1 )
	{
		assertMsg( "getstruct used for more than one struct of type " + type + " called " + name + "." );
		return undefined;
	}
	return array[ 0 ];
}
getstructarray( name, type )
{
	assertEx( IsDefined( level.struct_class_names ), "Tried to getstruct before the structs were init" );
	array = level.struct_class_names[type][name];
	if(!IsDefined( array ) )
	{
		return [];
	}
	else
	{
		return array;
	}
}
play_sound_in_space( localClientNum, alias, origin)
{
	PlaySound( localClientNum, alias, origin);
}
vector_compare(vec1, vec2)
{
	return (abs(vec1[0] - vec2[0]) < .001) && (abs(vec1[1] - vec2[1]) < .001) && (abs(vec1[2] - vec2[2]) < .001);
}
vector_scale(vec, scale)
{
	vec = (vec * scale);
	return vec;
}
vector_multiply( vec, vec2 )
{
	vec = (vec * vec2);
	return vec;
}
array_func(entities, func, arg1, arg2, arg3, arg4, arg5)
{
	if (!IsDefined( entities ))
	{
		return;
	}
	if (IsArray(entities))
	{
		if (entities.size)
		{
			keys = GetArrayKeys( entities );
			for (i = 0; i < keys.size; i++)
			{
				single_func(entities[keys[i]], func, arg1, arg2, arg3, arg4, arg5);
			}
		}
	}
	else
	{
		single_func(entities, func, arg1, arg2, arg3, arg4, arg5);
	}
}
single_func(entity, func, arg1, arg2, arg3, arg4, arg5)
{
	if (IsDefined(arg5))
	{
		entity [[ func ]](arg1, arg2, arg3, arg4, arg5);
	}
	else if (IsDefined(arg4))
	{
		entity [[ func ]](arg1, arg2, arg3, arg4);
	}
	else if (IsDefined(arg3))
	{
		entity [[ func ]](arg1, arg2, arg3);
	}
	else if (IsDefined(arg2))
	{
		entity [[ func ]](arg1, arg2);
	}
	else if (IsDefined(arg1))
	{
		entity [[ func ]](arg1);
	}
	else
	{
		entity [[ func ]]();
	}
}
array_thread( entities, func, arg1, arg2, arg3, arg4, arg5 )
{
	if (!IsDefined( entities ))
	{
		return;
	}
	if (IsArray(entities))
	{
		if (entities.size)
		{
			keys = GetArrayKeys( entities );
			for (i = 0; i < keys.size; i++)
			{
				single_thread(entities[keys[i]], func, arg1, arg2, arg3, arg4, arg5);
			}
		}
	}
	else
	{
		single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
	}
}
single_thread(entity, func, arg1, arg2, arg3, arg4, arg5)
{
	if (IsDefined(arg5))
	{
		entity thread [[ func ]](arg1, arg2, arg3, arg4, arg5);
	}
	else if (IsDefined(arg4))
	{
		entity thread [[ func ]](arg1, arg2, arg3, arg4);
	}
	else if (IsDefined(arg3))
	{
		entity thread [[ func ]](arg1, arg2, arg3);
	}
	else if (IsDefined(arg2))
	{
		entity thread [[ func ]](arg1, arg2);
	}
	else if (IsDefined(arg1))
	{
		entity thread [[ func ]](arg1);
	}
	else
	{
		entity thread [[ func ]]();
	}
}
array(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z)
{
	array = [];
	if ( IsDefined( a ) ) array[ 0] = a; else return array;
	if ( IsDefined( b ) ) array[ 1] = b; else return array;
	if ( IsDefined( c ) ) array[ 2] = c; else return array;
	if ( IsDefined( d ) ) array[ 3] = d; else return array;
	if ( IsDefined( e ) ) array[ 4] = e; else return array;
	if ( IsDefined( f ) ) array[ 5] = f; else return array;
	if ( IsDefined( g ) ) array[ 6] = g; else return array;
	if ( IsDefined( h ) ) array[ 7] = h; else return array;
	if ( IsDefined( i ) ) array[ 8] = i; else return array;
	if ( IsDefined( j ) ) array[ 9] = j; else return array;
	if ( IsDefined( k ) ) array[10] = k; else return array;
	if ( IsDefined( l ) ) array[11] = l; else return array;
	if ( IsDefined( m ) ) array[12] = m; else return array;
	if ( IsDefined( n ) ) array[13] = n; else return array;
	if ( IsDefined( o ) ) array[14] = o; else return array;
	if ( IsDefined( p ) ) array[15] = p; else return array;
	if ( IsDefined( q ) ) array[16] = q; else return array;
	if ( IsDefined( r ) ) array[17] = r; else return array;
	if ( IsDefined( s ) ) array[18] = s; else return array;
	if ( IsDefined( t ) ) array[19] = t; else return array;
	if ( IsDefined( u ) ) array[20] = u; else return array;
	if ( IsDefined( v ) ) array[21] = v; else return array;
	if ( IsDefined( w ) ) array[22] = w; else return array;
	if ( IsDefined( x ) ) array[23] = x; else return array;
	if ( IsDefined( y ) ) array[24] = y; else return array;
	if ( IsDefined( z ) ) array[25] = z;
	return array;
}
is_in_array( aeCollection, eFindee )
{
	for( i = 0; i < aeCollection.size; i++ )
	{
		if( aeCollection[ i ] == eFindee )
		{
			return( true );
		}
	}
	return( false );
}
add_to_array( array, ent, allow_dupes )
{
	if( !IsDefined( ent ) )
	{
		return array;
	}
	if (!IsDefined(allow_dupes))
	{
		allow_dupes = true;
	}
	if( !IsDefined( array ) )
	{
		array[ 0 ] = ent;
	}
	else if (allow_dupes || !is_in_array(array, ent))
	{
		array[ array.size ] = ent;
	}
	return array;
}
array_add( array, ent )
{
	array[ array.size ] = ent;
	return array;
}
array_delete( array )
{
	for( i = 0; i < array.size; i++ )
	{
		array[ i ] delete();
	}
}
array_randomize( array )
{
	for( i = 0; i < array.size; i++ )
	{
		j = RandomInt( array.size );
		temp = array[ i ];
		array[ i ] = array[ j ];
		array[ j ] = temp;
	}
	return array;
}
array_reverse( array )
{
	array2 = [];
	for( i = array.size - 1; i >= 0; i-- )
	{
		array2[ array2.size ] = array[ i ];
	}
	return array2;
}
array_removeUndefined( array )
{
	newArray = [];
	for( i = 0; i < array.size; i++ )
	{
		if( !IsDefined( array[ i ] ) )
		{
			continue;
		}
		newArray[ newArray.size ] = array[ i ];
	}
	return newArray;
}
array_insert( array, object, index )
{
	if( index == array.size )
	{
		temp = array;
		temp[ temp.size ] = object;
		return temp;
	}
	temp = [];
	offset = 0;
	for( i = 0; i < array.size; i++ )
	{
		if( i == index )
		{
			temp[ i ] = object;
			offset = 1;
		}
		temp[ i + offset ] = array[ i ];
	}
	return temp;
}
array_remove( ents, remover, keepArrayKeys )
{
	newents = [];
	keys = getArrayKeys( ents );
	if(IsDefined(keepArrayKeys))
	{
		for( i = keys.size - 1; i >= 0; i-- )
		{
			if( ents[ keys[ i ] ] != remover )
			{
				newents[ keys[i] ] = ents[ keys[ i ] ];
			}
		}
		return newents;
	}
	for( i = keys.size - 1; i >= 0; i-- )
	{
		if( ents[ keys[ i ] ] != remover )
		{
			newents[ newents.size ] = ents[ keys[ i ] ];
		}
	}
	return newents;
}
array_remove_nokeys( ents, remover )
{
	newents = [];
	for ( i = 0; i < ents.size; i++ )
	{
		if( ents[ i ] != remover )
		{
			newents[ newents.size ] = ents[ i ];
		}
	}
	return newents;
}
array_remove_index( array, index )
{
	newArray = [];
	keys = getArrayKeys( array );
	for( i = ( keys.size - 1 );i >= 0 ; i-- )
	{
		if( keys[ i ] != index )
		{
			newArray[ newArray.size ] = array[ keys[ i ] ];
		}
	}
	return newArray;
}
array_combine( array1, array2 )
{
	if( !array1.size )
	{
		return array2;
	}
	array3 = [];
	keys = GetArrayKeys( array1 );
	for( i = 0;i < keys.size;i++ )
	{
		key = keys[ i ];
		array3[ array3.size ] = array1[ key ];
	}
	keys = GetArrayKeys( array2 );
	for( i = 0;i < keys.size;i++ )
	{
		key = keys[ i ];
		array3[ array3.size ] = array2[ key ];
	}
	return array3;
}
array_merge( array1, array2 )
{
	if( array1.size == 0 )
	{
		return array2;
	}
	if( array2.size == 0 )
	{
		return array1;
	}
	newarray = array1;
	for( i = 0;i < array2.size;i++ )
	{
		foundmatch = false;
		for( j = 0;j < array1.size;j++ )
		{
			if( array2[ i ] == array1[ j ] )
			{
				foundmatch = true;
				break;
			}
		}
		if( foundmatch )
		{
			continue;
		}
		else
		{
			newarray[ newarray.size ] = array2[ i ];
		}
	}
	return newarray;
}
array_exclude( array, arrayExclude )
{
	newarray = array;
	for( i = 0;i < arrayExclude.size;i++ )
	{
		if( is_in_array( array, arrayExclude[ i ] ) )
		{
			newarray = array_remove( newarray, arrayExclude[ i ] );
		}
	}
	return newarray;
}
array_notify( ents, notifier )
{
	for( i = 0;i < ents.size;i++ )
	ents[ i ] notify( notifier );
}
array_wait(array, msg, timeout)
{
	keys = getarraykeys(array);
	structs = [];
	for (i = 0; i < keys.size; i++)
	{
		key = keys[i];
		structs[ key ] = spawnstruct();
		structs[ key ]._array_wait = true;
		structs[ key ] thread array_waitlogic1( array[ key ], msg, timeout );
	}
	for (i = 0; i < keys.size; i++)
	{
		key = keys[i];
		if( IsDefined( array[ key ] ) && structs[ key ]._array_wait)
		{
			structs[ key ] waittill( "_array_wait" );
		}
	}
}
array_waitlogic1( ent, msg, timeout )
{
	self array_waitlogic2( ent, msg, timeout );
	self._array_wait = false;
	self notify( "_array_wait" );
}
array_waitlogic2( ent, msg, timeout )
{
	ent endon( msg );
	ent endon( "death" );
	if( isdefined( timeout ) )
	{
		wait timeout;
	}
	else
	{
		ent waittill( msg );
	}
}
array_check_for_dupes( array, single )
{
	for( i = 0; i < array.size; i++ )
	{
		if( array[i] == single )
		{
			return false;
		}
	}
	return true;
}
array_swap( array, index1, index2 )
{
	assertEx( index1 < array.size, "index1 to swap out of range" );
	assertEx( index2 < array.size, "index2 to swap out of range" );
	temp = array[index1];
	array[index1] = array[index2];
	array[index2] = temp;
	return array;
}
random( array )
{
	return array [ randomint( array.size ) ];
}
realWait(seconds)
{
	start = GetRealTime();
	while(GetRealTime() - start < seconds * 1000)
	{
		wait(.01);
	}
}
registerSystem(sSysName, cbFunc)
{
	if(!IsDefined(level._systemStates))
	{
		level._systemStates = [];
	}
	if(level._systemStates.size >= 32)
	{
		error("Max num client systems exceeded.");
		return;
	}
	if(IsDefined(level._systemStates[sSysName]))
	{
		error("Attempt to re-register client system : " + sSysName);
		return;
	}
	else
	{
		level._systemStates[sSysName] = spawnstruct();
		level._systemStates[sSysName].callback = cbFunc;
	}
}
loop_sound_Delete( ender, entId )
{
	self waittill( ender );
	deletefakeent(0, entId);
}
loop_fx_sound( clientNum, alias, origin, ender )
{
	entId = spawnfakeent(clientNum);
	if( IsDefined( ender ) )
	{
		thread loop_sound_Delete( ender, entId );
		self endon( ender );
	}
	setfakeentorg(clientNum, entId, origin);
	playloopsound( clientNum, entId, alias );
}
waitforallclients()
{
	localClient = 0;
	while (localClient < getlocalplayers().size)
	{
		waitforclient(localClient);
		localClient++;
	}
}
waitforclient(client)
{
	while(!clienthassnapshot(client))
	{
		wait(0.01);
	}
}
waittill_string( msg, ent )
{
	if ( msg != "death" )
		self endon ("death");
	ent endon ( "die" );
	self waittill ( msg );
	ent notify ( "returned", msg );
}
waittill_any_return( string1, string2, string3, string4, string5, string6 )
{
	if ((!IsDefined (string1) || string1 != "death") &&
	(!IsDefined (string2) || string2 != "death") &&
	(!IsDefined (string3) || string3 != "death") &&
	(!IsDefined (string4) || string4 != "death") &&
	(!IsDefined (string5) || string5 != "death") &&
	(!IsDefined (string6) || string6 != "death"))
	self endon ("death");
	ent = SpawnStruct();
	if (IsDefined(string1))
		self thread waittill_string(string1, ent);
	if (IsDefined(string2))
		self thread waittill_string(string2, ent);
	if (IsDefined(string3))
		self thread waittill_string(string3, ent);
	if (IsDefined(string4))
		self thread waittill_string(string4, ent);
	if (IsDefined(string5))
		self thread waittill_string(string5, ent);
	if (IsDefined(string6))
		self thread waittill_string(string6, ent);
	ent waittill ("returned", msg);
	ent notify ("die");
	return msg;
}
waittill_any( string1, string2, string3, string4, string5 )
{
	assert( IsDefined( string1 ) );
	if ( IsDefined( string2 ) )
		self endon( string2 );
	if ( IsDefined( string3 ) )
		self endon( string3 );
	if ( IsDefined( string4 ) )
		self endon( string4 );
	if ( IsDefined( string5 ) )
		self endon( string5 );
	self waittill( string1 );
}
waittill_multiple( string1, string2, string3, string4, string5 )
{
	self endon ("death");
	ent = SpawnStruct();
	ent.threads = 0;
	if (IsDefined (string1))
	{
		self thread waittill_string (string1, ent);
		ent.threads++;
	}
	if (IsDefined (string2))
	{
		self thread waittill_string (string2, ent);
		ent.threads++;
	}
	if (IsDefined (string3))
	{
		self thread waittill_string (string3, ent);
		ent.threads++;
	}
	if (IsDefined (string4))
	{
		self thread waittill_string (string4, ent);
		ent.threads++;
	}
	if (IsDefined (string5))
	{
		self thread waittill_string (string5, ent);
		ent.threads++;
	}
	while (ent.threads)
	{
		ent waittill ("returned");
		ent.threads--;
	}
	ent notify ("die");
}
within_fov( start_origin, start_angles, end_origin, fov )
{
	normal = VectorNormalize( end_origin - start_origin );
	forward = AnglesToForward( start_angles );
	dot = VectorDot( forward, normal );
	return dot >= fov;
}
setFootstepEffect(name, fx)
{
	assertEx(IsDefined(name), "Need to define the footstep surface type.");
	assertEx(IsDefined(fx), "Need to define the footstep effect.");
	if (!IsDefined(level._optionalStepEffects))
		level._optionalStepEffects = [];
	level._optionalStepEffects[level._optionalStepEffects.size] = name;
	level._effect["step_" + name] = fx;
}
getExploderId( ent )
{
	if(!IsDefined(level._exploder_ids))
	{
		level._exploder_ids = [];
		level._exploder_id = 1;
	}
	if(!IsDefined(level._exploder_ids[ent.v["exploder"]]))
	{
		level._exploder_ids[ent.v["exploder"]] = level._exploder_id;
		level._exploder_id ++;
	}
	return level._exploder_ids[ent.v["exploder"]];
}
reportExploderIds()
{
	if(!IsDefined(level._exploder_ids))
		return;
	keys = GetArrayKeys( level._exploder_ids );
	println("Client Exploder dictionary : ");
	for( i = 0; i < keys.size; i++ )
	{
		println(keys[i] + " : " + level._exploder_ids[keys[i]]);
	}
}
init_exploders()
{
	println("*** Init exploders...");
	script_exploders = [];
	ents = GetStructArray( "script_brushmodel", "classname" );
	println("Client : s_bm " + ents.size);
	smodels = GetStructArray( "script_model", "classname" );
	println("Client : sm " + smodels.size);
	for( i = 0; i < smodels.size; i++ )
	{
		ents[ents.size] = smodels[i];
	}
	for( i = 0; i < ents.size; i++ )
	{
		if( IsDefined( ents[i].script_prefab_exploder ) )
		{
			ents[i].script_exploder = ents[i].script_prefab_exploder;
		}
	}
	potentialExploders = GetStructArray( "script_brushmodel", "classname" );
	println("Client : Potential exploders from script_brushmodel " + potentialExploders.size);
	for( i = 0; i < potentialExploders.size; i++ )
	{
		if( IsDefined( potentialExploders[i].script_prefab_exploder ) )
		{
			potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
		}
		if( IsDefined( potentialExploders[i].script_exploder ) )
		{
			script_exploders[script_exploders.size] = potentialExploders[i];
		}
	}
	potentialExploders = GetStructArray( "script_model", "classname" );
	println("Client : Potential exploders from script_model " + potentialExploders.size);
	for( i = 0; i < potentialExploders.size; i++ )
	{
		if( IsDefined( potentialExploders[i].script_prefab_exploder ) )
		{
			potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
		}
		if( IsDefined( potentialExploders[i].script_exploder ) )
		{
			script_exploders[script_exploders.size] = potentialExploders[i];
		}
	}
	for( i = 0; i < level.struct.size; i++ )
	{
		if( IsDefined( level.struct[i].script_prefab_exploder ) )
		{
			level.struct[i].script_exploder = level.struct[i].script_prefab_exploder;
		}
		if( IsDefined( level.struct[i].script_exploder ) )
		{
			script_exploders[script_exploders.size] = level.struct[i];
		}
	}
	if( !IsDefined( level.createFXent ) )
	{
		level.createFXent = [];
	}
	acceptableTargetnames = [];
	acceptableTargetnames["exploderchunk visible"] = true;
	acceptableTargetnames["exploderchunk"] = true;
	acceptableTargetnames["exploder"] = true;
	exploder_id = 1;
	for( i = 0; i < script_exploders.size; i++ )
	{
		exploder = script_exploders[i];
		ent = createExploder( exploder.script_fxid );
		ent.v = [];
		if(!IsDefined(exploder.origin))
		{
			println("************** NO EXPLODER ORIGIN." + i);
		}
		ent.v["origin"] = exploder.origin;
		ent.v["angles"] = exploder.angles;
		ent.v["delay"] = exploder.script_delay;
		ent.v["firefx"] = exploder.script_firefx;
		ent.v["firefxdelay"] = exploder.script_firefxdelay;
		ent.v["firefxsound"] = exploder.script_firefxsound;
		ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
		ent.v["trailfx"] = exploder.script_trailfx;
		ent.v["trailfxtag"] = exploder.script_trailfxtag;
		ent.v["trailfxdelay"] = exploder.script_trailfxdelay;
		ent.v["trailfxsound"] = exploder.script_trailfxsound;
		ent.v["trailfxtimeout"] = exploder.script_firefxtimeout;
		ent.v["earthquake"] = exploder.script_earthquake;
		ent.v["rumble"] = exploder.script_rumble;
		ent.v["damage"] = exploder.script_damage;
		ent.v["damage_radius"] = exploder.script_radius;
		ent.v["repeat"] = exploder.script_repeat;
		ent.v["delay_min"] = exploder.script_delay_min;
		ent.v["delay_max"] = exploder.script_delay_max;
		ent.v["target"] = exploder.target;
		ent.v["ender"] = exploder.script_ender;
		ent.v["physics"] = exploder.script_physics;
		ent.v["type"] = "exploder";
		if( !IsDefined( exploder.script_fxid ) )
		{
			ent.v["fxid"] = "No FX";
		}
		else
		{
			ent.v["fxid"] = exploder.script_fxid;
		}
		ent.v["exploder"] = exploder.script_exploder;
		if( !IsDefined( ent.v["delay"] ) )
		{
			ent.v["delay"] = 0;
		}
		if( IsDefined( exploder.script_sound ) )
		{
			ent.v["soundalias"] = exploder.script_sound;
		}
		else if( ent.v["fxid"] != "No FX" )
		{
			if( IsDefined( level.scr_sound ) && IsDefined( level.scr_sound[ent.v["fxid"]] ) )
			{
				ent.v["soundalias"] = level.scr_sound[ent.v["fxid"]];
			}
		}
		fixup_set = false;
		if(IsDefined(ent.v["target"]))
		{
			ent.needs_fixup = exploder_id;
			exploder_id++;
			fixup_set = true;
			{
				temp_ent = GetStruct( ent.v["target"], "targetname" );
				org = temp_ent.origin;
			}
			if(IsDefined(org))
			{
				ent.v["angles"] = VectorToAngles( org - ent.v["origin"] );
			}
			else
			{
				println("*** Client : Exploder " + exploder.script_fxid + " Failed to find target ");
			}
			if(IsDefined(ent.v["angles"]))
			{
				ent set_forward_and_up_vectors();
			}
			else
			{
				println("*** Client " + exploder.script_fxid + " has no angles.");
			}
		}
		if( exploder.classname == "script_brushmodel" || IsDefined( exploder.model ) )
		{
			if(IsDefined(exploder.model))
			{
				println("*** exploder " + exploder_id + " model " + exploder.model);
			}
			ent.model = exploder;
			if(fixup_set == false)
			{
				ent.needs_fixup = exploder_id;
				exploder_id++;
			}
		}
		if( IsDefined( exploder.targetname ) && IsDefined( acceptableTargetnames[exploder.targetname] ) )
		{
			ent.v["exploder_type"] = exploder.targetname;
		}
		else
		{
			ent.v["exploder_type"] = "normal";
		}
	}
	for(i = 0; i < level.createFXent.size;i ++ )
	{
		ent = level.createFXent[i];
		if(ent.v["type"] != "exploder")
			continue;
		ent.v["exploder_id"] = getExploderId( ent );
	}
	reportExploderIds();
	println("*** Client : " + script_exploders.size + " exploders.");
}
playfx_for_all_local_clients( fx_id, pos, forward_vec, up_vec )
{
	localPlayers = getlocalplayers();
	if( IsDefined( up_vec ) )
	{
		for(i = 0; i < localPlayers.size; i ++)
		{
			playfx( i, fx_id, pos, forward_vec, up_vec );
		}
	}
	else if( IsDefined( forward_vec ) )
	{
		for(i = 0; i < localPlayers.size; i ++)
		{
			playfx( i, fx_id, pos, forward_vec );
		}
	}
	else
	{
		for(i = 0; i < localPlayers.size; i ++)
		{
			playfx( i, fx_id, pos );
		}
	}
}
play_sound_on_client( sound_alias )
{
	players = GetLocalPlayers();
	PlaySound( 0, sound_alias, players[0].origin );
}
loop_sound_on_client( sound_alias, min_delay, max_delay, end_on )
{
	players = GetLocalPlayers();
	if( IsDefined( end_on ) )
	{
		level endon( end_on );
	}
	for( ;; )
	{
		play_sound_on_client( sound_alias );
		wait( min_delay + RandomFloat( max_delay ) );
	}
}
add_listen_thread( wait_till, func, param1, param2, param3, param4, param5 )
{
	level thread add_listen_thread_internal( wait_till, func, param1, param2, param3, param4, param5 );
}
add_listen_thread_internal( wait_till, func, param1, param2, param3, param4, param5 )
{
	for( ;; )
	{
		level waittill( wait_till );
		single_thread(level, func, param1, param2, param3, param4, param5);
	}
}
addLightningExploder(num)
{
	if (!isdefined(level.lightningExploder))
	{
		level.lightningExploder = [];
		level.lightningExploderIndex = 0;
	}
	level.lightningExploder[level.lightningExploder.size] = num;
}
splitscreen_populate_dvars( clientNum )
{
	if ( getlocalplayers().size <= 1 )
	{
		return;
	}
	UpdateDvarsFromProfile( clientNum );
}
splitscreen_restore_dvars()
{
	if ( getlocalplayers().size <= 1 )
	{
		return;
	}
	splitscreen_populate_dvars( 0 );
}
is_plane()
{
	if(self.vehicleclass == "plane")
	{
		return true;
	}
	return false;
}
is_boat()
{
	if(self.vehicleclass == "boat")
	{
		return true;
	}
	return false;
}
is_mig()
{
	if(self.vehicletype == "plane_mig17" || self.vehicletype == "plane_mig21")
	{
		return true;
	}
	return false;
}
is_helicopter()
{
	if(self.vehicleclass == "helicopter")
	{
		return true;
	}
	return false;
}
is_tank()
{
	if(self.vehicleclass == "tank")
	{
		return true;
	}
	return false;
}
is_artillery()
{
	if(self.vehicleclass == "artillery")
	{
		return true;
	}
	return false;
}
is_4wheel()
{
	if(self.vehicleclass == "4 wheel")
	{
		return true;
	}
	return false;
}
add_trigger_to_ent(ent, trig)
{
	if(!isdefined(ent._triggers))
	{
		ent._triggers = [];
	}
	ent._triggers[trig getentitynumber()] = 1;
}
remove_trigger_from_ent(ent, trig)
{
	if(!isdefined(ent._triggers))
		return;
	if(!isdefined(ent._triggers[trig getentitynumber()]))
		return;
	ent._triggers[trig getentitynumber()] = 0;
}
ent_already_in_trigger(trig)
{
	if(!isdefined(self._triggers))
		return false;
	if(!isdefined(self._triggers[trig getentitynumber()]))
		return false;
	if(!self._triggers[trig getentitynumber()])
		return false;
	return true;
}
trigger_thread(ent, on_enter_payload, on_exit_payload)
{
	ent endon("entityshutdown");
	ent endon("death");
	if(ent ent_already_in_trigger(self))
		return;
	add_trigger_to_ent(ent, self);
	if(isdefined(on_enter_payload))
	{
		[[on_enter_payload]](ent);
	}
	while(isdefined(ent) && ent istouching(self))
	{
		wait(0.01);
	}
	if(ent IsPlayer())
	{
		while(!ClientHasSnapshot(0))
		{
			wait(0.01);
		}
	}
	if(isdefined(ent) && isdefined(on_exit_payload))
	{
		[[on_exit_payload]](ent);
	}
	if(isdefined(ent))
	{
		remove_trigger_from_ent(ent, self);
	}
}
remove_triggers_from_ent( ent )
{
	if( IsDefined( ent._triggers ) )
	{
		ent._triggers = [];
	}
}
notify_delay( sNotifyString, fDelay )
{
	assert( IsDefined( self ) );
	assert( IsDefined( sNotifyString ) );
	assert( IsDefined( fDelay ) );
	assert( fDelay > 0 );
	self endon( "death" );
	wait fDelay;
	if( !IsDefined( self ) )
	{
		return;
	}
	self notify( sNotifyString );
}
OnPlayerConnect_Callback(func)
{
	clientscripts\_callbacks::AddCallback("on_player_connect", func);
}
set_player_viewmodel(viewmodel)
{
	level.player_viewmodel = viewmodel;
}
spawn_player_arms()
{
	arms = Spawn(self GetLocalClientNumber(), self GetOrigin() + ( 0, 0, -1000 ), "script_model");
	if (IsDefined(level.player_viewmodel))
	{
		arms SetModel(level.player_viewmodel);
	}
	else
	{
		arms SetModel("viewmodel_usa_marine_arms");
	}
	return arms;
}
get_eye()
{
	if (self IsPlayer())
	{
		linked_ent = self GetLinkedEnt();
		if (IsDefined(linked_ent) && (GetDvarInt(#"cg_cameraUseTagCamera") > 0))
		{
			camera = linked_ent GetTagOrigin("tag_camera");
			if (IsDefined(camera))
			{
				return camera;
			}
		}
	}
	pos = self GetEye();
	return pos;
}
clamp(val, val_min, val_max)
{
	if (val < val_min)
	{
		val = val_min;
	}
	else if (val > val_max)
	{
		val = val_max;
	}
	return val;
}
waittill_either( msg1, msg2 )
{
	self endon( msg1 );
	self waittill( msg2 );
}
is_valid_type_for_callback(type)
{
	switch(type)
	{
		case "actor":
		case "vehicle":
		case "player":
		case "NA":
		case "general":
		case "missile":
		case "scriptmover":
		case "mg42":
		case "plane":
		{
			return true;
		}
		default:
		{
			return false;
		}
	}
}
register_clientflag_callback(type, flag, function)
{
	if(!is_valid_type_for_callback(type))
	{
		AssertMsg(type + " is not a valid entity type to have a callback function registered.");
		return;
	}
	if(IsDefined(level._client_flag_callbacks[type][flag]))
	{
		if(level._client_flag_callbacks[type][flag] == function)
		{
			return;
		}
		AssertMsg("Flag " + flag + " is already registered for ent type " + type + ".  Please use a different flag number.  See console for list of free flags for this type.");
		return;
	}
	level._client_flag_callbacks[type][flag] = function;
}
is_mature()
{
	if ( level.onlineGame )
		return true;
	return GetDvarInt( #"cg_mature" );
}
is_german_build()
{
	if( GetDvar( #"language" ) == "german" )
	{
		return true;
	}
	return false;
}
 