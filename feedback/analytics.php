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
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
  <style>
  .axis path, .axis line
  {
      fill: none;
      stroke: #777;
      shape-rendering: crispEdges;
  }

  .axis text
  {
      font-family: 'Arial';
      font-size: 13px;
  }
  .tick
  {
      stroke-dasharray: 1, 2;
  }
  .bar
  {
      fill: FireBrick;
  }
  </style>
  <svg id="visualisation" width="1000" height="500"></svg>

  <script>
	      $(document).ready(function() {

	    // Load jumbotron links
	    $(".jumbotron-links").load("jumbotron_links.php");

	    alertWidget('display-alerts');
	    var form = $(this);
	    var url = '../api/loadAlumniFBBasic.php';
	    $.ajax({
	      type: "GET",
	      url: url,
	      data: {
	      ajaxMode:	"true"
	      },
	      success: function(result) {
	      var resultJSON = processJSONResult(result);
	      if (resultJSON['errors'] && resultJSON['errors'] > 0){
	        alertWidget('display-alerts');
	      } else {

            InitChart(resultJSON);

	      }
}
	 });

});



    function InitChart(barData2) {
      barData=[{'x':1, 'y':5},{'x':2, 'y':5},{'x':3, 'y':2},{'x':4, 'y':3},{'x':5, 'y':4}];
/*      var barData = [{
        'x': 1,
        'y': 5
      }, {
        'x': 20,
        'y': 20
      }, {
        'x': 40,
        'y': 10
      }, {
        'x': 60,
        'y': 40
      }, {
        'x': 80,
        'y': 5
      }, {
        'x': 100,
        'y': 60
      }];*/

      var vis = d3.select('#visualisation'),
        WIDTH = 1000,
        HEIGHT = 500,
        MARGINS = {
          top: 20,
          right: 20,
          bottom: 20,
          left: 50
        },
        xRange = d3.scale.ordinal().rangeRoundBands([MARGINS.left, WIDTH - MARGINS.right], 0.1).domain(barData.map(function (d) {
          return d.x;
        })),


        yRange = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([0,
          d3.max(barData, function (d) {
            return d.y;
          })
        ]),

        xAxis = d3.svg.axis()
          .scale(xRange)
          .tickSize(5)
          .tickSubdivide(true),

        yAxis = d3.svg.axis()
          .scale(yRange)
          .tickSize(5)
          .orient("left")
          .tickSubdivide(true);


      vis.append('svg:g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + (HEIGHT - MARGINS.bottom) + ')')
        .call(xAxis);

      vis.append('svg:g')
        .attr('class', 'y axis')
        .attr('transform', 'translate(' + (MARGINS.left) + ',0)')
        .call(yAxis);

      vis.selectAll('rect')
        .data(barData)
        .enter()
        .append('rect')
        .attr('x', function (d) {
          return xRange(d.key);
        })
        .attr('y', function (d) {
          return yRange(d.value);
        })
        .attr('width', xRange.rangeBand())
        .attr('height', function (d) {
          return ((HEIGHT - MARGINS.bottom) - yRange(d.y));
        })
        .attr('fill', 'grey')
        .on('mouseover',function(d){
          d3.select(this)
            .attr('fill','blue');
        })
        .on('mouseout',function(d){
          d3.select(this)
            .attr('fill','grey');
        });

    }
	</script>
</body>
</html>
