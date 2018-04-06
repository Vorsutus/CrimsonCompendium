<<<<<<< HEAD
/////////VID ARROW STUFF/////////
$(document).ready(function() {

    var $item = $("div.vid-item"), //Cache your DOM selector
        visible = 3, //Set the number of items that will be visible (count 0 index too)
        index = 0, //Starting index
        endIndex = ($item.length / visible ) - 1; //End index (NOTE:: Requires visible to be a factor of $item.length... You can improve this by rounding...)

    $(".arrow-right").click(function(){
        if(index < endIndex ){
          index++;
        $item.animate({"left":"-=300px"});
        }

    });

    $(".arrow-left").click(function(){
        if(index > 0){
          index--;            
        $item.animate({"left":"+=300px"});
        }

=======
//////////// ARROWS
$(document).ready(function () {
    $(".arrow-right").bind("click", function (event) {
        event.preventDefault();
        $(".vid-list-container").stop().animate({
            scrollLeft: "+=336"
        }, 750);
    });
	
    $(".arrow-left").bind("click", function (event) {
        event.preventDefault();
        $(".vid-list-container").stop().animate({
            scrollLeft: "-=336"
        }, 750);
>>>>>>> 1b7b843e3e88f37ec4c829167a0e4d0e99dc7695
    });
});