$(function() {
	$(".connect").sortable({
		connectWith : '.connect',
		cancel: '.not-draggable'
	}).disableSelection();

	var board = window.location.search.replace("?", '').replace('board=', '');
	var counter = $('.col-data').length;

	var submitData = function() {
		var data = collectData();
		console.log(data);
		$.post("/tasko/playground/save", {
			board : board,
			data : JSON.stringify(data)
		}, function(data, status) {
			if(status === 'success') {
				setAlerts(data);
				$('.alert-success').slideDown('slow', function(){
					$('.alert-success').fadeOut(2000)
				})
			} else {
				$('.alert-warning').slideDown('slow', function(){
					$('.alert-warning').fadeOut(5000)
				})
			}
		});
	};

	var getColumnHtml = function(counter, heading) {
		return '<div class="ccolumn col-md-2">'
				+ '<div class="ccolumn panel panel-default '
				+ (counter % 2 == 0 ? '' : 'panel-force-dark')
				+ ' connect col-data">'
				+ '<div class="panel-heading">'
				+ '<h6 class="editable content columnheader">'
				+ heading
				+ '</h6>'
				+ '<i class="fa fa-pencil-square-o edit"></i>'
				+ '<i class="delete-column fa fa-times-circle-o"></i>'
				+ '</div> <br/><br/>'
				+ '<div class="add-task btn btn-default"> <i class="fa fa-plus-circle"></i> Click to add'
				+ '</div>' + '</div>' + '</div>';
	};

	var cardHtml = function(text, alert) {
		return '<div class="innerccolumn" id="2a">'
					+'<div class="content editable">'
					+text
					+'</div>'
					+ '<div class="row">'
					+ '<div class="row">'
					+'<div style="font-size:24px;"> <i class="fa fa-clock-o"></i></div>'
					+'</div>'
					+ '<div class="row timerdata">'
					+ '<span style="font-size: 8px;"> Timer: </span> '
					+ ' <input name="time" class="timer" style ="width:'+ (alert? (alert.length+ 1) : 1) * 4+'px"'
					+' onchange="this.style.width = ((this.value.length + 1) * 4) + \'px\';" value="' + (alert || '') +'">'
					+ '</input>'
					+'</div>'
					+ '<div class="row">'
					+ '<i  style="font-size:24px;" class="delete fa fa-times-circle-o"></i>'
					+ '</div>'
					+ '</div>'
					+'</div>';
	}

	var addColumn = function(heading) {
		if (!heading || typeof heading != 'string') {
			heading = 'Board title'
		}

		if (counter < 6) {
			$(getColumnHtml(counter, heading)).appendTo($('.main-panel-tasko'));
			counter++;
		} else {
			alert("Currently we support only 6 lists");
		}

	};

	var collectData = function() {
		var combined_data = {
			board : board
		};
		data = [];
		var colarr = $('.col-data'); // [elements with this class, ...]
		colarr.each(function (col) {
			var $elem = $(colarr[col]); // convert each column into jquery format to perform operations via jquery
			var row = {
				data : []
			};
			var innercolarr = $elem.find('.innerccolumn'); // get all card elements
			row.column = $elem.find('.columnheader').text(); // get column/list title
			innercolarr.each(function(innercol) { // iterate through all cards
				// push card details in array
				row.data.push({
					id : innercolarr[innercol].id,
					val : $(innercolarr[innercol]).find('.content').text(), // this is a div, that's why text()
					alert: $(innercolarr[innercol]).find('.timer').val(), // alert is input tag so val()
				})
			});
			data.push(row);
		});
		combined_data.data = data;
		return combined_data;
	};

	var addCard = function(event, card, alert) {
		var $this = $(this);
		if (!card){
			card = {};
			card.content = 'Click to edit';
		}
		$(cardHtml(card.content, card.alert)).appendTo($this.parent())

		$('.timer').bootstrapMaterialDatePicker({ format : 'MM/DD/YYYY HH:mm', lang : 'en', weekStart : 1, cancelText : 'Cancel' });

		
		// refresh sortable library to make new component draggable
		$(".connect").sortable({
			connectWith : '.connect',
			cancel: '.not-draggable'
		}).disableSelection();
	};

	$('#add-col').click(addColumn);

	$('#save').click(submitData);

	$(document).on('click', '.add-task', addCard);

	// On click functionality
	$(document).on('click', '.editable', function() {
		var name = $(this).text();
		var $this = $(this);
		var attr = {
			'type' : 'text',
			'class' : 'txt_input'
		};

		if (name == 'Click to edit' || name == '') {
			attr.placeholder = "Click to edit";
		} else {
			attr.value = name;
		}
		$(this).html('');
		$('<input></input>').attr(attr).appendTo($this).focus();

		$(this).removeClass('editable');
	});

	$(document).on('click', '.edit', function() {
		var $element = $(this).parent().find('.editable');
		var name = $element.text();
		var $this = $element;
		var attr = {
			'type' : 'text',
			'class' : 'txt_input'
		};

		if (name == 'Click to edit' || name == '') {
			attr.placeholder = "Click to edit";
		} else {
			attr.value = name;
		}
		$element.html('');
		$('<input></input>').attr(attr).appendTo($this).focus();

		$(this).removeClass('editable');
	});

	$(document).on('blur', '.content', function() {
		var name = $(this).find('input').val();
		$(this).text(name);
		$(this).addClass('editable');

	});

	$(document).on('click', '.delete', function() {
		var name = $(this).parent().parent().parent().remove();
	});

	$(document).on('click', '.delete-column', function() {
		var name = $(this).parent().parent().parent().remove();
		counter--;
	});
	
	$(document).on('click', '.fa-clock-o', function(){
		var $element  = $(this).parent().parent().parent().children('.timerdata').children('.timer');
		$element.focus() && $element.focus;
	});

	$(document).on('blur', '.columnheader', function() {
		var name = $(this).find('input').val();
		$(this).text(name);
		$(this).addClass('editable');

	});
	
	var draw = false;

	try {
		content = JSON.parse(content);
		draw = true;
	} catch (e) {
		draw = false;
	}

	if (draw && content) {
		for (var i = 0; i < content.data.length; i++) { // iterate over each column
			var column = content.data[i].column; // get column name
			var columnContent = content.data[i].data; // get column tiles
			if (i == 0) { // By default we have one column, so for first column no need to add column, update existing one
				$('.columnheader').text(column);
			} else {
				addColumn(column);
			}
			for (var j = 0; j < columnContent.length; j++) {
				$('.add-task').last().trigger('click', {content: columnContent[j].val, alert: columnContent[j].alert});
			}
			
		}
	}

});