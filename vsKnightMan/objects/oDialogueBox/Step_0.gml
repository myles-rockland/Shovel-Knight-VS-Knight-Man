/// @description Insert description here
// You can write your code in this editor
skipButtonPressed = (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("J")));
if (skipButtonPressed)
{
	var _len = string_length(text[text_current]);
	if (char_current < _len) //Display the whole string instantly
	{
		char_current = _len;
	}
	else //Go to the next line
    {
	    text_current += 1;
	    if (text_current > text_last)
	    {
			instance_destroy();
	    }
	    else
	    {
			text[text_current] = string_wrap(text[text_current], text_width);
			char_current = string_pos(":", text[text_current]); //Start from the first colon
	    }
    }
}