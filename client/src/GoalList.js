import React from 'react';
import GoalItem from './GoalItem';

const GoalList = (props) => {
  const goalDayCount = props.goals.map((goal) => {
    return goal.count_consecutive_days_completed;
  });
  const maxDayCount = Math.max(...goalDayCount);

  return (
    <div>
    <h1> Your Goals </h1>
     <ul className="GoalList">
       {
         props.goals.map(
           (goal, index) => {
             return (
               <GoalItem
                 goal={goal}
                 checkFunction={props.checkFunction}
                 deleteFunction={props.deleteFunction}
                 editGoalModalFunction={props.editGoalModalFunction}
                 openDeleteModalFunction={props.openDeleteModalFunction}
                 key={goal.id}
                 maxDayCount={maxDayCount}
              />
             );
           }
         )
       }
     </ul>
   </div>
  );
};

export default GoalList;
