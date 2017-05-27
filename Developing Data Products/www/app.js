var lastDate = new Date().getTime();
var error = false;

setInterval(function(){
	var today = new Date().getTime();
	if(today-lastDate<500){
		return;
	}
	lastDate = today;
	if(error){
		return;
	}
	$(".hoverlayer").bind("DOMSubtreeModified", function() {
    	//console.log(this);
    	if($(".hovertext")){
    		if($(".hovertext").find("tspan")[1]){
    			var funding = $(".hovertext").find("tspan")[0].innerHTML;
    			var tempDiv = $(".hovertext").find("tspan")[1];
    			
    			var innerHTML = tempDiv.innerHTML;

    			var pos1 = innerHTML.indexOf("Name: ");
    			var pos2 = innerHTML.indexOf("URL: ");
    			var pos3 = innerHTML.indexOf("Funding Rounds: ");

    			var name = innerHTML.substring(pos1+5,pos2);
    			var url  = innerHTML.substring(pos2+4,pos3);
    			var rounds = innerHTML.substring(pos3+16, innerHTML.length);
    			var domain = url.substring(url.indexOf("//"),url.length);

    			var nameH2 = "<h2>Company Name:"+name+"</h2>";
    			var urlH3 = "<span><h3><a target='_blank' href='"+url+"'>"+url+"</a></h3></span>";
    			var faviconImg = "<img width='75px' height='75px' src='http://www.google.com/s2/favicons?domain="+domain+"'>";
    			var fundingH3 = "<h3>Raised (USD): "+ funding +"</h3>";
    			var fundingRoundsH4 = "<h4>Rounds of Funding: "+rounds+"</h4>";
    			$("#start-up-info").html(
    				nameH2+faviconImg+urlH3+fundingH3+fundingRoundsH4
    			);
    		}
    	}
	})
	$(".js-range-slider").change(function(){
		if(error){
			$(".shiny-output-error").css("display","none");
		}
		setTimeout(function(){
			console.log($(".shiny-output-error"));
			$(".shiny-output-error").css("display","block");
			if($(".shiny-output-error")[0]){
				var css = '<style id="pseudo">.shiny-output-error.before-hidden:before {display: none;}</style>';
        		document.head.insertAdjacentHTML( 'beforeEnd', css );

				$(".shiny-output-error").text("No matching data returned").css(
					{   "font-style": "italic",
    					"font-weight": "800",
    					"font-size": "2.25em",
    					"color": "#ffc300"
					}).addClass("before-hidden");
				console.log($(".shiny-output-error")[0]);
				$(".hoverlayer").unbind("DOMSubtreeModified");
				$("#start-up-info").html("");
				error = true;
			}else{
				error = false;
			}
		},400);
	})
},1500)

