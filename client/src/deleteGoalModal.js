import React from 'react';
import Modal from 'react-modal';
import RaisedButton from 'material-ui/RaisedButton';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

const customStyles = {
  content: {
    fontFamily: 'Roboto',
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    transform: 'translate(-50%, -50%)'
  }
};

const DeleteGoalModal = (props) => {
  return (
    <MuiThemeProvider>
    <Modal
      isOpen={props.isOpen}
      goalBeingEdited={props.goalBeingEdited}
      onAfterOpen={props.onAfterOpen}
      onRequestClose={props.onRequestClose}
      style={customStyles}
      contentLabel="Example Modal"
    >
    <form onSubmit={props.onSubmit}>
      <p>Are you sure you want to delete this goal?</p>
      <RaisedButton type="submit" value="Confirm" label="Confirm" primary={true} style={{ margin: '12' }} />
   </form>
      <RaisedButton type="submit"
         value="Cancel"
         onClick={props.onRequestClose}
         label="Cancel"
         secondary={true}
         style={{ margin: '12' }} />
    </Modal>
  </MuiThemeProvider>
  );
};

export default DeleteGoalModal;
