/// @function                   string_wrap(text, width);
/// @param  {string}    text    The text to wrap
/// @param  {real}      width   The maximum width of the text before a line break is inserted
/// @description        Take a string and add line breaks so that it doesn't overflow the maximum width

function string_wrap(_text, _width)
{
	var _text_wrapped = "";
	var _space = -1;
	var _char_pos = 1;
	while (string_length(_text) >= _char_pos)
	{
		if (string_width(string_copy(_text, 1, _char_pos)) > _width)
		{
			if (_space != -1)
		    {
				_text_wrapped += string_copy(_text, 1, _space) + "\n";
				_text = string_copy(_text, _space + 1, string_length(_text) - (_space));
				_char_pos = 1;
				_space = -1;
		    }
		}
		if (string_char_at(_text,_char_pos) == " ")
		{
			_space = _char_pos;
		}
		_char_pos += 1;
	}
	if (string_length(_text) > 0)
	{
		_text_wrapped += _text;
	}
	return _text_wrapped;
}