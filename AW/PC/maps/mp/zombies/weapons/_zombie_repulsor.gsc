/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_repulsor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 58 ms
 * Timestamp: 4/22/2024 2:13:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["dlc_repulsor"] = loadfx("vfx/gameplay/mp/zombie/dlc_repulsor");
}

//Function Number: 2
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self notify("onPlayerSpawnZombieRepulsor");
	self endon("onPlayerSpawnZombieRepulsor");
	var_00 = self.team;
	for(;;)
	{
		self waittill("grenade_fire",var_01,var_02);
		var_03 = maps\mp\_utility::strip_suffix(var_02,"_lefthand");
		if(var_03 != "repulsor_zombie_mp")
		{
			continue;
		}

		var_04 = (var_01.origin[0],var_01.origin[1],self.origin[2] + 20);
		var_01 delete();
		dorepulsor(var_04,var_00);
	}
}

//Function Number: 3
dorepulsor(param_00,param_01)
{
	var_02 = self.angles;
	var_03 = (0,0,1);
	playfx(common_scripts\utility::getfx("dlc_repulsor"),self.origin,var_02,var_03);
	self radiusdamage(param_00,500,100,25,self,"MOD_EXPLOSIVE","repulsor_zombie_mp");
	wait(0.1);
	physicsexplosionsphere(param_00,500,0,10,0);
}