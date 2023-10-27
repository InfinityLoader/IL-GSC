/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 425 ms
 * Timestamp: 10/27/2023 2:30:26 AM
*******************************************************************/

//Function Number: 1
func_1C1A(param_00)
{
	self.weaponinfo[param_00] = spawnstruct();
	self.weaponinfo[param_00].var_1C1B = "none";
	self.weaponinfo[param_00].var_1C1C = 1;
	if(getweaponclipmodel(param_00) != "")
	{
		self.weaponinfo[param_00].var_1C1D = 1;
		return;
	}

	self.weaponinfo[param_00].var_1C1D = 0;
}

//Function Number: 2
isweaponinitialized(param_00)
{
	return isdefined(self.weaponinfo[param_00]);
}

//Function Number: 3
setglobalaimsettings()
{
	anim.var_898 = 55;
	anim.aimyawdifffartolerance = 10;
	anim.aimyawdiffclosedistsq = 4096;
	anim.aimyawdiffclosetolerance = 45;
	anim.aimpitchdifftolerance = 20;
	anim.painyawdifffartolerance = 25;
	anim.painyawdiffclosedistsq = level.aimyawdiffclosedistsq;
	anim.painyawdiffclosetolerance = level.aimyawdiffclosetolerance;
	anim.painpitchdifftolerance = 30;
	anim.maxanglecheckyawdelta = 65;
	anim.maxanglecheckpitchdelta = 65;
}

//Function Number: 4
func_1C24()
{
	if(animscripts/utility::isshotgun(self.secondaryweapon))
	{
		return 1;
	}

	if(weaponclass(self.primaryweapon) == "rocketlauncher")
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
main()
{
	self.a = spawnstruct();
	self.a.laseron = 0;
	self.primaryweapon = self.weapon;
	firstinit();
	if(self.primaryweapon == "")
	{
		self.primaryweapon = "none";
	}

	if(self.secondaryweapon == "")
	{
		self.secondaryweapon = "none";
	}

	if(self.sidearm == "")
	{
		self.sidearm = "none";
	}

	func_1C1A(self.primaryweapon);
	func_1C1A(self.secondaryweapon);
	func_1C1A(self.sidearm);
	self setdefaultaimlimits();
	self.a.weaponpos["left"] = "none";
	self.a.weaponpos["right"] = "none";
	self.a.weaponpos["chest"] = "none";
	self.a.weaponpos["back"] = "none";
	self.a.weaponposdropping["left"] = "none";
	self.a.weaponposdropping["right"] = "none";
	self.a.weaponposdropping["chest"] = "none";
	self.a.weaponposdropping["back"] = "none";
	self.lastweapon = self.weapon;
	self.root_anim = %root;
	thread func_17A7();
	var_00 = animscripts/utility::usingrocketlauncher();
	self.a.neverlean = var_00;
	if(var_00)
	{
		thread animscripts/shared::rpgplayerrepulsor();
	}

	self.a.rockets = 3;
	self.a.rocketvisible = 1;
	self.a.var_911 = "stand";
	self.a.grenadethrowpose = "stand";
	self.a.movement = "stop";
	self.a.state = "stop";
	self.a.special = "none";
	self.a.gunhand = "none";
	self.a.prevputguninhandtime = -1;
	self.dropweapon = 1;
	self.minexposedgrenadedist = 750;
	animscripts/shared::placeweaponon(self.primaryweapon,"right");
	if(animscripts/utility::isshotgun(self.secondaryweapon))
	{
		animscripts/shared::placeweaponon(self.secondaryweapon,"back");
	}

	self.a.needstorechamber = 0;
	self.a.var_1C2B = gettime();
	self.a.lastenemytime = gettime();
	self.a.var_1C2D = 0;
	self.a.disablelongdeath = !self isbadguy();
	self.a.lookangle = 0;
	self.a.paintime = 0;
	self.a.lastshoottime = 0;
	self.a.nextgrenadetrytime = 0;
	self.a.reacttobulletchance = 0.8;
	if(self.team != "allies")
	{
		self.has_no_ir = 1;
	}

	self.a.var_1C2F = undefined;
	self.a.stance = "stand";
	self.chooseposefunc = ::animscripts/utility::choosepose;
	self._animactive = 0;
	self._lastanimtime = 0;
	thread func_1C43();
	self.baseaccuracy = 1;
	self.a.var_1556 = 0;
	self.a.nodeath = 0;
	self.a.var_1556 = 0;
	self.a.var_1C32 = 0;
	self.a.disablepain = 0;
	self.accuracystationarymod = 1;
	self.chatinitialized = 0;
	self.sightpostime = 0;
	self.var_1C35 = 1;
	self.var_1C36 = 1;
	self.defaultturnthreshold = 55;
	self.a.nextstandinghitdying = 0;
	if(!isdefined(self.script_forcegrenade))
	{
		self.script_forcegrenade = 0;
	}

	setupuniqueanims();
	animscripts/weaponlist::refillclip();
	self.lastenemysighttime = 0;
	self.combattime = 0;
	self.suppressed = 0;
	self.suppressedtime = 0;
	if(self.team == "allies")
	{
		self.suppressionthreshold = 0.5;
	}
	else
	{
		self.suppressionthreshold = 0;
	}

	if(self.team == "allies")
	{
		self.var_1C38 = 0;
	}
	else
	{
		self.var_1C38 = 256;
	}

	self.ammocheatinterval = 8000;
	self.ammocheattime = 0;
	animscripts/animset::func_88B();
	self.exception = [];
	self.exception["corner"] = 1;
	self.exception["cover_crouch"] = 1;
	self.exception["stop"] = 1;
	self.exception["stop_immediate"] = 1;
	self.exception["move"] = 1;
	self.exception["exposed"] = 1;
	self.exception["corner_normal"] = 1;
	var_01 = getarraykeys(self.exception);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		common_scripts\utility::clear_exception(var_01[var_02]);
	}

	self.reacquire_state = 0;
	thread setnameandrank_andaddtosquad();
	self.shouldconserveammotime = 0;
	thread animscripts/combat_utility::monitorflash();
	thread ondeath();
}

//Function Number: 6
weapons_with_ir(param_00)
{
	var_01[0] = "m4_grenadier";
	if(!isdefined(var_01))
	{
		return 0;
	}

	for(var_02 = 0;var_02 < var_41.size;var_02++ = var_41[3])
	{
		if(issubstr(var_01,var_41[var_02]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
setnameandrank_andaddtosquad()
{
	self endon("death");
	if(!isdefined(level.loadoutcomplete))
	{
		level waittill("loadout complete");
	}

	maps\_names::get_name();
	thread animscripts/squadmanager::addtosquad();
}

//Function Number: 8
pollallowedstancesthread()
{
	for(;;)
	{
		if(self isstanceallowed("stand"))
		{
			var_00[0] = "stand allowed";
			var_01[0] = (0,1,0);
		}
		else
		{
			var_00[0] = "stand not allowed";
			var_01[0] = (1,0,0);
		}

		if(self isstanceallowed("crouch"))
		{
			var_00[1] = "crouch allowed";
			var_01[1] = (0,1,0);
		}
		else
		{
			var_00[1] = "crouch not allowed";
			var_01[1] = (1,0,0);
		}

		if(self isstanceallowed("prone"))
		{
			var_00[2] = "prone allowed";
			var_01[2] = (0,1,0);
		}
		else
		{
			var_00[2] = "prone not allowed";
			var_01[2] = (1,0,0);
		}

		var_02 = self getshootatpos() + (0,0,30);
		var_03 = (0,0,-10);
		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
			var_05 = (var_02[0] + var_03[0] * var_04,var_02[1] + var_03[1] * var_04,var_02[2] + var_03[2] * var_04);
		}

		wait 0.05;
	}
}

//Function Number: 9
setupuniqueanims()
{
	if(!isdefined(self.animplaybackrate) || !isdefined(self.moveplaybackrate))
	{
		func_1C40();
	}
}

//Function Number: 10
func_1C40()
{
	self.animplaybackrate = 0.9 + randomfloat(0.2);
	self.movetransitionrate = 0.9 + randomfloat(0.2);
	self.moveplaybackrate = 1;
	self.sidesteprate = 1.35;
}

//Function Number: 11
infiniteloop(param_00,param_01,param_02,param_03)
{
	anim waittill("new exceptions");
}

//Function Number: 12
empty(param_00,param_01,param_02,param_03)
{
}

//Function Number: 13
func_1C43()
{
	self endon("death");
	if(1)
	{
		return;
	}

	for(;;)
	{
		self waittill("enemy");
		if(!isalive(self.enemy))
		{
			continue;
		}

		while(isplayer(self.enemy))
		{
			if(animscripts/utility::hasenemysightpos())
			{
				level.lastplayersighted = gettime();
			}

			wait 2;
		}
	}
}

//Function Number: 14
func_1C45()
{
	level.window_down_height[0] = -36.8552;
	level.window_down_height[1] = -27.0095;
	level.window_down_height[2] = -15.5981;
	level.window_down_height[3] = -4.37769;
	level.window_down_height[4] = 17.7776;
	level.window_down_height[5] = 59.8499;
	level.window_down_height[6] = 104.808;
	level.window_down_height[7] = 152.325;
	level.window_down_height[8] = 201.052;
	level.window_down_height[9] = 250.244;
	level.window_down_height[10] = 298.971;
	level.window_down_height[11] = 330.681;
}

//Function Number: 15
firstinit()
{
	if(isdefined(level.notfirsttime))
	{
		return;
	}

	anim.notfirsttime = 1;
	animscripts/animset::func_84F();
	anim.usefacialanims = 0;
	maps\_load::init_level_players();
	level.player.invul = 0;
	level.nextgrenadedrop = randomint(3);
	level.lastplayersighted = 100;
	anim.defaultexception = ::empty;
	initdeveloperdvars();
	setdvar("scr_expDeathMayMoveCheck","on");
	maps\_names::setup_names();
	anim.var_1C4B = 0;
	animscripts/init_move_transitions::initmovestartstoptransitions();
	animscripts/reactions::func_B07();
	anim.var_1C4C = 10000;
	anim.var_1C4D = 6000;
	initgrenades();
	func_1C6A();
	animscripts/utility::func_1C4E("none");
	if(!isdefined(level.optionalstepeffectfunction))
	{
		anim.optionalstepeffectsmallfunction = ::animscripts/notetracks::playfootstepeffectsmall;
		anim.optionalstepeffectfunction = ::animscripts/notetracks::playfootstepeffect;
	}

	if(!isdefined(level.var_1C53))
	{
		anim.var_1C53 = [];
	}

	if(!isdefined(level.optionalstepeffectssmall))
	{
		anim.optionalstepeffectssmall = [];
	}

	anim.shootenemywrapper_func = ::animscripts/utility::shootenemywrapper_shootnotify;
	level.fire_notetrack_functions["scripted"] = ::animscripts/notetracks::fire_straight;
	level.fire_notetrack_functions["cover_right"] = ::animscripts/notetracks::shootnotetrack;
	level.fire_notetrack_functions["cover_left"] = ::animscripts/notetracks::shootnotetrack;
	level.fire_notetrack_functions["cover_crouch"] = ::animscripts/notetracks::shootnotetrack;
	level.fire_notetrack_functions["cover_stand"] = ::animscripts/notetracks::shootnotetrack;
	level.fire_notetrack_functions["move"] = ::animscripts/notetracks::shootnotetrack;
	animscripts/notetracks::registernotetracks();
	if(!isdefined(level.flag))
	{
		common_scripts\utility::init_flags();
	}

	maps\_gameskill::setskill();
	level.painai = undefined;
	animscripts/setposemovement::initposemovementfunctions();
	animscripts/face::initlevelface();
	anim.burstfirenumshots = animscripts/utility::array(1,2,2,2,3,3,3,3,4,4,5);
	anim.var_1C5D = animscripts/utility::array(2,3,3,3,4,4,4,5,5);
	anim.var_1C5E = animscripts/utility::array(1,2,2,3,3,4,4,4,4,5,5,5);
	anim.badplaces = [];
	anim.var_1C5F = 0;
	anim.player = getentarray("player","classname")[0];
	initbattlechatter();
	func_1C45();
	animscripts/flashed::initflashed();
	animscripts/cqb::func_C65();
	func_1C63();
	setglobalaimsettings();
	anim.lastcarexplosiontime = -100000;
	func_1C77();
	level.player thread animscripts/combat_utility::watchreloading();
	thread aiturnnotifies();
}

//Function Number: 16
initdeveloperdvars()
{
}

//Function Number: 17
initbattlechatter()
{
	animscripts/squadmanager::func_676();
	level.player thread animscripts/squadmanager::addplayertosquad();
	animscripts/battlechatter::init_battlechatter();
	level.player thread animscripts/battlechatter_ai::addtosystem();
	anim thread animscripts/battlechatter::bcsdebugwaiter();
}

//Function Number: 18
func_1C63()
{
	anim.numdeathsuntilcrawlingpain = randomintrange(0,15);
	anim.numdeathsuntilcornergrenadedeath = randomintrange(0,10);
	anim.nextcrawlingpaintime = gettime() + randomintrange(0,20000);
	anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(0,10000);
	anim.nextcornergrenadedeathtime = gettime() + randomintrange(0,15000);
}

//Function Number: 19
initgrenades()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		var_01 = level.players[var_00];
		var_01.grenadetimers["fraggrenade"] = randomintrange(1000,20000);
		var_01.grenadetimers["flash_grenade"] = randomintrange(1000,20000);
		var_01.grenadetimers["double_grenade"] = randomintrange(1000,-5536);
		var_01.var_1C66 = 0;
		var_01.lastgrenadelandednearplayertime = -1000000;
		var_01.lastfraggrenadetoplayerstart = -1000000;
		var_01 thread setnextplayergrenadetime();
	}

	level.grenadetimers["AI_fraggrenade"] = randomintrange(0,20000);
	level.grenadetimers["AI_flash_grenade"] = randomintrange(0,20000);
	level.grenadetimers["AI_smoke_grenade_american"] = randomintrange(0,20000);
	animscripts/combat_utility::initgrenadethrowanims();
}

//Function Number: 20
func_1C6A()
{
	level.var_1C6B = [];
	level.var_1C6B["axis"] = 0;
	level.var_1C6B["allies"] = 0;
	level.var_1C6B["team3"] = 0;
	level.var_1C6B["neutral"] = 0;
	level.var_1C6C = [];
	level.var_1C6C["axis"] = (0,0,0);
	level.var_1C6C["allies"] = (0,0,0);
	level.var_1C6C["team3"] = (0,0,0);
	level.var_1C6C["neutral"] = (0,0,0);
	level.lastadvancetoenemysrc = [];
	level.lastadvancetoenemysrc["axis"] = (0,0,0);
	level.lastadvancetoenemysrc["allies"] = (0,0,0);
	level.lastadvancetoenemysrc["team3"] = (0,0,0);
	level.lastadvancetoenemysrc["neutral"] = (0,0,0);
	level.lastadvancetoenemyattacker = [];
	level.var_1C6F = [];
	level.var_1C6F["axis"] = 0;
	level.var_1C6F["allies"] = 0;
	level.var_1C6F["team3"] = 0;
	level.var_1C6F["neutral"] = 0;
	level.advancetoenemyinterval = 30000;
	level.advancetoenemygroupmax = 3;
}

//Function Number: 21
aiturnnotifies()
{
	var_00 = 0;
	var_01 = 3;
	for(;;)
	{
		var_02 = getaiarray();
		if(var_02.size == 0)
		{
			wait 0.05;
			var_00 = 0;
			continue;
		}

		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(!isdefined(var_02[var_03]))
			{
				continue;
			}

			var_02[var_03] notify("do_slow_things");
			var_00++;
			if(var_00 == var_01)
			{
				wait 0.05;
				var_00 = 0;
			}
		}
	}
}

//Function Number: 22
setnextplayergrenadetime()
{
	waittillframeend;
	if(isdefined(self.var_1C74.var_1C75))
	{
		var_00 = int(self.var_1C74.var_1C75 * 0.7);
		if(var_00 < 1)
		{
			var_00 = 1;
		}

		self.grenadetimers["fraggrenade"] = randomintrange(0,var_00);
		self.grenadetimers["flash_grenade"] = randomintrange(0,var_00);
	}

	if(isdefined(self.var_1C74.var_1C76))
	{
		var_00 = int(self.var_1C74.var_1C76);
		var_01 = int(var_00 / 2);
		if(var_00 <= var_01)
		{
			var_00 = var_01 + 1;
		}

		self.grenadetimers["double_grenade"] = randomintrange(var_01,var_00);
	}
}

//Function Number: 23
func_17A7()
{
	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_00 thread maps\_utility::grenade_earthquake();
	}
}

//Function Number: 24
func_1C77()
{
	anim.randominttablesize = 60;
	anim.randominttable = [];
	for(var_00 = 0;var_00 < level.randominttablesize;var_00++)
	{
		level.randominttable[var_00] = var_00;
	}

	for(var_00 = 0;var_00 < level.randominttablesize;var_00++)
	{
		var_01 = randomint(level.randominttablesize);
		var_02 = level.randominttable[var_00];
		level.randominttable[var_00] = level.randominttable[var_01];
		level.randominttable[var_01] = var_02;
	}
}

//Function Number: 25
ondeath()
{
	if(isdefined(level.var_1C7B))
	{
		return;
	}

	self waittill("death");
	if(!isdefined(self))
	{
		if(isdefined(self.a.usingturret))
		{
			self.a.usingturret delete();
		}
	}
}