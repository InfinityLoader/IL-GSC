/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_dna_aoe_grenade.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 130 ms
 * Timestamp: 4/22/2024 2:13:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["dna_aoe"] = loadfx("vfx/unique/vfx_killstreak_missilestrike_dna_friendly_sml");
	level.zombie_dna_grenades_active = [];
}

//Function Number: 2
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self notify("onPlayerSpawnDNAAOEGrenade");
	self endon("onPlayerSpawnDNAAOEGrenade");
	var_00 = self.team;
	for(;;)
	{
		self waittill("grenade_fire",var_01,var_02);
		var_03 = maps\mp\_utility::strip_suffix(var_02,"_lefthand");
		if(var_03 != "dna_aoe_grenade_zombie_mp" && var_03 != "dna_aoe_grenade_throw_zombie_mp")
		{
			continue;
		}

		if(!isdefined(var_01))
		{
			continue;
		}

		var_04 = var_01 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("explode","dud_explode","repulsor_repel");
		if(var_04.size < 2 || var_04[0] == "dud_explode" || var_04[0] == "repulsor_repel")
		{
			continue;
		}

		thread addaoecloud(var_04[1],var_00);
	}
}

//Function Number: 3
addaoecloud(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin");
	level.zombie_dna_grenades_active[level.zombie_dna_grenades_active.size] = var_02;
	level.zombie_dna_grenades_active = common_scripts\utility::array_removeundefined(level.zombie_dna_grenades_active);
	if(level.zombie_dna_grenades_active.size > 6)
	{
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dna_aoe"),level.zombie_dna_grenades_active[0],"tag_origin");
		level.zombie_dna_grenades_active[0] notify("stopGrenade");
	}

	wait 0.05;
	var_02 playloopsound("dna_grenade_front_lp");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dna_aoe"),var_02,"tag_origin");
	var_02 updateaoe(param_01,self);
	var_02 stoploopsound();
	var_02 playsound("dna_grenade_front_end");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dna_aoe"),var_02,"tag_origin");
	wait(0.05);
	var_02 delete();
}

//Function Number: 4
updateaoe(param_00,param_01)
{
	self endon("death");
	self endon("stopGrenade");
	var_02 = squared(160);
	var_03 = 0;
	var_04 = 0.15;
	while(var_03 < 20)
	{
		wait(var_04);
		var_03 = var_03 + var_04;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(!isdefined(level.agentarray))
		{
			continue;
		}

		foreach(var_06 in level.agentarray)
		{
			if(!isdefined(var_06) || !isalive(var_06) || isdefined(var_06.team) && !isenemyteam(param_00,var_06.team))
			{
				continue;
			}

			if(distancesquared(self.origin,var_06.origin) > var_02)
			{
				continue;
			}

			var_06 maps\mp\zombies\_zombies::addbuff("dnaBuff",var_06 getdnabuff(param_01));
		}
	}
}

//Function Number: 5
getdnabuff(param_00)
{
	var_01 = maps\mp\zombies\_zombies::getbuff("dnaBuff");
	if(!isdefined(var_01))
	{
		var_01 = spawndnabuff();
	}

	var_01.lifespan = 0.2;
	var_01.player = param_00;
	return var_01;
}

//Function Number: 6
spawndnabuff()
{
	var_00 = spawnstruct();
	var_00.buffupdate = ::updatednabuff;
	var_00.buffremove = ::removednabuff;
	var_00.lifespan = 0.2;
	var_00.damageperstep = 60 * maps\mp\zombies\_zombies::getbufftimestep();
	var_00.speedmultiplier = 0.4;
	self notify("speed_debuffs_changed");
	return var_00;
}

//Function Number: 7
updatednabuff(param_00)
{
	var_01 = param_00.player;
	if(isremovedentity(var_01))
	{
		var_01 = undefined;
	}

	self dodamage(param_00.damageperstep,self.origin,var_01,undefined,"MOD_TRIGGER_HURT","dna_aoe_grenade_zombie_mp","none");
}

//Function Number: 8
removednabuff(param_00)
{
	self notify("speed_debuffs_changed");
}