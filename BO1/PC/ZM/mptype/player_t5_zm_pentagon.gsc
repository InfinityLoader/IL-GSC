
main()
{
	switch( codescripts\character::get_random_character(4) )
	{
		case 0:
		character\c_usa_nixon_zt::main();
		break;
		case 1:
		character\c_cub_castro_zt::main();
		break;
		case 2:
		character\c_usa_jfk_zt::main();
		break;
		case 3:
		character\c_usa_mcnamara_zt::main();
		break;
	}
}
precache()
{
	character\c_usa_nixon_zt::precache();
	character\c_cub_castro_zt::precache();
	character\c_usa_jfk_zt::precache();
	character\c_usa_mcnamara_zt::precache();
}
 