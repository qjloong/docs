<!doctype html>

<html>

<head>
{% include 'templates/include/head.html' %}
<style type="text/css">
@media (min-width: 992px){
  #content {
      padding: 0 20%;
  }
  #apps-select {
    width: 40%;
  }
}
.doc-home-title {
  background-color: white;
  z-index: 1000;
  display: block;
  width: 100%;
  top: 0;
  padding: 0;
  border-bottom: 1px solid #eee;
}  
.start-page .step h3 {
    padding: 0;
    margin: 20px 0;
    color: #aaa;
    font-size: 16px;
}
.step1 .custom-form-inline .custom-control {
    margin-top: 5px;
    margin-bottom: 5px;
    min-width: 108px;
}
#start-main {
  border-top: 1px solid #eee;
  margin-bottom: 24px;
  padding-top: 24px; 
}
</style>
</head>

<body  class="dashboard-init" ng-cloak ng-controller="AppCtrl">


{% include 'templates/include/header.html' %}


<div class="container-fluid <%= node %>" id="content" style="padding-bottom: 2em;">
  {{body}}
</div>
<!-- .container-fluid -->
{% include 'templates/include/common-footer.html' %}

{% include 'templates/include/footer.html' %}

<!-- <script type="text/javascript">
// get nav items ready for scrollspy
$(window).load(function() {
  $('.doc-home-title').affix({
      offset: {
        top: $('nav').outerHeight(true) + $('header').outerHeight(true)
      }
  });
});
</script> -->
</body>

</html>
