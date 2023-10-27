/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_burnplayer.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 92 ms
 * Timestamp: 10/27/2023 3:01:13 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;

//Function Number: 1
initburnplayer()
{
	level.flamedamage = 15;
	level.flameburntime = 1.5;
}

//Function Number: 2
hitwithincendiary(attacker,inflictor,mod)
{
	if(IsDefined(self.burning))
	{
		return;
	}

	self starttanning();
	self thread waitthenstoptanning(level.flameburntime);
	self endon("disconnect");
	attacker endon("disconnect");
	waittillframeend;
	self.burning = 1;
	self thread burn_blocker();
	tagarray = [];
	if(isai(self))
	{
		tagarray[tagarray.size] = "J_Wrist_RI";
		tagarray[tagarray.size] = "J_Wrist_LE";
		tagarray[tagarray.size] = "J_Elbow_LE";
		tagarray[tagarray.size] = "J_Elbow_RI";
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_RI";
		tagarray[tagarray.size] = "J_Ankle_LE";
	}
	else
	{
		tagarray[tagarray.size] = "J_Wrist_RI";
		tagarray[tagarray.size] = "J_Wrist_LE";
		tagarray[tagarray.size] = "J_Elbow_LE";
		tagarray[tagarray.size] = "J_Elbow_RI";
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_RI";
		tagarray[tagarray.size] = "J_Ankle_LE";
		if(isplayer(self) && self.health > 0)
		{
			self setburn(3);
		}
	}

	if(IsDefined(level._effect["character_fire_death_torso"]))
	{
		for(arrayindex = 0;arrayindex < tagarray.size;arrayindex++)
		{
			playfxontag(level._effect["character_fire_death_sm"],self,tagarray[arrayindex]);
		}
	}

	if(isai(self))
	{
		playfxontag(level._effect["character_fire_death_torso"],self,"J_Spine1");
	}
	else
	{
		playfxontag(level._effect["character_fire_death_torso"],self,"J_SpineLower");
	}

	if(!(isalive(self)))
	{
		return;
	}

	if(isplayer(self))
	{
		self thread watchforwater(7);
		self thread watchfordeath();
	}
}

//Function Number: 3
hitwithnapalmstrike(attacker,inflictor,mod)
{
	if(IsDefined(self.burning) || self hasperk("specialty_fireproof"))
	{
		return;
	}

	self starttanning();
	self thread waitthenstoptanning(level.flameburntime);
	self endon("disconnect");
	attacker endon("disconnect");
	self endon("death");
	if(IsDefined(self.burning))
	{
		return;
	}

	self thread burn_blocker();
	waittillframeend;
	self.burning = 1;
	self thread burn_blocker();
	tagarray = [];
	if(isai(self))
	{
		tagarray[tagarray.size] = "J_Wrist_RI";
		tagarray[tagarray.size] = "J_Wrist_LE";
		tagarray[tagarray.size] = "J_Elbow_LE";
		tagarray[tagarray.size] = "J_Elbow_RI";
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_RI";
		tagarray[tagarray.size] = "J_Ankle_LE";
	}
	else
	{
		tagarray[tagarray.size] = "J_Wrist_RI";
		tagarray[tagarray.size] = "J_Wrist_LE";
		tagarray[tagarray.size] = "J_Elbow_LE";
		tagarray[tagarray.size] = "J_Elbow_RI";
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_RI";
		tagarray[tagarray.size] = "J_Ankle_LE";
		if(isplayer(self))
		{
			self setburn(3);
		}
	}

	if(IsDefined(level._effect["character_fire_death_sm"]))
	{
		for(arrayindex = 0;arrayindex < tagarray.size;arrayindex++)
		{
			playfxontag(level._effect["character_fire_death_sm"],self,tagarray[arrayindex]);
		}
	}

	if(IsDefined(level._effect["character_fire_death_torso"]))
	{
		playfxontag(level._effect["character_fire_death_torso"],self,"J_SpineLower");
	}

	if(!(isalive(self)))
	{
		return;
	}

	self thread donapalmstrikedamage(attacker,inflictor,mod);
	if(isplayer(self))
	{
		self thread watchforwater(7);
		self thread watchfordeath();
	}
}

//Function Number: 4
walkedthroughflames(attacker,inflictor,weapon)
{
	if(IsDefined(self.burning) || self hasperk("specialty_fireproof"))
	{
		return;
	}

	self starttanning();
	self thread waitthenstoptanning(level.flameburntime);
	self endon("disconnect");
	waittillframeend;
	self.burning = 1;
	self thread burn_blocker();
	tagarray = [];
	if(isai(self))
	{
		tagarray[tagarray.size] = "J_Wrist_RI";
		tagarray[tagarray.size] = "J_Wrist_LE";
		tagarray[tagarray.size] = "J_Elbow_LE";
		tagarray[tagarray.size] = "J_Elbow_RI";
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_RI";
		tagarray[tagarray.size] = "J_Ankle_LE";
	}
	else
	{
		tagarray[tagarray.size] = "J_Knee_RI";
		tagarray[tagarray.size] = "J_Knee_LE";
		tagarray[tagarray.size] = "J_Ankle_RI";
		tagarray[tagarray.size] = "J_Ankle_LE";
	}

	if(IsDefined(level._effect["character_fire_player_sm"]))
	{
		for(arrayindex = 0;arrayindex < tagarray.size;arrayindex++)
		{
			playfxontag(level._effect["character_fire_player_sm"],self,tagarray[arrayindex]);
		}
	}

	if(!(isalive(self)))
	{
		return;
	}

	self thread doflamedamage(attacker,inflictor,weapon,1);
	if(isplayer(self))
	{
		self thread watchforwater(7);
		self thread watchfordeath();
	}
}

//Function Number: 5
burnedwithflamethrower(attacker,inflictor,weapon)
{
	if(IsDefined(self.burning))
	{
		return;
	}

	self starttanning();
	self thread waitthenstoptanning(level.flameburntime);
	self endon("disconnect");
	waittillframeend;
	self.burning = 1;
	self thread burn_blocker();
	tagarray = [];
	if(isai(self))
	{
		tagarray[0] = "J_Spine1";
		tagarray[1] = "J_Elbow_LE";
		tagarray[2] = "J_Elbow_RI";
		tagarray[3] = "J_Head";
		tagarray[4] = "j_knee_ri";
		tagarray[5] = "j_knee_le";
	}
	else
	{
		tagarray[0] = "J_Elbow_RI";
		tagarray[1] = "j_knee_ri";
		tagarray[2] = "j_knee_le";
		if(isplayer(self) && self.health > 0)
		{
			self setburn(3);
		}
	}

	if(isplayer(self) && isalive(self))
	{
		self thread watchforwater(7);
		self thread watchfordeath();
	}

	if(IsDefined(level._effect["character_fire_player_sm"]))
	{
		for(arrayindex = 0;arrayindex < tagarray.size;arrayindex++)
		{
			playfxontag(level._effect["character_fire_player_sm"],self,tagarray[arrayindex]);
		}
	}
}

//Function Number: 6
burnedwithdragonsbreath(attacker,inflictor,weapon)
{
	if(IsDefined(self.burning))
	{
		return;
	}

	self starttanning();
	self thread waitthenstoptanning(level.flameburntime);
	self endon("disconnect");
	waittillframeend;
	self.burning = 1;
	self thread burn_blocker();
	tagarray = [];
	if(isai(self))
	{
		tagarray[0] = "J_Spine1";
		tagarray[1] = "J_Elbow_LE";
		tagarray[2] = "J_Elbow_RI";
		tagarray[3] = "J_Head";
		tagarray[4] = "j_knee_ri";
		tagarray[5] = "j_knee_le";
	}
	else
	{
		tagarray[0] = "j_spinelower";
		tagarray[1] = "J_Elbow_RI";
		tagarray[2] = "j_knee_ri";
		tagarray[3] = "j_knee_le";
		if(isplayer(self) && self.health > 0)
		{
			self setburn(3);
		}
	}

	if(isplayer(self) && isalive(self))
	{
		self thread watchforwater(7);
		self thread watchfordeath();
		return;
	}

	if(IsDefined(level._effect["character_fire_player_sm"]))
	{
		for(arrayindex = 0;arrayindex < tagarray.size;arrayindex++)
		{
			playfxontag(level._effect["character_fire_player_sm"],self,tagarray[arrayindex]);
		}
	}
}

//Function Number: 7
burnedtodeath()
{
	self.burning = 1;
	self thread burn_blocker();
	self starttanning();
	self thread doburningsound();
	self thread waitthenstoptanning(level.flameburntime);
}

//Function Number: 8
watchfordeath()
{
	self endon("disconnect");
	self notify("watching for death while on fire");
	self endon("watching for death while on fire");
	self waittill("death");
	if(isplayer(self))
	{
		self _stopburning();
	}

	self.burning = undefined;
}

//Function Number: 9
watchforwater(time)
{
	self endon("disconnect");
	self notify("watching for water");
	self endon("watching for water");
	wait(0.1);
	looptime = 0.1;
	while(time > 0)
	{
		wait(looptime);
		if(self depthofplayerinwater() > 0)
		{
			finish_burn();
			time = 0;
		}

		time = time - looptime;
	}
}

//Function Number: 10
finish_burn()
{
	self notify("stop burn damage");
	tagarray = [];
	tagarray[0] = "j_spinelower";
	tagarray[1] = "J_Elbow_RI";
	tagarray[2] = "J_Head";
	tagarray[3] = "j_knee_ri";
	tagarray[4] = "j_knee_le";
	if(IsDefined(level._effect["fx_fire_player_sm_smk_2sec"]))
	{
		for(arrayindex = 0;arrayindex < tagarray.size;arrayindex++)
		{
			playfxontag(level._effect["fx_fire_player_sm_smk_2sec"],self,tagarray[arrayindex]);
		}
	}

	self.burning = undefined;
	self _stopburning();
	self.ingroundnapalm = 0;
}

//Function Number: 11
donapalmstrikedamage(attacker,inflictor,mod)
{
	if(isai(self))
	{
		dodognapalmstrikedamage(attacker,inflictor,mod);
		return;
	}

	self endon("death");
	self endon("disconnect");
	attacker endon("disconnect");
	self endon("stop burn damage");
	while(IsDefined(level.napalmstrikedamage) && IsDefined(self) && self depthofplayerinwater() < 1)
	{
		self dodamage(level.napalmstrikedamage,self.origin,attacker,attacker,"none",mod,0,"napalm_mp");
		wait(1);
	}
}

//Function Number: 12
donapalmgrounddamage(attacker,inflictor,mod)
{
	if(self hasperk("specialty_fireproof"))
	{
		return;
	}

	if(level.teambased)
	{
		if(attacker != self && attacker.team == self.team)
		{
			return;
		}
	}

	if(isai(self))
	{
		dodognapalmgrounddamage(attacker,inflictor,mod);
		return;
	}

	if(IsDefined(self.burning))
	{
		return;
	}

	self thread burn_blocker();
	self endon("death");
	self endon("disconnect");
	attacker endon("disconnect");
	self endon("stop burn damage");
	if(IsDefined(level.groundburntime))
	{
		if(GetDvar(#"6EC13261") == "")
		{
			waittime = level.groundburntime;
		}
		else
		{
			waittime = GetDvarFloat(#"6EC13261");
		}
	}
	else
	{
		waittime = 100;
	}

	self walkedthroughflames(attacker,inflictor,"napalm_mp");
	self.ingroundnapalm = 1;
	if(IsDefined(level.napalmgrounddamage))
	{
		if(GetDvar(#"3FFA6673") == "")
		{
			napalmgrounddamage = level.napalmgrounddamage;
		}
		else
		{
			napalmgrounddamage = GetDvarFloat(#"3FFA6673");
		}

		while(IsDefined(self) && IsDefined(inflictor) && self depthofplayerinwater() < 1 && waittime > 0)
		{
			self dodamage(level.napalmgrounddamage,self.origin,attacker,inflictor,"none",mod,0,"napalm_mp");
			if(isplayer(self))
			{
				self setburn(1.1);
			}

			wait(1);
			waittime = waittime - 1;
		}
	}

	self.ingroundnapalm = 0;
}

//Function Number: 13
dodognapalmstrikedamage(attacker,inflictor,mod)
{
	attacker endon("disconnect");
	self endon("death");
	self endon("stop burn damage");
	while(IsDefined(level.napalmstrikedamage) && IsDefined(self))
	{
		self dodamage(level.napalmstrikedamage,self.origin,attacker,attacker,"none",mod);
		wait(1);
	}
}

//Function Number: 14
dodognapalmgrounddamage(attacker,inflictor,mod)
{
	attacker endon("disconnect");
	self endon("death");
	self endon("stop burn damage");
	while(IsDefined(level.napalmgrounddamage) && IsDefined(self))
	{
		self dodamage(level.napalmgrounddamage,self.origin,attacker,attacker,"none",mod,0,"napalm_mp");
		wait(1);
	}
}

//Function Number: 15
burn_blocker()
{
	self endon("disconnect");
	self endon("death");
	wait(3);
	self.burning = undefined;
}

//Function Number: 16
doflamedamage(attacker,inflictor,weapon,time)
{
	if(isai(self))
	{
		dodogflamedamage(attacker,inflictor,weapon,time);
		return;
	}

	if(IsDefined(attacker))
	{
		attacker endon("disconnect");
	}

	self endon("death");
	self endon("disconnect");
	self endon("stop burn damage");
	self thread doburningsound();
	self notify("snd_burn_scream");
	wait_time = 1;
	while(IsDefined(level.flamedamage) && IsDefined(self) && self depthofplayerinwater() < 1 && time > 0)
	{
		if(IsDefined(attacker) && IsDefined(inflictor) && IsDefined(weapon))
		{
			if(maps/mp/gametypes/_globallogic_player::dodamagefeedback(weapon,attacker))
			{
				attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
			}

			self dodamage(level.flamedamage,self.origin,attacker,inflictor,"none","MOD_BURNED",0,weapon);
		}
		else
		{
			self dodamage(level.flamedamage,self.origin);
		}

		wait(wait_time);
		time = time - wait_time;
	}

	self thread finish_burn();
}

//Function Number: 17
dodogflamedamage(attacker,inflictor,weapon,time)
{
	if(!IsDefined(attacker) || !IsDefined(inflictor) || !IsDefined(weapon))
	{
		return;
	}

	attacker endon("disconnect");
	self endon("death");
	self endon("stop burn damage");
	self thread doburningsound();
	wait_time = 1;
	while(IsDefined(level.flamedamage) && IsDefined(self) && time > 0)
	{
		self dodamage(level.flamedamage,self.origin,attacker,inflictor,"none","MOD_BURNED",0,weapon);
		wait(wait_time);
		time = time - wait_time;
	}
}

//Function Number: 18
waitthenstoptanning(time)
{
	self endon("disconnect");
	self endon("death");
	wait(time);
	self _stopburning();
}

//Function Number: 19
doburningsound()
{
	self endon("disconnect");
	self endon("death");
	fire_sound_ent = spawn("script_origin",self.origin);
	fire_sound_ent linkto(self,"tag_origin",(0,0,0),(0,0,0));
	fire_sound_ent playloopsound("mpl_player_burn_loop");
	self thread firesounddeath(fire_sound_ent);
	self waittill("StopBurnSound");
	if(IsDefined(fire_sound_ent))
	{
		fire_sound_ent stoploopsound(0.5);
	}

	wait(0.5);
	if(IsDefined(fire_sound_ent))
	{
		fire_sound_ent delete();
	}

/#
	println("sound stop burning");
#/
}

//Function Number: 20
_stopburning()
{
	self endon("disconnect");
	self notify("StopBurnSound");
	if(IsDefined(self))
	{
		self stopburning();
	}
}

//Function Number: 21
firesounddeath(ent)
{
	ent endon("death");
	self waittill_any("death","disconnect");
	ent delete();
/#
	println("sound delete burning");
#/
}