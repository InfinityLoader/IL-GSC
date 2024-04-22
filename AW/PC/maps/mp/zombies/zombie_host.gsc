/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_host.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 292 ms
 * Timestamp: 4/22/2024 2:15:09 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["zombie_host"] = level.agent_funcs["zombie"];
	level.agent_funcs["zombie_host"]["think"] = level.agent_funcs["zombie_generic"]["think"];
	level.agent_funcs["zombie_host"]["spawn"] = ::spawn_zombie_host;
	var_00[0] = ["zom_host_fullbody"];
	level._effect["zombie_eye_host"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_host");
	level._effect["zombie_eye_host_exec"] = loadfx("vfx/gameplay/mp/zombie/executive_eyes_host");
	level._effect["zombie_eye_host_janitor"] = loadfx("vfx/gameplay/mp/zombie/janitor_eyes_host_");
	level._effect["zombie_eye_host_it"] = loadfx("vfx/gameplay/mp/zombie/lilith_eyes_host");
	level._effect["zombie_eye_host_security"] = loadfx("vfx/gameplay/mp/zombie/securityguard_eyes_host");
	level._effect["zombie_host_hand"] = loadfx("vfx/gameplay/mp/zombie/zombie_host_hand");
	var_01 = spawnstruct();
	var_01.agent_type = "zombie_host";
	var_01.animclass = "zombie_animclass";
	var_01.model_bodies = var_00;
	var_01.health_scale = 1;
	var_01.meleedamage = 250;
	var_01.healthoverridefunc = ::calculatehosthealth;
	maps\mp\zombies\_util::agentclassregister(var_01,"zombie_host");
	level.getspawntypefunc["zombie_host"] = ::gethostroundspawntype;
	level.candroppickupsfunc["zombie_host"] = ::hostroundcandroppickups;
	level.roundstartfunc["zombie_host"] = ::hostroundstart;
	level.roundendfunc["zombie_host"] = ::hostroundend;
	level.numenemiesthisroundfunc["zombie_host"] = ::hostroundnumenemies;
	level.roundspawndelayfunc["zombie_host"] = ::hostroundspawndelay;
	level.nummaxenemiesthisroundfunc["zombie_host"] = ::hostroundmaxnumenemies;
	level.mutatorfunc["zombie_host"] = ::hostmutator;
	level.movemodefunc["zombie_host"] = ::hostcaculatemovemode;
	level.moveratescalefunc["zombie_host"] = ::hostcaculatemoveratescale;
	level.nonmoveratescalefunc["zombie_host"] = ::hostcalculatenonmoveratescale;
	level.traverseratescalefunc["zombie_host"] = ::hostcalculatetraverseratescale;
}

//Function Number: 2
spawn_zombie_host(param_00,param_01,param_02)
{
	self [[ level.agent_funcs["zombie"]["spawn"] ]](param_00,param_01,param_02);
	self.boostfxtag = "no_boost_fx";
	maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_traverse();
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_host_hand"),self,"j_wrist_ri");
}

//Function Number: 3
calculatehosthealth()
{
	var_00 = 400;
	switch(level.specialroundcounter)
	{
		case 1:
		case 0:
			var_00 = 400;
			break;

		case 2:
			var_00 = 750;
			break;

		case 3:
			var_00 = 1200;
			break;

		default:
			var_00 = 1500;
			break;
	}

	return var_00;
}

//Function Number: 4
hostroundstart()
{
	thread hostroundalarm();
}

//Function Number: 5
hostcaculatemovemode()
{
	return "sprint";
}

//Function Number: 6
hostcaculatemoveratescale()
{
	return 0.9 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 7
hostcalculatenonmoveratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 8
hostcalculatetraverseratescale()
{
	return 1.55 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 9
hostroundalarm()
{
	var_00 = spawn("script_origin",(0,0,0));
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		var_00 playsound("zmb_hst_round_start_alarm");
		wait(1.1);
	}

	var_00 delete();
}

//Function Number: 10
hostroundend()
{
	maps\mp\gametypes\zombies::createpickuporgive("ammo",level.lastenemydeathpos,"Host Round End");
}

//Function Number: 11
gethostroundspawntype(param_00,param_01)
{
	var_02 = "zombie_host";
	if(!zombiehostcanspawn())
	{
		var_02 = "zombie_generic";
	}

	if(param_00 && common_scripts\utility::mod(param_00,5) == 0)
	{
		var_02 = "zombie_generic";
	}

	return var_02;
}

//Function Number: 12
hostroundcandroppickups(param_00)
{
	return 0;
}

//Function Number: 13
zombiehostcanspawn()
{
	if(!maps\mp\zombies\_terminals::getiteminmap("host_cure"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
hostroundnumenemies(param_00)
{
	return min(52,param_00);
}

//Function Number: 15
hostroundmaxnumenemies(param_00)
{
	return param_00 - 4;
}

//Function Number: 16
hostroundspawndelay(param_00,param_01)
{
	var_02 = 1.5;
	switch(level.specialroundcounter)
	{
		case 1:
		case 0:
			var_02 = 3;
			break;

		case 2:
			var_02 = 2.5;
			break;

		case 3:
			var_02 = 2;
			break;

		default:
			var_02 = 1.5;
			break;
	}

	var_02 = var_02 - param_00 / param_01;
	return var_02;
}

//Function Number: 17
hostmutator(param_00)
{
}