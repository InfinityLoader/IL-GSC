
main()
{
	self setModel("c_usa_sog_mp_body_camo");
	self.headModel = "c_usa_sog_mp_head_1";
	self attach(self.headModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_sog_mp_body_camo");
	precacheModel("c_usa_sog_mp_head_1");
}
 