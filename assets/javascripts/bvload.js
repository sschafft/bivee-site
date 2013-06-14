$(window).load(function() {
		// Animate loader off screen
		$("#glare").fadeIn(500);
		$("#loading").fadeOut(1000, function(){
			$("#logo").fadeIn(600, function(){
				$("#container").fadeIn(700, function(){
					$(".bv-submit-wrap").fadeIn(700, function(){
						$(".social").fadeIn(500);
					});
				});
			});
		});
	});
