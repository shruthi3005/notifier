// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require jquery_nested_form
//= require bootstrap-datepicker
//= require_tree .

const dateDobConfig = {
  format: 'yyyy-mm-dd',
  endDate: 'today'
}

const modalDobConfig = {
  format: 'yyyy-mm-dd',
  endDate: 'today',
  container: '#entityModalBody'
}

const dateConfig = {
  format: 'yyyy-mm-dd'
}

const modalDateConfig = {
  format: 'yyyy-mm-dd',
  container: '#entityModalBody'
}

const dateNextConfig = {
  format: 'yyyy-mm-dd'
}

function hideNotification(){
  $("#notification").hide();
}

function setPlace(btnId){
  if(btnId != undefined){
    var model = $("#place_"+btnId).data("model");
    $("#"+model+"_place_id").val(btnId);
    $("#place_search").val($("#place_"+btnId).html());
  }
  $("#place_search").attr("readonly", true);
  $("#popPlaceContent").hide();
};

function setUser(btnId){
  if(btnId != undefined){
    var model = $("#user_"+btnId).data("model");
    $("#"+model+"_user_id").val(btnId);
    $("#user_search").val($("#user_"+btnId).html());
  }
  $("#user_search").attr("readonly", true);
  $("#popUserContent").hide();
};

function setPlaceSuggester(url, model){
  $("#place_search").keyup(function(){
    var text = $(this).val();
    $.get(url+"?search="+text, function(res){
      var content = '<button class="list-group-item list-group-item-action text-left" onclick="setPlace(); return false;">Cancel</button>';
      for(i in res){
        content += `<button data-model="${model}" id="place_${res[i].id}" class="list-group-item list-group-item-action text-left" onclick="setPlace(${res[i].id}); return false;">${res[i].name}</button>`
      }
      $("#popPlaceContent").html(content);
      $("#popPlaceContent").show();
    });
  });
  
  $("#editPlaceSelect").click(function(){
    $("#place_search").attr("readonly",false);
  });
}

function setUserSuggester(url, model){
  $("#user_search").keyup(function(){
    var text = $(this).val();
    $.get(url+"?search="+text, function(res){
      var content = '<div class="list-group-item list-group-item-action text-left">'+
        '<button class="btn btn-danger float-right" onclick="setUser(); return false;"><i class="fas fa-times"></i></button>'+
        '<button class="btn btn-secondary" style="margin-left:10px;" onclick="addUser(); return false;">+ Add A New User</button>'+
        '</div>';
      for(i in res){
        content += `<button data-model="${model}" id="user_${res[i].id}" class="list-group-item list-group-item-action text-left" onclick="setUser(${res[i].id}); return false;">${res[i].name}</button>`
      }
      $("#popUserContent").html(content);
      $("#popUserContent").show();
    });
  });
  
  $("#editUserSelect").click(function(){
    $("#user_search").attr("readonly",false);
  });
}

function showActiveNotification(url){
  $("#notifyModalHeading").html("Current Notifications");
  $("#notifyModalBody").load(url);
  $("#notifyModal").modal("show");
}

function showNotification(data){
  $("#notifyModalHeading").html(data.heading);
  $("#notifyModalBody").html(data.body);
  $("#notifyModal").modal("show");
}
