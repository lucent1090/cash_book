$.ajax({
  type: "GET",
  contentType: "application/json; charset=utf-8",
  url: 'users/graphic_data',
  dataType: 'json',
  success: function (word) {
    $(document).ready(function(){
      $("#graph").text(JSON.stringify(word));
    });

      d3.layout.cloud().size([800, 800])
        .words(word)
        .padding(5)
        .rotate(function() { return ~~(Math.random() * 2) * 75; })
        .font("Impact")
        .fontSize(function(d) { return d.size; })
        .on("end", end)
        .start();   
    
    
  },
  error: function (result) {
    error();
  }
});

function end(word) { 
  d3.select("body").append("svg")
      .attr("width", 850)
      .attr("height", 350)
    .append("g")
      .attr("transform", "translate(" + 850 / 2 + "," + 350 / 2 + ")")
    .selectAll("text")
      .data(word)
    .enter().append("text")
      .style("font-size", function(d) { return d.size + "px"; })
      .style("font-family", "Impact")
      .style("fill", function(d, i) { return fill(i); })
      .attr("text-anchor", "middle")
      .attr("transform", function(d) {
        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
      })
      .text(function(d) { return d.text; });
} 

var fill = d3.scale.category20();

function error() {
  console.log("error")
}