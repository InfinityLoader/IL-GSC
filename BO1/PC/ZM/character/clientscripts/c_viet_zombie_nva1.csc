
matches_me()
{
	if(self.model == "c_viet_zombie_nva1_body")
	{
		return true;
	}
	return(false);
}
register_gibs()
{
	if(!isDefined(level._gibbing_actor_models))
	{
		level._gibbing_actor_models = [];
	}
	gib_spawn = spawnstruct();
	gib_spawn.matches_me = ::matches_me;
	gib_spawn.gibSpawn1 = "c_viet_zombie_vc_rarmspawn";
	gib_spawn.gibSpawnTag1 = "J_Elbow_RI";
	gib_spawn.gibSpawn2 = "c_viet_zombie_vc_larmspawn";
	gib_spawn.gibSpawnTag2 = "J_Elbow_LE";
	gib_spawn.gibSpawn3 = "c_viet_zombie_vc_rlegspawn";
	gib_spawn.gibSpawnTag3 = "J_Knee_RI";
	gib_spawn.gibSpawn4 = "c_viet_zombie_vc_llegspawn";
	gib_spawn.gibSpawnTag4 = "J_Knee_LE";
	level._gibbing_actor_models[level._gibbing_actor_models.size] = gib_spawn;
}
 