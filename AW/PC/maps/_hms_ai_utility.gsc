/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hms_ai_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 710 ms
 * Timestamp: 4/22/2024 2:21:23 AM
*******************************************************************/

//Function Number: 1
gototogoal(param_00,param_01,param_02)
{
	self endon("death");
	self.goalradius = 64;
	if(!isdefined(param_01) || !isstring(param_01))
	{
		param_01 = "default";
	}

	switch(param_01)
	{
		case "default":
			self.enablesprint = 0;
			self.enablecqb = 0;
			break;

		case "sprint":
			self.enablesprint = 1;
			self.enablecqb = 0;
			break;

		case "cqb":
			self.enablecqb = 1;
			self.enablesprint = 0;
			break;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_02 == 1)
	{
		playerleashdisable();
	}

	if(self.enablesprint == 1 && distance(self.origin,param_00.origin) >= 512)
	{
		maps\_utility::enable_sprint();
		maps\_utility::disable_pain();
	}

	if(self.enablecqb == 1)
	{
		maps\_utility::enable_cqbwalk();
	}

	self notify("newgoal");
	maps\_utility::set_goal_node(param_00);
	wait 0.05;
	_waittillgoalornewgoal();
	if(isdefined(self.sprint) && self.sprint == 1)
	{
		maps\_utility::disable_sprint();
		maps\_utility::enable_pain();
	}

	if(self.enablecqb == 1)
	{
		maps\_utility::disable_cqbwalk();
	}
}

//Function Number: 2
_waittillgoalornewgoal()
{
	self endon("newgoal");
	self waittill("goal");
}

//Function Number: 3
playerleashbehavior(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("disable_leash_behavior");
	if(isdefined(self.bplayerleash) && self.bplayerleash == 1)
	{
		return;
	}

	self.bplayerleash = 1;
	common_scripts\utility::create_dvar("AI_Leash_Debug",0);
	common_scripts\utility::create_dvar("AI_Score_Debug",0);
	common_scripts\utility::create_dvar("AI_Teleport_Debug",0);
	self.goalradius = 16;
	self.fixednodesaferadius = 64;
	self.script_careful = 1;
	self.disablelongpain = 1;
	self.ignoresuppression = 1;
	if(isdefined(self.bestcovernode))
	{
		self.bestcovernode = undefined;
	}

	self.leashplayerdistancetether = 400;
	if(isdefined(param_00))
	{
		self.leashplayerdistancetether = param_00;
	}

	self.leashcoversearchradius = 400;
	if(isdefined(param_01))
	{
		self.leashcoversearchradius = param_01;
	}

	self.leashcoversearchradiusmin = 64;
	self.leashsearchoffset = 128;
	if(isdefined(param_02))
	{
		self.leashsearchoffset = param_02;
	}

	var_04 = self.leashsearchoffset * 2;
	self.leashheightoffset = 32;
	if(isdefined(param_03))
	{
		self.leashheightoffset = param_03;
	}

	thread _teleportleashbehavior();
	childthread _updateenemygroupdirection();
	childthread _updatebuddycovernodes();
	var_05 = randomfloatrange(8,15);
	for(;;)
	{
		wait(0.05);
		var_05 = var_05 - 0.05;
		if(var_05 < 0 || !maps\_utility::players_within_distance(self.leashplayerdistancetether,self.origin))
		{
			if(common_scripts\utility::cointoss())
			{
				movetocovernearplayer();
				self waittill("goal");
			}

			var_05 = randomfloatrange(3,6);
		}
	}
}

//Function Number: 4
playerleashdisable()
{
	self.bplayerleash = 0;
	self notify("disable_leash_behavior");
}

//Function Number: 5
_updateenemygroupdirection()
{
	self endon("death");
	self endon("disable_leash_behavior");
	level notify("UpdateEnemyGroupDirection");
	level endon("UpdateEnemyGroupDirection");
	var_00 = getaiarray("axis");
	self.enemydirection = undefined;
	for(;;)
	{
		wait(0.05);
		var_00 = getaiarray("axis");
		if(var_00.size == 0)
		{
			self.enemydirection = undefined;
			continue;
		}

		var_01 = (0,0,0);
		foreach(var_03 in var_00)
		{
			var_01 = var_01 + vectornormalize(var_03.origin - self.origin);
		}

		var_01 = (var_01[0],var_01[1],0);
		var_01 = var_01 / var_00.size;
		self.enemydirection = vectornormalize(var_01);
	}
}

//Function Number: 6
_updatebuddycovernodes()
{
	self endon("death");
	self endon("disable_leash_behavior");
	level notify("UpdateBuddyCoverNodes");
	level endon("UpdateBuddyCoverNodes");
	var_00 = maps\_sarray::sarray_spawn();
	for(;;)
	{
		wait(0.05);
		if(!_evaluatebuddycovernodes(var_00))
		{
			continue;
		}

		var_01 = var_00.array[0];
		if(!isdefined(var_01))
		{
			continue;
		}

		if(getdvarint("AI_Score_Debug") == 1)
		{
		}

		self.bestcovernode = var_00.array[0];
	}
}

//Function Number: 7
_evaluatebuddycovernodes(param_00)
{
	var_01 = anglestoforward(level.player.angles);
	if(isdefined(self.enemydirection))
	{
		var_01 = self.enemydirection;
	}

	var_02 = level.player.origin + var_01 * self.leashsearchoffset;
	var_03 = getnodesinradiussorted(var_02,self.leashcoversearchradius,self.leashcoversearchradiusmin,self.leashheightoffset,"cover");
	if(var_03.size == 0)
	{
		return 0;
	}

	param_00 maps\_sarray::sarray_clear();
	var_04 = getdvarint("AI_Score_Debug");
	foreach(var_06 in var_03)
	{
		wait(0.05);
		var_06.score = _determineallynodescore(self,var_06,self.leashcoversearchradius);
		if(var_06.score < 0)
		{
			continue;
		}

		if(var_04 == 1)
		{
		}

		param_00 maps\_sarray::sarray_push(var_06);
	}

	maps\_sarray::sarray_sort_by_handler(param_00,maps\_sarray::sarray_create_func_obj(::_sortbyscore));
	return 1;
}

//Function Number: 8
movetocovernearplayer()
{
	self endon("death");
	if(!isdefined(self.bestcovernode))
	{
		maps\_utility::set_goal_pos(self.origin);
		return;
	}

	self.currentcovernode = self.bestcovernode;
	_advancetogoal(self.bestcovernode);
}

//Function Number: 9
_evaluatenoderangetoplayer(param_00,param_01)
{
	var_02 = length2d(level.player.origin - param_00.origin);
	return maps\_utility::linear_interpolate(min(var_02 / param_01,1),0.8,1);
}

//Function Number: 10
_evaluatenodeplayervisibility(param_00)
{
	if(!sighttracepassed(level.player geteye(),param_00.origin,1,level.player))
	{
		return 0.75;
	}

	return 1;
}

//Function Number: 11
_determineallynodescore(param_00,param_01,param_02)
{
	if(param_01.type == "Exposed")
	{
		return -1;
	}

	if(isdefined(param_01.script_team) && param_01.script_team == "axis")
	{
		return -1;
	}

	if(isnodeoccupied(param_01))
	{
		return -1;
	}

	if(distance(param_01.origin,level.player.origin) > param_00.leashplayerdistancetether)
	{
		return -1;
	}

	if(param_00 isknownenemyinradius(param_01.origin,128))
	{
		return -1;
	}

	if(maps\_utility::players_within_distance(64,param_01.origin))
	{
		return -1;
	}

	var_03 = _evaluatenodeiscover(param_01);
	var_03 = var_03 + _evaluatenoderangetoplayer(param_01,param_02);
	var_03 = var_03 + _evaluatenodeplayervisibility(param_01);
	return var_03 / 3;
}

//Function Number: 12
_sortbyscore(param_00,param_01)
{
	return param_00.score > param_01.score;
}

//Function Number: 13
_advancetogoal(param_00)
{
	self endon("death");
	self endon("goal");
	self endon("goal_blocked");
	self clearenemy();
	maps\_utility::set_goal_node(param_00);
	thread _goalblockedbyplayer(param_00);
	thread _goalblockedbyai();
	common_scripts\utility::waittill_any_timeout(10,"goal");
}

//Function Number: 14
_goalblockedbyplayer(param_00)
{
	self endon("goal");
	for(;;)
	{
		wait(0.05);
		if(!maps\_utility::players_within_distance(64,param_00.origin))
		{
			continue;
		}

		self notify("goal_blocked");
		wait(0.05);
		movetocovernearplayer();
	}
}

//Function Number: 15
_goalblockedbyai()
{
	self endon("death");
	self endon("goal");
	self waittill("node_taken");
	self notify("goal_blocked");
	movetocovernearplayer();
}

//Function Number: 16
_teleportleashbehavior()
{
	self endon("death");
	self endon("disable_leash_behavior");
	var_00 = getdvarint("cg_fov");
	for(;;)
	{
		wait(0.05);
		if(maps\_utility::players_within_distance(768,self.origin))
		{
			continue;
		}

		var_01 = getnodesinradius(level.player.origin,512,256,32);
		if(!isdefined(var_01))
		{
			continue;
		}

		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.script_team) && var_03.script_team == "axis")
			{
				var_01 = common_scripts\utility::array_remove(var_01,var_03);
			}

			if(isnodeoccupied(var_03) || maps\_utility::players_within_distance(64,var_03.origin) || maps\_utility::within_fov_of_players(var_03.origin,cos(120)) || maps\_utility::within_fov_of_players(self.origin,cos(var_00)))
			{
				var_01 = common_scripts\utility::array_remove(var_01,var_03);
			}
		}

		if(var_01.size == 0)
		{
			continue;
		}

		var_05 = var_01[maps\_utility::get_closest_index(level.player.origin,var_01)];
		if(isdefined(var_05))
		{
			self clearenemy();
			maps\_utility::anim_stopanimscripted();
			maps\_utility::teleport_ai(var_05);
			wait(0.05);
			movetocovernearplayer();
		}
	}
}

//Function Number: 17
assistplayer()
{
	self endon("death");
	self endon("disable_player_assist");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01) && isai(var_01))
		{
			var_02 = maps\_utility::get_closest_ai(self.origin,"allies");
			if(isalive(var_01) && isdefined(var_02))
			{
				var_02 getenemyinfo(var_01);
			}
		}

		wait(1.5);
	}
}

//Function Number: 18
adjustallyaccuracyovertime()
{
	self endon("death");
	self endon("disable_accuracy_adjust");
	self.baseaccuracy = 0;
	for(;;)
	{
		wait(1);
		var_00 = self.enemy;
		if(isdefined(var_00) && var_00 == self.enemy && self.baseaccuracy < 1)
		{
			self.baseaccuracy = self.baseaccuracy + 0.1;
			continue;
		}

		self.baseaccuracy = 0;
	}
}

//Function Number: 19
setupshotgunkva(param_00,param_01)
{
	if(!isdefined(level.kvashotgunners))
	{
		level.kvashotgunners = [];
		createthreatbiasgroup("player");
		createthreatbiasgroup("kva_shotgunner");
		level.player setthreatbiasgroup("player");
		setthreatbias("player","kva_shotgunner",500);
		level.player.dontmelee = 1;
	}

	common_scripts\utility::create_dvar("AI_Pain_Debug",0);
	common_scripts\utility::create_dvar("AI_Shotgunner_Score_Debug",0);
	var_02 = "iw5_maul_sp";
	maps\_utility::disable_surprise();
	self.disablebulletwhizbyreaction = 1;
	self.grenadeammo = 0;
	self.health = 1000;
	self.combatmode = "no_cover";
	self.a.disablelongdeath = 1;
	self.a.disablelongpain = 1;
	self.aggressivemode = 1;
	self.noruntwitch = 1;
	self.disablereactionanims = 1;
	self.ignoresuppression = 1;
	self.no_pistol_switch = 1;
	self.dontmelee = 1;
	self.meleealwayswin = 1;
	self.currentshotguncovernode = undefined;
	maps\_utility::enable_cqbwalk();
	maps\_utility::forceuseweapon(var_02,"primary");
	self setmodel("kva_heavy_body");
	thread codescripts\character::setheadmodel("kva_heavy_head");
	self orientmode("face enemy");
	self.attackradius = 512;
	self.goalradius = 64;
	maps\_utility::set_battlechatter(0);
	level.kvashotgunners = common_scripts\utility::add_to_array(level.kvashotgunners,self);
	self setthreatbiasgroup("kva_shotgunner");
	if(!isdefined(param_01))
	{
		thread _pursueenemy();
		thread _updateshotgunnercovernodes();
	}
	else
	{
		thread _defendlocation(param_01);
	}

	thread painmanagement();
	thread _shotgunnerambience();
	maps\_utility::add_damage_function(::_shotgunnerdamagefunction);
	thread _shotgunnerdeath();
}

//Function Number: 20
_shotgunnerdamagefunction(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_01) && isdefined(param_01.script_team) && self.script_team == param_01.script_team)
	{
		return;
	}

	if(isplayer(param_01))
	{
		self notify("Took_Damage_From_Player");
	}

	if(isalive(self) && isdefined(param_01) && !isplayer(param_01))
	{
		self.health = int(min(self.maxhealth,self.health + param_00 * 0.7));
		return;
	}

	if(isalive(self) && isdefined(param_01) && isplayer(param_01) && isexplosivedamagemod(param_04))
	{
		self dodamage(param_00 / 2,self.origin,level.player);
	}
}

//Function Number: 21
_shotgunnerambience()
{
	self endon("death");
	for(;;)
	{
		wait(randomfloatrange(2,10));
		if(maps\_utility::players_within_distance(2048,self.origin))
		{
			if(soundexists("shotgunner_chatter"))
			{
				maps\_utility::play_sound_on_entity("shotgunner_chatter");
			}
		}
	}
}

//Function Number: 22
_shotgunnerdeath()
{
	self waittill("death");
	level.kvashotgunners = maps\_utility::array_removedead_or_dying(level.kvashotgunners);
	if(soundexists("shotgunner_death_fx"))
	{
		var_00 = spawn("script_origin",self.origin);
		var_00 thread maps\_utility::play_sound_on_entity("shotgunner_death_fx","deathsfx_ended");
		var_00 waittill("deathsfx_ended");
		var_00 delete();
	}
}

//Function Number: 23
_drawdebug()
{
	for(;;)
	{
		wait(0.05);
		if(getdvarint("AI_Shotgunner_Score_Debug") <= 0)
		{
			continue;
		}

		if(isdefined(self) && isdefined(self.attacknode))
		{
			if(isdefined(self.attacknode.score))
			{
			}
		}
	}
}

//Function Number: 24
_defendlocation(param_00)
{
	self endon("death");
	if(!isnodeoccupied(param_00))
	{
		thread maps\_utility::set_goal_node(param_00);
		thread _abortdefendlocation();
	}
}

//Function Number: 25
_abortdefendlocation()
{
	self endon("death");
	common_scripts\utility::waittill_any("Took_Damage_From_Player","Abort_Defend_Goal");
	thread _pursueenemy();
	thread _updateshotgunnercovernodes();
}

//Function Number: 26
_pursueenemy()
{
	self endon("death");
	if(!isdefined(self.attackradius))
	{
		self.attackradius = 512;
	}

	for(;;)
	{
		wait(0.05);
		var_00 = level.player;
		if(isdefined(self.enemy))
		{
			var_00 = self.enemy;
		}

		var_01 = distancesquared(var_00.origin,self.origin);
		if(var_01 < squared(self.attackradius) || var_01 < squared(150))
		{
			continue;
		}

		if(isdefined(self.attacknode))
		{
			self notify("changing_cover");
			_shotgunneradvance(self.attacknode);
		}
	}
}

//Function Number: 27
_shotgunneradvance(param_00)
{
	self endon("death");
	self endon("changing_cover");
	self endon("node_taken");
	self.currentshotguncovernode = param_00;
	maps\_utility::set_goal_node(param_00);
	common_scripts\utility::waittill_any_timeout(5,"goal");
}

//Function Number: 28
_updateshotgunnercovernodes()
{
	self endon("death");
	for(;;)
	{
		wait(0.05);
		var_00 = level.player;
		if(isdefined(self.enemy))
		{
			var_00 = self.enemy;
		}

		_evaluateshotgunnercovernodes(var_00,self.attackradius);
	}
}

//Function Number: 29
_evaluateshotgunnercovernodes(param_00,param_01)
{
	self notify("_EvaluateShotgunnerCoverNodes");
	self endon("_EvaluateShotgunnerCoverNodes");
	self endon("death");
	var_02 = -1;
	if(isdefined(self.attacknode))
	{
		var_02 = _determineshotgunnodescore(self,self.attacknode,param_01);
	}

	var_03 = getnodesinradiussorted(param_00.origin,param_01,param_01 / 2,64);
	if(var_03.size == 0)
	{
		return;
	}

	var_04 = 0;
	var_05 = var_03.size + 1;
	var_06 = getdvarint("AI_Shotgunner_Score_Debug") > 0;
	foreach(var_08 in var_03)
	{
		wait(0.05);
		if(var_04 > 20)
		{
			break;
		}

		var_09 = _determineshotgunnodescore(self,var_08,param_01);
		if(var_06)
		{
		}

		if(var_09 >= 0 && var_09 > var_02)
		{
			self.attacknode = var_08;
			self.attacknode.score = var_09;
			var_02 = var_09;
		}

		var_04++;
	}
}

//Function Number: 30
_evaluatenodeknownenemyinradius(param_00,param_01)
{
	if(param_01 isknownenemyinradius(param_00.origin,128))
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
_evaluatenodeplayerinradius(param_00)
{
	if(maps\_utility::players_within_distance(128,param_00.origin))
	{
		return 0.75;
	}

	return 1;
}

//Function Number: 32
_evaluatenodeiscover(param_00)
{
	if(param_00.type == "Cover Left")
	{
		return 0.95;
	}

	if(param_00.type == "Cover Right")
	{
		return 0.9;
	}

	if(param_00.type == "Cover Crouch")
	{
		return 0.85;
	}

	if(param_00.type == "Cover Stand")
	{
		return 0.75;
	}

	return 0;
}

//Function Number: 33
_evaluatenodeisexposed(param_00)
{
	if(param_00.type == "Exposed")
	{
		return 0.75;
	}

	return 0;
}

//Function Number: 34
_evaluatenodeinplayerfov(param_00)
{
	if(!maps\_utility::within_fov_of_players(param_00.origin,cos(35)))
	{
		return 0.65;
	}

	return 1;
}

//Function Number: 35
_evaluatenodelostoplayer(param_00)
{
	if(!sighttracepassed(level.player geteye(),param_00.origin,0,level.player))
	{
		return 0.85;
	}

	return 1;
}

//Function Number: 36
_evaluatenodeattackradius(param_00,param_01)
{
	if(param_01 <= 0)
	{
		return 1;
	}

	var_02 = distance2d(level.player.origin,param_00.origin);
	return clamp(var_02 / param_01,0,1);
}

//Function Number: 37
_evaluatenodeothershotgunnersbest(param_00,param_01)
{
	foreach(var_03 in level.kvashotgunners)
	{
		if(param_01 == var_03)
		{
			continue;
		}

		if(isdefined(var_03.attacknode) && param_00 == var_03.attacknode)
		{
			return 0.5;
		}
	}

	return 1;
}

//Function Number: 38
_determineshotgunnodescore(param_00,param_01,param_02)
{
	if(isnodeoccupied(param_01))
	{
		return -1;
	}

	var_03 = _evaluatenodeknownenemyinradius(param_01,param_00);
	var_03 = var_03 + _evaluatenodeplayerinradius(param_01);
	var_03 = var_03 + _evaluatenodeiscover(param_01);
	var_03 = var_03 + _evaluatenodeisexposed(param_01);
	var_03 = var_03 + _evaluatenodeinplayerfov(param_01);
	var_03 = var_03 + _evaluatenodelostoplayer(param_01);
	var_03 = var_03 + _evaluatenodeattackradius(param_01,param_02);
	var_03 = var_03 * _evaluatenodeothershotgunnersbest(param_01,param_00);
	var_03 = var_03 / 7;
	return var_03;
}

//Function Number: 39
painmanagement(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("disable_pain_management");
	if(!isdefined(param_00))
	{
		param_00 = 70;
	}

	if(!isdefined(param_01))
	{
		param_01 = 150;
	}

	if(!isdefined(param_03))
	{
		param_03 = 5;
	}

	if(!isdefined(param_02))
	{
		param_02 = 225;
	}

	self.minpaindamage = param_00;
	var_04 = spawnstruct();
	var_04.amount = 0;
	childthread _updatepainamount(var_04);
	for(;;)
	{
		wait(0.05);
		self.minpaindamage = int(maps\_utility::linear_interpolate(min(var_04.amount / param_02,1),param_00,param_01));
		var_04.amount = var_04.amount - param_03;
		var_04.amount = max(var_04.amount,0);
	}
}

//Function Number: 40
_updatepainamount(param_00)
{
	for(;;)
	{
		self waittill("damage",var_01);
		wait(0.05);
		param_00.amount = param_00.amount + var_01;
	}
}

//Function Number: 41
_enableexplosivedeath()
{
	maps\_utility::enable_long_death();
	self waittill("deathanim");
	var_00 = spawn("script_origin",self.origin);
	var_00 linkto(self,"TAG_WEAPON_CHEST");
	var_01 = var_00.origin + (0,0,16);
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		var_03 = randomfloatrange(1.5,3);
		magicgrenademanual("fraggrenade",var_00.origin,var_01,var_03);
		wait(0.05);
	}
}

//Function Number: 42
_getindex(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		if(var_04 == param_01)
		{
			return var_02;
		}

		var_02++;
	}
}