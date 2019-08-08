var entityFormUrl = "";

function setEditListener(url){
  entityFormUrl = url;
  $(".place-editable").click(function(){
    placeId = $(this).data("place-id");
    $("#entityModalLabel").html("Editing Area/Ward/Hamlet");
    $("#entityModalBody").load(entityFormUrl+"?entity_type=Place&id="+placeId);
    $("#entityModal").modal("show");
  });

  $(".panchayat-editable").click(function(){
    panchId = $(this).data("panchayat-id");
    $("#entityModalLabel").html("Editing Panchayat");
    $("#entityModalBody").load(entityFormUrl+"?entity_type=Panchayat&id="+panchId);
    $("#entityModal").modal("show");
  });

  $(".taluk-editable").click(function(){
    talukId = $(this).data("taluk-id");
    $("#entityModalLabel").html("Editing Taluk");
    $("#entityModalBody").load(entityFormUrl+"?entity_type=Taluk&id="+talukId);
    $("#entityModal").modal("show");
  });
}

function newPlaceInZone(panchId){
  $("#entityModalLabel").html("Creating Area/Ward/Hamlet");
  $("#entityModalBody").load(entityFormUrl+"?entity_type=Place&id=new&place[panchayat_id]="+panchId);
  $("#entityModal").modal("show");
}

function newPanchInZone(talukId){
  $("#entityModalLabel").html("Creating Panchayat");
  $("#entityModalBody").load(entityFormUrl+"?entity_type=Panchayat&id=new&panchayat[taluk_id]="+talukId);
  $("#entityModal").modal("show");
}

function newTalukInZone(distId){
  $("#entityModalLabel").html("Creating Taluk");
  $("#entityModalBody").load(entityFormUrl+"?entity_type=Taluk&id=new&taluk[district_id]="+distId);
  $("#entityModal").modal("show");
}
