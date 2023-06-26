/// @description Insert description here
// You can write your code in this editor
input = instance_nearest(x, y, oInput);

cursorAnimCounter++; //Keep animating the cursor until a choice is made

if (startGameCounter > 0)
{
	cursorAnimCounter = 0; //Move the cursor across the screen
	cursorPosChange += 5;
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
		room_goto(firstBattle);
	}
}
else if (exitGameCounter > 0)
{
	cursorAnimCounter = 0; //Move the cursor across the screen
	cursorPosChange += 5;
	exitGameCounter++;
	downKeyPressed = false; //Disabling inputs
	upKeyPressed = false;
	confirmKeyPressed = false;
	if (exitGameCounter == 120)
	{
		game_end();
	}
}
else if (instance_exists(oControlsBox))
{
	input.downPressed = false;
	input.upPressed = false;
	input.confirmPressed = false;
}

//Change selection based on inputs
if (input.downPressed)
{
	selection++;
	if (selection == array_length(choices))
	{
		selection = 0;
	}
	audio_play_sound(sfxMenuCursorMove, 0, false);
}
else if (input.upPressed)
{
	selection--;
	if (selection == -1)
	{
		selection = array_length(choices) - 1;
	}
	audio_play_sound(sfxMenuCursorMove, 0, false);
}
else if (input.confirmPressed)
{
	switch(choices[selection])
	{
		case "start game":
			startGameCounter++;
			audio_stop_sound(musTitle);
			instance_destroy(oMusicTitle);
			audio_play_sound(sfxStartGame, 0, false);
		break;
		//Create a case for "controls" where it creates an instance of oControlsTip
		case "controls":
			if (!instance_exists(oControlsBox))
			{
				instance_create_layer(112, 72, "Instances", oControlsBox);
				audio_play_sound(sfxMenuConfirm, 0, false);
			}
		break;
		case "exit":
			exitGameCounter++;
			audio_play_sound(sfxMenuConfirm, 0, false);
		break;
	}
}