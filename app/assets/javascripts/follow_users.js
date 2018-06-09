$(document).ready(function(){
  $("#toggle-followers").on('click', '.follow-btn', function(e) {
    var followed_id = this.dataset.id;
    var btn_id = "#" + this.id;

    $.ajax({
      url: '/relationships',
      type: 'post',
      dataType: "json",
      data: {
        followed_id: followed_id
      },
      success: function(data){
        alert(data.message);
        $(btn_id).hide();
      },
      error: function(return_value){
        console.log(return_value);
        alert("Failed to follow.");
      }
    });
  });
});