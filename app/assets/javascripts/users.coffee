# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if usersCreatedByWeek?
  yAxis = Object.values(usersCreatedByWeek);

  xAxis = [];
  for week in Object.keys(usersCreatedByWeek)
    d = new Date(week)
    xAxis.push((d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear())

  trace = {
    x: xAxis,
    y: yAxis,
    type: 'scatter',
    marker: {
      color: '#76bf43'
    }
  };

  data = [trace];

  Plotly.newPlot('users-created-by-week', data);

if punchesCreatedByWeek?
  yAxis = Object.values(punchesCreatedByWeek);

  xAxis = [];
  for week in Object.keys(punchesCreatedByWeek)
    d = new Date(week)
    xAxis.push((d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear())

  trace = {
    x: xAxis,
    y: yAxis,
    type: 'scatter',
    marker: {
      color: '#76bf43'
    }
  };

  data = [trace];

  Plotly.newPlot('punches-created-by-week', data);

if totalUsersCreatedByWeek?
  yAxis = Object.values(totalUsersCreatedByWeek);

  xAxis = [];
  for week in Object.keys(totalUsersCreatedByWeek)
    d = new Date(week)
    xAxis.push((d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear())

  trace = {
    x: xAxis,
    y: yAxis,
    type: 'scatter',
    marker: {
      color: '#76bf43'
    }
  };

  data = [trace];

  Plotly.newPlot('total-users-created-by-week', data);

if reasonCounts?
  yData = Object.values(reasonCounts);

  xData = Object.keys(reasonCounts);

  # for week in Object.keys(reasonCounts)
  #   d = new Date(week)
  #   xAxis.push((d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear())

  trace = {
    x: xData,
    y: yData,
    type: 'bar',
    marker: {
      color: '#76bf43'
    }
  };

  data = [trace];

  Plotly.newPlot('reason-counts', data);
