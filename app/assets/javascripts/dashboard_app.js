angular.module('DashboardApp',[])
.controller('DashboardController',['$scope',function($scope) {
  console.log('Hello from the other side')
  $scope.filter = {
    channel: null,
    user: null,
    tags: []
  }

  $scope.addTag = function(tag) {
    $scope.filter.tags = _.uniq($scope.filter.tags.concat([tag]));
  }
  $scope.removeTag = function(tag) {
    var index = $scope.filter.tags.indexOf(tag);
    $scope.filter.tags.splice(index,1);
  }

  $scope.setUser = function(user) {
    $scope.filter.user = user;
  }
  $scope.clearUser = function() {
    $scope.filter.user = null;
  }

  $scope.setChannel = function(channel) {
    $scope.filter.channel = channel;
  }
  $scope.clearChannel = function() {
    $scope.filter.channel = null;
  }
  $scope.isDataClipVisible = function(dataClipId) {
    if($scope.filter.channel === null && $scope.filter.user === null && $scope.filter.tags.length === 0) {
      return true;
    }
    var curr = _.findWhere($scope.dataClips,{id: dataClipId});
    if($scope.filter.channel && curr.channel_id !== $scope.filter.channel.id) {
      return false;
    }
    if($scope.filter.user && curr.user_id !== $scope.filter.user.id) {
      return false;
    }
    if($scope.filter.tags.length > 0 && _.intersection($scope.filter.tags,curr.tags).length === 0) {
      return false;
    }
    return true;
  }
  window.scope = function() {
    return $scope;
  }
}]);
