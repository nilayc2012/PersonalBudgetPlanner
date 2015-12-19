// Create the chart
//highcharts for charts and gon gem to send the data to the javascript so highcharts can use it to display the logic
  $(function () {
    $('#barchart').highcharts({
      chart: {
            type: 'column'
        },
      title: {
            text: 'Expense Type vs Expense Amount'
        },
      xAxis: {
            type: 'category'
        },
      yAxis: {
            title: {
                text: 'Total Expense Amount'
            }
        },
      legend: {
            enabled: false
        },
      plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: true
                }
            }
        },
      series: [
            {
                name: 'Total Expense Amount is',
                colorByPoint: true,
                data: gon.expense_list
            }
        ],
    });
      $('#piechart').css('height','0px');
      $('#barchart').css('height','0px');
  });

  function userChange() {
    var chart = document.getElementById("display_charts").value;
     // Create the chart
     //highcharts for charts and gon gem to send the data to the javascript so highcharts can use it to display the logic
    $('#piechart').highcharts({
        chart: {
                  type: 'pie'
                },
        title: {
                  text: 'Expense Type vs Expense Amount'
                },
        plotOptions: {
                        pie: {
                              allowPointSelect: true,
                              cursor: 'pointer',
                              dataLabels: {
                                  enabled: true
                              }
                        }
                    },
                      series: [
                          {
                            name: 'Total Expense Amount is',
                            colorByPoint: true,
                            data: gon.expense_list
                          }
                      ],
                  });
        if (chart == "barchart"){
                $('#barchart').show();
                $('#piechart').hide();
                window.location.reload();
            }
        if (chart == "piechart") {
            $('#barchart').hide();
            $('#piechart').show();
       }
    }
 