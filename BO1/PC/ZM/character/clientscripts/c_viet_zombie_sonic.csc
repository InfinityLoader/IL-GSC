
matches_me()
{
	if(self.model == "c_viet_zombie_sonic_body")
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
	level._gibbing_actor_models[level._gibbing_actor_models.size] = gib_spawn;
}
 