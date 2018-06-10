$(document).on('turbolinks:load', function(){
  // $(document).ready(function(){
  $("#toggle-followers").on('click', '.follow-btn', function(e) {
    var other_user_id = this.dataset.id;
    var btn_id = "#" + this.id;

    $.ajax({
      url: '/relationships',
      type: 'post',
      dataType: "json",
      data: {
        other_user_id: other_user_id
      },
      success: function(data){
        if ($(btn_id).html() == 'Follow') {
          $(btn_id).html('Unfollow');
        } else {
          $(btn_id).html('Follow');
        }
      },
      error: function(return_value){
        console.log(return_value);
        alert("Action Failed.");
      }
    });
  });
});