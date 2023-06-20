/// @description Insert description here
// You can write your code in this editor
draw_self(); //Draw box above HUD

//Setting text formatting
draw_set_font(shovelFont);
draw_set_colour(c_white);

//Number of messages in array
text_end = array_length(text);

//incrementing t for use in sin wave
t++;

if (text_end > 0)
{
	//Variables
	var charWidth = 8;
	var lineEnd = 40;
	var line = 0;
	var space = 0;
	var i = 1;
	var delay = 1;
	
	//Text position
	tX = 55;
	tY = 8;
	
	//Next Message
	if (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(vk_space))
	{
		//If the current text has not finished being written, immediately finish it
		if (cutoff < string_length(text[text_current]))
		{
			cutoff = string_length(text[text_current]);
			timer = 0;
		}
		//If there is more text, go to the next one
		else if (text_current < text_end - 1)
		{
			text_current++;
			cutoff = (string_pos(":", text[text_current]) != 0 ? string_pos(":", text[text_current]) : 0); //Start from either colon or very start
		}
		//If there isn't, the text is done
		else
		{
			instance_destroy();
		}
	}
	
	//Typewriter
	if (cutoff < string_length(text[text_current]))
	{
		if (timer >= delay)
		{
			cutoff++;
			timer = 0;
		}
		else timer++;
	}
	
	//Draw the text
	while (i <= string_length(text[text_current]) && i <= cutoff)
	{
		//Check for modifier
		if (string_char_at(text[text_current], i) == "\\")
		{
			modifier = string_char_at(text[text_current], ++i);
			++i;
		}
		
		//Go to next line
		var length = 0;
		while (string_char_at(text[text_current], i) != " " && i <= string_length(text[text_current]))
		{
			i++;
			length++;
		}
		
		if (space + length > lineEnd)
		{
			space = 0;
			line++;
		}
		i -= length;
		
		//Text
		switch(modifier)
		{
			case "0": //normal
			{
				draw_set_colour(c_white);
				draw_text(tX+(space*charWidth), tY+(12*line), string_char_at(text[text_current], i));
				break;
			}
			case "s": //shaky
			{
				draw_set_colour(c_white);
				draw_text(floor(tX+(space*charWidth)+random_range(-1,1)), floor(tY+(12*line)+random_range(-1,1)), string_char_at(text[text_current], i));
				break;
			}
			case "w": //wavy
			{
				var so = t + i;
				var shift = sin(so*pi*freq/60)*amplitude;
				draw_set_colour(c_white);
				draw_text(tX+(space*charWidth), round(tY+(12*line)+shift), string_char_at(text[text_current], i));
				break;
			}
		}
		
		space++;
		i++;
	}
	
	//Draw the portrait
	if (string_starts_with(text[text_current], "\\0knight man"))
	{
		draw_sprite(sEnemyDialogue, 0, 0, 0);
	}
	else
	{
		draw_sprite(sPlayerDialogue, 0, 0, 0);
	}
	
	//Drawing coloured names
	if (string_starts_with(text[text_current], "\\0knight man"))
	{
		draw_set_colour(#0000c4); //Knight Man colour
	}
	else if (string_starts_with(text[text_current], "\\0shovel knight"))
	{
		draw_set_colour(#38c0fc); //Shovel Knight colour
	}
	draw_text(tX, round(tY), string_copy(text[text_current], 3, string_pos(":", text[text_current]) - 3));
	draw_set_colour(c_white); //Set colour back to white to not interfere with other gui
}