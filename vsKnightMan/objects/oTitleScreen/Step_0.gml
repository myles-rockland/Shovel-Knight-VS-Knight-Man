/// @description Insert description here
// You can write your code in this editor
downKeyPressed = keyboard_check_pressed(ord("S"));
upKeyPressed = keyboard_check_pressed(ord("W"));
confirmKeyPressed = (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(vk_space));

if (startGameCounter > 0)
{
	startGameCounter++;
	downKeyPressed = false; //Disabling inputs
	upKeyPressed = false;
	confirmKeyPressed = false;
	if (startGameCounter == 120)
	{
		instance_create_layer(0, 0, "Instances", oCurtainTransitionOutro);
	}
	else if (startGameCounter > 120 && !instance_exists(oCurtainTransitionOutro))
	{
		room_goto(mainBattle);
	}
}

//Change selection based on inputs
if (downKeyPressed)
{
	selection++;
	if (selection == array_length(choices))
	{
		selection = 0;
	}
}
else if (upKeyPressed)
{
	selection--;
	if (selection == -1)
	{
		selection = array_length(choices) - 1;
	}
}
else if (confirmKeyPressed)
{
	switch(choices[selection])
	{
		case "start game":
			startGameCounter++;
		break;
		//Create a case for "controls" where it creates an instance of oControlsTip
		case "exit":
			game_end();
		break;
	}
}