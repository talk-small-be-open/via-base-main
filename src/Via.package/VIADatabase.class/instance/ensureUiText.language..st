uitext
ensureUiText: aKey language: aLanguage
	| key |
	key := self uiTextKeyFor: aKey language: aLanguage.

	uiTexts at: key ifAbsent: [
		| defaultValue |
		defaultValue := '??? ',
			(MCLPlatform splitString: aKey greaseString delimiter: $:) last.

		self uiTextAt: key put: defaultValue]