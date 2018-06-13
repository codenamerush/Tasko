function setAlerts(allBoards){
	try{
		JSON.parse(allBoards).map(function(board) {
			if (board){
				var boardContent = board.data;
				boardContent.map(function(columns) {
					columns.data.map(function(card) {
						var timer = +new Date(card.alert); 
						var diff = (timer - Date.now());
						if (diff > 0 ){
							setTimeout(function() {
								alert("Alert: \n " + card.val);
							}, diff);
						}
					});
				})
			}
		});
	} catch (e) {
		console.log(e);
	}
}
