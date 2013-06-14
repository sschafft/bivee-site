$(window).load(function() {
		// Animate loader off screen
		$("#loading").fadeOut(1000, function(){
			$("#logo").fadeIn(400, function(){
				$("#container").fadeIn(400, function(){
					$(".bv-submit-wrap").fadeIn(400, function(){
						$(".social").fadeIn(400);
					});
				});
			});
		});
	});
