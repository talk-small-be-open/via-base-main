rendering
renderToolbarOn: html
	html heading level2; t: 'examModuleTeacher:title'.
	html heading level3; with: model displayName.
	html ukAnchorButton
		callback: [self createNewExam];
		with: [
			html iconAdd; space.
			html t: 'examModuleTeacher:createNewExam'.
		].
	html space.
	html ukAnchorButton
		callback: [self previewTestExamModule];
		with: [
			html iconPreview; space.
			html t: 'examModuleTeacher:previewExamModule'].
	html space.
	html ukAnchorButton
		callback: [self refresh];
		with: [
			html iconRefresh; space.
			html t: 'examModuleTeacher:refresh'.
		].