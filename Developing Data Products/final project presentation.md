Start-up Funding Data Visualization
========================================================
author: Sammie Bae 
date: 2015-12-27

Intro
========================================================

The goal for this project was to let users select from different
categories and filters about start-ups to see what their fundings are like

Feautres:
- Filterings on 7 different factors
- Sorting by order of funding
- Interactivity with JavaScript

Data Processing:
========================================================
I used CrunchBase's open data to get the csv:
and preprocessed it before passing it to my server

```r
require(data.table)
library(dplyr)
library(ggplot2)
library(DT)
library(devtools)
crunchbaseCompanies<-read.csv("crunchbase-data/companies.csv", na.strings=c("NA",""),stringsAsFactors = FALSE)
head(crunchbaseCompanies)
```

```
                        permalink                 name
1 /organization/bratpackstyle-llc #BratPackStyle, LLC.
2             /organization/-fame                #fame
3           /organization/hashoff             #HASHOFF
4           /organization/waywire             #waywire
5 /organization/tv-communications   &TV Communications
6   /organization/rock-your-paper    'Rock' Your Paper
                  homepage_url
1 http://www.bratpackstyle.com
2           http://livfame.com
3       http://www.hashoff.com
4       http://www.waywire.com
5        http://enjoyandtv.com
6 http://www.rockyourpaper.org
                                                            category_list
1 |Lifestyle|Content Discovery|Social Commerce|Retail|Fashion|E-Commerce|
2                                                                 |Media|
3                                   |Digital Media|Internet|Social Media|
4                              |Entertainment|Politics|Social Media|News|
5                                                                 |Games|
6                                                  |Publishing|Education|
           market funding_total_usd    status country_code state_code
1 Social Commerce                 0 operating          USA         NY
2           Media          10000000 operating          IND       <NA>
3   Digital Media            955000 operating          USA         CO
4            News           1750000  acquired          USA         NY
5           Games           4000000 operating          USA         CA
6      Publishing             40000 operating          EST       <NA>
         region        city funding_rounds founded_at first_funding_at
1 New York City    New York              1 2015-04-19       2015-06-01
2        Mumbai      Mumbai              1       <NA>       2015-01-05
3        Denver      Denver              2 2014-04-01       2014-12-08
4 New York City    New York              1 2012-06-01       2012-06-30
5   Los Angeles Los Angeles              2       <NA>       2010-06-04
6       Tallinn     Tallinn              1 2012-10-26       2012-08-09
  last_funding_at
1      2015-06-01
2      2015-01-05
3      2015-08-11
4      2012-06-30
5      2010-09-23
6      2012-08-09
```

```r
setnames(crunchbaseCompanies, "category_list", "categories")
setnames(crunchbaseCompanies, "funding_total_usd", "totalFunding")
setnames(crunchbaseCompanies, "funding_rounds", "fundingRounds")
setnames(crunchbaseCompanies, "founded_at", "foundedAt")
```


Server:
========================================================
With use of plot_ly framework and my JavaScript, I added interactivity

```r
#queriedData <-queryData(crunchbaseCompanies, #input$founded_at[1],input$founded_at[2],
                        #input$funding_rounds[1],input$funding_total_usd[1],input$market[1],                        input$status[1],input$name[1],input$sort[1])
```
Passing the layout to the UI:

```r
    #queryGraph<-plot_ly(queriedData, x = name, y = totalFunding, text = paste("Name:", name, "\n URL:", homepage_url,"\n Funding Rounds: ",fundingRounds),mode = "markers",color = totalFunding)
    # style the xaxis
    #layout(queryGraph, xaxis = list(title = "Start-up Names"))
```

UI:
========================================================
Using various types of inputs (filter,radiobox, text),
variety of inputs for filtering was created

```r
#wellPanel(
#             tags$head(tags$script(src="app.js")),
#             h4("Filter"),
             #Inputs:
#             sliderInput("founded_at", "Year Founded", 1915, 2015, value = c(1915, 2015)),
#             sliderInput("funding_rounds", "Number of funding rounds",           #              1, 19, 2, step = 1),
#             textInput("funding_total_usd", "Total Funding ($ USD)"),
#             selectInput("market", "Market/Industry",
#                         c(uniqueMarketCategories)
#             ),
#             textInput("name", "Company name"),
#             selectInput("status", "Status", c("operating","acquired","closed","all")),
#             radioButtons("sort", "Sort",
#                          c("None" = "none",
#                           "Ascending" = "ascending",
#                            "Descending" = "descending")
#                         )
             #textInput("companyInfo", "Info for Company")
#           )
```
Recieving the plot from server:

```r
   #plotlyOutput("mainGraph")
```

JavaScript:
========================================================
Adding interactivity and information box using JavaScript
```{}
$(".hoverlayer").bind("DOMSubtreeModified", function() {
    	//console.log(this);
    	if($(".hovertext")){
    		if($(".hovertext").find("tspan")[1]){
    			var funding = $(".hovertext").find("tspan")[0].innerHTML;
    			var tempDiv = $(".hovertext").find("tspan")[1];
    			console.log(tempDiv.innerHTML);
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
```

Next Steps:
========================================================

Next Steps:
- Comparing different rounds of funding
- Bug fix: if there are no matching companies, the graph breaks
- Stat analysis on funding based on their industry/market/founding date
