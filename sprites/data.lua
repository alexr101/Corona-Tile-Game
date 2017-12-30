local data = {}

data.files = {
	star = 'general',
	starPic = 'general',
	electricity = 'general',
	smoke = 'general'
}

data.sequences = {
	electricity = {
		{
			name = "Main",
			start =  1,
			count = 6,
			time = 700,
			loopCount = 0,
		}
	},
	smoke = {
		{
			name = "Main",
			start = 7,
			count = 14,
			time = 1000,
			loopCount = 1, 
		}
	},
	star = {
		{
			name = "Main",
			start = 21,
			count = 6,
			time = 800,
			loopCount = 0, 
		}
	},
	starPic = {
		{
			name = "StarPic",
			start = 21,
			count = 1,
			time = 0,
			loopCount = 1, 
		}
	}
}

return data