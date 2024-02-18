
#include maps\_utility;
#include common_scripts\utility;
rainHard(transition)
{
	println ("Rain becomes Hard over " + transition + " seconds");
	level notify ("rain_change", "hard", transition);
	level thread rainEffectChange(10, transition);
	wait (transition*0.5);
	level.ambient_modifier["rain"] = "";
	wait (transition*0.5);
}
rainMedium(transition)
{
	println ("Rain becomes Medium over " + transition + " seconds");
	level notify ("rain_change", "medium", transition);
	level thread rainEffectChange(5, transition);
	wait (transition*0.5);
	level.ambient_modifier["rain"] = "med";
	wait (transition*0.5);
}
rainLight(transition)
{
	println ("Rain becomes Light over " + transition + " seconds");
	level notify ("rain_change", "light", transition);
	level thread rainEffectChange(1, transition);
	wait (transition*0.5);
	level.ambient_modifier["rain"] = "light";
	wait (transition*0.5);
}
rainNone(transition)
{
	println ("Rain fades out over " + transition + " seconds");
	level notify ("rain_change", "none", transition);
	level thread rainEffectChange(0, transition);
	wait (transition*0.5);
	level.ambient_modifier["rain"] = "norain";
	wait (transition*0.5);
}
rainInit(lvl)
{
	if (lvl == "none")
	{
		level.rainLevel = 0;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		rainNone(0.1);
	}
	else if (lvl == "light")
	{
		level.rainLevel = 1;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		rainLight(0.1);
	}
	if (lvl == "medium")
	{
		level.rainLevel = 5;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		rainMedium(0.1);
	}
	if (lvl == "hard")
	{
		level.rainLevel = 10;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		rainHard(0.1);
	}
	else
	{
		level.rainLevel = 10;
		level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		rainHard(0.1);
	}
}
lightning(normal, flash)
{
	if( !IsDefined( level.disableLightning ) )
	{
		level.disableLightning = false;
	}
	[[normal]]();
	waittillframeend;
	for (;;)
	{
		lightningThink(normal, flash);
	}
}
rainEffectChange(change, transition)
{
	level notify ("rain_level_change");
	level endon ("rain_level_change");
	if (level.rainLevel > change)
	{
		dif = level.rainLevel - change;
		transition /= dif;
		for (i=0;i<dif;i++)
		{
			wait (transition);
			level.rainLevel--;
			level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		}
		assert (level.rainLevel == change);
	}
	if (level.rainLevel < change)
	{
		dif = change - level.rainLevel;
		transition /= dif;
		for (i=0;i<dif;i++)
		{
			wait (transition);
			level.rainLevel++;
			level._effect["rain_drops"] = level._effect["rain_" + level.rainLevel];
		}
		assert (level.rainLevel == change);
	}
}
rainlevelRandomwait()
{
	if (level.rainLevel == 0)
	{
		return (randomfloat (30));
	}
	else if (level.rainLevel == 1)
	{
		return (randomfloat (24));
	}
	else if (level.rainLevel == 2)
	{
		return (randomfloat (20));
	}
	else if (level.rainLevel == 3)
	{
		return (randomfloat (15));
	}
	else if (level.rainLevel == 4)
	{
		return (randomfloat (12));
	}
	else if (level.rainLevel == 5)
	{
		return (randomfloat (9));
	}
	else if (level.rainLevel == 6)
	{
		return (randomfloat (8));
	}
	else if (level.rainLevel == 7)
	{
		return (randomfloat (8));
	}
	else if (level.rainLevel == 8)
	{
		return (randomfloat (7));
	}
	else if (level.rainLevel == 9)
	{
		return (randomfloat (6));
	}
	else if (level.rainLevel == 10)
	{
		return (randomfloat (5));
	}
}
rainlevelwait()
{
	if (level.rainLevel == 0)
	{
		return (20);
	}
	else if (level.rainLevel == 1)
	{
		return (18);
	}
	else if (level.rainLevel == 2)
	{
		return (16);
	}
	else if (level.rainLevel == 3)
	{
		return (14);
	}
	else if (level.rainLevel == 4)
	{
		return (12);
	}
	else if (level.rainLevel == 5)
	{
		return (10);
	}
	else if (level.rainLevel == 6)
	{
		return (9);
	}
	else if (level.rainLevel == 7)
	{
		return (8);
	}
	else if (level.rainLevel == 8)
	{
		return (7);
	}
	else if (level.rainLevel == 9)
	{
		return (6);
	}
	else if (level.rainLevel == 10)
	{
		return (5);
	}
}
lightningThink(normal, flash)
{
	level endon ("rain_change");
	nextStrike = gettime() + ((rainlevelwait() + rainlevelRandomwait())*1000);
	if (nextStrike < level.nextLightning)
	{
		level.nextLightning = nextStrike;
	}
	for (;;)
	{
		timer = (level.nextLightning - gettime()) * 0.001;
		if (timer > 0)
		{
			wait (timer);
		}
		if( level.rainLevel != 0 && !level.disableLightning )
		{
			lightningStrike( normal, flash );
		}
		level.nextLightning = gettime() + ((rainlevelwait() + rainlevelRandomwait())*1000);
	}
}
lightningStrike( normalfunc, flashfunc )
{
	if( !IsDefined( level.pauseLightning ) )
	{
		level.pauseLightning = false;
	}
	if( level.pauseLightning )
	{
		return;
	}
	flash[0] = "quick";
	flash[1] = "double";
	flash[2] = "triple";
	flashType = RandomInt( flash.size );
	thread thunder( flash[flashType] );
	lit_num = 0;
	if( IsDefined( level.lightningExploderIndex ) )
	{
		if( level.lightningExploder.size > 1 )
		{
			while( lit_num == level.lightningExploderIndex )
			{
				lit_num = RandomInt( level.lightningExploder.size );
			}
		}
		level.lightningExploderIndex = lit_num;
	}
	switch( flash[flashType] )
	{
		case "quick":
		{
			lightningflash( normalfunc, flashfunc );
			break;
		}
		case "double":
		{
			lightningflash( normalfunc, flashfunc );
			wait( 0.05 );
			lightningflash( normalfunc, flashfunc );
			break;
		}
		case "triple":
		{
			lightningflash( normalfunc, flashfunc );
			wait( 0.05 );
			lightningflash( normalfunc, flashfunc );
			wait( 0.5 );
			lightningflash( normalfunc, flashfunc );
			break;
		}
	}
}
lightningflash( normalfunc, flashfunc )
{
	if (isdefined (level.lightningExploderIndex))
	{
		exploder(level.lightningExploder[level.lightningExploderIndex]);
	}
	[[flashfunc]]();
	wait RandomFloatRange( 0.05, 0.1 );
	[[normalfunc]]();
}
thunder( flashType )
{
	if (level.rainLevel == 0)
	{
		wait (6 + randomfloat(2));
	}
	else if (level.rainLevel == 1)
	{
		wait (5 + randomfloat(1.8));
	}
	else if (level.rainLevel == 2)
	{
		wait (4.5 + randomfloat(1.6));
	}
	else if (level.rainLevel == 3)
	{
		wait (4 + randomfloat(1.6));
	}
	else if (level.rainLevel == 4)
	{
		wait (3.5 + randomfloat(1.5));
	}
	else if (level.rainLevel == 5)
	{
		wait (3 + randomfloat(1.5));
	}
	else if (level.rainLevel == 6)
	{
		wait (2.5 + randomfloat(1.2));
	}
	else if	(level.rainLevel == 7)
	{
		wait (2 + randomfloat(0.75));
	}
	else if (level.rainLevel == 8)
	{
		wait (1.25 + randomfloat(0.5));
	}
	else if (level.rainLevel == 9)
	{
		wait (1);
	}
	else if (level.rainLevel == 10)
	{
		wait (0.75);
	}
	thunderDistant = "thunder_farL";
	thunderClose = "thunder_closeL";
	if( IsDefined( level.thunder_distant_sound ) )
	{
		thunderDistant = level.thunder_distant_sound;
	}
	if( IsDefined( level.thunder_strike_sound ) )
	{
		thunderClose = level.thunder_close_sound;
	}
	if( IsDefined( level.thunderSoundEmitter ) )
	{
		emitter_thunder( thunderDistant, thunderClose, flashType );
	}
	else
	{
		array_thread( get_players(), ::player_thunder, thunderDistant, thunderClose, flashType );
	}
}
emitter_thunder( thunderDistant, thunderClose, flashType )
{
	ent = Spawn( "script_origin", level.thunderSoundEmitter.origin );
	ent thread thunder_playsound( thunderDistant, thunderClose, flashType );
}
player_thunder( thunderDistant, thunderClose, flashType )
{
	ent = Spawn( "script_origin", ( 0, 0, 0 ) );
	ent.origin = self.origin + ( 0, 0, 60 );
	ent LinkTo( self );
	ent thread thunder_playsound( thunderDistant, thunderClose, flashType );
}
thunder_playsound( thunderDistant, thunderClose, flashType )
{
	if( level.rainlevel <= 7 )
	{
		self PlaySound( thunderDistant, "sounddone" );
	}
	else
	{
		sound = thunderClose;
		doRumble = true;
		if( IsDefined( flashType ) && flashType == "quick" )
		{
			sound = thunderDistant;
			doRumble = false;
		}
		else if( IsDefined( flashType ) && flashType == "triple" )
		{
			sound = thunderClose;
			doRumble = true;
		}
		else
		{
			if( RandomInt( 100 ) < 40 )
			{
				sound = thunderDistant;
				doRumble = false;
			}
		}
		self PlaySound( sound, "sounddone" );
		if( doRumble )
		{
			array_thread( get_players(), ::thunder_rumble );
		}
	}
	self waittill( "sounddone" );
	self Delete();
}
thunder_rumble()
{
	self endon( "death" );
	self endon( "disconnect" );
	wait( 0.1 );
	self notify( "thunder_rumble" );
	self endon( "thunder_rumble" );
	duration = 0.5;
	stopTime = GetTime() + ( duration * 1000 );
	while( GetTime() <= stopTime )
	{
		self PlayRumbleOnEntity( "damage_heavy" );
		wait( 0.05 );
	}
}
 