as yet unclassified
renderContentOn: html
	html form: [
		html label: 'First name'.
		html textInput on: #firstName of: model.
		html label: 'Last name'.
		html textInput on: #lastName of: model.
		html label: 'Email'.
		html textInput on: #email of: model.
		html label  class: 'topBuffer'; with: 'Roles'.
		html multiSelect
			list: VIAUser allRoles;
			on: #roles of: model.

		html label class: 'topBuffer'; with: 'Password:'.
		html submitButton
			callback: [self setPassword];
			with: 'Set password ...'.
		html space.
		html submitButton
			callback: [self testPassword];
			with: 'Test password ...'.

		html div class: 'topBuffer'; with: [
			html submitButton
				callback: [self save];
				with: 'Save'.
			html space.
			html ukAnchorButton
				callback: [self cancel];
				with: 'Cancel'
		]]