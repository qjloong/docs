<!doctype html>

<html>

<head>
{% include 'templates/include/head.html' %}
<style type="text/css">
@media (min-width: 992px){
  #content {
      padding: 0 20%;
  }
}
</style>
</head>

<body  class="dashboard-init" ng-cloak ng-controller="AppCtrl">

{% include 'templates/include/header.html' %}


<div class="container-fluid <%= node %> doc-content" id="content" style="padding-bottom: 2em;">
  <div class="docs-meta"></div>
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
