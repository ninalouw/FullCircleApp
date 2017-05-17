import React from 'react';
import Modal from 'react-modal';
import RaisedButton from 'material-ui/RaisedButton';

const customStyles = {
  content: {
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    transform: 'translate(-50%, -50%)'
  }
};

const NewGoalModal = (props) => {
  return (
    <Modal
      newGoal={props.newGoal}
      isOpen={props.isOpen}
      onAfterOpen={props.onAfterOpen}
      onRequestClose={props.onRequestClose}
      style={customStyles}
      contentLabel="Example Modal"
    >
      <h3>Create a new goal</h3>
      <form onSubmit={props.onSubmit}>
        <p>Goal: &nbsp;</p>
        <input
          onChange={props.onNameChange}/>
        <p>Minutes: &nbsp;</p>
        <input
         onChange={props.onMinutesChange} />
        <div>
        <RaisedButton type="submit" value="Submit" label="Submit" primary={true} style={{ margin: '12' }} />
        </div>
      </form>
      <RaisedButton type="submit"
         value="Cancel"
         onClick={props.onRequestClose}
         label="Cancel"
         secondary={true}
         style={{ margin: '12' }} />
    </Modal>
  );
};

export default NewGoalModal;
