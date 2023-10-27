/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_attack_drone_individual.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 21 ms
 * Timestamp: 10/27/2023 2:06:12 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel(param_00);
	maps\_utility::set_console_status();
	maps\_vehicle::build_template("attack_drone_individual",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathquake(0.4,0.8,1024);
	maps\_vehicle::build_life(499);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
init_local()
{
	self.script_cheap = 1;
	self.script_badplace = 0;
	self.dontdisconnectpaths = 1;
	self.contents = self setcontents(0);
	self.ignore_death_fx = 1;
	self.delete_on_death = 1;
}