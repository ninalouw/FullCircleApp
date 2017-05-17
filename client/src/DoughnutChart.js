import React from 'react';
import { Doughnut } from 'react-chartjs-2';

const GoalDoughnutChart = (props) => {
  const goalMinutes = props.goals.map((goal) => {
    return goal.minutes;
  });

  const goalNames = props.goals.map((goal) => {
    return goal.name;
  });

  const data = {
    labels: goalNames,
    datasets: [
      {
        label: "Time Spent on Goals",
        data: goalMinutes,
        backgroundColor: [
          "rgb(244, 10, 122)",
          "#F7464A",
          "#00BFA5",
          "rgb(246, 224, 76)",
          "rgb(246, 138, 50)",
          "#00B8D4",
          "rgb(73, 101, 185)",
          "rgb(161, 87, 196)",
          "#C51162",
          "rgb(158, 4, 18)",
          "rgb(149, 59, 9)",
          "rgb(75, 227, 175)",
          "rgb(249, 123, 7)"
        ],
        hoverBackgroundColor: [
          "rgb(249, 81, 151)",
          "#FF5A5E",
          "#5AD3D1",
          "rgb(246, 240, 92)",
          "rgb(242, 118, 57)",
          "rgb(97, 190, 214)",
          "rgb(105, 123, 213)",
          "rgb(184, 73, 212)",
          "rgb(195, 63, 119)",
          "rgb(171, 44, 48)",
          "rgb(176, 94, 48)",
          "rgb(134, 244, 178)",
          "rgb(246, 143, 85)"
        ]
      }]
  };

  const options = {
    maintainAspectRatio: false,
    legend: {
      position: 'bottom'
    }
  };

  return (
      <Doughnut data={data} options={options}/>
  );
};
export default GoalDoughnutChart;
