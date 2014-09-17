$(function(){

$.extend( sys, {
  admin: {
    init: function(){
      sys.admin.venues.init();
    },
    venues: {
      init: function(){},
      added: function(a,b,c){
        this.parents(this.data('parent')).fadeOut();
      }
    }
  }
});

sys.admin.init();

});
