icons
iconDurationTag: aDurationTag
	aDurationTag ifNil: [^self].
	
	self image
"		class: 'icon';"
		class: 'hm-kuchen';
		url: '/files/images/', (aDurationTag duration min: 4) asString, '-4-kuchen.svg'