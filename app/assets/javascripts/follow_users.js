$(document).ready(function(){
  $("#toggle-followers").on('click', '.follow-btn', function(e) {
    var followed_id = this.dataset.id;

    $.ajax({
      url: '/relationships',
      type: 'post',
      dataType: "json",
      data: {
        followed_id: followed_id
      },
      success: function(data){
        console.log(data);
      },
      error: function(return_value){
        alert("Failed to follow.");
      }
    });
  });
});