$(function(){

$.extend( sys, {
  charts: {
    stack: [],
    willRedraw: null,
    init: function(){
      $(window).resize(sys.charts.redraw);
    },
    redraw: function(){
      if(sys.charts.willRedraw!=null) clearTimeout(sys.charts.willRedraw);
      sys.charts.willRedraw = setTimeout(function(){
        $.each(sys.charts.stack, function(){
          this.redraw();
        });
      }, 500);
    },
    cities: function(data){
      var points = [];
      $.each(data,function(){
        points.push( { location: new google.maps.LatLng(this.latitude, this.longitude), weight: this.cnt*10 } );
      });
      new google.maps.LatLng()
      var heatmap = new google.maps.visualization.HeatmapLayer({ data: points });
      heatmap.setMap(sys.map);
    },
    line: function(data, id, labels){
      sys.charts.stack.push(Morris.Line({
        element: id,
        data: data,
        xkey: 'reg_date',
        ykeys: ['cnt'],
        labels: labels
      }));
    }
  }
});

sys.charts.init();

});
