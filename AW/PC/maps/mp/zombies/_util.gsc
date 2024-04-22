/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 209
 * Decompile Time: 3391 ms
 * Timestamp: 4/22/2024 2:14:13 AM
*******************************************************************/

//Function Number: 1
agentclassregister(param_00,param_01)
{
	if(isdefined(param_00.model_bodies) && isdefined(param_00.model_heads))
	{
	}

	if(!isdefined(level.agentclasses))
	{
		level.agentclasses = [];
	}

	level.agentclasses[param_01] = param_00;
}

//Function Number: 2
agentclassget(param_00)
{
	return level.agentclasses[param_00];
}

//Function Number: 3
removeksicon(param_00,param_01,param_02)
{
	if(param_02 != 1)
	{
		var_03 = "ks_icon" + common_scripts\utility::tostring(param_02);
		self setclientomnvar(var_03,0);
	}
}

//Function Number: 4
zombies_trigger_use_think()
{
	self endon("death");
	self endon("zombies_make_unusable");
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(!isdefined(self))
		{
			continue;
		}

		self notify("player_used",var_00);
		if(isdefined(self.owner))
		{
			self.owner notify("player_used",var_00);
		}
	}
}

//Function Number: 5
zombies_make_usable(param_00,param_01)
{
	zombies_make_unusable();
	self.trigger = spawn("script_model",self.origin);
	self.trigger.owner = self;
	self.trigger setmodel("tag_origin");
	if(isdefined(param_01))
	{
		self.trigger.origin = self.trigger.origin + param_01;
	}

	self.trigger linkto(self);
	self.trigger makeusable();
	self.trigger sethintstring(param_00);
	self.trigger thread zombies_trigger_use_think();
}

//Function Number: 6
zombies_make_unusable()
{
	self notify("zombies_make_unusable");
	if(isdefined(self.trigger))
	{
		self.trigger notify("zombies_make_unusable");
		self.trigger delete();
	}

	self.trigger = undefined;
}

//Function Number: 7
zombies_make_objective(param_00)
{
	zombies_make_nonobjective();
	self.objid = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(self.objid,"invisible",(0,0,0));
	objective_position(self.objid,self.origin);
	objective_state(self.objid,"active");
	objective_icon(self.objid,param_00);
	objective_team(self.objid,"allies");
	objective_onentity(self.objid,self);
}

//Function Number: 8
zombies_make_nonobjective()
{
	if(isdefined(self.objid))
	{
		maps\mp\_utility::_objective_delete(self.objid);
		self.objid = undefined;
	}
}

//Function Number: 9
get_character_count(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.characters)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(isdefined(var_03.agent_type) && var_03.agent_type == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 10
getnumplayers()
{
	var_00 = 0;
	if(!isdefined(level.players))
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		if(isonhumanteam(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 11
isonhumanteam(param_00)
{
	if(isdefined(param_00.team))
	{
		return param_00.team == level.playerteam;
	}

	return 0;
}

//Function Number: 12
isonhumanteamorspectator(param_00)
{
	if(isdefined(param_00.team))
	{
		if(param_00.team == level.playerteam || param_00.team == "spectator")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
iszombieequipment(param_00)
{
	return iszombielethal(param_00) || iszombietactical(param_00);
}

//Function Number: 14
iszombielethal(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "contact_grenade_throw_zombies_mp":
		case "contact_grenade_zombies_mp":
		case "frag_grenade_zombies_mp":
		case "frag_grenade_throw_zombies_mp":
			var_01 = 1;
			break;
	}

	return var_01;
}

//Function Number: 15
iszombietactical(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "teleport_throw_zombies_mp":
		case "dna_aoe_grenade_zombie_mp":
		case "distraction_drone_throw_zombie_mp":
		case "distraction_drone_zombie_mp":
		case "explosive_drone_throw_zombie_mp":
		case "explosive_drone_zombie_mp":
		case "dna_aoe_grenade_throw_zombie_mp":
		case "teleport_zombies_mp":
		case "repulsor_zombie_mp":
			var_01 = 1;
			break;
	}

	return var_01;
}

//Function Number: 16
iszombiedistractiondrone(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "distraction_drone_throw_zombie_mp":
		case "distraction_drone_zombie_mp":
			var_01 = 1;
			break;
	}

	return var_01;
}

//Function Number: 17
iszombiednagrenade(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "dna_aoe_grenade_zombie_mp":
		case "dna_aoe_grenade_throw_zombie_mp":
			var_01 = 1;
			break;
	}

	return var_01;
}

//Function Number: 18
playerhasweapon(param_00,param_01)
{
	if(iszombieequipment(param_01))
	{
		var_02 = getzombieequipmentalternatename(param_01);
		return param_00 hasweapon(param_01) || param_00 hasweapon(var_02);
	}

	return param_01 hasweapon(var_02);
}

//Function Number: 19
getzombieequipmentalternatename(param_00)
{
	var_01 = getpreexoequipment(param_00);
	if(!isdefined(var_01))
	{
		var_01 = getpostexoequipmentname(param_00);
	}

	return var_01;
}

//Function Number: 20
getpreexoequipment(param_00)
{
	switch(param_00)
	{
		case "frag_grenade_zombies_mp":
			return "frag_grenade_throw_zombies_mp";

		case "contact_grenade_zombies_mp":
			return "contact_grenade_throw_zombies_mp";

		case "explosive_drone_zombie_mp":
			return "explosive_drone_throw_zombie_mp";

		case "distraction_drone_zombie_mp":
			return "distraction_drone_throw_zombie_mp";

		case "dna_aoe_grenade_zombie_mp":
			return "dna_aoe_grenade_throw_zombie_mp";

		case "teleport_zombies_mp":
			return "teleport_throw_zombies_mp";

		default:
			break;
	}

	return undefined;
}

//Function Number: 21
getpostexoequipmentname(param_00)
{
	switch(param_00)
	{
		case "frag_grenade_throw_zombies_mp":
			return "frag_grenade_zombies_mp";

		case "contact_grenade_throw_zombies_mp":
			return "contact_grenade_zombies_mp";

		case "explosive_drone_throw_zombie_mp":
			return "explosive_drone_zombie_mp";

		case "distraction_drone_throw_zombie_mp":
			return "distraction_drone_zombie_mp";

		case "dna_aoe_grenade_throw_zombie_mp":
			return "dna_aoe_grenade_zombie_mp";

		case "teleport_throw_zombies_mp":
			return "teleport_zombies_mp";

		default:
			break;
	}

	return undefined;
}

//Function Number: 22
iszombiekillstreakweapon(param_00)
{
	switch(param_00)
	{
		case "iw5_exominigunzm_mp":
		case "killstreak_uav_mp":
		case "airdrop_sentry_marker_mp":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 23
getplayerweaponzombies(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(isdefined(param_00.changingweapon))
	{
		var_01 = param_00.changingweapon;
	}

	if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_01))
	{
		var_01 = param_00 common_scripts\utility::getlastweapon();
	}

	if(!param_00 hasweapon(var_01))
	{
		var_02 = param_00 getweaponslistprimaries();
		if(var_02.size > 0)
		{
			var_01 = var_02[0];
		}
	}

	return var_01;
}

//Function Number: 24
getzombieweaponlevel(param_00,param_01)
{
	var_02 = getweaponbasename(param_01);
	if(!haszombieweaponstate(param_00,var_02))
	{
		return 0;
	}

	return param_00.weaponstate[var_02]["level"];
}

//Function Number: 25
haszombieweaponstate(param_00,param_01)
{
	return isdefined(param_01) && isdefined(param_00.weaponstate[param_01]);
}

//Function Number: 26
requestzombieagent(param_00,param_01)
{
	var_02 = undefined;
	for(;;)
	{
		var_02 = maps\mp\agents\_agent_common::connectnewagent(param_00,param_01);
		if(isdefined(var_02))
		{
			break;
		}

		wait(0.1);
	}

	return var_02;
}

//Function Number: 27
spawnbotagent(param_00,param_01,param_02)
{
	if(!isdefined(param_00.angles))
	{
		param_00.angles = (0,0,0);
	}

	var_03 = requestzombieagent(param_01.agent_type,param_02);
	var_03 maps\mp\agents\_agents::spawn_agent_player(param_00.origin,param_00.angles);
	return var_03;
}

//Function Number: 28
onspawnscriptagenthumanoid(param_00,param_01,param_02)
{
	maps\mp\agents\humanoid\_humanoid::spawn_humanoid(self.animclass,param_00,param_01,param_02);
}

//Function Number: 29
spawnscriptagent(param_00,param_01,param_02)
{
	if(!isdefined(param_00.angles))
	{
		param_00.angles = (0,0,0);
	}

	var_03 = requestzombieagent(param_01.agent_type,param_02);
	var_03.animclass = undefined;
	if(isdefined(param_01.animclass))
	{
		var_03.animclass = param_01.animclass;
	}

	var_03 thread [[ var_03 maps\mp\agents\_agent_utility::agentfunc("spawn") ]](param_00.origin,param_00.angles);
	if(isdefined(param_00.script_animation))
	{
		if(isdefined(level.spawnanimationnotetrackhandlerassigner))
		{
			var_04 = var_03 [[ level.spawnanimationnotetrackhandlerassigner ]](param_00);
		}
		else
		{
			var_04 = undefined;
		}

		var_05 = isdefined(param_00.script_ghettotag) && param_00.script_ghettotag == "ignoreRealign";
		var_03 thread maps\mp\agents\humanoid\_humanoid_util::scriptedanimation(param_00.origin,param_00.angles,param_00.script_animation,1,var_04,var_05);
	}

	if(isdefined(var_03) && isdefined(param_01))
	{
		var_03 detachall();
		var_03.headmodel = undefined;
		if(isdefined(level.assignzombiemeshoverridefunc) && var_03 [[ level.assignzombiemeshoverridefunc ]]())
		{
			return var_03;
		}

		if(isdefined(param_01.model_bodies))
		{
			var_06 = randomint(param_01.model_bodies.size);
			var_07 = common_scripts\utility::random(param_01.model_bodies[var_06]);
			var_03 setmodel(var_07);
			if(isdefined(param_01.model_heads))
			{
				var_03.headmodel = common_scripts\utility::random(param_01.model_heads[var_06]);
				var_03 attach(var_03.headmodel);
			}

			if(isdefined(param_01.model_limbs))
			{
				var_03 attachlimb("right_leg",param_01.model_limbs[var_06]);
				var_03 attachlimb("left_leg",param_01.model_limbs[var_06]);
				var_03 attachlimb("right_arm",param_01.model_limbs[var_06]);
				var_03 attachlimb("left_arm",param_01.model_limbs[var_06]);
			}
		}
	}

	return var_03;
}

//Function Number: 30
attachlimb(param_00,param_01)
{
	self.limbmodels[param_00] = common_scripts\utility::random(param_01[param_00]);
	self attach(self.limbmodels[param_00]);
}

//Function Number: 31
countlimbs(param_00)
{
	var_01 = 0;
	while(param_00 > 0)
	{
		var_01++;
		param_00 = param_00 - param_00 & 0 - param_00;
	}

	return var_01;
}

//Function Number: 32
getdismembersoundname()
{
	if(checkactivemutator("exo"))
	{
		return "dismemberExoSound";
	}

	return "dismemberSound";
}

//Function Number: 33
onscriptagentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.isactive = 0;
	self.hasdied = 0;
	if(isdefined(self.animcbs.onexit[self.aistate]))
	{
		self [[ self.animcbs.onexit[self.aistate] ]]();
	}

	var_09 = undefined;
	if(isdefined(self.deathanimstateoverride))
	{
		var_09 = self.deathanimstateoverride;
	}
	else if(self.species == "dog")
	{
		if(param_03 == "MOD_MELEE" && isdefined(param_01) && isplayer(param_01) && param_01 ishighjumpallowed())
		{
			var_0A = vectornormalize(param_01.origin - self.origin);
			var_0B = anglestoforward(self.angles);
			var_0C = anglestoright(self.angles);
			var_0D = vectordot(var_0A,var_0B);
			var_0E = vectordot(var_0A,var_0C);
			if(abs(var_0D) >= abs(var_0E))
			{
				if(var_0D >= 0)
				{
					var_09 = "death_melee_exo_front";
				}
				else
				{
					var_09 = "death_melee_exo_back";
				}
			}
			else if(var_0E >= 0)
			{
				var_09 = "death_melee_exo_left";
			}
			else
			{
				var_09 = "death_melee_exo_right";
			}
		}
		else
		{
			var_09 = "death";
		}
	}
	else if(param_03 == "MOD_MELEE")
	{
		if(isdefined(param_01) && isplayer(param_01) && param_01 ishighjumpallowed())
		{
			var_0A = vectornormalize(param_01.origin - self.origin);
			var_0B = anglestoforward(self.angles);
			var_0C = anglestoright(self.angles);
			var_0D = vectordot(var_0A,var_0B);
			var_0E = vectordot(var_0A,var_0C);
			if(abs(var_0D) >= abs(var_0E))
			{
				if(var_0D >= 0)
				{
					var_09 = "death_melee_exo_front";
				}
				else
				{
					var_09 = "death_melee_exo_back";
				}
			}
			else if(var_0E >= 0)
			{
				var_09 = "death_melee_exo_left";
			}
			else
			{
				var_09 = "death_melee_exo_right";
			}
		}
		else
		{
			var_09 = "death_melee_knife";
		}
	}
	else if(maps\mp\zombies\_mutators::isfullbodymutilation())
	{
		if(self.movemode == "run" || self.movemode == "sprint")
		{
			var_09 = "death_full_body_run";
		}
		else
		{
			var_09 = "death_full_body_stand";
		}
	}
	else if(self.aistate == "idle" || self.aistate == "melee")
	{
		var_09 = "death_stand";
	}
	else
	{
		var_09 = "death_" + self.movemode;
	}

	if(isdefined(self.traversalvector))
	{
		moveawayfromtraversalsurface();
	}

	self scragentsetphysicsmode("gravity");
	var_0F = randomint(self getanimentrycount(var_09));
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_09,var_0F);
	var_10 = self getanimentry(var_09,var_0F);
	var_11 = getdeathanimduration(var_10);
	if(isdefined(self.precloneswapfunc))
	{
		[[ self.precloneswapfunc ]]();
	}

	if(isdefined(param_04) && param_04 == "zombie_vaporize_mp" && common_scripts\utility::fxexists("zombie_death_vaporize"))
	{
		self.bypasscorpse = 1;
		playfx(common_scripts\utility::getfx("zombie_death_vaporize"),self.origin + (0,0,30));
	}

	if(!isdefined(self.bypasscorpse) || !self.bypasscorpse)
	{
		self.body = self finishagentdamage(var_11);
		if(doimmediateragdollviaweapon(param_04,param_03,param_01))
		{
			self.ragdollimmediately = 1;
		}

		var_12 = getragdollwaittime(var_11 * 0.001);
		thread handleragdoll(self.body,var_12,var_10);
	}

	maps\mp\agents\_agent_utility::deactivateagent();
	self notify("killanimscript");
}

//Function Number: 34
doimmediateragdollviaweapon(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		if(param_00 == "repulsor_zombie_mp" || param_00 == "zombie_water_trap_mp")
		{
			return 1;
		}
		else if(param_00 == "iw5_exominigunzm_mp" && isdefined(param_01) && param_01 == "MOD_MELEE_ALT")
		{
			level thread delayphysicsexplosionragdoll(self,param_02);
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
delayphysicsexplosionragdoll(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_02 = param_01.origin + (0,0,30);
	wait(0.1);
	physicsexplosionsphere(var_02,100,0,10,0);
}

//Function Number: 36
shouldimmediateragdoll()
{
	if(maps\mp\zombies\_mutators::isfullbodymutilation())
	{
		return 1;
	}

	if(!self isonground() || is_true(self.inairforleap))
	{
		return 1;
	}

	if(is_true(self.neverimmediatelyragdoll))
	{
		return 0;
	}

	if(isdefined(self.ragdollimmediately) && self.ragdollimmediately)
	{
		return 1;
	}

	return self.aistate == "traverse" || self.aistate == "scripted";
}

//Function Number: 37
canragdoll(param_00)
{
	if(is_true(self.noragdollondeath))
	{
		return 0;
	}

	var_01 = getanimlength(param_00);
	var_02 = getnotetracktimes(param_00,"ignore_ragdoll");
	return var_02.size == 0;
}

//Function Number: 38
moveawayfromtraversalsurface()
{
	var_00 = 20;
	var_01 = vectortoangles(self.traversalvector);
	var_02 = anglestoup(var_01);
	var_03 = self.origin + var_02 * var_00;
	self setorigin(var_03);
}

//Function Number: 39
getdeathanimduration(param_00)
{
	var_01 = getanimlength(param_00);
	var_02 = getnotetracktimes(param_00,"start_ragdoll");
	if(var_02.size > 0)
	{
		var_01 = var_01 * var_02[0];
	}
	else
	{
		var_01 = var_01 * 0.5;
	}

	var_03 = int(var_01 * 1000);
	return var_03;
}

//Function Number: 40
handleragdoll(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!canragdoll(param_02))
	{
		return;
	}

	if(shouldimmediateragdoll())
	{
		param_00 startragdoll();
		if(param_00 isragdoll())
		{
			return;
		}
	}

	wait(param_01);
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 startragdoll();
	if(param_00 isragdoll())
	{
		return;
	}

	var_03 = getanimlength(param_02);
	if(var_03 > param_01)
	{
		wait(var_03 - param_01);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 startragdoll();
	}

	if(!param_00 isragdoll())
	{
		param_00 delete();
	}
}

//Function Number: 41
getragdollwaittime(param_00)
{
	var_01 = 0.2;
	if(self.aistate == "traverse" || self.aistate == "scripted")
	{
		return var_01;
	}

	return param_00;
}

//Function Number: 42
waitforbadpath()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bad_path");
		self.bhasnopath = 1;
		if(isdefined(self.distractiondrone))
		{
			self.distractiondronebadpathcount++;
		}
	}
}

//Function Number: 43
shouldignoreent(param_00)
{
	if(isplayerinlaststand(param_00))
	{
		return 1;
	}

	if(isplayerteleporting(param_00))
	{
		return 1;
	}

	if(is_true(param_00.zombiesignoreme) && !is_true(self.ignorescamouflage))
	{
		return 1;
	}

	if(isdefined(level.shouldignoreplayercallback))
	{
		if([[ level.shouldignoreplayercallback ]](param_00))
		{
			return 1;
		}
	}

	if(is_true(param_00.iszomboni) && istrapresistant())
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
checkexpiretime(param_00,param_01,param_02)
{
	if(isdefined(self.ignoreexpiretime) && self.ignoreexpiretime)
	{
		return 0;
	}

	var_03 = gettime() - param_00 / 1000;
	if(var_03 > param_01)
	{
		if(var_03 > param_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 45
locateenemypositions()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.participants)
		{
			if(isonhumanteam(var_01))
			{
				self getenemyinfo(var_01);
			}
		}

		wait(0.5);
	}
}

//Function Number: 46
agentemptythink()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self scragentsetgoalpos(self.origin);
		wait(0.5);
	}
}

//Function Number: 47
onaiconnect()
{
	self.agentname = &"ZOMBIES_EMPTY_STRING";
}

//Function Number: 48
zombiewaitingfordeath()
{
	return isdefined(self.throttledeath);
}

//Function Number: 49
zombieshouldwaitfordeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(param_02 < self.maxhealth)
	{
		return 0;
	}

	if(!isdefined(level.zmdeaththrottlenetworkframe) || level.zmdeaththrottlenetworkframe != getnetworkframe())
	{
		level.zmdeaththrottlenetworkframe = getnetworkframe();
		level.zmdeaththrottlecount = 0;
	}

	if(!isdefined(level.zmdeaththrottlequeue))
	{
		level.zmdeaththrottlequeue = 0;
	}

	if(isdefined(self.throttledeathready))
	{
		self.throttledeathready = undefined;
		return 0;
	}
	else if(level.zmdeaththrottlequeue + level.zmdeaththrottlecount + 1 > 4)
	{
		return 1;
	}

	level.zmdeaththrottlecount++;
	return 0;
}

//Function Number: 50
zombiehandlesuicide()
{
	self endon("processDelayDeath");
	self waittill("death");
	level.zmdeaththrottlequeue--;
}

//Function Number: 51
zombiedelaydeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	level.zmdeaththrottlequeue++;
	self.throttledeath = getnetworkframe() + int(ceil(level.zmdeaththrottlequeue / 4));
	thread zombiehandlesuicide();
	while(getnetworkframe() < self.throttledeath)
	{
		waitnetworkframe();
	}

	if(level.zmdeaththrottlenetworkframe != getnetworkframe())
	{
		level.zmdeaththrottlenetworkframe = getnetworkframe();
		level.zmdeaththrottlecount = 0;
	}

	self.throttledeath = undefined;
	self.throttledeathready = 1;
	level.zmdeaththrottlequeue--;
	level.zmdeaththrottlecount++;
	self notify("processDelayDeath");
	self dodamage(param_02,param_05,param_01,undefined,param_03,param_04);
}

//Function Number: 52
candie()
{
	if(gettime() - self.spawntime <= 0.05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 53
ispendingdeath(param_00)
{
	return isdefined(self.pendingdeath) && self.pendingdeath;
}

//Function Number: 54
zombiependingdeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self notify("zombiePendingDeath");
	self endon("zombiePendingDeath");
	while(isdefined(self) && isalive(self))
	{
		self.pendingdeath = 1;
		if(!candie())
		{
			wait(0.05);
			continue;
		}

		self.pendingdeath = 0;
		maps\mp\zombies\_zombies::onzombiedamagefinished(param_00,param_01,self.health + 1,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
}

//Function Number: 55
enemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.lastenemydeathpos = self.origin;
	level thread maps\mp\gametypes\zombies::chancetospawnpickup(param_01,self,param_03,param_04);
	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 thread maps\mp\zombies\_zombies_audio::player_kill_zombie(param_06,param_03,param_04,self);
		if(!level.gameended)
		{
			param_01 maps\mp\_utility::incplayerstat("kills",1);
			param_01 maps\mp\_utility::incpersstat("kills",1);
			param_01.kills = param_01 maps\mp\_utility::getpersstat("kills");
			param_01 maps\mp\gametypes\_persistence::statsetchild("round","kills",param_01.kills);
		}
	}

	if(isdefined(param_01))
	{
		param_01 notify("killed_enemy");
	}

	if(isdefined(level.processenemykilledfunc))
	{
		self thread [[ level.processenemykilledfunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}
}

//Function Number: 56
isinstakill()
{
	var_00 = maps\mp\_utility::gameflag("insta_kill");
	return var_00;
}

//Function Number: 57
isplayerinlaststand(param_00)
{
	return isdefined(param_00.laststand) && param_00.laststand;
}

//Function Number: 58
isplayerteleporting(param_00)
{
	return isdefined(param_00.inteleport) && param_00.inteleport;
}

//Function Number: 59
isplayerinfected(param_00)
{
	return isdefined(param_00.infected) && param_00.infected;
}

//Function Number: 60
anyplayerinfected()
{
	foreach(var_01 in level.players)
	{
		if(isplayerinfected(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 61
iscrategodmode(param_00)
{
	return isdefined(param_00.crategodmode) && param_00.crategodmode;
}

//Function Number: 62
setallignoreme(param_00)
{
	if(param_00)
	{
		self.ignoreme = 1;
		if(!isdefined(self.ignoremecount) || self.ignoremecount < 0)
		{
			self.ignoremecount = 0;
		}

		self.ignoremecount++;
		return;
	}

	if(isdefined(self.ignoremecount) && self.ignoremecount > 0)
	{
		self.ignoremecount--;
		if(self.ignoremecount > 0)
		{
			return;
		}

		self.ignoreme = 0;
	}
}

//Function Number: 63
setzombiesignoreme(param_00)
{
	if(param_00)
	{
		self.zombiesignoreme = 1;
		if(!isdefined(self.zombiesignoremecount) || self.zombiesignoremecount < 0)
		{
			self.zombiesignoremecount = 0;
		}

		self.zombiesignoremecount++;
		return;
	}

	if(isdefined(self.zombiesignoremecount) && self.zombiesignoremecount > 0)
	{
		self.zombiesignoremecount--;
		if(self.zombiesignoremecount > 0)
		{
			return;
		}

		self.zombiesignoreme = 0;
	}
}

//Function Number: 64
isspecialround(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.wavecounter;
	}

	if(param_00 == level.specialroundnumber)
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
civiliansareenabled()
{
	return isdefined(level.zombies_using_civilians) && level.zombies_using_civilians;
}

//Function Number: 66
allowextendedsprint(param_00)
{
	var_01 = "specialty_longersprint";
	if(param_00)
	{
		maps\mp\_utility::giveperk(var_01,0);
		return;
	}

	if(maps\mp\_utility::_hasperk(var_01))
	{
		maps\mp\_utility::_unsetperk(var_01);
	}
}

//Function Number: 67
playerallowextendedsprint(param_00,param_01)
{
	maps\mp\_utility::_playerallow("extendedSprint",param_00,param_01,::allowextendedsprint,0);
}

//Function Number: 68
allowlightweight(param_00)
{
	var_01 = "specialty_lightweight";
	if(param_00)
	{
		maps\mp\_utility::giveperk(var_01,0);
		return;
	}

	if(maps\mp\_utility::_hasperk(var_01))
	{
		maps\mp\_utility::_unsetperk(var_01);
	}
}

//Function Number: 69
playerallowlightweight(param_00,param_01)
{
	maps\mp\_utility::_playerallow("lightweight",param_00,param_01,::allowlightweight,0);
}

//Function Number: 70
zombieallowallboost(param_00,param_01)
{
	maps\mp\_utility::playerallowdodge(param_00,param_01);
	maps\mp\_utility::playerallowpowerslide(param_00,param_01);
	maps\mp\_utility::playerallowhighjump(param_00,param_01);
	playerallowextendedsprint(param_00,param_01);
	playerallowlightweight(param_00,param_01);
}

//Function Number: 71
creditstotokens(param_00)
{
	if(!param_00)
	{
		return 0;
	}

	if(param_00 <= 100)
	{
		return 1;
	}

	if(param_00 <= 500)
	{
		return 5;
	}

	if(param_00 <= 1000)
	{
		return 10;
	}

	if(param_00 <= 1500)
	{
		return 15;
	}

	if(param_00 <= 2000)
	{
		return 20;
	}

	return 25;
}

//Function Number: 72
gettokencoststring(param_00)
{
	switch(param_00)
	{
		case 0:
			return &"ZOMBIES_EMPTY_STRING";

		case 1:
			return &"ZOMBIES_USE_TOKEN";

		case 5:
			return &"ZOMBIES_USE_TOKEN_5";

		case 10:
			return &"ZOMBIES_USE_TOKEN_10";

		case 15:
			return &"ZOMBIES_USE_TOKEN_15";

		case 20:
			return &"ZOMBIES_USE_TOKEN_20";

		case 25:
			return &"ZOMBIES_USE_TOKEN_25";

		default:
			return "NEED TOKEN STRING FOR " + param_00 + " TOKENS.";
	}
}

//Function Number: 73
getcoststring(param_00)
{
	switch(param_00)
	{
		case 0:
			return &"ZOMBIES_EMPTY_STRING";

		case 100:
			return &"ZOMBIES_COST_100";

		case 200:
			return &"ZOMBIES_COST_200";

		case 250:
			return &"ZOMBIES_COST_250";

		case 300:
			return &"ZOMBIES_COST_300";

		case 400:
			return &"ZOMBIES_COST_400";

		case 500:
			return &"ZOMBIES_COST_500";

		case 600:
			return &"ZOMBIES_COST_600";

		case 700:
			return &"ZOMBIES_COST_700";

		case 750:
			return &"ZOMBIES_COST_750";

		case 800:
			return &"ZOMBIES_COST_800";

		case 900:
			return &"ZOMBIES_COST_900";

		case 1000:
			return &"ZOMBIES_COST_1000";

		case 1250:
			return &"ZOMBIES_COST_1250";

		case 1500:
			return &"ZOMBIES_COST_1500";

		case 1750:
			return &"ZOMBIES_COST_1750";

		case 2000:
			return &"ZOMBIES_COST_2000";

		case 2500:
			return &"ZOMBIES_COST_2500";

		case 3000:
			return &"ZOMBIES_COST_3000";

		case 4000:
			return &"ZOMBIES_COST_4000";

		case 5000:
			return &"ZOMBIES_COST_5000";

		default:
			return "NEED HINT STRING FOR $" + param_00 + ".";
	}
}

//Function Number: 74
getreducedcost(param_00)
{
	switch(param_00)
	{
		case 0:
			return 0;

		case 100:
			return 0;

		case 200:
			return 100;

		case 250:
			return 100;

		case 300:
			return 200;

		case 400:
			return 200;

		case 500:
			return 250;

		case 600:
			return 300;

		case 700:
			return 300;

		case 750:
			return 300;

		case 800:
			return 400;

		case 900:
			return 400;

		case 1000:
			return 500;

		case 1250:
			return 500;

		case 1500:
			return 750;

		case 1750:
			return 800;

		case 2000:
			return 1000;

		case 2500:
			return 1250;

		case 3000:
			return 1500;

		case 4000:
			return 2000;

		case 5000:
			return 2500;

		default:
			return 500;
	}
}

//Function Number: 75
getincreasedcost(param_00)
{
	switch(param_00)
	{
		case 0:
			return 0;

		case 100:
			return 200;

		case 200:
			return 300;

		case 250:
			return 400;

		case 300:
			return 500;

		case 400:
			return 600;

		case 500:
			return 750;

		case 600:
			return 800;

		case 700:
			return 900;

		case 750:
			return 1000;

		case 800:
			return 1250;

		case 900:
			return 1500;

		case 1000:
			return 1500;

		case 1250:
			return 1750;

		case 1500:
			return 2000;

		case 1750:
			return 2500;

		case 2000:
			return 2500;

		case 2500:
			return 3000;

		case 3000:
			return 4000;

		case 4000:
			return 5000;

		case 5000:
			return 5000;

		default:
			return 1000;
	}
}

//Function Number: 76
zombie_set_eyes(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "tag_eye";
	}

	self.eyefxactive = 1;
	playfxontagnetwork(common_scripts\utility::getfx(param_00),self,param_01);
	thread zombiestopeyeeffectsonnotify(param_00,param_01,"humanoidPendingDeath");
}

//Function Number: 77
zombiestopeyeeffectsonnotify(param_00,param_01,param_02)
{
	self notify("zombieStopEyeEffectsOnNotify");
	self endon("zombieStopEyeEffectsOnNotify");
	self endon("death");
	self waittill(param_02);
	stopfxontagnetwork(common_scripts\utility::getfx(param_00),self,param_01);
}

//Function Number: 78
delete_on_death_of(param_00)
{
	delete_on_notification(param_00,"death");
}

//Function Number: 79
delete_on_notification(param_00,param_01)
{
	self endon("death");
	param_00 waittill(param_01);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 80
isspawnlistreplaceabletype(param_00)
{
	return !isdefined(level.modifyspawnlist[param_00]);
}

//Function Number: 81
array_remove_index(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		if(var_02 == param_01)
		{
			param_00[var_02] = param_00[var_02 + 1];
			param_01++;
		}
	}

	param_00[param_00.size - 1] = undefined;
	return param_00;
}

//Function Number: 82
arrayremoveundefinedkeephash(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isnumber(var_04))
		{
			var_01[var_01.size] = var_03;
			continue;
		}

		var_01[var_04] = var_03;
	}

	return var_01;
}

//Function Number: 83
isgenericzombie(param_00)
{
	if(!isdefined(param_00.agent_type))
	{
		return 0;
	}

	if(param_00.agent_type != "zombie_generic")
	{
		return 0;
	}

	return 1;
}

//Function Number: 84
hasactivemutator(param_00)
{
	return isdefined(param_00.activemutators);
}

//Function Number: 85
checkactivemutator(param_00)
{
	return isdefined(self.activemutators) && isdefined(self.activemutators[param_00]);
}

//Function Number: 86
resetcharacterindex(param_00)
{
	if(!isdefined(level.zmcharacterpool))
	{
		return;
	}

	level.zmcharacterpool[level.zmcharacterpool.size] = param_00;
}

//Function Number: 87
selectcharacterindextouse(param_00)
{
	if(isdefined(level.zmcharacterpool) && level.zmcharacterpool.size == 0)
	{
		return -1;
	}

	if(!isdefined(level.zmcharacterpool))
	{
		level.zmcharacterpool = [];
		level.zmcharacterpool[level.zmcharacterpool.size] = 0;
		level.zmcharacterpool[level.zmcharacterpool.size] = 1;
		level.zmcharacterpool[level.zmcharacterpool.size] = 2;
		level.zmcharacterpool[level.zmcharacterpool.size] = 3;
		level.zmcharacterpool = common_scripts\utility::array_randomize(level.zmcharacterpool);
	}

	if(!isdefined(param_00))
	{
		var_01 = level.zmcharacterpool[level.zmcharacterpool.size - 1];
		level.zmcharacterpool[level.zmcharacterpool.size - 1] = undefined;
		self.characterindex = var_01;
	}
	else
	{
		self.characterindex = param_00;
	}

	return self.characterindex;
}

//Function Number: 88
get_player_index(param_00)
{
	return param_00.characterindex;
}

//Function Number: 89
get_round_enemy_array()
{
	var_00 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.team == level.enemyteam)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 90
is_true(param_00)
{
	return isdefined(param_00) && param_00;
}

//Function Number: 91
set_player_is_female(param_00)
{
	self.isfemale = param_00;
}

//Function Number: 92
get_player_is_female()
{
	return self.isfemale;
}

//Function Number: 93
initializecharactermodel(param_00,param_01,param_02,param_03)
{
	level.characterassets[param_00]["body"] = param_01;
	level.characterassets[param_00]["viewmodel"] = param_02;
	if(isdefined(param_03) && param_03.size > 0)
	{
		level.characterassets[param_00]["attachments"] = param_03;
	}
}

//Function Number: 94
setcharactermodel(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_01) || param_01 == 0)
	{
		self waittill("spawned_player");
	}

	if(!isdefined(level.characterassets[param_00]))
	{
		param_00 = "default";
	}

	self detachall();
	self.charactermodel = level.characterassets[param_00]["body"];
	if(!maps\mp\_utility::isjuggernaut())
	{
		self setmodel(level.characterassets[param_00]["body"]);
	}

	if(isdefined(level.characterassets[param_00]["viewmodel"]))
	{
		self.characterviewmodel = level.characterassets[param_00]["viewmodel"];
		if(!maps\mp\_utility::isjuggernaut())
		{
			self setviewmodel(level.characterassets[param_00]["viewmodel"]);
		}
	}

	if(isdefined(level.characterassets[param_00]["attachments"]))
	{
		foreach(var_04 in level.characterassets[param_00]["attachments"])
		{
			if(issubstr(var_04,"head"))
			{
				self.characterhead = var_04;
			}

			if(!maps\mp\_utility::isjuggernaut())
			{
				self attach(var_04,"",1);
			}
		}
	}
}

//Function Number: 95
givecustomcharactersdefault(param_00)
{
	var_02 = selectcharacterindextouse(param_00);
	var_03 = 1;
	if(var_02 == -1)
	{
		var_03 = 0;
		var_02 = 0;
		self.characterindex = 0;
	}

	if(var_03)
	{
		var_01 = "ui_zm_character_" + var_02;
		setomnvar(var_01,self getentitynumber());
		var_04 = "ui_zm_character_" + var_02 + "_alive";
		setomnvar(var_04,0);
		thread resetcharacterondisconnect(var_01,var_04,var_02);
	}

	setcustomcharacter(var_02,0);
	setcharacteraudio(var_02);
}

//Function Number: 96
setcharacteraudio(param_00,param_01)
{
	self.favorite_wall_weapons_list = [];
	switch(param_00)
	{
		case 0:
			level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player","guard_",self,self.characterindex);
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_maulzm";
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_mp11zm";
			maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
			break;

		case 1:
			level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player","exec_",self,self.characterindex);
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_uts19zm";
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_m182sprzm";
			maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
			break;

		case 2:
			level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player","it_",self,self.characterindex);
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_hbra3zm";
			self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_hmr9zm";
			maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
			break;

		case 3:
			if(getzombieslevelnum() < 3 || is_true(param_01))
			{
				level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player","janitor_",self,self.characterindex);
				self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_maulzm";
				self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_arx160zm";
				maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
			}
			else
			{
				level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("player","pilot_",self,self.characterindex);
				self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_mp11zm";
				self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = "iw5_arx160zm";
				maps\mp\gametypes\_battlechatter_mp::disablebattlechatter(self);
			}
			break;
	}
}

//Function Number: 97
setcustomcharacter(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	switch(param_00)
	{
		case 0:
			var_03 = "security";
			break;

		case 1:
			var_03 = "exec";
			break;

		case 2:
			var_03 = "it";
			var_04 = 1;
			break;

		case 3:
			if(getzombieslevelnum() < 3)
			{
				var_03 = "janitor";
			}
			else
			{
				var_03 = "pilot";
			}
			break;
	}

	if(isdefined(var_03))
	{
		thread setcharactermodel(var_03,param_01,param_02);
		set_player_is_female(var_04);
	}
}

//Function Number: 98
resetcharacterondisconnect(param_00,param_01,param_02)
{
	self waittill("disconnect");
	setomnvar(param_00,-1);
	setomnvar(param_01,0);
	resetcharacterindex(param_02);
}

//Function Number: 99
flag_link(param_00,param_01)
{
	level thread _flag_link(param_00,param_01);
}

//Function Number: 100
_flag_link(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_00);
	common_scripts\utility::flag_set(param_01);
}

//Function Number: 101
lerp(param_00,param_01,param_02)
{
	var_03 = param_02 - param_01;
	var_04 = param_00 * var_03;
	var_05 = param_01 + var_04;
	return var_05;
}

//Function Number: 102
getnetworkframe()
{
	return int(gettime() / 100);
}

//Function Number: 103
waitnetworkframe()
{
	wait 0.05;
	wait 0.05;
}

//Function Number: 104
playfxontagnetwork(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	thread _playfxontagnetworkinternal(param_00,param_01,param_02,param_03);
}

//Function Number: 105
_playfxontagnetworkinternal(param_00,param_01,param_02,param_03)
{
	param_01 endon("death");
	param_01 notify("StopFxOnTagNetwork_" + param_00 + param_02);
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	_waittillcandofxevent(param_01);
	if(!isdefined(param_01))
	{
		return;
	}

	playfxontag(param_00,param_01,param_02);
	if(!param_03)
	{
		param_01 _entitytrackfx(param_00,param_02,0);
	}

	param_01 _entityincrementeventcount();
}

//Function Number: 106
playfxontagforclientnetwork(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		return;
	}

	thread _playfxontagnetworkforclientinternal(param_00,param_01,param_02,param_03);
}

//Function Number: 107
_playfxontagnetworkforclientinternal(param_00,param_01,param_02,param_03)
{
	param_01 endon("death");
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	_waittillcandofxevent(param_01);
	playfxontagforclients(param_00,param_01,param_02,param_03);
	param_01 _entityincrementeventcount();
}

//Function Number: 108
stopfxontagforclientnetwork(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		return;
	}

	thread _stopfxontagnetworkforclientinternal(param_00,param_01,param_02,param_03);
}

//Function Number: 109
_stopfxontagnetworkforclientinternal(param_00,param_01,param_02,param_03)
{
	param_01 endon("death");
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	_waittillcandofxevent(param_01);
	stopfxontagforclient(param_00,param_01,param_02,param_03);
	param_01 _entityincrementeventcount();
}

//Function Number: 110
stopfxontagnetwork(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	thread _stopfxontagnetworkinternal(param_00,param_01,param_02);
}

//Function Number: 111
_stopfxontagnetworkinternal(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 notify("StopFxOnTagNetwork_" + param_00 + param_02);
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	_waittillcandofxevent(param_01);
	stopfxontag(param_00,param_01,param_02);
	param_01 _entitytrackfx(param_00,param_02,1);
	param_01 _entityincrementeventcount();
}

//Function Number: 112
killfxontagnetwork(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	_killfxontagnetworkinternal(param_00,param_01,param_02);
}

//Function Number: 113
_killfxontagnetworkinternal(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 notify("StopFxOnTagNetwork_" + param_00 + param_02);
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	_waittillcandofxevent(param_01);
	killfxontag(param_00,param_01,param_02);
	param_01 _entitytrackfx(param_00,param_02,1);
	param_01 _entityincrementeventcount();
}

//Function Number: 114
_waittillcandofxevent(param_00)
{
	var_01 = 0;
	if(!isdefined(param_00.trackedfxdata))
	{
		param_00 _entitysetupplayfxnetworkstatus();
	}
	else if(getnetworkframe() > param_00.trackedfxdata.networkframe)
	{
		param_00 _entityresetplayfxnetworkstatus();
	}

	while(param_00.trackedfxdata.count >= level.network_max_events || isdefined(param_00.birthtime) && param_00.birthtime == gettime())
	{
		waitnetworkframe();
		var_01 = 1;
		if(!isdefined(param_00))
		{
			return var_01;
		}

		if(!isdefined(param_00.trackedfxdata))
		{
			param_00 _entitysetupplayfxnetworkstatus();
		}

		if(getnetworkframe() > param_00.trackedfxdata.networkframe)
		{
			param_00 _entityresetplayfxnetworkstatus();
		}
	}

	return var_01;
}

//Function Number: 115
_entitysetupplayfxnetworkstatus()
{
	self.trackedfx = [];
	self.trackedfxdata = spawnstruct();
	_entityresetplayfxnetworkstatus();
}

//Function Number: 116
_entityresetplayfxnetworkstatus()
{
	self.trackedfxdata.count = 0;
	self.trackedfxdata.networkframe = getnetworkframe();
}

//Function Number: 117
_entityincrementeventcount()
{
	self.trackedfxdata.count++;
}

//Function Number: 118
_entitytrackfx(param_00,param_01,param_02)
{
	if(!isdefined(level.entswithfx[self getentitynumber()]))
	{
		level.entswithfx[self getentitynumber()] = self;
	}

	var_03 = 0;
	foreach(var_05 in self.trackedfx)
	{
		if(var_05.id == param_00 && var_05.tagname == param_01 && var_05.stop == param_02)
		{
			var_03 = 1;
			break;
		}
	}

	if(!var_03)
	{
		var_07 = spawnstruct();
		var_07.id = param_00;
		var_07.tagname = param_01;
		var_07.stop = param_02;
		self.trackedfx[self.trackedfx.size] = var_07;
		if(!param_02)
		{
			thread _entitywatchforstopeffect(var_07);
		}
	}
}

//Function Number: 119
_entitywatchforstopeffect(param_00)
{
	self endon("death");
	thread _entitystoptrackingondeath();
	self waittill("StopFxOnTagNetwork_" + param_00.id + param_00.tagname);
	self.trackedfx = common_scripts\utility::array_remove(self.trackedfx,param_00);
}

//Function Number: 120
_entitystoptrackingondeath()
{
	self notify("_entityKillFXOnDeath");
	self endon("_entityKillFXOnDeath");
	var_00 = self getentitynumber();
	self waittill("death");
	level.entswithfx[var_00] = undefined;
	if(isdefined(self))
	{
		self.trackedfx = undefined;
		self.trackedfxdata = undefined;
	}
}

//Function Number: 121
startfxforlatejoiner(param_00)
{
	param_00 endon("disconnect");
	if(param_00 maps\mp\gametypes\_playerlogic::mayspawn())
	{
		param_00 waittill("spawned_player");
	}
	else
	{
		param_00 waittill("joined_spectators");
	}

	waittillplayersnextsnapshot(param_00);
	if(is_true(param_00.laterjoinereffects))
	{
		return;
	}

	param_00.laterjoinereffects = 1;
	foreach(var_02 in level.entswithfx)
	{
		thread startfxforlatejoineronent(param_00,var_02);
	}
}

//Function Number: 122
startfxforlatejoineronent(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("death");
	if(!isdefined(param_01) || !isdefined(param_01.trackedfx))
	{
		return;
	}

	var_02 = [];
	var_03 = param_01.trackedfx.size;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = param_01.trackedfx[var_04];
		stopfxontagforclientnetwork(var_05.id,param_01,var_05.tagname,param_00);
		if(!var_05.stop)
		{
			var_02[var_02.size] = var_05;
		}
	}

	waittillplayersnextsnapshot(param_00);
	if(!level.nextgen)
	{
		wait(5);
	}

	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(!isdefined(var_05) || !common_scripts\utility::array_contains(param_01.trackedfx,var_05))
		{
			continue;
		}

		playfxontagforclientnetwork(var_05.id,param_01,var_05.tagname,param_00);
	}
}

//Function Number: 123
handlenetworkeffects()
{
	thread onplayerconnectfxlatejoiners();
	thread onhostmigratefx();
}

//Function Number: 124
onplayerconnectfxlatejoiners()
{
	if(!isdefined(level.entswithfx))
	{
		level.entswithfx = [];
	}

	level.network_max_events = 2;
	for(;;)
	{
		level waittill("connected",var_00);
		if(isbot(var_00))
		{
			continue;
		}

		level thread startfxforlatejoiner(var_00);
	}
}

//Function Number: 125
onhostmigratefx()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		foreach(var_01 in level.entswithfx)
		{
			thread startfxforhostmigrationonent(var_01);
		}
	}
}

//Function Number: 126
startfxforhostmigrationonent(param_00)
{
	param_00 endon("death");
	if(!isdefined(param_00) || !isdefined(param_00.trackedfx))
	{
		return;
	}

	waittillframeend;
	var_01 = [];
	var_02 = param_00.trackedfx.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = param_00.trackedfx[var_03];
		stopfxontagnetwork(var_04.id,param_00,var_04.tagname);
		if(!var_04.stop)
		{
			var_01[var_01.size] = var_04;
		}
	}

	level waittill("host_migration_end");
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = var_01[var_03];
		playfxontagnetwork(var_04.id,param_00,var_04.tagname);
	}
}

//Function Number: 127
istrapweapon(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "trap_missile_zm_mp":
			case "trap_zm_mp":
			case "zombie_water_trap_mp":
			case "zombie_vaporize_mp":
			case "zombie_trap_turret_mp":
			case "trap_sniper_zm_mp":
				return 1;

			default:
				return 0;
		}
	}

	return 0;
}

//Function Number: 128
getroundtype(param_00)
{
	switch(param_00)
	{
		case "zombie_dog":
			return 1;

		case "zombie_host":
			return 2;

		case "normal":
		default:
			return 0;
	}
}

//Function Number: 129
waittill_enter_game()
{
	while(!has_entered_game())
	{
		wait(0.05);
	}
}

//Function Number: 130
has_entered_game()
{
	return is_true(self.hastraversed);
}

//Function Number: 131
isusetriggerforsingleclient(param_00)
{
	return isdefined(param_00.script_index);
}

//Function Number: 132
isusetriggerprimary(param_00)
{
	return !isdefined(param_00.script_index) || param_00.script_index == 0;
}

//Function Number: 133
setupusetriggerforclient(param_00,param_01)
{
	if(!isdefined(param_00.script_index))
	{
		return;
	}

	param_00 common_scripts\utility::trigger_off();
	param_00.claimed = 0;
	foreach(var_03 in level.players)
	{
		if(var_03 _playerisassignedtousetrigger(param_00))
		{
			var_03 thread _playerassignusetrigger(param_00,param_01);
			break;
		}
	}

	thread _onplayerconnectedusetriggerassign(param_00,param_01);
}

//Function Number: 134
_onplayerconnectedusetriggerassign(param_00,param_01)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_02);
		if(var_02 _playerisassignedtousetrigger(param_00))
		{
			var_02 _playerassignusetrigger(param_00,param_01);
		}
	}
}

//Function Number: 135
_playerisassignedtousetrigger(param_00)
{
	return isdefined(param_00.script_index) && self getentitynumber() == param_00.script_index;
}

//Function Number: 136
_playerassignusetrigger(param_00,param_01)
{
	self clientclaimtrigger(param_00);
	param_00 common_scripts\utility::trigger_on();
	param_00 notify("claimed");
	param_00.claimed = 1;
	param_00.claimedby = self;
	thread _playerreleaseusetriggerondisconnect(param_00);
	param_00 thread [[ param_01 ]](self);
}

//Function Number: 137
_playerreleaseusetriggerondisconnect(param_00)
{
	param_00 endon("death");
	self waittill("disconnect");
	if(isdefined(self))
	{
		self clientreleasetrigger(param_00);
	}

	param_00 common_scripts\utility::trigger_off();
	param_00.claimed = 0;
}

//Function Number: 138
isrippedturretweapon(param_00)
{
	return param_00 == "turretheadenergy_mp" || param_00 == "turretheadrocket_mp" || param_00 == "turretheadmg_mp";
}

//Function Number: 139
outofboundswatch(param_00)
{
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			if(var_02.sessionstate == "spectator" || var_02.sessionstate == "intermission")
			{
				continue;
			}

			if(var_02 isnoclip())
			{
				continue;
			}

			if(!isalive(var_02))
			{
				continue;
			}

			var_03 = var_02 maps\mp\zombies\_zombies_zone_manager::getplayerzone();
			if(!isdefined(var_03))
			{
				var_04 = !param_00;
				if(var_04)
				{
					var_02.outofbounds = 1;
					var_02 suicide();
				}
				else
				{
					iprintlnbold("Player out of bounds at " + var_02.origin);
					wait(1);
				}
			}
			else
			{
				var_02.outofbounds = undefined;
			}

			if(!param_00)
			{
				wait(0.5);
			}
		}

		wait 0.05;
	}
}

//Function Number: 140
waittillplayersnextsnapshot(param_00)
{
	param_00 endon("disconnect");
	var_01 = param_00 getsnapshotindexforclient();
	if(!isdefined(var_01))
	{
		return;
	}

	for(;;)
	{
		wait 0.05;
		var_02 = param_00 getsnapshotacknowledgedindexforclient();
		if(!isdefined(var_02))
		{
			return;
		}

		if(var_02 >= var_01)
		{
			break;
		}
	}
}

//Function Number: 141
iszombiegamepaused()
{
	if(!isdefined(level.zombiegamepaused))
	{
		return 0;
	}

	return level.zombiegamepaused;
}

//Function Number: 142
waittillzombiegameunpaused()
{
	while(iszombiegamepaused())
	{
		wait 0.05;
	}
}

//Function Number: 143
clearzombiestats(param_00)
{
	if(isdefined(level.dlcleaderboardnumber) && level.dlcleaderboardnumber >= 2 && level.dlcleaderboardnumber <= 4)
	{
		var_01 = "dlc" + level.dlcleaderboardnumber;
		param_00 setcoopplayerdatareservedint(var_01 + "MoneyEarned",0);
		param_00 setcoopplayerdatareservedint(var_01 + "Kills",0);
		param_00 setcoopplayerdatareservedint(var_01 + "Revives",0);
		param_00 setcoopplayerdatareservedint(var_01 + "Rounds",0);
		param_00 setcoopplayerdatareservedint(var_01 + "TimePlayed",0);
		param_00 setcoopplayerdatareservedint(var_01 + "Headshots",0);
		param_00 setcoopplayerdatareservedint(var_01 + "MeleeKills",0);
		if(level.dlcleaderboardnumber == 2)
		{
			param_00 setcoopplayerdatareservedint(var_01 + "Civilians",0);
		}

		if(level.dlcleaderboardnumber == 3)
		{
			param_00 setcoopplayerdatareservedint(var_01 + "Bombs",0);
			return;
		}

		return;
	}

	param_00 setcoopplayerdata("totalRounds",0);
	param_00 setcoopplayerdata("totalKills",0);
	param_00 setcoopplayerdata("totalRevives",0);
	param_00 setcoopplayerdata("totalMoneyEarned",0);
	param_00 setcoopplayerdata("totalMoneySpent",0);
	param_00 setcoopplayerdata("totalMagicBox",0);
	param_00 setcoopplayerdata("totalTraps",0);
	param_00 setcoopplayerdata("totalHeadshots",0);
	param_00 setcoopplayerdata("totalMeleeKills",0);
	param_00 setcoopplayerdatareservedint("totalTimePlayed",0);
}

//Function Number: 144
writezombiestats()
{
	writezombiematchdata();
	foreach(var_01 in level.players)
	{
		writezombieplayerstats(var_01);
	}
}

//Function Number: 145
writezombiematchdata()
{
	foreach(var_01 in level.players)
	{
		setmatchdata("players",var_01.clientid,"startXp",var_01.assists);
		setmatchdata("players",var_01.clientid,"startKills",var_01.kills);
		setmatchdata("players",var_01.clientid,"startWins",var_01.moneyearnedtotal);
		setmatchdata("players",var_01.clientid,"startLosses",var_01.moneyearnedtotal - var_01.moneycurrent);
		setmatchdata("players",var_01.clientid,"startHits",var_01.magicboxuses);
		setmatchdata("players",var_01.clientid,"startMisses",var_01.trapuses);
		setmatchdata("players",var_01.clientid,"startGamesPlayed",var_01.headshotkills);
		setmatchdata("players",var_01.clientid,"startScore",var_01.meleekills);
		setmatchdata("players",var_01.clientid,"startUnlockPoints",var_01.timeplayed["total"]);
		setmatchdata("players",var_01.clientid,"startDeaths",var_01.numberofdowns);
		setmatchdata("players",var_01.clientid,"startDP",var_01.numberofbleedouts);
		setmatchdata("players",var_01.clientid,"endXp",level.wavecounter);
		setmatchdata("players",var_01.clientid,"endKills",level.doorsopenedbitmask);
		setmatchdata("players",var_01.clientid,"endDeaths",level.players.size);
		setmatchdata("players",var_01.clientid,"endWins",var_01.exosuitround);
		setmatchdata("players",var_01.clientid,"endScore",var_01.numupgrades);
		level.roundtypemap = [];
		level.roundtypemap["normal"] = 0;
		level.roundtypemap["zombie_dog"] = 1;
		level.roundtypemap["zombie_host"] = 2;
		level.roundtypemap["zombie_melee_goliath"] = 3;
		level.roundtypemap["civilian"] = 4;
		level.roundtypemap["zombie_boss_oz"] = 5;
		level.roundtypemap["zombie_boss_oz_stage1"] = 6;
		level.roundtypemap["zombie_boss_oz_stage2"] = 7;
		if(isdefined(level.roundtypemap[level.roundtype]))
		{
			setmatchdata("players",var_01.clientid,"endUnlockPoints",level.roundtypemap[level.roundtype]);
		}
	}
}

//Function Number: 146
recordplayermatchdataforroundstart(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = self getentitynumber();
	var_02 = self.origin;
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"startPos",0,int(var_02[0]));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"startPos",1,int(var_02[1]));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"startPos",2,int(var_02[2]));
	var_03 = self getweaponslistall();
	var_04 = 1;
	foreach(var_06 in var_03)
	{
		var_07 = getweaponbasename(var_06);
		var_08 = level.weaponnamemap[var_07];
		if(!isdefined(var_08) && iszombieequipment(var_07))
		{
			var_07 = getzombieequipmentalternatename(var_07);
			if(isdefined(var_07))
			{
				var_08 = level.weaponnamemap[var_07];
			}
		}

		if(!isdefined(var_08))
		{
			continue;
		}

		if(iszombielethal(var_07))
		{
			setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"equipment",0,var_08);
			continue;
		}

		if(iszombietactical(var_07))
		{
			setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"equipment",1,var_08);
			continue;
		}

		var_09 = getzombieweaponlevel(self,var_07);
		if(var_04)
		{
			var_04 = 0;
			setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"weapons",0,var_08);
			setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"weaponLevels",0,var_09);
		}
		else
		{
			setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"weapons",1,var_08);
			setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"weaponLevels",1,var_09);
		}
	}

	self.roundmoneyearned = 0;
	self.roundmoneyspent = 0;
	self.killsatroundstart = self.kills;
	self.bleedoutsatroundstart = self.numberofbleedouts;
	self.downsatroundstart = self.numberofdowns;
	self.magicboxusesatroundstart = self.magicboxuses;
}

//Function Number: 147
recordplayermatchdataforroundend(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = self getentitynumber();
	var_02 = self.origin;
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"endPos",0,int(var_02[0]));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"endPos",1,int(var_02[1]));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"endPos",2,int(var_02[2]));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"moneyEarned",maps\mp\_utility::clamptoshort(self.roundmoneyearned));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"moneySpent",maps\mp\_utility::clamptoshort(self.roundmoneyspent));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"kills",maps\mp\_utility::clamptoshort(self.kills - self.killsatroundstart));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"printerUses",maps\mp\_utility::clamptobyte(self.magicboxuses - self.magicboxusesatroundstart));
	setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"timesDowned",maps\mp\_utility::clamptobyte(self.numberofdowns - self.downsatroundstart));
	if(self.bleedoutsatroundstart != self.numberofbleedouts)
	{
		setmatchdata("zombieRounds",param_00,"playerRounds",var_01,"died",1);
	}
}

//Function Number: 148
recordmatchdataforroundstart(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = maps\mp\_utility::clamptoshort(maps\mp\_utility::getsecondspassed());
	setmatchdata("zombieRounds",param_00,"startTime",var_01);
	foreach(var_03 in level.players)
	{
		var_03 recordplayermatchdataforroundstart(param_00);
	}

	level.roundsupplydrops = [];
	level.roundpowerstations = [];
}

//Function Number: 149
recordmatchdataforroundend(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = maps\mp\_utility::clamptoshort(maps\mp\_utility::getsecondspassed());
	setmatchdata("zombieRounds",param_00,"endTime",var_01);
	foreach(var_03 in level.roundpowerstations)
	{
		if(var_03 >= 0 && var_03 < 24)
		{
			setmatchdata("zombieRounds",param_00,"powerStationActivated",var_03,1);
		}
	}

	var_05 = 0;
	foreach(var_07 in level.roundsupplydrops)
	{
		var_08 = 1;
		foreach(var_0A in level.cratetypes["airdrop_assault"])
		{
			if(var_0A.type == var_07)
			{
				setmatchdata("zombieRounds",param_00,"supplyDrops",var_05,maps\mp\_utility::clamptobyte(var_08));
				var_05++;
				break;
			}

			var_08++;
		}

		if(var_05 >= 2)
		{
			break;
		}
	}

	foreach(var_0E in level.players)
	{
		var_0E recordplayermatchdataforroundend(param_00);
	}
}

//Function Number: 150
writezombieplayerstats(param_00)
{
	if(isdefined(level.dlcleaderboardnumber) && level.dlcleaderboardnumber >= 2 && level.dlcleaderboardnumber <= 4)
	{
		var_01 = "dlc" + level.dlcleaderboardnumber;
		setzombiereservedata(param_00,var_01 + "MoneyEarned",var_01 + "MoneyEarnedBest",param_00.moneyearnedtotal);
		setzombiereservedata(param_00,var_01 + "Kills",var_01 + "KillsBest",param_00.kills);
		setzombiereservedata(param_00,var_01 + "Revives",var_01 + "RevivesBest",param_00.assists);
		setzombiereservedata(param_00,var_01 + "Rounds",var_01 + "RoundsBest",level.wavecounter);
		setzombiereservedata(param_00,var_01 + "TimePlayed",var_01 + "TimePlayedBest",param_00.timeplayed["total"]);
		setzombiereservedata(param_00,var_01 + "Headshots",var_01 + "HeadshotsBest",param_00.headshotkills);
		setzombiereservedata(param_00,var_01 + "MeleeKills",var_01 + "MeleeKillsBest",param_00.meleekills);
		if(level.dlcleaderboardnumber == 2)
		{
			setzombiereservedata(param_00,var_01 + "Civilians",var_01 + "CiviliansBest",level.civiliansrescued);
			if(isdefined(level.civiliansrescued))
			{
				var_02 = param_00 getcoopplayerdatareservedint("civiliansRescued");
				var_02 = var_02 + level.civiliansrescued;
				param_00 setcoopplayerdatareservedint("civiliansRescued",var_02);
			}
		}

		if(level.dlcleaderboardnumber == 3)
		{
			setzombiereservedata(param_00,var_01 + "Bombs",var_01 + "BombsBest",level.bombsdefused);
		}
	}
	else
	{
		setzombieplayerdata(param_00,"totalRounds","highestRound",level.wavecounter);
		setzombieplayerdata(param_00,"totalKills","mostKillsGame",param_00.kills);
		setzombieplayerdata(param_00,"totalRevives","mostRevives",param_00.assists);
		setzombieplayerdata(param_00,"totalMoneyEarned","mostMoneyEarned",param_00.moneyearnedtotal);
		setzombieplayerdata(param_00,"totalMoneySpent","mostMoneySpent",param_00.moneyearnedtotal - param_00.moneycurrent);
		setzombieplayerdata(param_00,"totalMagicBox","mostMagicBox",param_00.magicboxuses);
		setzombieplayerdata(param_00,"totalTraps","mostTraps",param_00.trapuses);
		setzombieplayerdata(param_00,"totalHeadshots","mostHeadshotsGame",param_00.headshotkills);
		setzombieplayerdata(param_00,"totalMeleeKills","mostMeleeKills",param_00.meleekills);
		setzombiereservedata(param_00,"totalTimePlayed","mostTimePlayed",param_00.timeplayed["total"]);
	}

	var_03 = param_00 getcoopplayerdata("totalGames");
	param_00 setcoopplayerdata("totalGames",var_03 + 1);
}

//Function Number: 151
setzombieplayerdata(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		return;
	}

	var_04 = param_00 getcoopplayerdata(param_01);
	param_00 setcoopplayerdata(param_01,var_04 + param_03);
	var_05 = param_00 getcoopplayerdata(param_02);
	if(param_03 > var_05)
	{
		param_00 setcoopplayerdata(param_02,param_03);
	}
}

//Function Number: 152
setzombiereservedata(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		return;
	}

	var_04 = param_00 getcoopplayerdatareservedint(param_01);
	param_00 setcoopplayerdatareservedint(param_01,var_04 + param_03);
	var_05 = param_00 getcoopplayerdatareservedint(param_02);
	if(param_03 > var_05)
	{
		param_00 setcoopplayerdatareservedint(param_02,param_03);
	}
}

//Function Number: 153
setmeleeradius(param_00)
{
	self.meleeradius = param_00;
	self.meleeradiussq = param_00 * param_00;
}

//Function Number: 154
playergetem1ammo()
{
	return self.pers["em1Ammo"].ammo;
}

//Function Number: 155
playerrecordem1ammo(param_00)
{
	self.pers["em1Ammo"].ammo = param_00;
}

//Function Number: 156
playerhasem1ammoinfo()
{
	return isdefined(self.pers["em1Ammo"]);
}

//Function Number: 157
playerclearem1ammoinfo()
{
	self.pers["em1Ammo"] = undefined;
}

//Function Number: 158
cg_setupstorestrings(param_00)
{
	if(!isdefined(param_00.storedescription))
	{
		param_00.storedescription = param_00 maps\mp\gametypes\_hud_util::createfontstring("hudbig",0.75);
		param_00.storedescription maps\mp\gametypes\_hud_util::setpoint("BOTTOM",undefined,0,-120);
		param_00.storedescription settext("");
	}

	if(!isdefined(param_00.storecost))
	{
		param_00.storecost = param_00 maps\mp\gametypes\_hud_util::createfontstring("hudbig",0.75);
		param_00.storecost maps\mp\gametypes\_hud_util::setpoint("BOTTOM",undefined,0,-95);
		param_00.storecost settext("");
	}
}

//Function Number: 159
waittilltriggerortokenuse()
{
	self endon("death");
	thread watchtokentrigger();
	thread watchtokenuse();
	self waittill("used",var_00,var_01);
	return [var_00,var_01];
}

//Function Number: 160
watchtokentrigger()
{
	self endon("used");
	self endon("death");
	self waittill("trigger",var_00);
	self notify("used",var_00,"trigger");
}

//Function Number: 161
watchtokenuse()
{
	self endon("used");
	self endon("death");
	if(!level.tokensenabled)
	{
		return;
	}

	foreach(var_01 in level.players)
	{
		thread watchtokenuseent(var_01);
	}

	for(;;)
	{
		level waittill("connected",var_01);
		thread watchtokenuseent(var_01);
	}
}

//Function Number: 162
watchtokenuseent(param_00)
{
	watchtokenuseentwait(param_00);
	if(isdefined(param_00))
	{
		param_00 cleartokenuseomnvars();
	}
}

//Function Number: 163
watchtokenuseentwait(param_00)
{
	self endon("used");
	self endon("death");
	param_00 endon("disconnect");
	var_01 = undefined;
	for(;;)
	{
		if(is_true(param_00.tokenbuttonpressed) && is_true(self.tokenstringvisible) && isplayeruseent(param_00,self) && param_00 maps\mp\gametypes\zombies::hastoken(self.tokencost))
		{
			if(!isdefined(var_01))
			{
				var_01 = gettime() + param_00 maps\mp\gametypes\zombies::gettokenusetime();
				param_00 settokenuseomvars();
			}

			if(gettime() >= var_01)
			{
				param_00.tokenbuttonpressed = 0;
				self notify("used",param_00,"token");
			}
		}
		else if(isdefined(var_01))
		{
			var_01 = undefined;
			param_00 cleartokenuseomnvars();
		}

		wait 0.05;
	}
}

//Function Number: 164
cleartokenuseomnvars()
{
	self setclientomnvar("ui_use_bar_start_time",0);
	self setclientomnvar("ui_use_bar_end_time",0);
	self setclientomnvar("ui_use_bar_text",0);
}

//Function Number: 165
settokenuseomvars()
{
	self setclientomnvar("ui_use_bar_start_time",gettime());
	var_00 = gettime() + maps\mp\gametypes\zombies::gettokenusetime();
	self setclientomnvar("ui_use_bar_end_time",var_00);
	self setclientomnvar("ui_use_bar_text",5);
}

//Function Number: 166
settokencost(param_00)
{
	self.tokencost = param_00;
}

//Function Number: 167
tokenhintstring(param_00)
{
	if(param_00 && level.tokensenabled)
	{
		self.tokenstringvisible = 1;
		self settertiaryhintstring(gettokencoststring(self.tokencost));
		return;
	}

	self.tokenstringvisible = 0;
	self settertiaryhintstring("");
}

//Function Number: 168
enabletokens()
{
	level.tokensenabled = getdvarint("tokensEnabled",0);
}

//Function Number: 169
isplayeruseent(param_00,param_01)
{
	var_02 = param_00 playergetuseent(1);
	return isdefined(var_02) && var_02 == param_01;
}

//Function Number: 170
droppostoground(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 18;
	}

	var_02 = param_00 + (0,0,param_01);
	var_03 = param_00 + (0,0,param_01 * -1);
	var_04 = self aiphysicstrace(var_02,var_03,self.radius,self.height,1);
	if(abs(var_04[2] - var_02[2]) < 0.1)
	{
		return undefined;
	}

	if(abs(var_04[2] - var_03[2]) < 0.1)
	{
		return undefined;
	}

	return var_04;
}

//Function Number: 171
canmovepointtopoint(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	if(!isdefined(param_03))
	{
		param_03 = self.radius;
	}

	var_04 = (0,0,1) * param_02;
	var_05 = param_00 + var_04;
	var_06 = param_01 + var_04;
	return self aiphysicstracepassed(var_05,var_06,param_03,self.height - param_02,1);
}

//Function Number: 172
getzombieslevelnum()
{
	return level.zombiedlclevel;
}

//Function Number: 173
nodeisinspawncloset(param_00)
{
	return !isdefined(param_00.zombieszone);
}

//Function Number: 174
areaparallelpipid(param_00,param_01,param_02)
{
	return param_00[0] * param_01[1] - param_00[1] * param_01[0] + param_01[0] * param_02[1] - param_02[0] * param_01[1] + param_02[0] * param_00[1] - param_00[0] * param_02[1];
}

//Function Number: 175
areatriange(param_00,param_01,param_02)
{
	return areaparallelpipid(param_00,param_01,param_02) * 0.5;
}

//Function Number: 176
lrtest(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = areaparallelpipid(param_01,param_02,param_00);
	if(var_04 > param_03)
	{
		return 1;
	}

	if(var_04 < param_03 * -1)
	{
		return 2;
	}

	return 3;
}

//Function Number: 177
project(param_00,param_01)
{
	var_02 = vectordot(param_00,param_01) / lengthsquared(param_01);
	return [param_01 * var_02,var_02];
}

//Function Number: 178
projecttoline(param_00,param_01,param_02)
{
	param_00 = param_00 - param_01;
	var_03 = project(param_00,param_02 - param_01);
	param_00 = var_03[0];
	var_04 = var_03[1];
	param_00 = param_00 + param_01;
	return [param_00,var_04];
}

//Function Number: 179
projecttolineseg(param_00,param_01,param_02)
{
	var_03 = projecttoline(param_00,param_01,param_02);
	param_00 = var_03[0];
	var_04 = var_03[1];
	if(var_04 < 0)
	{
		param_00 = param_01;
	}
	else if(var_04 > 1)
	{
		param_00 = param_02;
	}

	return [param_00,var_04];
}

//Function Number: 180
disttoline(param_00,param_01,param_02)
{
	var_03 = projecttoline(param_00,param_01,param_02);
	var_04 = var_03[0];
	var_05 = var_03[1];
	return distance(var_04,param_00);
}

//Function Number: 181
despawnzombie()
{
	self hudoutlinedisable();
	maps\mp\agents\_agent_utility::deactivateagent();
	self notify("killanimscript");
	self notify("death");
	self waittill("disconnect");
	self despawnagent();
}

//Function Number: 182
gameflagexists(param_00)
{
	return isdefined(game["flags"][param_00]);
}

//Function Number: 183
isvalidweaponzombies(param_00)
{
	return isvalidprimaryzombies(param_00) || isvalidsecondaryzombies(param_00);
}

//Function Number: 184
isvalidprimaryzombies(param_00)
{
	switch(param_00)
	{
		case "iw5_tridentzm":
		case "iw5_linegunzm":
		case "iw5_microwavezm":
		case "iw5_fusionzm":
		case "iw5_dlcgun4zm":
		case "iw5_dlcgun3zm":
		case "iw5_dlcgun1zm":
		case "iw5_rhinozm":
		case "iw5_gm6zm":
		case "iw5_asm1zm":
		case "iw5_sac3zm":
		case "iw5_sn6zm":
		case "iw5_asawzm":
		case "iw5_himarzm":
		case "iw5_lsatzm":
		case "iw5_bal27zm":
		case "iw5_ak12zm":
		case "iw5_arx160zm":
		case "iw5_hmr9zm":
		case "iw5_hbra3zm":
		case "iw5_m182sprzm":
		case "iw5_uts19zm":
		case "iw5_mp11zm":
		case "iw5_maulzm":
		case "iw5_dlcgun2zm":
		case "iw5_em1zm":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 185
isvalidsecondaryzombies(param_00)
{
	switch(param_00)
	{
		case "iw5_exocrossbowzm":
		case "iw5_mahemzm":
		case "iw5_titan45zm":
		case "iw5_rw1zm":
		case "iw5_vbrzm":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 186
isvalidequipmentzombies(param_00)
{
	switch(param_00)
	{
		case "teleport_zombies":
		case "repulsor_zombie":
		case "dna_aoe_grenade_zombie":
		case "distraction_drone_zombie":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 187
pausezombiespawning(param_00)
{
	if(!isdefined(level.zombie_pause_spawning_count))
	{
		level.zombie_pause_spawning_count = 0;
	}

	if(param_00)
	{
		level.zombie_pause_spawning_count++;
	}
	else
	{
		level.zombie_pause_spawning_count--;
	}
}

//Function Number: 188
instakillimmune()
{
	if(is_true(self.fakeplayer))
	{
		return 1;
	}
	else if(isdefined(self.agent_type))
	{
		if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 189
nohitreactions()
{
	if(isdefined(self.agent_type))
	{
		if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 190
isdoortrapimmune()
{
	if(isdefined(self.agent_type))
	{
		if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 191
istrapresistant()
{
	if(isdefined(self.agent_type))
	{
		if(self.agent_type == "zombie_melee_goliath" || self.agent_type == "zombie_boss_oz_stage2")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 192
getenemyagents()
{
	var_00 = [];
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_03 in var_01)
	{
		if(isdefined(level.despawning_agents) && common_scripts\utility::array_contains(level.despawning_agents,var_03))
		{
			continue;
		}

		if(is_true(var_03.waitingtodeactivate))
		{
			continue;
		}

		if(!isalliedsentient(self,var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 193
getnumagentswaitingtodeactivate()
{
	var_00 = 0;
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_03 in level.agentarray)
	{
		if(isdefined(level.despawning_agents) && common_scripts\utility::array_contains(level.despawning_agents,var_03))
		{
			var_00++;
			continue;
		}

		if(is_true(var_03.waitingtodeactivate))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 194
getarrayofoffscreenagentstorecycle(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isalive(var_03))
		{
			var_04 = var_03 getnearestnode();
			if(isdefined(var_04))
			{
				var_01[var_01.size] = var_04;
			}
		}
	}

	var_06 = [];
	foreach(var_08 in param_00)
	{
		if(var_08 instakillimmune() || issubstr(var_08.agent_type,"ranged_elite_soldier"))
		{
			continue;
		}

		var_09 = 1;
		var_0A = var_08 getnearestnode();
		if(isdefined(var_0A))
		{
			foreach(var_04 in var_01)
			{
				if(nodesvisible(var_0A,var_04,1))
				{
					var_09 = 0;
					break;
				}
			}
		}

		if(var_09)
		{
			var_06[var_06.size] = var_08;
		}
	}

	return var_06;
}

//Function Number: 195
waittill_any_return_parms_no_endon_death(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread waittill_string_parms_no_endon_death(param_00,var_08);
	}

	if(isdefined(param_01))
	{
		childthread waittill_string_parms_no_endon_death(param_01,var_08);
	}

	if(isdefined(param_02))
	{
		childthread waittill_string_parms_no_endon_death(param_02,var_08);
	}

	if(isdefined(param_03))
	{
		childthread waittill_string_parms_no_endon_death(param_03,var_08);
	}

	if(isdefined(param_04))
	{
		childthread waittill_string_parms_no_endon_death(param_04,var_08);
	}

	if(isdefined(param_05))
	{
		childthread waittill_string_parms_no_endon_death(param_05,var_08);
	}

	if(isdefined(param_06))
	{
		childthread waittill_string_parms_no_endon_death(param_06,var_08);
	}

	if(isdefined(param_07))
	{
		childthread waittill_string_parms_no_endon_death(param_07,var_08);
	}

	var_08 waittill("returned",var_09);
	var_08 notify("die");
	return var_09;
}

//Function Number: 196
waittill_string_parms_no_endon_death(param_00,param_01)
{
	param_01 endon("die");
	self waittill(param_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	var_0C = [];
	var_0C[0] = param_00;
	if(isdefined(var_02))
	{
		var_0C[1] = var_02;
	}

	if(isdefined(var_03))
	{
		var_0C[2] = var_03;
	}

	if(isdefined(var_04))
	{
		var_0C[3] = var_04;
	}

	if(isdefined(var_05))
	{
		var_0C[4] = var_05;
	}

	if(isdefined(var_06))
	{
		var_0C[5] = var_06;
	}

	if(isdefined(var_07))
	{
		var_0C[6] = var_07;
	}

	if(isdefined(var_08))
	{
		var_0C[7] = var_08;
	}

	if(isdefined(var_09))
	{
		var_0C[8] = var_09;
	}

	if(isdefined(var_0A))
	{
		var_0C[9] = var_0A;
	}

	if(isdefined(var_0B))
	{
		var_0C[10] = var_0B;
	}

	param_01 notify("returned",var_0C);
}

//Function Number: 197
playerallowfire(param_00,param_01)
{
	if(!isdefined(self.playerdisablefire))
	{
		self.playerdisablefire = [];
	}

	if(!isdefined(param_01))
	{
		param_01 = "default";
	}

	if(param_00)
	{
		self.playerdisablefire = common_scripts\utility::array_remove(self.playerdisablefire,param_01);
		if(!self.playerdisablefire.size)
		{
			self allowfire(1);
			return;
		}

		return;
	}

	if(!isdefined(common_scripts\utility::array_find(self.playerdisablefire,param_01)))
	{
		self.playerdisablefire = common_scripts\utility::array_add(self.playerdisablefire,param_01);
	}

	self allowfire(0);
}

//Function Number: 198
iszombieshardmode()
{
	return is_true(game["start_in_zmb_hard_mode"]);
}

//Function Number: 199
disablekillstreaks()
{
	if(!isdefined(level.disablekillstreaks))
	{
		level.disablekillstreaks = 0;
	}

	level.disablekillstreaks++;
}

//Function Number: 200
enablekillstreaks()
{
	if(!isdefined(level.disablekillstreaks))
	{
		level.disablekillstreaks = 0;
		return;
	}

	if(level.disablekillstreaks > 0)
	{
		level.disablekillstreaks--;
	}
}

//Function Number: 201
arekillstreaksdisabled()
{
	return isdefined(level.disablekillstreaks) && level.disablekillstreaks > 0;
}

//Function Number: 202
disablepickups()
{
	if(!isdefined(level.disablepickups))
	{
		level.disablepickups = 0;
	}

	level.disablepickups++;
}

//Function Number: 203
enablepickups()
{
	if(!isdefined(level.disablepickups))
	{
		level.disablepickups = 0;
		return;
	}

	if(level.disablepickups > 0)
	{
		level.disablepickups--;
	}
}

//Function Number: 204
arepickupsdisabled()
{
	return isdefined(level.disablepickups) && level.disablepickups > 0;
}

//Function Number: 205
disablewallbuys()
{
	if(!isdefined(level.disablewallbuys))
	{
		level.disablewallbuys = 0;
	}

	level.disablewallbuys++;
	level notify("disableWallbuysUpdate");
}

//Function Number: 206
enablewallbuys()
{
	if(!isdefined(level.disablewallbuys))
	{
		level.disablewallbuys = 0;
		return;
	}

	if(level.disablewallbuys > 0)
	{
		level.disablewallbuys--;
		level notify("disableWallbuysUpdate");
	}
}

//Function Number: 207
arewallbuysdisabled()
{
	return isdefined(level.disablewallbuys) && level.disablewallbuys > 0;
}

//Function Number: 208
setfriendlyfireround(param_00)
{
	if(is_true(param_00))
	{
		level.friendlyfire = 1;
		level.teamtweaks["fftype"].value = 1;
		return;
	}

	level.friendlyfire = 0;
	level.teamtweaks["fftype"].value = 0;
}

//Function Number: 209
isfriendlyfireround()
{
	return level.friendlyfire == 1;
}