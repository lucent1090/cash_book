$.ajax({
  type: "GET",
  contentType: "application/json; charset=utf-8",
  url: 'users/graphic_data',
  dataType: 'json',
  success: function (word) {
      d3.layout.cloud().size([350, 300])
        .words(word)
        .padding(5)
        .rotate(function() { return ~~(Math.random() * 2) * 75; })
        .font("Impact")
        .fontSize(function(d) { return d.size; })
        .on("end", draw)
        .start();   
  },
  error: function (result) {
    error();
  }
});

function draw(word) { 
  d3.select("#word-could").append("svg")
      .attr("width", 400)
      .attr("height", 350)
    .append("g")
      .attr("transform", "translate(" + 400 / 2 + "," + 350 / 2 + ")")
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