
main()
{
	self setModel("c_usa_pent_ciaagent_body_zt");
	self.headModel = "c_usa_pent_head3_sunglasses";
	self attach(self.headModel, "", true);
	self.voice = "russian";
	self.skeleton = "base";
}
precache()
{
	precacheModel("c_usa_pent_ciaagent_body_zt");
	precacheModel("c_usa_pent_head3_sunglasses");
}
 