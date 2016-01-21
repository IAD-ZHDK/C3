var Timeline = function(element) {
  this.element = element;

  var self = this;
  $.getJSON($(element).data('url'), function(data){
    self.data = data.timeline;

    self.data.forEach(function(event){
      event.time = new Date(event.time);
    });

    self.render();
  });
};

Timeline.prototype.render = function() {
  var options =   {
    margin: { left: 50, right: 50, top: 50, bottom: 50 },
    initialWidth: 1000,
    initialHeight: 170
  };

  var icons = {
    requested: "\uf0eb",
    proposed: "\uf0f2",
    voted: "\uf004",
    attended: "\uf00c",
    scheduled: "\uf017",
    conducted: "\uf023"
  };

  var innerWidth =  options.initialWidth - options.margin.left - options.margin.right;

  var vis = d3.select(this.element)
    .append('svg')
    .attr('width',  options.initialWidth)
    .attr('height', options.initialHeight)
    .append('g')
    .attr('transform', 'translate(' + (options.margin.left) + ',' + (options.margin.top) + ')');

  var timeScale = d3.time.scale()
    .domain(d3.extent(this.data, function(d){ return d.time; }))
    .range([0, innerWidth])
    .nice();

  var nodes = this.data.map(function(d){
    return new labella.Node(timeScale(d.time), 32, d);
  });

  vis.append('line')
    .classed('horizon', true)
    .attr('x2', innerWidth);

  var linkLayer = vis.append('g');
  var labelLayer = vis.append('g');
  var dotLayer = vis.append('g');

  dotLayer.selectAll('.dot')
    .data(nodes)
    .enter().append('circle')
    .classed('dot', true)
    .attr('r', 3)
    .attr('cx', function(d){ return d.getRoot().idealPos; });

  var renderer = new labella.Renderer({
    layerGap: 60,
    nodeHeight: nodes[0].data.h,
    direction: 'bottom'
  });

  function draw(nodes){
    renderer.layout(nodes);

    var sEnter = labelLayer.selectAll('.flag')
      .data(nodes)
      .enter().append('g')
      .attr('transform', function(d){ return 'translate(' + (d.x - d.width / 2) + ',' + (d.y) + ')'; });

    sEnter
      .append('rect')
      .classed('flag', true)
      .attr('width', 32)
      .attr('height', 32)
      .attr('rx', 30)
      .attr('ry', 30);

    sEnter.append('text')
      .classed('label', true)
      .attr('x', 16)
      .attr('y', 22)
      .text(function(d){ return icons[d.data.type]; });

    linkLayer.selectAll('.link')
      .data(nodes)
      .enter().append('path')
      .classed('link', true)
      .attr('d', function(d){ return renderer.generatePath(d); });
  }

  var force = new labella.Force({
    minPos: -10,
    maxPos: innerWidth,
    nodeSpacing: 10
  });

  force.nodes(nodes)
    .on('end', function(){
      draw(force.nodes());
    })
    .start(100);
};
