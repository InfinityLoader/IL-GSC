/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_terrace.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 155 ms
 * Timestamp: 4/22/2024 2:18:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_terrace_precache::main();
	maps\createart\mp_terrace_art::main();
	maps\mp\mp_terrace_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_terrace_lighting::main();
	maps\mp\mp_terrace_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_terrace");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.allow_swimming = 0;
	level thread maps\mp\_water::init();
	level.aerial_pathnode_group_connect_dist = 400;
	level.mapcustomkillstreakfunc = ::terracecustomkillstreakfunc;
	level thread init_turbines();
	level thread init_blimps();
	level thread init_bells();
	level.orbitalsupportoverridefunc = ::terracecustomospfunc;
	level.ospvisionset = "mp_terrace_osp";
	level.osplightset = "mp_terrace_osp";
	level.dronevisionset = "mp_terrace_drone";
	level.dronelightset = "mp_terrace_drone";
	level.warbirdvisionset = "mp_terrace_warbird";
	level.warbirdlightset = "mp_terrace_warbird";
}

//Function Number: 2
terracecustomospfunc()
{
	level.orbitalsupportoverrides.spawnanglemin = 180;
	level.orbitalsupportoverrides.spawnanglemax = 270;
	if(level.currentgen)
	{
		level.orbitalsupportoverrides.leftarc = 17.5;
		level.orbitalsupportoverrides.rightarc = 17.5;
		level.orbitalsupportoverrides.toparc = -35;
		level.orbitalsupportoverrides.bottomarc = 60;
	}
}

//Function Number: 3
terracecustomkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_terrace::init();
}

//Function Number: 4
init_turbines()
{
	var_00 = getentarray("turbine_blades","targetname");
	common_scripts\utility::array_thread(var_00,::turbine_spin);
}

//Function Number: 5
turbine_spin()
{
	var_00 = 1800;
	var_01 = randomfloatrange(30,60);
	for(;;)
	{
		self rotatevelocity((0,var_01,0),var_00);
		wait(var_00);
	}
}

//Function Number: 6
init_blimps()
{
	var_00 = getentarray("blimp","targetname");
	common_scripts\utility::array_thread(var_00,::blimp_run);
}

//Function Number: 7
blimp_run()
{
	var_00 = 600;
	var_01 = self;
	while(isdefined(var_01.target))
	{
		var_01 = common_scripts\utility::getstruct(var_01.target,"targetname");
		if(!isdefined(var_01))
		{
			return;
		}

		self moveto(var_01.origin,var_00,var_00 * 0.1,var_00 * 0.1);
		self rotateto(var_01.angles,var_00,var_00 * 0.1,var_00 * 0.1);
		wait(var_00);
	}
}

//Function Number: 8
init_bells()
{
	var_00 = getentarray("bell_collision","targetname");
	common_scripts\utility::array_thread(var_00,::bell_run);
}

//Function Number: 9
bell_run()
{
	self setcandamage(1);
	self ghost();
	for(;;)
	{
		self.health = 1000;
		self waittill("damage");
		self playsound("physics_bell_default");
	}
}