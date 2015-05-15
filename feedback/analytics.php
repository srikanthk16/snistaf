<?php
/*
SNISTAF Public Code
By Srikanth Kasukurthi
Copyright (c) 2015 for SNIST


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
require_once("../models/config.php");

// Public page

setReferralPage(getAbsoluteDocumentPath(__FILE__));
 ?>
<html>
<?php
echo renderAccountPageHeader(array("#SITE_ROOT#" => SITE_ROOT, "#SITE_TITLE#" => SITE_TITLE, "#PAGE_TITLE#" => "Analytics"));
?>
<body>
  <div id="wrapper">
    <?php echo renderMenu("Forum");
    ?>

  <div id="pagewrapper" padding-left="60px" >
    <div class="row">
        <div id='display-alerts' class="col-lg-12">

        </div>
      </div>
        <div class="row" >
          <div class="col-lg-12">
</br></br>
<div class="btn-group">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
    Chart Style <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu">
    <li><a onclick="BarChart()">Bar Chart</a></li>
    <li><a onclick="lineChart()">Line Chart</a></li>
    <li><a href="#">Pie Chart</a></li>
    <li class="divider"></li>
    <li><a onclick="textMode()">Text Mode</a></li>
  </ul>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
  <style>
  #chart rect{
    fill: #4aaeea;
  }
  body{
    background-color: #ffffff;
    color: #000000;
    padding : 10px;
  }
  #chart text{
    fill: black;
    font: 10px sans-serif;
    text-anchor: end;
  }

  .axis text{
    font: 10px sans-serif;
  }

  .axis path, .axis line{
    fill: none;
    stroke : #000;
    shape-rendering: crispEdges;
  }


  </style>
  <div id="chart" width="1000" height="500"></div>

  <script>
	      $(document).ready(function() {

	    // Load jumbotron links
	    $(".jumbotron-links").load("jumbotron_links.php");

	    alertWidget('display-alerts');


});



    function BarChart() {
      var margin ={top:20, right:30, bottom:30, left:40},
      width=960-margin.left - margin.right,
      height=500-margin.top-margin.bottom;

  // scale to ordinal because x axis is not numerical
  var x = d3.scale.ordinal().rangeRoundBands([0, width], .1);

  //scale to numerical value by height
  var y = d3.scale.linear().range([height, 0]);

  var chart = d3.select("#chart")
                .append("svg")  //append svg element inside #chart
                .attr("width", width+(2*margin.left)+margin.right)    //set width
                .attr("height", height+margin.top+margin.bottom);  //set height
  var xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");  //orient bottom because x-axis will appear below the bars

  var yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");
                d3.json("../api/loadAlumniFBBasic.php", function(error, data){
  x.domain(data.map(function(d){ return d.x}));
  y.domain([0, d3.max(data, function(d){return d.y})]);

  var bar = chart.selectAll("g")
                    .data(data)
                  .enter()
                    .append("g")
                    .attr("transform", function(d, i){
                      return "translate("+x(d.x)+", 0)";
                    });

  bar.append("rect")
      .attr("y", function(d) {
        return y(d.y);
      })
      .attr("x", function(d,i){
        return x.rangeBand()+(margin.left/4);
      })
      .attr("height", function(d) {
        return height - y(d.y);
      })
      .attr("width", x.rangeBand());  //set width base on range on ordinal data

  bar.append("text")
      .attr("x", x.rangeBand()+margin.left )
      .attr("y", function(d) { return y(d.y) -10; })
      .attr("dy", ".75em")
      .text(function(d) { return d.y; });

  chart.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate("+margin.left+","+ height+")")
        .call(xAxis);

  chart.append("g")
        .attr("class", "y axis")
        .attr("transform", "translate("+margin.left+",0)")
        .call(yAxis)
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Average");
});
}
function type(d) {
    d.letter = +d.letter; // coerce to number
    return d;
  }
function lineChart(){
  var margin ={top:20, right:30, bottom:30, left:40},
  width=960-margin.left - margin.right,
  height=500-margin.top-margin.bottom;

  // scale to ordinal because x axis is not numerical
  var x = d3.scale.ordinal().rangeRoundBands([0, width], .1);

  //scale to numerical value by height
  var y = d3.scale.linear().range([height, 0]);

  var chart = d3.select("#chart")
            .append("svg")  //append svg element inside #chart
            .attr("width", width+(2*margin.left)+margin.right)    //set width
            .attr("height", height+margin.top+margin.bottom);  //set height
  var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");  //orient bottom because x-axis will appear below the bars

  var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left");
            d3.json("../api/loadAlumniFBBasic.php", function(error, data){
  x.domain(data.map(function(d){ return d.x}));
  y.domain([0, d3.max(data, function(d){return d.y})]);

  var group = chart.selectAll("g")
                    .data(data)
                  .enter()
                    .append("g")
                    .attr("transform", function(d, i){
                      return "translate("+x(d.x)+", 0)";
                    });
   var line = d3.svg.line()
        .x(function(d, i) {
            return d.x;
        })
        .y(function(d, i) {
            return d.y;
        });

   chart.selectAll("path")
        .data(data).enter()
        .append("path")
        .attr("d", function(d){ return line(d) })
        .attr("fill", "none")
        .attr("stroke", "green")
        .attr("stroke-width", 3);

          chart.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate("+margin.left+","+ height+")")
                .call(xAxis);

          chart.append("g")
                .attr("class", "y axis")
                .attr("transform", "translate("+margin.left+",0)")
                .call(yAxis)
                .append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Average");
});
}
function textMode(){
  alert("coming soon");
}
function pieChart(){
data=d3.JSON("../api/loadAlumniFBBasic.php");
var width = 800,
    height = 250,
    radius = Math.min(width, height) / 2;

var color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);

var pie = d3.layout.pie()
    .sort(null)
    .value(function (d) {
    return d.y;
});



var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    var g = svg.selectAll(".arc")
        .data(pie(data))
        .enter().append("g")
        .attr("class", "arc");

    g.append("path")
        .attr("d", arc)
        .style("fill", function (d) {
        return color(d.data.y);
    });

    g.append("text")
        .attr("transform", function (d) {
        return "translate(" + arc.centroid(d) + ")";
    })
        .attr("dy", ".35em")
        .style("text-anchor", "middle")
        .text(function (d) {
        return d.data.y;
    });
}
	</script></div></div>
</body>
</html>
