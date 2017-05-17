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

const EditGoalModal = (props) => {
  return (
    <Modal
      isOpen={props.isOpen}
      goalBeingEdited={props.goalBeingEdited}
      onAfterOpen={props.onAfterOpen}
      onRequestClose={props.onRequestClose}
      style={customStyles}
      contentLabel="Example Modal"
    >
      <h3>Edit your goal</h3>
      <form onSubmit={props.onSubmit}>
        <label>
          Goal name:&nbsp;
        </label>
        <input value={props.goalBeingEdited && props.goalBeingEdited.name}
              onChange={props.onNameChange} />&nbsp;
        &nbsp;<label>
          Minutes:&nbsp;
        </label>
        <input value={props.goalBeingEdited && props.goalBeingEdited.minutes}
              onChange={props.onMinutesChange} />
        <RaisedButton type="submit" value="Submit" label="Submit" primary={true} style={{ margin: '12' }} />
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

export default EditGoalModal;
