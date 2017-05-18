import React from 'react';
import GoalBarChart from './BarChart';
import IconButton from 'material-ui/IconButton';
import ActionCheckCircle from 'material-ui/svg-icons/action/check-circle';
import ActionDelete from 'material-ui/svg-icons/action/delete';
import ActionEdit from 'material-ui/svg-icons/editor/mode-edit';

const GoalItem = (props) => {
  return (
      <li>
        <div className="row">
          <div className="col-xs-12 col-sm-4 col-md-12">
             <h3>{props.goal.name}</h3>
             <IconButton className="icon-btn" tooltip="Edit"
               onClick={props.editGoalModalFunction}
               data-index={props.goal.id}>
              <ActionEdit />
             </IconButton>
             <IconButton className="icon-btn" tooltip="Done"
               onClick={props.checkFunction}
               data-index={props.goal.id}>
              <ActionCheckCircle />
             </IconButton>
             <IconButton className="icon-btn" tooltip="Delete"
               onClick={props.openDeleteModalFunction}
               data-index={props.goal.id}>
              <ActionDelete />
             </IconButton>
         </div>
         <div className="col-xs-12 col-sm-8 col-md-12" style={{ maxWidth: '260px' }}>
           <GoalBarChart count={props.goal.count_consecutive_days_completed}
                    name={props.goal.name}
                  maxDayCount={props.maxDayCount} />
         </div>
       </div>
    </li>
  );
};
export default GoalItem;
