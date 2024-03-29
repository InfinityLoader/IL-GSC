init ()
{
	SetAIFootstepPrepend ("fly_step_run_npc_");
}
playerFootstep(client_num, player, movementtype, ground_type, firstperson, quiet )
{
	if( player underwater() )
		return;
	if( IsDefined( level.footstep_vol_override ) )
	{
		movementtype = "run";
	}
	full_movement_type = "step_" + movementtype;
	sound_alias = buildMovementSoundAliasName(full_movement_type, ground_type, firstperson, quiet );
	player.movementtype = movementtype;
	player playsound( client_num, sound_alias );
	if ( IsDefined( player.step_sound ) && (!quiet) && (player.step_sound) != "none" )
	{
		volume = clientscripts\_audio::get_vol_from_speed (player);
		player playsound (client_num, player.step_sound, player.origin, volume);
	}
}
playerJump(client_num, player, ground_type, firstperson, quiet)
{
	sound_alias = buildMovementSoundAliasName("step_run", ground_type, firstperson, quiet );
	player playsound( client_num, sound_alias );
}
playerLand(client_num, player, ground_type, firstperson, quiet, damagePlayer)
{
	sound_alias = buildMovementSoundAliasName("land", ground_type, firstperson, quiet );
	player playsound( client_num, sound_alias );
	if ( IsDefined( player.step_sound ) && (!quiet) && (player.step_sound) != "none" )
	{
		volume = clientscripts\_audio::get_vol_from_speed (player);
		player playsound (client_num, player.step_sound, player.origin, volume);
	}
	if ( damagePlayer )
	{
		sound_alias = "fly_land_damage_npc";
		if ( firstperson )
		{
			sound_alias = "fly_land_damage_plr";
			player playsound( client_num, sound_alias );
		}
	}
}
playerFoliage(client_num, player, firstperson, quiet)
{
	sound_alias = "fly_movement_foliage_npc";
	if ( firstperson )
	{
		sound_alias = "fly_movement_foliage_plr";
	}
	player playsound( client_num, sound_alias );
}
SetAIFootstepPrepend( prepend )
{
	level.footstepPrepend = prepend;
}
playAIFootstep(client_num, ent, pos, ground_type, on_fire, is_dog)
{
	sound_alias = undefined;
	if ( !IsDefined( is_dog ) )
	{
		is_dog = false;
	}
	if(IsDefined(ent.footstepPrepend))
	{
		sound_alias = ent.footstepPrepend + ground_type;
	}
	else if( isdefined( level.footstepPrepend ) )
	{
		sound_alias = level.footstepPrepend + ground_type;
	}
	if ( is_dog )
	{
		sound_alias = "fly_dog_step_run_default";
	}
	if( isdefined( sound_alias ) )
		playsound ( client_num, sound_alias, pos);
	if ( IsDefined( ent.step_sound ) && (ent.step_sound) != "null" )
	{
		volume = clientscripts\_audio::get_vol_from_speed (ent);
		ent playsound (client_num, ent.step_sound, ent.origin, volume);
	}
	ent do_foot_effect(client_num, ground_type, pos, on_fire);
}
buildMovementSoundAliasName( movementtype, ground_type, firstperson, quiet )
{
	if(firstperson && isdefined(level.snd_footstep_override_plr) && (level.snd_footstep_override_plr != ""))
	{
		return level.snd_footstep_override_plr;
	}
	if((!firstperson) && isdefined(level.snd_footstep_override_npc) && (level.snd_footstep_override_npc != ""))
	{
		return level.snd_footstep_override_npc;
	}
	sound_alias = "fly_";
	if ( quiet )
	{
		sound_alias = sound_alias + "q";
	}
	sound_alias = sound_alias + movementtype;
	if ( firstperson )
	{
		sound_alias = sound_alias + "_plr_";
	}
	else
	{
		sound_alias = sound_alias + "_npc_";
	}
	sound_alias = sound_alias + ground_type;
	return sound_alias;
}
do_foot_effect(client_num, ground_type, foot_pos, on_fire)
{
	if(!isdefined(level._optionalStepEffects) && !isdefined(self._footstepOverrideEffect))
	{
		return;
	}
	if( on_fire )
	{
		ground_type = "fire";
	}
	if(isdefined(self._footstepOverrideEffect))
	{
		fwd = anglestoforward(self.angles);
		playfx(client_num, level._effect[self._footstepOverrideEffect], foot_pos, fwd, (0,0,1) );
		return;
	}
	for(i = 0; i < level._optionalStepEffects.size; i ++)
	{
		if(level._optionalStepEffects[i] == ground_type)
		{
			effect = "step_" + ground_type;
			if(isdefined(level._effect[effect]))
			{
				playfx(client_num, level._effect[effect], foot_pos, foot_pos + (0,0,100));
				return;
			}
		}
	}
} 