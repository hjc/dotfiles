function xclip --description 'Make xclip use the right clipboard by default.'
	command xclip -selection C $argv; 
end
