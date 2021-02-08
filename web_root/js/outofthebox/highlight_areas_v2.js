// Outofthebox JS for VIAHighlightAreasV2Renderer

function highlightAreas_onDragEnter(event, id) {
	highlightAreas_selectFromTo($("#" + id), event.relatedTarget, event.target);
}

function highlightAreas_onDragLeave(event, id) {
	highlightAreas_unselect($("#" + id), event.target);
}

function highlightAreas_selectFromTo(taskElement, startElement, endElement) {
	var all = $(taskElement).data("allSelChars");
	var a = all.index(startElement); 
	var b = all.index(endElement);
	if (a>b) {[a, b] = [b, a]}
	all.removeClass("selected").slice(a, b+1).addClass("selected");
}

function highlightAreas_unselect(taskElement, element) {
	$(element).removeClass("selected");
}

function highlightAreas_resetTouch(taskElement) {
	$(taskElement).data("allSelChars").removeClass('touchedNow');
}

// function highlightAreas_onDragLeave(event, id) {
// 	var all = $("#" + id).data("allSelChars");
// 	var a = all.index(event.relatedTarget); 
// 	var b = all.index(event.target);
// 	if (a>b) {[a, b] = [b, a]}
// 	all.removeClass("selected").slice(a, b+1).addClass("selected");
// }


function highlightAreas_highlightFromTo(taskElement, startElement, endElement) {

	var all = taskElement.data("allSelChars");
	var a = all.index(startElement); 
	var b = all.index(endElement); 

	if (a>b) {[a, b] = [b, a]}

	var highlighted = all.slice(a, b+1);
	all.removeClass("selected");
	var toggle = true;
	if ( (startElement != endElement) && ($(startElement).hasClass("highlighted") && $(endElement).hasClass("highlighted"))) {
		toggle = false;
	}
	highlighted.toggleClass("highlighted", toggle).addClass('touchedNow');

	// var map = all.map(function(i,e){return $(e).hasClass("highlighted") ? e.textContent : notHighlightedSymbol}).get().join("");
	// taskElement.find("input.charsMap").val(map);
	highlightAreas_scan(taskElement);

	var text = highlighted.text();	
	taskElement.trigger("via:highlightchanged", [text]);
	
	// Hit detection. Selection has to be within an area, then we fire some ajax
	var leftArea = $(startElement).closest("span.highlightArea");
	var rightArea = $(endElement).closest("span.highlightArea");
	if (leftArea[0] && (leftArea[0] == rightArea[0])) {
		leftArea.trigger("via:highlightinarea", [text]);
	}
}

// Click on an already highlighted area. Remove highlight.
function highlightAreas_onClick(event, id) {
	var me = event.target;
	
	if ( !$(me).hasClass("selChar highlighted") || $(me).hasClass('touchedNow') ) {
		return
	}

	var taskElement = $("#"+id);
	var all = taskElement.data("allSelChars");
	var groups = runningGroupArray(all, function(each){ return $(each).hasClass("highlighted") });
	var myGroup = groups.find(function(each){return _.includes(each, me)})
	$(myGroup).removeClass("highlighted");

	highlightAreas_scan(taskElement);

	taskElement.trigger("via:highlightchanged");

}

function highlightAreas_onStart(event, id) {
	var taskElement = $("#"+id);
	highlightAreas_selectFromTo(taskElement, event.target, event.target);
}

function highlightAreas_onEnd(event, id) {
	var taskElement = $("#"+id);
	highlightAreas_highlightFromTo(taskElement, event.relatedTarget || event.target, event.target);
	var all = taskElement.data("allSelChars");
	all.removeClass("selected");

	// Remove special marker, for timing issues
	setTimeout(function(){highlightAreas_resetTouch(taskElement)}, 1000);

}

// Write the highlighted structure into a form element
function highlightAreas_scan(taskElement) {
	var all = taskElement.data("allSelChars");
	var map = all.map(function(i,e){return $(e).hasClass("highlighted") ? e.textContent : '~'}).get().join("");
	taskElement.find("input.charsMap").val(map);
}
