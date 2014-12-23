$ ->
  loadLatestTemperature = ->
    latestTemperatureUrl = $('#temperature').attr('data-latest-temperature-url')
    $.getJSON latestTemperatureUrl, (data) =>
      console.log(data[0].value + ' - ' + $.now())
      $('#temperature span').text(data[0].value)

    setTimeout loadLatestTemperature, 60000

  loadLatestTemperature()
