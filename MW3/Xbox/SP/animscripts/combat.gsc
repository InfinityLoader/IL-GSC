/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\combat.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 62
 * Decompile Time: 1009 ms
 * Timestamp: 10/27/2023 2:29:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.no_ai))
	{
		return;
	}

	if(isdefined(self.var_89E))
	{
		animscripts/snowmobile::main();
		return;
	}

	if(isdefined(self.custom_animscript_table))
	{
		if(isdefined(self.custom_animscript_table["combat"]))
		{
			[[ self.custom_animscript_table["combat"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	[[ self.exception["exposed"] ]]();
	animscripts/utility::initialize("combat");
	self.a.var_CCA = undefined;
	if(isdefined(self.node) && self.node.type == "Ambush" && self nearnode(self.node))
	{
		self.ambushnode = self.node;
	}

	transitiontocombat();
	do_friendly_fire_reaction();
	animscripts/stop::specialidleloop();
	setup();
	exposedcombatmainloop();
	self notify("stop_deciding_how_to_shoot");
}

//Function Number: 2
end_script()
{
	self.ambushnode = undefined;
}

//Function Number: 3
do_friendly_fire_reaction()
{
	if(self.team != "allies")
	{
		return;
	}

	if(self ismovesuppressed() && self.prevscript == "move" && self.a.var_911 == "stand" && !isdefined(self.disablefriendlyfirereaction))
	{
		if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < squared(128))
		{
			return;
		}

		self animmode("zonly_physics");
		self setflaggedanimknoballrestart("react",%surprise_stop_v1,%root,1,0.2,self.animplaybackrate);
		animscripts/shared::donotetracks("react");
	}
}

//Function Number: 4
transitiontocombat()
{
	if(isdefined(self.specialidleanim) || isdefined(self.customidleanimset))
	{
		return;
	}

	if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 262144)
	{
		return;
	}

	if(self.prevscript == "stop" && !animscripts/utility::iscqbwalking() && self.a.var_911 == "stand")
	{
		self animmode("zonly_physics");
		self setflaggedanimknoballrestart("transition",%casual_stand_idle_trans_out,%root,1,0.2,1.2 * self.animplaybackrate);
		animscripts/shared::donotetracks("transition");
	}
}

//Function Number: 5
func_0CF3()
{
	if(self.a.var_911 == "stand")
	{
		animscripts/animset::set_animarray_standing();
		return;
	}

	if(self.a.var_911 == "crouch")
	{
		animscripts/animset::set_animarray_crouching();
		return;
	}

	if(self.a.var_911 == "prone")
	{
		animscripts/animset::set_animarray_prone();
		return;
	}
}

//Function Number: 6
setup()
{
	if(animscripts/utility::usingsidearm() && self isstanceallowed("stand"))
	{
		transitionto("stand");
	}

	func_0CF3();
	set_aim_and_turn_limits();
	thread stopshortly();
	self.previouspitchdelta = 0;
	self clearanim(%root,0.2);
	animscripts/combat_utility::setupaim(0.2);
	thread animscripts/combat_utility::aimidlethread();
	self.a.meleestate = "aim";
	func_0D2D();
}

//Function Number: 7
stopshortly()
{
	self endon("killanimscript");
	wait 0.2;
	self.a.movement = "stop";
}

//Function Number: 8
set_aim_and_turn_limits()
{
	self setdefaultaimlimits();
	if(self.a.var_911 == "stand")
	{
		self.upaimlimit = 60;
		self.downaimlimit = -60;
	}

	self.turnthreshold = self.defaultturnthreshold;
}

//Function Number: 9
setupexposedcombatloop()
{
	thread animscripts/track::trackshootentorpos();
	thread reacquirewhennecessary();
	thread animscripts/shoot_behavior::decidewhatandhowtoshoot("normal");
	thread watchshootentvelocity();
	resetgiveuponenemytime();
	if(isdefined(self.a.magicreloadwhenreachenemy))
	{
		animscripts/weaponlist::refillclip();
		self.a.magicreloadwhenreachenemy = undefined;
	}

	self.a.dontcrouchtime = gettime() + randomintrange(500,1500);
}

//Function Number: 10
func_0CFE(param_00)
{
	if(animscripts/utility::usingrocketlauncher() && param_00 < 262144 || self.a.rockets < 1)
	{
		if(self.a.var_911 != "stand" && self.a.var_911 != "crouch")
		{
			transitionto("crouch");
		}

		if(self.a.var_911 == "stand")
		{
			animscripts/shared::throwdownweapon(%rpg_stand_throw);
		}
		else
		{
			animscripts/shared::throwdownweapon(%rpg_crouch_throw);
		}

		self clearanim(%root,0.2);
		animscripts/combat_utility::endfireandanimidlethread();
		func_0CF3();
		animscripts/combat_utility::startfireandaimidlethread();
		return 1;
	}

	return 0;
}

//Function Number: 11
exposedcombatcheckstance(param_00)
{
	if(self.a.var_911 != "stand" && self isstanceallowed("stand"))
	{
		if(param_00 < 81225)
		{
			transitionto("stand");
			return 1;
		}

		if(func_0D0B())
		{
			return 1;
		}
	}

	if(param_00 > 262144 && self.a.var_911 != "crouch" && self isstanceallowed("crouch") && !animscripts/utility::usingsidearm() && !isdefined(self.heat) && gettime() >= self.a.dontcrouchtime && lengthsquared(self.var_96C) < 10000)
	{
		if(!isdefined(self.shootpos) || sighttracepassed(self.origin + (0,0,36),self.shootpos,0,undefined))
		{
			transitionto("crouch");
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
func_0D01(param_00)
{
	if(!animscripts/utility::usingsidearm())
	{
		if(isdefined(self.forcesidearm) && self.a.var_911 == "stand")
		{
			if(tryusingsidearm())
			{
				return 1;
			}
		}

		if(animscripts/combat_utility::issniper() && param_00 < 167772.2)
		{
			if(tryusingsidearm())
			{
				return 1;
			}
		}
	}

	if(animscripts/combat_utility::needtoreload(0))
	{
		if(!animscripts/utility::usingsidearm() && common_scripts\utility::cointoss() && !animscripts/utility::usingrocketlauncher() && animscripts/utility::usingprimary() && param_00 < 167772.2 && self isstanceallowed("stand"))
		{
			if(self.a.var_911 != "stand")
			{
				transitionto("stand");
				return 1;
			}

			if(tryusingsidearm())
			{
				return 1;
			}
		}

		if(exposedreload(0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
exposedcombatcheckputawaypistol(param_00)
{
	if(animscripts/utility::usingsidearm() && self.a.var_911 == "stand" && !isdefined(self.forcesidearm))
	{
		if(param_00 > 262144 || self.combatmode == "ambush_nodes_only" && !isdefined(self.enemy) || !self cansee(self.enemy))
		{
			switchtolastweapon(%pistol_stand_switch);
		}
	}
}

//Function Number: 14
exposedcombatpositionadjust()
{
	if(isdefined(self.heat) && self nearclaimnodeandangle())
	{
		self safeteleport(self.nodeoffsetpos,self.node.angles);
	}
}

//Function Number: 15
exposedcombatneedtoturn()
{
	if(func_0D0C())
	{
		var_00 = 0.25;
		if(isdefined(self.shootent) && !issentient(self.shootent))
		{
			var_00 = 1.5;
		}

		var_01 = animscripts/shared::getpredictedaimyawtoshootentorpos(var_00);
		if(turntofacerelativeyaw(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
exposedcombatmainloop()
{
	self endon("killanimscript");
	self endon("combat_restart");
	setupexposedcombatloop();
	self animmode("zonly_physics",0);
	self orientmode("face angle",self.angles[1]);
	for(;;)
	{
		if(animscripts/utility::usingrocketlauncher())
		{
			self.deathfunction = undefined;
		}

		animscripts/utility::isincombat();
		if(waitforstancechange())
		{
			continue;
		}

		trymelee();
		exposedcombatpositionadjust();
		if(!isdefined(self.shootpos))
		{
			func_0D0E();
			if(!isdefined(self.enemy))
			{
				var_00 = 1;
			}

			continue;
		}

		resetgiveuponenemytime();
		var_01 = lengthsquared(self.origin - self.shootpos);
		if(func_0CFE(var_01))
		{
			continue;
		}

		if(exposedcombatneedtoturn())
		{
			continue;
		}

		if(considerthrowgrenade())
		{
			continue;
		}

		if(func_0D01(var_01))
		{
			continue;
		}

		if(animscripts/utility::usingrocketlauncher() && self.a.var_911 != "crouch" && randomfloat(1) > 0.65)
		{
			self.deathfunction = ::func_0D48;
		}

		exposedcombatcheckputawaypistol(var_01);
		if(exposedcombatcheckstance(var_01))
		{
			continue;
		}

		if(animscripts/combat_utility::func_CCF())
		{
			shootuntilneedtoturn();
			animscripts/combat_utility::hidefireshowaimidle();
			continue;
		}

		func_0D0A();
	}
}

//Function Number: 17
func_0D0A()
{
	if(!isdefined(self.enemy) || !self cansee(self.enemy))
	{
		self endon("enemy");
		self endon("shoot_behavior_change");
		wait 0.2 + randomfloat(0.1);
		self waittill("do_slow_things");
		return;
	}

	wait 0.05;
}

//Function Number: 18
func_0D0B()
{
	if(isdefined(self.enemy) && !self cansee(self.enemy) || !self canshootenemy() && sighttracepassed(self.origin + (0,0,64),self.enemy getshootatpos(),0,undefined))
	{
		self.a.dontcrouchtime = gettime() + 3000;
		transitionto("stand");
		return 1;
	}

	return 0;
}

//Function Number: 19
func_0D0C()
{
	var_00 = self.shootpos;
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = self.angles[1] - vectortoyaw(var_00 - self.origin);
	var_02 = distancesquared(self.origin,var_00);
	if(var_02 < 65536)
	{
		var_03 = sqrt(var_02);
		if(var_03 > 3)
		{
			var_01 = var_01 + asin(-3 / var_03);
		}
	}

	return animscripts/utility::absangleclamp180(var_01) > self.turnthreshold;
}

//Function Number: 20
waitforstancechange()
{
	var_00 = self.a.var_911;
	if(isdefined(self.a.onback))
	{
		wait 0.1;
		return 1;
	}

	if(var_00 == "stand" && isdefined(self.heat))
	{
		return 0;
	}

	if(!self isstanceallowed(var_00))
	{
		var_01 = "crouch";
		if(var_00 == "crouch")
		{
			var_01 = "stand";
		}

		if(self isstanceallowed(var_01))
		{
			if(var_00 == "stand" && animscripts/utility::usingsidearm())
			{
				return 0;
			}

			transitionto(var_01);
			return 1;
		}
	}

	return 0;
}

//Function Number: 21
func_0D0E()
{
	if(self.a.var_911 != "stand" && self isstanceallowed("stand") && func_0D0B())
	{
		return 1;
	}

	var_00 = gettime();
	self.a.dontcrouchtime = var_00 + 1500;
	if(isdefined(self.group) && isdefined(self.group.forward))
	{
		var_01 = angleclamp180(self.angles[1] - vectortoyaw(self.group.forward));
		if(turntofacerelativeyaw(var_01))
		{
			return 1;
		}
	}

	if(isdefined(self.node) && isdefined(level.iscombatscriptnode[self.node.type]))
	{
		var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		if(turntofacerelativeyaw(var_01))
		{
			return 1;
		}
	}
	else if((isdefined(self.enemy) && self seerecently(self.enemy,2)) || var_00 > self.a.scriptstarttime + 1200)
	{
		var_01 = undefined;
		var_02 = self getanglestolikelyenemypath();
		if(isdefined(var_02))
		{
			var_01 = angleclamp180(self.angles[1] - var_02[1]);
		}
		else if(isdefined(self.node))
		{
			var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		}
		else if(isdefined(self.enemy))
		{
			var_02 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
			var_01 = angleclamp180(self.angles[1] - var_02[1]);
		}

		if(isdefined(var_01) && turntofacerelativeyaw(var_01))
		{
			return 1;
		}
	}
	else if(isdefined(self.heat) && self nearclaimnode())
	{
		var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		if(turntofacerelativeyaw(var_01))
		{
			return 1;
		}
	}

	if(considerthrowgrenade())
	{
		return 1;
	}

	var_03 = self.a.nextgiveuponenemytime < var_00;
	var_04 = 0;
	if(var_03)
	{
		var_04 = 0.99999;
	}

	if(exposedreload(var_04))
	{
		return 1;
	}

	if(var_03 && animscripts/utility::usingsidearm())
	{
		if(switchtolastweapon(%pistol_stand_switch))
		{
			return 1;
		}
	}

	cantseeenemywait();
	return 1;
}

//Function Number: 22
cantseeenemywait()
{
	self endon("shoot_behavior_change");
	wait 0.4 + randomfloat(0.4);
	self waittill("do_slow_things");
}

//Function Number: 23
resetgiveuponenemytime()
{
	self.a.nextgiveuponenemytime = gettime() + randomintrange(2000,4000);
}

//Function Number: 24
turntofacerelativeyaw(param_00)
{
	if(param_00 < 0 - self.turnthreshold)
	{
		if(self.a.var_911 == "prone")
		{
			animscripts/cover_prone::proneto("crouch");
			animscripts/animset::set_animarray_crouching();
		}

		doturn("left",0 - param_00);
		maps\_gameskill::didsomethingotherthanshooting();
		return 1;
	}

	if(param_00 > self.turnthreshold)
	{
		if(self.a.var_911 == "prone")
		{
			animscripts/cover_prone::proneto("crouch");
			animscripts/animset::set_animarray_crouching();
		}

		doturn("right",param_00);
		maps\_gameskill::didsomethingotherthanshooting();
		return 1;
	}

	return 0;
}

//Function Number: 25
watchshootentvelocity()
{
	self endon("killanimscript");
	self.var_96C = (0,0,0);
	var_00 = undefined;
	var_01 = self.origin;
	var_02 = 0.15;
	for(;;)
	{
		if(isdefined(self.shootent) && isdefined(var_00) && self.shootent == var_00)
		{
			var_03 = self.shootent.origin;
			self.var_96C = var_03 - var_01 * 1 / var_02;
			var_01 = var_03;
		}
		else
		{
			if(isdefined(self.shootent))
			{
				var_01 = self.shootent.origin;
			}
			else
			{
				var_01 = self.origin;
			}

			var_00 = self.shootent;
			self.var_96C = (0,0,0);
		}

		wait var_02;
	}
}

//Function Number: 26
shouldswapshotgun()
{
	return 0;
}

//Function Number: 27
donotetrackswithendon(param_00)
{
	self endon("killanimscript");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 28
faceenemyimmediately()
{
	self endon("killanimscript");
	self notify("facing_enemy_immediately");
	self endon("facing_enemy_immediately");
	var_00 = 5;
	for(;;)
	{
		var_01 = 0 - animscripts/utility::getyawtoenemy();
		if(abs(var_01) < 2)
		{
			break;
		}

		if(abs(var_01) > var_00)
		{
			var_01 = var_00 * common_scripts\utility::sign(var_01);
		}

		self orientmode("face angle",self.angles[1] + var_01);
		wait 0.05;
	}

	self orientmode("face current");
	self notify("can_stop_turning");
}

//Function Number: 29
isdeltaallowed(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self isingoal(var_02) && self maymovetopoint(var_02);
}

//Function Number: 30
isanimdeltaingoal(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self isingoal(var_02);
}

//Function Number: 31
doturn(param_00,param_01)
{
	var_02 = isdefined(self.shootpos);
	var_03 = 1;
	var_04 = 0.2;
	var_05 = isdefined(self.enemy) && !isdefined(self.turntomatchnode) && self seerecently(self.enemy,2) && distancesquared(self.enemy.origin,self.origin) < 262144;
	if(self.a.scriptstarttime + 500 > gettime())
	{
		var_04 = 0.25;
		if(var_05)
		{
			thread faceenemyimmediately();
		}
	}
	else if(var_05)
	{
		var_06 = 1 - distance(self.enemy.origin,self.origin) / 512;
		var_03 = 1 + var_06 * 1;
		if(var_03 > 2)
		{
			var_04 = 0.05;
		}
		else if(var_03 > 1.3)
		{
			var_04 = 0.1;
		}
		else
		{
			var_04 = 0.15;
		}
	}

	var_07 = 0;
	if(param_01 > 157.5)
	{
		var_07 = 180;
	}
	else if(param_01 > 112.5)
	{
		var_07 = 135;
	}
	else if(param_01 > 67.5)
	{
		var_07 = 90;
	}
	else
	{
		var_07 = 45;
	}

	var_08 = "turn_" + param_00 + "_" + var_07;
	var_09 = animscripts/utility::animarray(var_08);
	if(isdefined(self.turntomatchnode))
	{
		self animmode("angle deltas",0);
	}
	else if(isdefined(self.node) && isdefined(level.iscombatpathnode[self.node.type]) && distancesquared(self.origin,self.node.origin) < 256)
	{
		self animmode("angle deltas",0);
	}
	else if(isanimdeltaingoal(var_09))
	{
		self animmode("zonly_physics",0);
	}
	else
	{
		self animmode("angle deltas",0);
	}

	self setanimknoball(%exposed_aiming,%body,1,var_04);
	if(!isdefined(self.turntomatchnode))
	{
		turningaimingon(var_04);
	}

	self setanimlimited(%turn,1,var_04);
	if(isdefined(self.heat))
	{
		var_03 = min(1,var_03);
	}
	else if(isdefined(self.turntomatchnode))
	{
		var_03 = max(1.5,var_03);
	}

	self setflaggedanimknoblimitedrestart("turn",var_09,1,var_04,var_03);
	self notify("turning");
	if(var_02 && !isdefined(self.turntomatchnode) && !isdefined(self.heat))
	{
		thread func_0D20();
	}

	doturnnotetracks();
	self setanimlimited(%turn,0,0.2);
	if(!isdefined(self.turntomatchnode))
	{
		turningaimingoff(0.2);
	}

	if(!isdefined(self.turntomatchnode))
	{
		self clearanim(%turn,0.2);
		self setanimknob(%exposed_aiming,1,0.2,1);
	}
	else
	{
		self clearanim(%exposed_modern,0.3);
	}

	if(isdefined(self.turnlastresort))
	{
		self.turnlastresort = undefined;
		thread faceenemyimmediately();
	}

	self animmode("zonly_physics",0);
	self notify("done turning");
}

//Function Number: 32
doturnnotetracks()
{
	self endon("can_stop_turning");
	animscripts/shared::donotetracks("turn");
}

//Function Number: 33
func_0D1D()
{
	self endon("killanimscript");
	self endon("done turning");
	var_00 = self.angles[1];
	wait 0.3;
	if(self.angles[1] == var_00)
	{
		self notify("turning_isnt_working");
		self.turnlastresort = 1;
	}
}

//Function Number: 34
turningaimingon(param_00)
{
	self setanimlimited(animscripts/utility::animarray("straight_level"),0,param_00);
	self setanim(%add_idle,0,param_00);
	if(!animscripts/utility::weapon_pump_action_shotgun())
	{
		self clearanim(%add_fire,0.2);
	}
}

//Function Number: 35
turningaimingoff(param_00)
{
	self setanimlimited(animscripts/utility::animarray("straight_level"),1,param_00);
	self setanim(%add_idle,1,param_00);
}

//Function Number: 36
func_0D20()
{
	self endon("killanimscript");
	self endon("done turning");
	if(animscripts/utility::usingrocketlauncher())
	{
		return;
	}

	animscripts/combat_utility::shootuntilshootbehaviorchange();
	self clearanim(%add_fire,0.2);
}

//Function Number: 37
shootuntilneedtoturn()
{
	thread watchforneedtoturnortimeout();
	self endon("need_to_turn");
	thread keeptryingtomelee();
	animscripts/combat_utility::shootuntilshootbehaviorchange();
	self notify("stop_watching_for_need_to_turn");
	self notify("stop_trying_to_melee");
}

//Function Number: 38
watchforneedtoturnortimeout()
{
	self endon("killanimscript");
	self endon("stop_watching_for_need_to_turn");
	var_00 = gettime() + 4000 + randomint(2000);
	for(;;)
	{
		if(gettime() > var_00 || func_0D0C())
		{
			self notify("need_to_turn");
			break;
		}

		wait 0.1;
	}
}

//Function Number: 39
considerthrowgrenade()
{
	if(!animscripts/combat_utility::func_D23())
	{
		return 0;
	}

	if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
	{
		if(tryexposedthrowgrenade(level.player,200))
		{
			return 1;
		}
	}

	if(isdefined(self.enemy) && tryexposedthrowgrenade(self.enemy,self.minexposedgrenadedist))
	{
		return 1;
	}

	self.a.nextgrenadetrytime = gettime() + 500;
	return 0;
}

//Function Number: 40
tryexposedthrowgrenade(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(self.dontevershoot) || isdefined(param_00.dontattackme))
	{
		return 0;
	}

	if(!isdefined(self.a.array["exposed_grenade"]))
	{
		return 0;
	}

	var_03 = param_00.origin;
	if(!self cansee(param_00))
	{
		if(isdefined(self.enemy) && param_00 == self.enemy && isdefined(self.shootpos))
		{
			var_03 = self.shootpos;
		}
	}

	if(!self cansee(param_00))
	{
		param_01 = 100;
	}

	if(distancesquared(self.origin,var_03) > param_01 * param_01 && self.a.var_911 == self.a.grenadethrowpose)
	{
		animscripts/combat_utility::setactivegrenadetimer(param_00);
		if(!animscripts/combat_utility::grenadecooldownelapsed(param_00))
		{
			return 0;
		}

		var_04 = animscripts/utility::getyawtospot(var_03);
		if(abs(var_04) < 60)
		{
			var_05 = [];
			foreach(var_07 in self.a.array["exposed_grenade"])
			{
				if(isdeltaallowed(var_07))
				{
					var_05[var_05.size] = var_07;
				}
			}

			if(var_05.size > 0)
			{
				self setanim(%exposed_aiming,0,0.1);
				self animmode("zonly_physics");
				animscripts/track::setanimaimweight(0,0);
				var_02 = animscripts/combat_utility::trygrenade(param_00,var_05[randomint(var_05.size)]);
				self setanim(%exposed_aiming,1,0.1);
				if(var_02)
				{
					animscripts/track::setanimaimweight(1,0.5);
				}
				else
				{
					animscripts/track::setanimaimweight(1,0);
				}
			}
		}
	}

	if(var_02)
	{
		maps\_gameskill::didsomethingotherthanshooting();
	}

	return var_02;
}

//Function Number: 41
transitionto(param_00)
{
	if(param_00 == self.a.var_911)
	{
		return;
	}

	var_01 = self.a.var_911 + "_2_" + param_00;
	if(!isdefined(self.a.array))
	{
		return;
	}

	var_02 = self.a.array[var_01];
	if(!isdefined(var_02))
	{
		return;
	}

	self clearanim(%root,0.3);
	animscripts/combat_utility::endfireandanimidlethread();
	if(param_00 == "stand")
	{
		var_03 = 2;
	}
	else
	{
		var_03 = 1.5;
	}

	if(!animhasnotetrack(var_02,"anim_pose = \" + param_00 + "\"))
	{
	}

	self setflaggedanimknoballrestart("trans",var_02,%body,1,0.2,var_03);
	var_04 = getanimlength(var_02) / var_03;
	var_05 = var_04 - 0.3;
	if(var_05 < 0.2)
	{
		var_05 = 0.2;
	}

	animscripts/notetracks::donotetracksfortime(var_05,"trans");
	self.a.var_911 = param_00;
	func_0CF3();
	animscripts/combat_utility::startfireandaimidlethread();
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 42
keeptryingtomelee()
{
	self endon("killanimscript");
	self endon("stop_trying_to_melee");
	self endon("done turning");
	self endon("need_to_turn");
	self endon("shoot_behavior_change");
	for(;;)
	{
		wait 0.2 + randomfloat(0.3);
		if(isdefined(self.enemy))
		{
			if(isplayer(self.enemy))
			{
				var_00 = -25536;
			}
			else
			{
				var_00 = 10000;
			}

			if(distancesquared(self.enemy.origin,self.origin) < var_00)
			{
				trymelee();
			}
		}
	}
}

//Function Number: 43
trymelee()
{
	animscripts/melee::melee_tryexecuting();
}

//Function Number: 44
func_0D2D()
{
	if(isdefined(self.nomeleechargedelay))
	{
		return;
	}

	if(isplayer(self.enemy))
	{
		return;
	}

	animscripts/melee::melee_standard_delaystandardcharge(self.enemy);
}

//Function Number: 45
exposedreload(param_00)
{
	if(animscripts/combat_utility::needtoreload(param_00))
	{
		self.a.exposedreloading = 1;
		animscripts/combat_utility::endfireandanimidlethread();
		var_01 = undefined;
		if(isdefined(self.specialreloadanimfunc))
		{
			var_01 = self [[ self.specialreloadanimfunc ]]();
			self.keepclaimednode = 1;
		}
		else
		{
			var_01 = animscripts/utility::animarraypickrandom("reload");
			if(self.a.var_911 == "stand" && animscripts/utility::animarrayanyexist("reload_crouchhide") && common_scripts\utility::cointoss())
			{
				var_01 = animscripts/utility::animarraypickrandom("reload_crouchhide");
			}
		}

		thread keeptryingtomelee();
		self.var_D32 = 0;
		if(weaponclass(self.weapon) == "pistol")
		{
			self orientmode("face default");
		}

		func_0D33(var_01,param_00 > 0.05);
		self notify("abort_reload");
		self orientmode("face current");
		if(self.var_D32)
		{
			animscripts/weaponlist::refillclip();
		}

		self clearanim(%reload,0.2);
		self.keepclaimednode = 0;
		self notify("stop_trying_to_melee");
		self.a.exposedreloading = 0;
		self.var_D32 = undefined;
		maps\_gameskill::didsomethingotherthanshooting();
		animscripts/combat_utility::startfireandaimidlethread();
		return 1;
	}

	return 0;
}

//Function Number: 46
func_0D33(param_00,param_01)
{
	self endon("abort_reload");
	if(param_01)
	{
		thread abortreloadwhencanshoot();
	}

	var_02 = 1;
	if(!animscripts/utility::usingsidearm() && !animscripts/utility::isshotgun(self.weapon) && isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.enemy.origin,self.origin) < 1048576)
	{
		var_02 = 1.2;
	}

	var_03 = "reload_" + animscripts/combat_utility::getuniqueflagnameindex();
	self clearanim(%root,0.2);
	self setflaggedanimrestart(var_03,param_00,1,0.2,var_02);
	thread func_0D35("abort_reload",var_03);
	self endon("start_aim");
	animscripts/shared::donotetracks(var_03);
	self.var_D32 = 1;
}

//Function Number: 47
abortreloadwhencanshoot()
{
	self endon("abort_reload");
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.shootent) && self cansee(self.shootent))
		{
			break;
		}

		wait 0.05;
	}

	self notify("abort_reload");
}

//Function Number: 48
func_0D35(param_00,param_01)
{
	self endon(param_00);
	self waittillmatch("start_aim",param_01);
	self.var_D32 = 1;
	self notify("start_aim");
}

//Function Number: 49
func_0CD6(param_00)
{
	self endon("killanimscript");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 50
drop_turret()
{
	maps\_mgturret::dropturret();
	animscripts/weaponlist::refillclip();
	self.a.needstorechamber = 0;
	self notify("dropped_gun");
	maps\_mgturret::restoredefaults();
}

//Function Number: 51
exception_exposed_mg42_portable()
{
	drop_turret();
}

//Function Number: 52
tryusingsidearm()
{
	if(isdefined(self.secondaryweapon) && animscripts/utility::isshotgun(self.secondaryweapon))
	{
		return 0;
	}

	if(isdefined(self.no_pistol_switch))
	{
		return 0;
	}

	self.a.var_911 = "stand";
	switchtosidearm(%pistol_stand_pullout);
	return 1;
}

//Function Number: 53
switchtosidearm(param_00)
{
	self endon("killanimscript");
	thread animscripts/combat_utility::func_D3E();
	animscripts/combat_utility::endfireandanimidlethread();
	self.var_D3F = param_00;
	self setflaggedanimknoballrestart("weapon swap",param_00,%body,1,0.2,animscripts/combat_utility::fasteranimspeed());
	donotetrackspostcallbackwithendon("weapon swap",::handlepickup,"end_weapon_swap");
	self clearanim(self.var_D3F,0.2);
	self notify("facing_enemy_immediately");
	self notify("switched_to_sidearm");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 54
donotetrackspostcallbackwithendon(param_00,param_01,param_02)
{
	self endon(param_02);
	animscripts/notetracks::donotetrackspostcallback(param_00,param_01);
}

//Function Number: 55
faceenemydelay(param_00)
{
	self endon("killanimscript");
	wait param_00;
	faceenemyimmediately();
}

//Function Number: 56
handlepickup(param_00)
{
	if(param_00 == "pistol_pickup")
	{
		self clearanim(animscripts/utility::animarray("straight_level"),0);
		animscripts/animset::set_animarray_standing();
		thread faceenemydelay(0.25);
		return;
	}

	if(param_00 == "start_aim")
	{
		animscripts/combat_utility::startfireandaimidlethread();
		if(func_0D0C())
		{
			self notify("end_weapon_swap");
			return;
		}
	}
}

//Function Number: 57
switchtolastweapon(param_00,param_01)
{
	self endon("killanimscript");
	if(animscripts/utility::isshotgun(self.primaryweapon) && isdefined(self.wantshotgun) && !self.wantshotgun && self.lastweapon == animscripts/utility::func_D45())
	{
		return 0;
	}

	animscripts/combat_utility::endfireandanimidlethread();
	self.var_D3F = param_00;
	self setflaggedanimknoballrestart("weapon swap",param_00,%body,1,0.1,1);
	if(isdefined(param_01))
	{
		donotetrackspostcallbackwithendon("weapon swap",::handlecleanupputaway,"end_weapon_swap");
	}
	else
	{
		donotetrackspostcallbackwithendon("weapon swap",::handleputaway,"end_weapon_swap");
	}

	self clearanim(self.var_D3F,0.2);
	self notify("switched_to_lastweapon");
	maps\_gameskill::didsomethingotherthanshooting();
	return 1;
}

//Function Number: 58
handleputaway(param_00)
{
	if(param_00 == "pistol_putaway")
	{
		self clearanim(animscripts/utility::animarray("straight_level"),0);
		animscripts/animset::set_animarray_standing();
		thread animscripts/combat_utility::func_D3E();
		return;
	}

	if(param_00 == "start_aim")
	{
		animscripts/combat_utility::startfireandaimidlethread();
		if(func_0D0C())
		{
			self notify("end_weapon_swap");
			return;
		}
	}
}

//Function Number: 59
handlecleanupputaway(param_00)
{
	if(param_00 == "pistol_putaway")
	{
		thread animscripts/combat_utility::func_D3E();
		return;
	}

	if(issubstr(param_00,"anim_gunhand"))
	{
		self notify("end_weapon_swap");
	}
}

//Function Number: 60
func_0D48()
{
	if(!animscripts/utility::usingrocketlauncher() || self.bulletsinclip == 0)
	{
		return 0;
	}

	if(randomfloat(1) > 0.5)
	{
		self setflaggedanimknoball("deathanim",%rpg_stand_death,%root,1,0.05,1);
	}
	else
	{
		self setflaggedanimknoball("deathanim",%rpg_stand_death_stagger,%root,1,0.05,1);
	}

	animscripts/shared::donotetracks("deathanim");
	animscripts/shared::dropallaiweapons();
}

//Function Number: 61
reacquirewhennecessary()
{
	self endon("killanimscript");
	self.a.exposedreloading = 0;
	for(;;)
	{
		wait 0.2;
		if(isdefined(self.enemy) && !self seerecently(self.enemy,2))
		{
			if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
			{
				continue;
			}
		}

		tryexposedreacquire();
	}
}

//Function Number: 62
tryexposedreacquire()
{
	if(self.fixednode)
	{
		return;
	}

	if(!isdefined(self.enemy))
	{
		self.reacquire_state = 0;
		return;
	}

	if(gettime() < self.teammovewaittime)
	{
		self.reacquire_state = 0;
		return;
	}

	if(isdefined(self.prevenemy) && self.prevenemy != self.enemy)
	{
		self.reacquire_state = 0;
		self.prevenemy = undefined;
		return;
	}

	self.prevenemy = self.enemy;
	if(self cansee(self.enemy) && self canshootenemy())
	{
		self.reacquire_state = 0;
		return;
	}

	if(isdefined(self.var_D32) && !self.var_D32)
	{
		self.reacquire_state = 0;
		return;
	}

	if(!isdefined(self.var_3F15) || !self.var_3F15)
	{
		var_00 = vectornormalize(self.enemy.origin - self.origin);
		var_01 = anglestoforward(self.angles);
		if(vectordot(var_00,var_01) < 0.5)
		{
			self.reacquire_state = 0;
			return;
		}
	}

	if(self.a.exposedreloading && animscripts/combat_utility::needtoreload(0.25) && self.enemy.health > self.enemy.maxhealth * 0.5)
	{
		self.reacquire_state = 0;
		return;
	}

	if(animscripts/combat_utility::shouldhelpadvancingteammate() && self.reacquire_state < 3)
	{
		self.reacquire_state = 3;
	}

	switch(self.reacquire_state)
	{
		case 0:
			if(self reacquirestep(32))
			{
				return;
			}
			break;

		case 1:
			if(self reacquirestep(64))
			{
				self.reacquire_state = 0;
				return;
			}
			break;

		case 2:
			if(self reacquirestep(96))
			{
				self.reacquire_state = 0;
				return;
			}
			break;

		case 3:
			if(animscripts/combat_utility::tryrunningtoenemy(0))
			{
				self.reacquire_state = 0;
				return;
			}
			break;

		case 4:
			if(!self cansee(self.enemy) || !self canshootenemy())
			{
				self flagenemyunattackable();
			}
			break;

		default:
			if(self.reacquire_state > 15)
			{
				self.reacquire_state = 0;
				return;
			}
			break;
	}

	self.reacquire_state++;
}